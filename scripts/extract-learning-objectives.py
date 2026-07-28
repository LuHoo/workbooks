#!/usr/bin/env python3
"""
Extract learning objectives from Volume 1 chapter manuscripts and generate
metadata/traceability entries compatible with metadata/traceability/learning_objectives.yml.

Chapter-to-ID mapping follows the Volume 1 workshop sequence convention used
in existing metadata IDs (C1–C6 = workshop 1–6 = chapter sequence in Volume 1):
  C1 = Probability Distributions   (probability-distributions.tex)
  C2 = Estimation                   (estimation.tex)
  C3 = Stratified Sampling          (auxiliary.tex)
  C4 = Hypothesis Testing           (hypothesis-testing.tex)
  C5 = Regression Analysis          (regression-analysis.tex)
  C6 = Goodness of Fit              (goodness-of-fit.tex)

Bloom-to-competency mapping (from learning-philosophy-vol1.md):
  remember, apply        → technical_skills
  understand, analyze    → statistical_reasoning
  evaluate, create       → professional_judgment

Usage:
  python3 scripts/extract-learning-objectives.py           # print new entries to stdout
  python3 scripts/extract-learning-objectives.py --append  # append to learning_objectives.yml
  python3 scripts/extract-learning-objectives.py --diff    # compare extracted vs existing
  python3 scripts/extract-learning-objectives.py --stats   # show summary table only
"""

import re
import sys
import argparse
from pathlib import Path

# ---------------------------------------------------------------------------
# Chapter configuration
# existing_seq: highest sequence number already used in learning_objectives.yml
# for this chapter's chapter-level (LO-C{n}-xx) IDs; new IDs start from seq+1.
# ---------------------------------------------------------------------------
CHAPTERS = [
    {
        "title": "Probability distributions",
        "file": "probability-distributions.tex",
        "c_num": 1,
        "existing_seq": 1,   # LO-C1-01 exists
    },
    {
        "title": "Estimating the population mean and proportion",
        "file": "estimation.tex",
        "c_num": 2,
        "existing_seq": 0,   # no LO-C2-xx yet
    },
    {
        "title": "Estimation with auxiliary variables and stratification",
        "file": "auxiliary.tex",
        "c_num": 3,
        "existing_seq": 1,   # LO-C3-01 exists
    },
    {
        "title": "Hypothesis testing",
        "file": "hypothesis-testing.tex",
        "c_num": 4,
        "existing_seq": 1,   # LO-C4-01 exists
    },
    {
        "title": "Regression analysis",
        "file": "regression-analysis.tex",
        "c_num": 5,
        "existing_seq": 1,   # LO-C5-01 exists
    },
    {
        "title": "Goodness of fit",
        "file": "goodness-of-fit.tex",
        "c_num": 6,
        "existing_seq": 2,   # LO-C6-01 and LO-C6-02 exist
    },
]

BLOOM_LEVELS = ["remember", "understand", "apply", "analyze", "evaluate", "create"]

BLOOM_TO_COMPETENCY = {
    "remember":   "technical_skills",
    "understand": "statistical_reasoning",
    "apply":      "technical_skills",
    "analyze":    "statistical_reasoning",
    "evaluate":   "professional_judgment",
    "create":     "professional_judgment",
}

# ---------------------------------------------------------------------------
# LaTeX cleanup
# ---------------------------------------------------------------------------

