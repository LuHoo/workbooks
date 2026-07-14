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
            violations.append(
                Violation(
                    notebook_path=str(path),
                    cell_number=index,
                    violation_type="raw_r_construct",
                    detail=(
                        f"raw R-only construct matched {pattern.pattern}; "
                        f"snippet: {snippet.replace(chr(10), '\\n')}"
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
    include_raw_r_checks = args.checks == "strict"

    notebooks = sorted(input_dir.rglob("*.ipynb"))
    if not notebooks:
        raise FileNotFoundError(
            f"No notebooks found under {input_dir}. Remediation: run scripts/export-python-notebooks.R first."
        )

    violations: list[Violation] = []
    for notebook in notebooks:
        violations.extend(check_notebook(notebook, include_raw_r_checks=include_raw_r_checks))

    if not violations:
        if include_raw_r_checks:
            print("Strict Python notebook guardrail passed: no execution artifacts or raw R-only constructs detected")
        else:
            print("Notebook hygiene check passed: no outputs or execution_count artifacts detected")
        return

    if include_raw_r_checks:
        report_violations(violations)
    else:
        report_hygiene_violations(violations)
    raise SystemExit(1)


if __name__ == "__main__":
    main()
