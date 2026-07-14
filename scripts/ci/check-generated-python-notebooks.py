#!/usr/bin/env python3

import argparse
import json
import re
from dataclasses import dataclass
from pathlib import Path


R_ONLY_PATTERNS = [
    re.compile(r"\blibrary\s*\("),
    re.compile(r"%>%"),
    re.compile(r"<-"),
    re.compile(r"\bggplot\s*\("),
    re.compile(r"\bgeom_[A-Za-z0-9_]*\s*\("),
    re.compile(r"\btheme_set\s*\("),
    re.compile(r"\bdata\.frame\s*\("),
    re.compile(r"\btribble\s*\("),
    re.compile(r"\bpivot_longer\s*\("),
    re.compile(r"\bchisq\.test\s*\("),
    re.compile(r"\bbind_rows\s*\("),
    re.compile(r"\bsubset\s*\("),
    re.compile(r"\b[A-Za-z][A-Za-z0-9_.]*\s*::\s*[A-Za-z][A-Za-z0-9_.]*\b"),
]


@dataclass
class Violation:
    notebook_path: str
    cell_number: int
    violation_type: str
    detail: str


@dataclass
class ArtifactPolicyViolation:
    artifact_path: str
    generated_path: str
    reason: str


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Fail when generated Python notebooks contain publication-blocking hygiene issues or raw R-only constructs."
    )
    parser.add_argument(
        "--input-dir",
        required=True,
        help="Directory containing generated Python notebooks.",
    )
    parser.add_argument(
        "--checks",
        choices=["strict", "hygiene"],
        default="strict",
        help=(
            "Validation profile: 'strict' checks hygiene + raw R-only constructs; "
            "'hygiene' checks only outputs/execution_count hygiene (for pre-publication gates)."
        ),
    )
    parser.add_argument(
        "--published-dir",
        help=(
            "Optional directory containing published Python notebooks "
            "(e.g. notebooks/workshops). When provided, validates generated-artifact "
            "edit policy by checking that published notebooks match canonical generated outputs."
        ),
    )
    return parser.parse_args()


def normalize_source(cell: dict) -> str:
    source = cell.get("source", [])
    if isinstance(source, list):
        return "".join(source)
    return str(source)


def check_notebook(path: Path, include_raw_r_checks: bool) -> list[Violation]:
    notebook = json.loads(path.read_text(encoding="utf-8"))
    violations: list[Violation] = []

    for index, cell in enumerate(notebook.get("cells", []), start=1):
        if cell.get("cell_type") != "code":
            continue

        execution_count = cell.get("execution_count")
        if execution_count is not None:
            violations.append(
                Violation(
                    notebook_path=str(path),
                    cell_number=index,
                    violation_type="execution_count",
                    detail=f"execution_count is {execution_count}",
                )
            )

        outputs = cell.get("outputs")
        if isinstance(outputs, list) and len(outputs) > 0:
            violations.append(
                Violation(
                    notebook_path=str(path),
                    cell_number=index,
                    violation_type="outputs",
                    detail=f"outputs present ({len(outputs)} outputs)",
                )
            )

        if not include_raw_r_checks:
            continue

        source = normalize_source(cell)

        # Chapter 5 intentionally includes an R bridge bootstrap that loads R
        # packages via ro.r("... library(...) ..."); this is expected Python code.
        trace = cell.get("metadata", {}).get("traceability", {})
        block_id = trace.get("block_id")

        for pattern in R_ONLY_PATTERNS:
            if (
                pattern.pattern == r"\blibrary\s*\("
                and block_id == "regression-analysis-bootstrap"
                and "ro.r(" in source
            ):
                continue

            match = pattern.search(source)
            if not match:
                continue
            snippet = source[max(0, match.start() - 80) : min(len(source), match.end() + 120)]
            snippet_preview = snippet.replace(chr(10), "\\n")
            violations.append(
                Violation(
                    notebook_path=str(path),
                    cell_number=index,
                    violation_type="raw_r_construct",
                    detail=(
                        f"raw R-only construct matched {pattern.pattern}; "
                        f"snippet: {snippet_preview}"
                    ),
                )
            )

    return violations