def clean_latex(text: str) -> str:
    """Convert LaTeX markup to plain readable text."""
    # LaTeX em dashes and en dashes
    text = text.replace("---", "\u2014").replace("--", "\u2013")
    # Hyphenation hints: \-
    text = re.sub(r'\\-', '', text)
    # \textsuperscript{X} → ^X  (e.g. R^2)
    text = re.sub(r'\\textsuperscript\{([^}]+)\}', r'^\1', text)
    # \textsubscript{X} → _X
    text = re.sub(r'\\textsubscript\{([^}]+)\}', r'_\1', text)
    # Common math symbols before stripping dollar signs
    math_symbols = {
        r'\chi': 'χ', r'\alpha': 'α', r'\beta': 'β', r'\gamma': 'γ',
        r'\delta': 'δ', r'\epsilon': 'ε', r'\sigma': 'σ', r'\mu': 'μ',
        r'\pi': 'π', r'\phi': 'φ', r'\lambda': 'λ', r'\theta': 'θ',
        r'\leq': '≤', r'\geq': '≥', r'\neq': '≠', r'\approx': '≈',
        r'\infty': '∞', r'\pm': '±',
    }
    for latex_sym, unicode_sym in math_symbols.items():
        text = text.replace(latex_sym, unicode_sym)
    # Inline math $...$ → keep content, strip delimiters
    text = re.sub(r'\$([^$]+)\$', r'\1', text)
    # Remove remaining lone $ signs
    text = text.replace('$', '')
    # Commands whose argument should be kept
    for cmd in ["emph", "textit", "textbf", "textsc", "hlblue", "text"]:
        text = re.sub(rf'\\{cmd}\{{([^}}]+)\}}', r'\1', text)
    # Commands whose content should be discarded
    for cmd in ["index", "label", "footnote", "nomenclature"]:
        text = re.sub(rf'\\{cmd}\{{[^}}]*\}}', '', text)
    # Remaining LaTeX commands (no argument)
    text = re.sub(r'\\[a-zA-Z]+\*?\s*', ' ', text)
    # Remove stray braces
    text = text.replace('{', '').replace('}', '')
    # Normalize whitespace
    text = ' '.join(text.split()).strip()
    return text


# ---------------------------------------------------------------------------
# LO extraction
# ---------------------------------------------------------------------------

def extract_lo_section(content: str) -> str | None:
    """Return the raw text of the Learning Objectives section."""
    match = re.search(
        r'\\section\*\s*\{\s*Learning\s+[Oo]bjectives\s*\}(.*?)(?=\\section)',
        content,
        re.DOTALL,
    )
    return match.group(1) if match else None


def extract_items_for_level(lo_section: str, level: str) -> list[str]:
    """
    Return cleaned item texts for a given Bloom level.
    Handles the pattern: \\textsc{level} ... \\begin{itemize} ... \\end{itemize}
    """
    # Find the itemize block that follows \textsc{level}
    pattern = (
        rf'\\textsc\s*\{{\s*{re.escape(level)}\s*\}}'   # \textsc{level}
        r'.*?'                                            # anything (incl. \noindent etc.)
        r'\\begin\{itemize\}(.*?)\\end\{itemize\}'        # itemize block
    )
    match = re.search(pattern, lo_section, re.DOTALL | re.IGNORECASE)
    if not match:
        return []

    raw = match.group(1)
    # Each item starts with \item; items are one per line in this corpus
    items = re.findall(r'\\item\s+([^\n]+)', raw)
    return [clean_latex(item) for item in items if item.strip()]


def extract_los_from_file(filepath: str) -> dict[str, list[str]]:
    """
    Extract all learning objectives from a chapter .tex file.
    Returns {bloom_level: [item_text, ...]} ordered by Bloom level.
    """
    with open(filepath, encoding="utf-8") as f:
        content = f.read()

    lo_section = extract_lo_section(content)
    if lo_section is None:
        return {}

    result = {}
    for level in BLOOM_LEVELS:
        items = extract_items_for_level(lo_section, level)
        if items:
            result[level] = items
    return result


# ---------------------------------------------------------------------------
# YAML entry generation
# ---------------------------------------------------------------------------

def generate_entries(chapter: dict, los: dict[str, list[str]]) -> list[dict]:
    """
    Generate new learning_objectives.yml-compatible entries for a chapter.
    Sequences start after chapter["existing_seq"] to avoid conflicts.
    """
    entries = []
    seq = chapter["existing_seq"] + 1
    c_num = chapter["c_num"]

    for level in BLOOM_LEVELS:
        for text in los.get(level, []):
            entries.append({
                "id": f"LO-C{c_num}-{seq:02d}",
                "chapter": c_num,
                "scope": "chapter",
                "text": text,
                "bloom": level,
                "competency": BLOOM_TO_COMPETENCY[level],
                "status": "active",
                "source": "manuscript",
            })
            seq += 1

    return entries


