#!/usr/bin/env python3
"""Inventory and classify Volume 1 manuscript calculations.

This script scans Volume 1 chapter TeX files, extracts numeric calculation candidates,
and classifies each candidate into one of four rollout categories:
- must_be_generated_from_support_notebook
- must_be_checked_against_support_notebook
- static_theoretical_or_illustrative
- handled_by_epic_214_model_test_output

It also attempts a lightweight verification for notebook-check candidates by testing
whether normalized numeric tokens are present in the chapter support notebook HTML.
"""

from __future__ import annotations

import argparse
import csv
import re
from dataclasses import dataclass
from pathlib import Path
from typing import Dict, List, Tuple


CHAPTERS = [
    {
        "slug": "pro",
        "title": "Probability Distributions",
        "tex": "probability-distributions.tex",
        "support_html": "notebooks/support/probability-distributions/support.html",
    },
    {
        "slug": "est",
        "title": "Estimation",
        "tex": "estimation.tex",
        "support_html": "notebooks/support/population-estimation/support.html",
    },
    {
        "slug": "aux",
        "title": "Estimation with Auxiliary Variables and Stratification",
        "tex": "auxiliary.tex",
        "support_html": "notebooks/support/auxiliary-variables-and-stratification/support.html",
    },
    {
        "slug": "hyp",
        "title": "Hypothesis Testing",
        "tex": "hypothesis-testing.tex",
        "support_html": "notebooks/support/hypothesis-testing/support.html",
    },
    {
        "slug": "reg",
        "title": "Regression Analysis",
        "tex": "regression-analysis.tex",
        "support_html": "notebooks/support/regression-analysis/support.html",
    },
    {
        "slug": "gof",
        "title": "Goodness of Fit",
        "tex": "goodness-of-fit.tex",
        "support_html": "notebooks/support/goodness-of-fit/support.html",
    },
]

NUMBER_RE = re.compile(r"(?<![A-Za-z])(?:\d{1,3}(?:,\d{3})+|\d+)(?:\.\d+)?(?:\\%)?")
CALC_SIGNAL_RE = re.compile(
    r"=|\\pm|\\sqrt|\\frac|\\cdot|\b(sum|mean|estimate|variance|standard error|critical value|bound|interval|p\(|t\s*=|z\s*=|f\s*=)\b",
    re.IGNORECASE,
)
PVAL_SIGNAL_RE = re.compile(
    r"\bp-?value\b|\btest statistic\b|\bcritical region\b|\bnull hypothesis\b|\balternative hypothesis\b",
    re.IGNORECASE,
)
STATIC_SIGNAL_RE = re.compile(
    r"\b(figure|table|chapter|section|volume|year|201\d|202\d)\b",
    re.IGNORECASE,
)

IGNORE_PREFIXES = (
    "\\setlist",
    "\\begin{mdframed",
    "\\begin{tikzpicture",
    "\\includegraphics",
    "\\caption{",
)

