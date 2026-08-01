#!/usr/bin/env python3
"""Verify audit findings - corrected version"""
import re
import os
from pathlib import Path

CHAPTERS = {
    "probability-distributions": ("2", "probability-distributions.tex", "Probability distributions"),
    "estimation": ("3", "estimation.tex", "Estimating the population mean and proportion"),
    "auxiliary": ("4", "auxiliary.tex", "Estimation with auxiliary variables and stratification"),
    "hypothesis-testing": ("5", "hypothesis-testing.tex", "Hypothesis testing"),
    "regression-analysis": ("7", "regression-analysis.tex", "Regression analysis"),
    "goodness-of-fit": ("9", "goodness-of-fit.tex", "Goodness of fit"),
}

print("=" * 80)
print("CORRECTED AUDIT VERIFICATION")
print("=" * 80)

for key, (chap_num, filename, title) in CHAPTERS.items():
    print(f"\nChapter {chap_num}: {title}")
    print("-" * 80)
    
    # Check for manuscript file
    if not os.path.exists(filename):
        print(f"  ✗ Manuscript file not found: {filename}")
        continue
    
    with open(filename, 'r') as f:
        content = f.read()
    
    # Extract Learning Objectives
    lo_match = re.search(
        r'\\section\*\{Learning objectives\}(.*?)(?=\\section|\Z)',
        content,
        re.DOTALL
    )
    
    if lo_match:
        lo_section = lo_match.group(1)
        # Count items across all Bloom levels
        items = re.findall(r'\\item\s+([^\n]+)', lo_section)
        bloom_levels = {}
        for level in ['remember', 'understand', 'apply', 'analyze', 'evaluate', 'create']:
            level_match = re.search(
                rf'\\textsc\{{{level}}}(.*?)(?=\\textsc|\\noindent|\\end|$)',
                lo_section,
                re.DOTALL | re.IGNORECASE
            )
            if level_match:
                level_items = re.findall(r'\\item\s+', level_match.group(1))
                if level_items:
                    bloom_levels[level.capitalize()] = len(level_items)
        
        print(f"  ✓ Learning Objectives: {len(items)} total")
        for level, count in bloom_levels.items():
            print(f"    - {level}: {count}")
    else:
        print(f"  ✗ No learning objectives section found")
    
    # Check for R workshops
    r_workshop_path = f"notebooks/support/{key}/support.Rmd"
    if os.path.exists(r_workshop_path):
        print(f"  ✓ R Workshop: {r_workshop_path}")
    else:
        print(f"  ✗ R Workshop not found: {r_workshop_path}")
    
    # Check for Python workshops (Workshop 1-6)
    python_workshops = [f for f in Path("notebooks/workshops").glob("*.ipynb") 
                       if "Workshop" in f.name and f.name.endswith(".ipynb")]
    if python_workshops:
        print(f"  ✓ Python Workshops: {len(python_workshops)} found")
    else:
        print(f"  ✗ No Python workshops found")

print("\n" + "=" * 80)
print("SUMMARY")
print("=" * 80)
print(f"\nAll chapters checked: {len(CHAPTERS)}")
print(f"Expected structure: All chapters should have manuscript + R workshop + Python workshops")
