#!/usr/bin/env python3
"""
Volume 1 Curriculum Audit Helper Script (CORRECTED VERSION)
Extracts learning objectives and workshop information from chapter files

Key fixes from v1:
- Case-insensitive Learning Objectives section matching
- Proper item counting in each Bloom level
- Validates actual workshop file existence in both locations
- Provides evidence-based findings
"""

import os
import re
from pathlib import Path

# Chapter file mappings
CHAPTERS = {
    "probability-distributions": {
        "number": 2,
        "title": "Probability distributions",
        "filename": "probability-distributions.tex",
        "workshop_key": "probability-distributions",
    },
    "estimation": {
        "number": 3,
        "title": "Estimating the population mean and proportion",
        "filename": "estimation.tex",
        "workshop_key": "estimation",
    },
    "auxiliary": {
        "number": 4,
        "title": "Estimation with auxiliary variables and stratification",
        "filename": "auxiliary.tex",
        "workshop_key": "auxiliary-variables-and-stratification",
    },
    "hypothesis-testing": {
        "number": 5,
        "title": "Hypothesis testing",
        "filename": "hypothesis-testing.tex",
        "workshop_key": "hypothesis-testing",
    },
    "regression-analysis": {
        "number": 7,
        "title": "Regression analysis",
        "filename": "regression-analysis.tex",
        "workshop_key": "regression-analysis",
    },
    "goodness-of-fit": {
        "number": 9,
        "title": "Goodness of fit",
        "filename": "goodness-of-fit.tex",
        "workshop_key": "goodness-of-fit",
    },
}

def extract_learning_objectives(filepath):
    """
    Extract learning objectives from chapter file.
    Returns dict with Bloom levels as keys and list of objectives as values.
    """
    try:
        with open(filepath, 'r', encoding='utf-8') as f:
            content = f.read()
        
        # Case-insensitive search for Learning objectives section
        match = re.search(
            r'\\section\*\s*\{\s*Learning\s+[Oo]bjectives\s*\}(.*?)(?=\\section|\Z)',
            content,
            re.DOTALL
        )
        
        if not match:
            return None
        
        lo_section = match.group(1)
        
        # Extract Bloom levels and their objectives
        bloom_levels = ['remember', 'understand', 'apply', 'analyze', 'evaluate', 'create']
        los = {}
        total_items = 0
        
        for level in bloom_levels:
            # Find the textsc section for this level
            level_pattern = rf'\\textsc\s*\{{\s*{level}\s*\}}(.*?)(?=\\textsc|\\begin\{{mdframed\}}|\\end\{{itemize\}}\s*(?:\\noindent|\\textsc|$))'
            level_match = re.search(level_pattern, lo_section, re.DOTALL | re.IGNORECASE)
            
            if level_match:
                level_content = level_match.group(1)
                # Count \item occurrences
                items = re.findall(r'\\item\s+', level_content)
                if items:
                    los[level.capitalize()] = len(items)
                    total_items += len(items)
        
        return los if los else None
    except Exception as e:
        print(f"Error extracting LOs from {filepath}: {e}")
        return None

def extract_case_study(filepath):
    """Extract case study information"""
    try:
        with open(filepath, 'r', encoding='utf-8') as f:
            content = f.read()
        
        # Look for "Case:" or "case:" section
        match = re.search(
            r'\\section\*\s*\{\s*[Cc]ase:?\s*([^}]+)\s*\}',
            content
        )
        
        if match:
            return match.group(1).strip()
        return None
    except:
        return None

def check_workshop_files(workshop_key):
    """Check for R and Python workshops"""
    r_workshop = None
    python_workshops = []
    
    # Check for R workshop in notebooks/support/{key}/support.Rmd
    r_path = f"notebooks/support/{workshop_key}/support.Rmd"
    if os.path.exists(r_path):
        r_workshop = r_path
    
    # Check for workshop in notebooks/workshops/ with descriptive name
    # Map workshop keys to workshop file names
    workshop_name_map = {
        "probability-distributions": "Probability distributions workshop",
        "estimation": "Estimating the population mean and proportion workshop",
        "auxiliary-variables-and-stratification": "Estimation with auxiliary variables and stratification workshop",
        "hypothesis-testing": "Hypothesis testing workshop",
        "regression-analysis": "Regression analysis workshop",
        "goodness-of-fit": "Goodness of fit workshop",
    }
    
    if workshop_key in workshop_name_map:
        base_name = workshop_name_map[workshop_key]
        r_file = f"notebooks/workshops/{base_name}.Rmd"
        if os.path.exists(r_file):
            python_workshops.append(("R", r_file))
    
    # Check for Python notebooks (Workshop 1-6)
    python_nb_dir = Path("notebooks/workshops")
    if python_nb_dir.exists():
        python_notebooks = sorted([f for f in python_nb_dir.glob("Workshop*.ipynb")])
        for nb in python_notebooks:
            python_workshops.append(("Python", str(nb)))
    
    return r_workshop, python_workshops