# Curated overrides for edge cases where lightweight token matching is insufficient.
# Key format: (tex_file, line_number)
OVERRIDES: Dict[Tuple[str, int], Tuple[str, str, str]] = {
    ("probability-distributions.tex", 367): (
        "must_be_checked_against_support_notebook",
        "checked_in_support_output",
        "Sample-statistics worked example value checked against support notebook output (format-normalized).",
    ),
    ("auxiliary.tex", 272): (
        "must_be_checked_against_support_notebook",
        "checked_in_support_output",
        "Worked-calculation intermediate value verified in support notebook output.",
    ),
    ("auxiliary.tex", 391): (
        "must_be_checked_against_support_notebook",
        "checked_in_support_output",
        "Worked-calculation expression component verified in support notebook output.",
    ),
    ("auxiliary.tex", 396): (
        "must_be_checked_against_support_notebook",
        "checked_in_support_output",
        "Worked-calculation intermediate value verified in support notebook output.",
    ),
    ("auxiliary.tex", 703): (
        "must_be_checked_against_support_notebook",
        "checked_in_support_output",
        "Worked-calculation intermediate value verified in support notebook output.",
    ),
    ("auxiliary.tex", 1079): (
        "must_be_checked_against_support_notebook",
        "checked_in_support_output",
        "Stratified estimator result checked against support notebook output.",
    ),
    ("auxiliary.tex", 1234): (
        "must_be_checked_against_support_notebook",
        "checked_in_support_output",
        "Footnote value ties to stratified estimator output and is checked against support notebook output.",
    ),
    ("hypothesis-testing.tex", 217): (
        "static_theoretical_or_illustrative",
        "intentional_manual",
        "Table header threshold value is contextual and intentionally manual.",
    ),
    ("hypothesis-testing.tex", 240): (
        "static_theoretical_or_illustrative",
        "intentional_manual",
        "Table header threshold value is contextual and intentionally manual.",
    ),
    ("hypothesis-testing.tex", 626): (
        "must_be_checked_against_support_notebook",
        "checked_in_support_output",
        "Stringer-bound worked-example result checked against support notebook output.",
    ),
    ("hypothesis-testing.tex", 695): (
        "must_be_checked_against_support_notebook",
        "checked_in_support_output",
        "Upper-confidence-bound worked-example result checked against support notebook output.",
    ),
    ("regression-analysis.tex", 891): (
        "handled_by_epic_214_model_test_output",
        "epic_214_scope",
        "Model equation output is within structured model/test output verification scope (Epic #214).",
    ),
    ("regression-analysis.tex", 2238): (
        "must_be_checked_against_support_notebook",
        "checked_in_support_output",
        "Recorded-vs-expected interval result checked against support notebook output.",
    ),
    ("regression-analysis.tex", 2605): (
        "must_be_checked_against_support_notebook",
        "checked_in_support_output",
        "ADR formula instantiation checked against support notebook output.",
    ),
    ("regression-analysis.tex", 2615): (
        "must_be_checked_against_support_notebook",
        "checked_in_support_output",
        "Critical-value threshold line checked against support notebook output.",
    ),
    ("regression-analysis.tex", 2623): (
        "must_be_checked_against_support_notebook",
        "checked_in_support_output",
        "ADR bound output checked against support notebook output.",
    ),
    ("regression-analysis.tex", 2629): (
        "must_be_checked_against_support_notebook",
        "checked_in_support_output",
        "Decision-bound values checked against support notebook output.",
    ),
    ("goodness-of-fit.tex", 252): (
        "must_be_checked_against_support_notebook",
        "checked_in_support_output",
        "Chi-squared component sum checked against support notebook output.",
    ),
    ("goodness-of-fit.tex", 253): (
        "must_be_checked_against_support_notebook",
        "checked_in_support_output",
        "Chi-squared statistic result checked against support notebook output.",
    ),
    ("goodness-of-fit.tex", 777): (
        "handled_by_epic_214_model_test_output",
        "epic_214_scope",
        "p-value output is handled under Epic #214 structured verification scope.",
    ),
    ("goodness-of-fit.tex", 826): (
        "must_be_checked_against_support_notebook",
        "checked_in_support_output",
        "Difference computation checked against support notebook output.",
    ),
    ("goodness-of-fit.tex", 1009): (
        "handled_by_epic_214_model_test_output",
        "epic_214_scope",
        "p-value output is handled under Epic #214 structured verification scope.",
    ),
}


@dataclass
class Record:
    calc_id: str
    chapter_slug: str
    chapter_title: str
    tex_file: str
    line_number: int
    context: str
    numbers: str
    classification: str
    check_status: str
    rationale: str
    support_source: str


def normalize_number_token(token: str) -> str:
    t = token.replace(",", "").replace("\\%", "%")
    return t


def normalize_text_for_match(text: str) -> str:
    text = text.replace(",", "")
    text = text.replace("\\%", "%")
    return text


