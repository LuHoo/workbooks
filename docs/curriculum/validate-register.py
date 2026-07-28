#!/usr/bin/env python3
"""
Curriculum Decision Register Validation Script
Validates curriculum-decision-register.yml for structural integrity
"""

import sys
import os
import json

# Add venv to path
sys.path.insert(0, os.path.join(os.path.dirname(__file__), '..', '..', '.venv', 'lib', 'python3.10', 'site-packages'))

try:
    import yaml
except ImportError:
    print("ERROR: PyYAML not installed. Install with: pip install pyyaml")
    sys.exit(1)

REGISTER_FILE = "docs/curriculum/curriculum-decision-register.yml"
VALID_STATUSES = {'confirmed', 'inferred', 'proposed', 'open', 'superseded'}
VALID_CONFIDENCE = {'high', 'medium', 'low'}
VALID_DOMAINS = {
    'educational-purpose', 'audit-judgement', 'statistical-foundations',
    'statistical-learning', 'competency-model', 'bloom-taxonomy',
    'learning-objectives', 'curriculum-sequencing', 'chapter-architecture',
    'manuscript-role', 'workshop-role', 'exercise-design', 'review-questions',
    'assessment', 'software-use', 'case-and-data-design', 'quality-assurance',
    'curriculum-governance'
}

def validate_register():
    """Validate the curriculum decision register"""
    
    print("=" * 50)
    print("Curriculum Decision Register Validation")
    print("=" * 50)
    print()
    
    # Load YAML
    print("1. Loading YAML file...")
    try:
        with open(REGISTER_FILE, 'r') as f:
            data = yaml.safe_load(f)
        print("   ✓ YAML syntax is valid")
    except yaml.YAMLError as e:
        print(f"   ✗ YAML parse error: {e}")
        return False
    except FileNotFoundError:
        print(f"   ✗ File not found: {REGISTER_FILE}")
        return False
    
    # Validate structure
    print("2. Validating top-level structure...")
    required_top_level = ['schema_version', 'generated_for_issue', 'scope', 'generated_at',
                          'status_definitions', 'decisions']
    missing = [f for f in required_top_level if f not in data]
    if missing:
        print(f"   ✗ Missing fields: {missing}")
        return False
    print("   ✓ All required top-level fields present")
    
    # Check schema version
    if data['schema_version'] != "1.0":
        print(f"   ✗ Invalid schema_version: {data['schema_version']}")
        return False
    print(f"   ✓ schema_version: {data['schema_version']}")
    
    # Validate decisions
    print("3. Validating decisions array...")
    decisions = data.get('decisions', [])
    if not isinstance(decisions, list):
        print("   ✗ decisions must be a list")
        return False
    print(f"   ✓ Found {len(decisions)} decisions")
    
    # Check unique IDs
    print("4. Checking decision IDs...")
    ids = [d.get('id') for d in decisions]
    if len(ids) != len(set(ids)):
        print("   ✗ Duplicate IDs found")
        return False
    print(f"   ✓ All {len(ids)} IDs are unique")
    
    # Validate each decision
    print("5. Validating decision structure...")
    required_decision_fields = ['id', 'title', 'domain', 'decision', 'status',
                               'confidence', 'rationale', 'implications', 'applies_to',
                               'evidence', 'related_decisions']
    
    errors = []
    for i, d in enumerate(decisions):
        decision_id = d.get('id', f'UNKNOWN[{i}]')
        
        # Check required fields
        for field in required_decision_fields:
            if field not in d:
                errors.append(f"{decision_id}: missing '{field}'")
        
        # Validate status
        if d.get('status') not in VALID_STATUSES:
            errors.append(f"{decision_id}: invalid status '{d.get('status')}'")
        
        # Validate confidence
        if d.get('confidence') not in VALID_CONFIDENCE:
            errors.append(f"{decision_id}: invalid confidence '{d.get('confidence')}'")
        
        # Validate domain
        domains = d.get('domain', []) or []
        if isinstance(domains, str):
            domains = [domains]
        for domain in domains:
            if domain not in VALID_DOMAINS:
                errors.append(f"{decision_id}: invalid domain '{domain}'")
        
        # Check evidence
        evidence = d.get('evidence', []) or []
        if not evidence:
            errors.append(f"{decision_id}: no evidence items")
        for j, ev in enumerate(evidence):
            if 'source_type' not in ev:
                errors.append(f"{decision_id}: evidence[{j}] missing source_type")
            if 'path' not in ev:
                errors.append(f"{decision_id}: evidence[{j}] missing path")
    
    if errors:
        print("   ✗ Validation errors found:")
        for error in errors:
            print(f"      - {error}")
        return False
    print(f"   ✓ All {len(decisions)} decisions have valid structure")
    
    # Validate references
    print("6. Checking decision references...")
    all_ids = set(d['id'] for d in decisions)
    ref_errors = []
    for d in decisions:
        related = d.get('related_decisions', {}) or {}
        for rel_type in ['supports', 'depends_on', 'qualifies', 'conflicts_with',
                        'supersedes', 'superseded_by']:
            refs = related.get(rel_type, []) or []
            for ref_id in refs:
                if ref_id not in all_ids:
                    ref_errors.append(f"{d['id']}: {rel_type} references undefined '{ref_id}'")
                if ref_id == d['id']:
                    ref_errors.append(f"{d['id']}: self-referential {rel_type}")
    
    if ref_errors:
        print("   ✗ Reference errors found:")
        for error in ref_errors:
            print(f"      - {error}")
        return False
    print(f"   ✓ All references are valid")
    
    # Summary statistics
    print("7. Summary statistics...")
    status_counts = {}
    confidence_counts = {}
    for d in decisions:
        status = d.get('status')
        confidence = d.get('confidence')
        status_counts[status] = status_counts.get(status, 0) + 1
        confidence_counts[confidence] = confidence_counts.get(confidence, 0) + 1
    
    print(f"   Status distribution: {dict(sorted(status_counts.items()))}")
    print(f"   Confidence distribution: {dict(sorted(confidence_counts.items()))}")
    
    total_evidence = sum(len(d.get('evidence', []) or []) for d in decisions)
    print(f"   Total evidence items: {total_evidence}")
    
    print()
    print("=" * 50)
    print("✓ Validation Complete - All checks passed!")
    print("=" * 50)
    return True

if __name__ == '__main__':
    success = validate_register()
    sys.exit(0 if success else 1)