def format_yaml_entry(entry: dict) -> str:
    """Render a single entry as YAML text (no PyYAML dependency required)."""
    text = entry["text"]
    # Quote text if it contains special YAML characters
    needs_quotes = any(c in text for c in [':', '#', '[', ']', '{', '}', '&', '*', '!', '|', '>', "'", '"', '%', '@', '`'])
    if needs_quotes:
        # Use double-quote style, escaping internal double quotes
        text_yaml = '"' + text.replace('\\', '\\\\').replace('"', '\\"') + '"'
    else:
        text_yaml = text

    lines = [
        f"- id: {entry['id']}",
        f"  chapter: {entry['chapter']}",
        f"  scope: {entry['scope']}",
        f"  text: {text_yaml}",
        f"  bloom: {entry['bloom']}",
        f"  competency: {entry['competency']}",
        f"  status: {entry['status']}",
        f"  source: {entry['source']}",
    ]
    return "\n".join(lines)


# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------

def main():
    parser = argparse.ArgumentParser(description="Extract LOs from chapter manuscripts.")
    parser.add_argument("--append", action="store_true", help="Append new entries to learning_objectives.yml")
    parser.add_argument("--diff", action="store_true", help="Show which LOs are new vs already present")
    parser.add_argument("--stats", action="store_true", help="Print summary statistics only")
    args = parser.parse_args()

    yml_path = Path("metadata/traceability/learning_objectives.yml")

    all_new_entries = []
    stats_rows = []

    for chapter in CHAPTERS:
        filepath = chapter["file"]
        if not Path(filepath).exists():
            print(f"WARNING: {filepath} not found", file=sys.stderr)
            continue

        los = extract_los_from_file(filepath)
        entries = generate_entries(chapter, los)
        all_new_entries.extend(entries)

        total = sum(len(v) for v in los.values())
        bloom_summary = ", ".join(
            f"{level[:2].capitalize()}:{len(items)}"
            for level, items in los.items()
        )
        stats_rows.append((f"C{chapter['c_num']}", chapter['title'], total, bloom_summary))

    # Stats table
    print("\n=== Learning Objectives Extracted from Manuscripts ===\n")
    print(f"{'ID':<4}  {'Chapter':<48}  {'LOs':>4}  {'Bloom Distribution'}")
    print("-" * 90)
    grand_total = 0
    for c_id, title, total, bloom in stats_rows:
        print(f"{c_id:<4}  {title:<48}  {total:>4}  {bloom}")
        grand_total += total
    print("-" * 90)
    print(f"{'':4}  {'TOTAL':<48}  {grand_total:>4}")
    print(f"\nNew metadata entries to add: {len(all_new_entries)}")

    if args.stats:
        return

    # Full output or diff
    if args.diff:
        existing_text = yml_path.read_text(encoding="utf-8") if yml_path.exists() else ""
        print("\n=== New entries not yet in learning_objectives.yml ===\n")
        for entry in all_new_entries:
            if entry["id"] not in existing_text:
                print(format_yaml_entry(entry))
                print()
        return

    # Print or append
    yaml_block = "\n".join(format_yaml_entry(e) + "\n" for e in all_new_entries)

    if args.append:
        if not yml_path.exists():
            print(f"ERROR: {yml_path} not found", file=sys.stderr)
            sys.exit(1)

        # Check for already-present IDs
        existing = yml_path.read_text(encoding="utf-8")
        new_entries = [e for e in all_new_entries if e["id"] not in existing]
        if not new_entries:
            print("Nothing to append: all IDs already present.")
            return

        skipped = len(all_new_entries) - len(new_entries)
        if skipped:
            print(f"Skipping {skipped} already-present IDs.")

        block = "\n".join(format_yaml_entry(e) + "\n" for e in new_entries)
        with open(yml_path, "a", encoding="utf-8") as f:
            f.write("\n# --- Manuscript chapter-level LOs (added issue #245) ---\n")
            f.write(block)

        print(f"Appended {len(new_entries)} entries to {yml_path}")
    else:
        print("\n=== YAML entries (new only) ===\n")
        print(yaml_block)


if __name__ == "__main__":
    main()