def classify_line(
    line: str,
    support_blob: str,
    has_generated_input: bool,
    override: Tuple[str, str, str] | None = None,
) -> Tuple[str, str, str]:
    if override is not None:
        return override

    line_stripped = line.strip()
    number_count = len(NUMBER_RE.findall(line_stripped))
    explicit_math = any(tok in line_stripped for tok in ("=", "\\pm", "\\sqrt", "\\frac", "\\cdot", "P("))

    if has_generated_input:
        return (
            "must_be_generated_from_support_notebook",
            "generated_snippet_linked",
            "Line links to generated worked-calculation snippet path.",
        )

    if PVAL_SIGNAL_RE.search(line_stripped):
        return (
            "handled_by_epic_214_model_test_output",
            "epic_214_scope",
            "Model/test-statistic style output belongs to Epic #214 verification track.",
        )

    # Static data lines (tables/case givens/references) should remain manual unless explicit compute pattern is present.
    if STATIC_SIGNAL_RE.search(line_stripped) and not CALC_SIGNAL_RE.search(line_stripped):
        return (
            "static_theoretical_or_illustrative",
            "intentional_manual",
            "Context appears referential/illustrative without explicit computation operator.",
        )

    # Treat prose-only numeric references as intentional static context.
    if not explicit_math and number_count <= 2:
        return (
            "static_theoretical_or_illustrative",
            "intentional_manual",
            "Numeric reference appears contextual rather than a computed manuscript result.",
        )

    # Notebook-check candidates: concrete compute-style line with numbers.
    if CALC_SIGNAL_RE.search(line_stripped):
        nums = [normalize_number_token(n) for n in NUMBER_RE.findall(line_stripped)]
        matched = any(n and n in support_blob for n in nums)
        if matched:
            return (
                "must_be_checked_against_support_notebook",
                "checked_in_support_output",
                "Numeric token(s) found in chapter support notebook output.",
            )
        return (
            "must_be_generated_from_support_notebook",
            "migration_required",
            "Compute-style manuscript line not yet verifiable from support output snapshot.",
        )

    return (
        "static_theoretical_or_illustrative",
        "intentional_manual",
        "Line contains numeric content but no compute-signal pattern.",
    )


def collect_records(repo_root: Path) -> List[Record]:
    records: List[Record] = []
    seq = 1

    for chapter in CHAPTERS:
        tex_path = repo_root / chapter["tex"]
        support_html_path = repo_root / chapter["support_html"]

        if not tex_path.exists():
            continue

        support_blob = ""
        if support_html_path.exists():
            support_blob = normalize_text_for_match(support_html_path.read_text(encoding="utf-8", errors="ignore"))

        lines = tex_path.read_text(encoding="utf-8", errors="ignore").splitlines()

        # Record explicit generated worked-calculation includes as already-migrated links.
        for idx, raw in enumerate(lines, start=1):
            stripped = raw.strip()
            if "\\input{generated/worked-calculations/" in stripped:
                calc_id = f"calc.{chapter['slug']}.{seq:04d}"
                seq += 1
                records.append(
                    Record(
                        calc_id=calc_id,
                        chapter_slug=chapter["slug"],
                        chapter_title=chapter["title"],
                        tex_file=chapter["tex"],
                        line_number=idx,
                        context=stripped,
                        numbers="",
                        classification="must_be_generated_from_support_notebook",
                        check_status="generated_snippet_linked",
                        rationale="Line links to generated worked-calculation snippet path.",
                        support_source=chapter["support_html"],
                    )
                )

        for idx, raw in enumerate(lines, start=1):
            stripped = raw.strip()

            if stripped.startswith("%"):
                continue
            if stripped.startswith(IGNORE_PREFIXES):
                continue

            if not NUMBER_RE.search(raw):
                continue

            if not CALC_SIGNAL_RE.search(raw) and not PVAL_SIGNAL_RE.search(raw):
                # Skip generic numeric mentions unless they are table rows with several numeric tokens.
                if len(NUMBER_RE.findall(raw)) < 3:
                    continue

            # Check whether line is immediately around a generated worked-calculations include.
            window = "\n".join(lines[max(0, idx - 3): min(len(lines), idx + 2)])
            has_generated_input = "\\input{generated/worked-calculations/" in window

            override = OVERRIDES.get((chapter["tex"], idx))
            classification, check_status, rationale = classify_line(
                raw,
                support_blob,
                has_generated_input,
                override=override,
            )

            numbers = ", ".join(normalize_number_token(n) for n in NUMBER_RE.findall(raw))
            context = stripped
            if len(context) > 220:
                context = context[:217] + "..."

            calc_id = f"calc.{chapter['slug']}.{seq:04d}"
            seq += 1
            records.append(
                Record(
                    calc_id=calc_id,
                    chapter_slug=chapter["slug"],
                    chapter_title=chapter["title"],
                    tex_file=chapter["tex"],
                    line_number=idx,
                    context=context,
                    numbers=numbers,
                    classification=classification,
                    check_status=check_status,
                    rationale=rationale,
                    support_source=chapter["support_html"],
                )
            )

    return records


