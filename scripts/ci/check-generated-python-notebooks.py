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
    re.compile(r"::"),
]


@dataclass
class Violation:
    notebook_path: str
    cell_number: int
    pattern: str
    snippet: str


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Fail when generated Python notebooks contain raw R-only constructs."
    )
    parser.add_argument(
        "--input-dir",
        required=True,
        help="Directory containing generated Python notebooks.",
    )
    return parser.parse_args()


def normalize_source(cell: dict) -> str:
    source = cell.get("source", [])
    if isinstance(source, list):
        return "".join(source)
    return str(source)


def check_notebook(path: Path) -> list[Violation]:
    notebook = json.loads(path.read_text(encoding="utf-8"))
    violations: list[Violation] = []

    for index, cell in enumerate(notebook.get("cells", []), start=1):
        if cell.get("cell_type") != "code":
            continue
        source = normalize_source(cell)

        for pattern in R_ONLY_PATTERNS:
            match = pattern.search(source)
            if not match:
                continue
            snippet = source[max(0, match.start() - 80) : min(len(source), match.end() + 120)]
            violations.append(
                Violation(
                    notebook_path=str(path),
                    cell_number=index,
                    pattern=pattern.pattern,
                    snippet=snippet.replace("\n", "\\n"),
                )
            )

    return violations


def main() -> None:
    args = parse_args()
    input_dir = Path(args.input_dir)

    notebooks = sorted(input_dir.rglob("*.ipynb"))
    if not notebooks:
        raise FileNotFoundError(
            f"No notebooks found under {input_dir}. Remediation: run scripts/export-python-notebooks.R first."
        )

    violations: list[Violation] = []
    for notebook in notebooks:
        violations.extend(check_notebook(notebook))

    if not violations:
        print("Strict Python notebook guardrail passed: no raw R-only constructs detected")
        return

    print("Strict Python notebook guardrail failed")
    for violation in violations:
        print("---")
        print(f"Notebook: {violation.notebook_path}")
        print(f"Cell: {violation.cell_number}")
        print(f"Matched pattern: {violation.pattern}")
        print(f"Snippet: {violation.snippet}")
    print("Remediation: add or fix Python overrides so generated Python notebooks do not emit raw R-only syntax.")
    raise SystemExit(1)


if __name__ == "__main__":
    main()