def report_hygiene_violations(violations: list[Violation]) -> None:
    by_notebook: dict[str, list[Violation]] = {}
    for violation in violations:
        by_notebook.setdefault(violation.notebook_path, []).append(violation)

    print("Notebook hygiene check failed.")
    for notebook_path in sorted(by_notebook):
        print()
        print(notebook_path)
        for violation in by_notebook[notebook_path]:
            if violation.violation_type == "outputs":
                print(f"  Cell {violation.cell_number}: contains outputs")
            elif violation.violation_type == "execution_count":
                print(f"  Cell {violation.cell_number}: execution_count={violation.detail.removeprefix('execution_count is ')}")

    print()
    print("Publication aborted.")


def canonical_notebook_json(path: Path) -> str:
    notebook = json.loads(path.read_text(encoding="utf-8"))
    return json.dumps(notebook, ensure_ascii=False, sort_keys=True, indent=2) + "\n"


def relpath_or_abs(path: Path) -> str:
    try:
        return str(path.relative_to(Path.cwd()))
    except ValueError:
        return str(path)


def collect_expected_published_mapping(
    generated_notebooks: list[Path],
) -> tuple[dict[str, Path], list[ArtifactPolicyViolation]]:
    expected: dict[str, Path] = {}
    violations: list[ArtifactPolicyViolation] = []

    for generated_path in generated_notebooks:
        notebook = json.loads(generated_path.read_text(encoding="utf-8"))
        renderer_meta = notebook.get("metadata", {}).get("ada_renderer", {})
        chapter_number = renderer_meta.get("chapter_number")

        try:
            chapter = int(chapter_number)
        except (TypeError, ValueError):
            violations.append(
                ArtifactPolicyViolation(
                    artifact_path="<unknown>",
                    generated_path=relpath_or_abs(generated_path),
                    reason=(
                        "Missing or invalid metadata.ada_renderer.chapter_number in generated notebook; "
                        "cannot determine published artifact mapping."
                    ),
                )
            )
            continue

        published_name = f"Workshop {chapter} (Python).ipynb"
        if published_name in expected:
            violations.append(
                ArtifactPolicyViolation(
                    artifact_path=published_name,
                    generated_path=relpath_or_abs(generated_path),
                    reason=(
                        "Multiple generated notebooks map to the same published artifact name; "
                        "workshop chapter mapping is ambiguous."
                    ),
                )
            )
            continue
        expected[published_name] = generated_path

    return expected, violations


def check_generated_artifact_edit_policy(
    generated_notebooks: list[Path],
    published_dir: Path,
) -> list[ArtifactPolicyViolation]:
    violations: list[ArtifactPolicyViolation] = []
    expected, mapping_violations = collect_expected_published_mapping(generated_notebooks)
    violations.extend(mapping_violations)

    for published_name, generated_path in sorted(expected.items()):
        artifact_path = published_dir / published_name
        if not artifact_path.exists():
            violations.append(
                ArtifactPolicyViolation(
                    artifact_path=relpath_or_abs(artifact_path),
                    generated_path=relpath_or_abs(generated_path),
                    reason=(
                        "Published artifact is missing for this generated notebook mapping."
                    ),
                )
            )
            continue

        if canonical_notebook_json(generated_path) != canonical_notebook_json(artifact_path):
            violations.append(
                ArtifactPolicyViolation(
                    artifact_path=relpath_or_abs(artifact_path),
                    generated_path=relpath_or_abs(generated_path),
                    reason=(
                        "Published artifact content differs from canonical generated notebook output. "
                        "This indicates manual edits or out-of-sync publication artifacts."
                    ),
                )
            )

    published_python = sorted(published_dir.glob("Workshop * (Python).ipynb"))
    expected_names = set(expected.keys())
    for artifact_path in published_python:
        if artifact_path.name in expected_names:
            continue
        violations.append(
            ArtifactPolicyViolation(
                artifact_path=relpath_or_abs(artifact_path),
                generated_path="<no canonical generated counterpart>",
                reason=(
                    "Published Python notebook does not map to current workshop export configuration."
                ),
            )
        )

    return violations