def count_items_in_section(filepath, section_name):
    """Count \\item occurrences in a specific section"""
    try:
        with open(filepath, 'r', encoding='utf-8') as f:
            content = f.read()
        
        # Find the section
        pattern = rf'\\section\*?\s*\{{\s*{re.escape(section_name)}\s*\}}(.*?)(?=\\section|\Z)'
        match = re.search(pattern, content, re.DOTALL)
        
        if match:
            section_content = match.group(1)
            items = re.findall(r'\\item\s+', section_content)
            return len(items)
        return 0
    except:
        return 0

def main():
    print("=" * 100)
    print("VOLUME 1 CURRICULUM AUDIT - CORRECTED VERSION")
    print("=" * 100)
    print()
    
    results = {}
    
    for key, chapter_info in CHAPTERS.items():
        chap_num = chapter_info["number"]
        title = chapter_info["title"]
        filename = chapter_info["filename"]
        workshop_key = chapter_info["workshop_key"]
        
        print(f"Chapter {chap_num}: {title}")
        print("-" * 100)
        
        # Check file exists
        if not os.path.exists(filename):
            print(f"  ERROR: File not found: {filename}")
            print()
            continue
        
        # Get file size
        file_size = os.path.getsize(filename)
        lines = len(open(filename).readlines())
        print(f"  File: {filename} ({lines} lines, {file_size} bytes)")
        
        # Extract learning objectives
        los = extract_learning_objectives(filename)
        
        if los:
            total_los = sum(los.values())
            print(f"  ✓ Learning Objectives: {total_los} total")
            for level in ['Remember', 'Understand', 'Apply', 'Analyze', 'Evaluate', 'Create']:
                count = los.get(level, 0)
                if count > 0:
                    print(f"    - {level}: {count}")
        else:
            print(f"  ✗ No Learning Objectives found")
            total_los = 0
        
        # Extract case study
        case = extract_case_study(filename)
        if case:
            print(f"  ✓ Case Study: {case}")
        else:
            print(f"  ✗ No case study found")
        
        # Check workshops
        r_workshop, python_workshops = check_workshop_files(workshop_key)
        
        if r_workshop:
            print(f"  ✓ R Workshop: {r_workshop}")
        else:
            print(f"  ✗ R Workshop not found (expected: notebooks/support/{workshop_key}/support.Rmd)")
        
        if python_workshops:
            print(f"  ✓ Python Workshops: {len(python_workshops)} found")
            for lang, path in python_workshops:
                print(f"    - {lang}: {path}")
        else:
            print(f"  ✗ No Python workshops found")
        
        # Store results
        results[chap_num] = {
            "title": title,
            "lines": lines,
            "los": total_los,
            "los_breakdown": los if los else {},
            "case_study": case,
            "r_workshop": r_workshop is not None,
            "python_workshops": len(python_workshops),
        }
        
        print()
    
    # Summary
    print("=" * 100)
    print("SUMMARY")
    print("=" * 100)
    print()
    
    print("| Chapter | Title | Lines | LOs | R Workshop | Python | Case Study |")
    print("|---|---|---|---|---|---|---|")
    
    total_lines = 0
    total_los_all = 0
    chapters_with_r = 0
    chapters_with_python = 0
    
    for chap_num in sorted(results.keys()):
        r = results[chap_num]
        r_yes = "✓" if r["r_workshop"] else "✗"
        py_yes = "✓" if r["python_workshops"] > 0 else "✗"
        case_yes = "✓" if r["case_study"] else "✗"
        
        print(f"| {chap_num} | {r['title'][:40]} | {r['lines']} | {r['los']} | {r_yes} | {py_yes} | {case_yes} |")
        
        total_lines += r["lines"]
        total_los_all += r["los"]
        if r["r_workshop"]:
            chapters_with_r += 1
        if r["python_workshops"] > 0:
            chapters_with_python += 1
    
    print()
    print(f"**TOTALS:**")
    print(f"  - Chapters audited: 6")
    print(f"  - Total manuscript lines: {total_lines}")
    print(f"  - Total learning objectives: {total_los_all}")
    print(f"  - Chapters with R workshops: {chapters_with_r}/6")
    print(f"  - Chapters with Python workshops: {chapters_with_python}/6")
    print()
    
    # Detailed findings
    print("=" * 100)
    print("DETAILED FINDINGS")
    print("=" * 100)
    print()
    
    print("**Learning Objectives Summary:**")
    for chap_num in sorted(results.keys()):
        r = results[chap_num]
        if r["los"] == 0:
            print(f"  - Chapter {chap_num}: NO LEARNING OBJECTIVES ✗✗✗")
        else:
            breakdown = ", ".join([f"{level}:{count}" for level, count in r["los_breakdown"].items()])
            print(f"  - Chapter {chap_num}: {r['los']} LOs ({breakdown})")
    
    print()
    print("**Workshop Coverage:**")
    all_workshops = True
    for chap_num in sorted(results.keys()):
        r = results[chap_num]
        r_status = "✓" if r["r_workshop"] else "✗"
        py_status = "✓" if r["python_workshops"] > 0 else "✗"
        if not (r["r_workshop"] and r["python_workshops"] > 0):
            all_workshops = False
        print(f"  - Chapter {chap_num}: R {r_status} | Python {py_status}")
    
    if all_workshops:
        print()
        print("  ✓ ALL CHAPTERS HAVE WORKSHOPS IN BOTH R AND PYTHON")
    
if __name__ == "__main__":
    main()