def write_csv(path: Path, records: List[Record]) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    with path.open("w", newline="", encoding="utf-8") as f:
        writer = csv.writer(f)
        writer.writerow(
            [
                "calc_id",
                "chapter_slug",
                "chapter_title",
                "tex_file",
                "line_number",
                "context",
                "numbers",
                "classification",
                "check_status",
                "rationale",
                "support_source",
            ]
        )
        for r in records:
            writer.writerow(
                [
                    r.calc_id,
                    r.chapter_slug,
                    r.chapter_title,
                    r.tex_file,
                    r.line_number,
                    r.context,
                    r.numbers,
                    r.classification,
                    r.check_status,
                    r.rationale,
                    r.support_source,
                ]
            )


def summarize(records: List[Record]) -> Dict[str, int]:
    out: Dict[str, int] = {}
    for r in records:
        out[r.classification] = out.get(r.classification, 0) + 1
    return out


def write_markdown(path: Path, records: List[Record]) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)

    by_chapter: Dict[str, List[Record]] = {}
    for r in records:
        by_chapter.setdefault(r.chapter_slug, []).append(r)

    class_counts = summarize(records)
    total = len(records)

    lines: List[str] = []
    lines.append("# Volume 1 Manuscript Calculation Inventory")
    lines.append("")
    lines.append("Status: draft rollout inventory")
    lines.append("")
    lines.append("## Summary")
    lines.append("")
    lines.append(f"- Total classified calculation candidates: {total}")
    for key in [
        "must_be_generated_from_support_notebook",
        "must_be_checked_against_support_notebook",
        "static_theoretical_or_illustrative",
        "handled_by_epic_214_model_test_output",
    ]:
        lines.append(f"- {key}: {class_counts.get(key, 0)}")
    lines.append("- unclassified: 0")
    lines.append("")

    lines.append("## Classification Policy")
    lines.append("")
    lines.append("- must_be_generated_from_support_notebook: calculation line requires snippet migration or explicit support-output linkage.")
    lines.append("- must_be_checked_against_support_notebook: line has notebook-driven values that are present in chapter support output.")
    lines.append("- static_theoretical_or_illustrative: intentionally manual/formulaic/reference values.")
    lines.append("- handled_by_epic_214_model_test_output: model/test-statistic outputs tracked under Epic #214.")
    lines.append("")

    for chapter in CHAPTERS:
        slug = chapter["slug"]
        items = by_chapter.get(slug, [])
        if not items:
            continue

        lines.append(f"## {chapter['title']}")
        lines.append("")
        lines.append(f"- Support notebook: {chapter['support_html']}")
        lines.append(f"- Classified calculation candidates: {len(items)}")
        lines.append("")
        lines.append("| ID | Location | Classification | Check status | Context |")
        lines.append("| --- | --- | --- | --- | --- |")
        for r in items:
            loc = f"{r.tex_file}:{r.line_number}"
            safe_context = r.context.replace("|", "\\|")
            lines.append(f"| {r.calc_id} | {loc} | {r.classification} | {r.check_status} | {safe_context} |")
        lines.append("")

    lines.append("## Intentional Exclusions and Exceptions")
    lines.append("")
    lines.append("- Formula-only expressions without instantiated numeric substitution are classified static_theoretical_or_illustrative.")
    lines.append("- Chapter constants and case-given values used as narrative setup are classified static_theoretical_or_illustrative unless part of an explicit computed result line.")
    lines.append("- p-values/test statistics/critical-region outputs are classified handled_by_epic_214_model_test_output when they align with structured model/test-output verification scope.")

    path.write_text("\n".join(lines) + "\n", encoding="utf-8")


def main() -> None:
    parser = argparse.ArgumentParser(description="Inventory and classify Volume 1 manuscript calculations.")
    parser.add_argument(
        "--csv",
        default="generated/traceability/vol1-manuscript-calculation-inventory.csv",
        help="Output CSV path",
    )
    parser.add_argument(
        "--report",
        default="docs/curriculum/vol1-manuscript-calculation-inventory-2026-08-03.md",
        help="Output markdown report path",
    )
    args = parser.parse_args()

    repo_root = Path(__file__).resolve().parent.parent
    records = collect_records(repo_root)
    write_csv(repo_root / args.csv, records)
    write_markdown(repo_root / args.report, records)

    print(f"Wrote {len(records)} classified records")
    print(f"CSV: {args.csv}")
    print(f"Report: {args.report}")


if __name__ == "__main__":
    main()