def report_artifact_policy_violations(violations: list[ArtifactPolicyViolation]) -> None:
    print("Generated artifact policy violation detected.")

    for violation in violations:
        print()
        print("Artifact:")
        print(f"  {violation.artifact_path}")
        print()
        print("This file is generated and must not be edited directly.")
        print()
        print("Reason:")
        print(f"  {violation.reason}")
        print(f"  Expected generated source: {violation.generated_path}")
        print()
        print("Remediation:")
        print("  1. Update canonical source content under notebooks/support/**/support.Rmd.")
        print("  2. Regenerate Python notebooks:")
        print("     Rscript scripts/export-python-notebooks.R --output-dir generated/python-notebooks")
        print("  3. Republish mapped notebooks:")
        print("     Rscript scripts/publish-python-notebooks.R --input-dir generated/python-notebooks --output-dir notebooks/workshops")
        print("  4. Commit regenerated outputs.")

    print()
    print("Validation failed.")


def report_violations(violations: list[Violation]) -> None:
    by_notebook: dict[str, list[Violation]] = {}
    for violation in violations:
        by_notebook.setdefault(violation.notebook_path, []).append(violation)

    print("Strict Python notebook guardrail failed")
    for notebook_path in sorted(by_notebook):
        print()
        print(f"Notebook: {notebook_path}")
        for violation in by_notebook[notebook_path]:
            print(f"  Cell {violation.cell_number}: {violation.detail}")

    notebook_count = len(by_notebook)
    print()
    print(
        f"Validation failed: {notebook_count} notebook"
        f"{'s' if notebook_count != 1 else ''} contain execution artifacts or raw R-only constructs."
    )
    print(
        "Remediation: regenerate clean distribution notebooks; do not publish executed notebooks or notebooks with raw R-only syntax."
    )


def main() -> None:
    args = parse_args()
    input_dir = Path(args.input_dir)
    published_dir = Path(args.published_dir) if args.published_dir else None
    include_raw_r_checks = args.checks == "strict"

    notebooks = sorted(input_dir.rglob("*.ipynb"))
    if not notebooks:
        raise FileNotFoundError(
            f"No notebooks found under {input_dir}. Remediation: run scripts/export-python-notebooks.R first."
        )

    violations: list[Violation] = []
    for notebook in notebooks:
        violations.extend(check_notebook(notebook, include_raw_r_checks=include_raw_r_checks))

    if violations:
        if include_raw_r_checks:
            report_violations(violations)
        else:
            report_hygiene_violations(violations)
        raise SystemExit(1)

    if published_dir is not None:
        if not published_dir.exists():
            raise FileNotFoundError(
                f"Published notebook directory not found: {published_dir}. "
                "Remediation: ensure the workbooks submodule is checked out before policy validation."
            )

        artifact_policy_violations = check_generated_artifact_edit_policy(notebooks, published_dir)
        if artifact_policy_violations:
            report_artifact_policy_violations(artifact_policy_violations)
            raise SystemExit(1)

        if include_raw_r_checks:
            print("Strict Python notebook guardrail passed: no execution artifacts or raw R-only constructs detected")
        else:
            print("Notebook hygiene check passed: no outputs or execution_count artifacts detected")
        print("Generated artifact edit-policy check passed: published notebooks match canonical generated outputs")
        return

    if include_raw_r_checks:
        print("Strict Python notebook guardrail passed: no execution artifacts or raw R-only constructs detected")
    else:
        print("Notebook hygiene check passed: no outputs or execution_count artifacts detected")


if __name__ == "__main__":
    main()
