#!/bin/bash
# Curriculum Decision Register Validation Script
# Purpose: Validate curriculum-decision-register.yml for structural integrity and consistency

set -e

REGISTER_FILE="docs/curriculum/curriculum-decision-register.yml"
ERRORS=0
WARNINGS=0

# Color codes
RED='\033[0;31m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

echo "=========================================="
echo "Curriculum Decision Register Validation"
echo "=========================================="
echo ""

# Check file exists
if [ ! -f "$REGISTER_FILE" ]; then
    echo -e "${RED}ERROR: Register file not found: $REGISTER_FILE${NC}"
    exit 1
fi

echo "Validating: $REGISTER_FILE"
echo ""

# 1. Validate YAML syntax using Python
echo "1. Checking YAML syntax..."
python3 << 'EOF'
import sys
import yaml

try:
    with open('docs/curriculum/curriculum-decision-register.yml', 'r') as f:
        data = yaml.safe_load(f)
    print("   ✓ YAML syntax is valid")
except yaml.YAMLError as e:
    print(f"   ✗ YAML parse error: {e}")
    sys.exit(1)
except Exception as e:
    print(f"   ✗ Error reading file: {e}")
    sys.exit(1)
EOF

# 2. Validate schema version
echo "2. Checking schema version..."
python3 << 'EOF'
import yaml

with open('docs/curriculum/curriculum-decision-register.yml', 'r') as f:
    data = yaml.safe_load(f)

if 'schema_version' not in data:
    print("   ✗ Missing schema_version field")
    exit(1)

schema_version = data['schema_version']
if schema_version != "1.0":
    print(f"   ✗ Unexpected schema_version: {schema_version} (expected 1.0)")
    exit(1)

print(f"   ✓ schema_version: {schema_version}")
EOF

# 3. Validate required top-level fields
echo "3. Checking required top-level fields..."
python3 << 'EOF'
import yaml
import sys

with open('docs/curriculum/curriculum-decision-register.yml', 'r') as f:
    data = yaml.safe_load(f)

required_fields = ['schema_version', 'generated_for_issue', 'scope', 'generated_at', 
                   'status_definitions', 'decisions']
missing = [f for f in required_fields if f not in data]

if missing:
    print(f"   ✗ Missing top-level fields: {missing}")
    sys.exit(1)

print(f"   ✓ All required top-level fields present")
EOF

# 4. Validate decisions array exists and is non-empty
echo "4. Checking decisions array..."
python3 << 'EOF'
import yaml
import sys

with open('docs/curriculum/curriculum-decision-register.yml', 'r') as f:
    data = yaml.safe_load(f)

decisions = data.get('decisions', [])

if not isinstance(decisions, list):
    print("   ✗ decisions must be an array")
    sys.exit(1)

if len(decisions) == 0:
    print("   ✗ decisions array is empty")
    sys.exit(1)

print(f"   ✓ Found {len(decisions)} decisions")
EOF

# 5. Validate unique decision IDs
echo "5. Checking decision ID uniqueness..."
python3 << 'EOF'
import yaml
import sys

with open('docs/curriculum/curriculum-decision-register.yml', 'r') as f:
    data = yaml.safe_load(f)

decisions = data['decisions']
ids = [d.get('id') for d in decisions]
unique_ids = set(ids)

if len(ids) != len(unique_ids):
    print("   ✗ Duplicate decision IDs found")
    duplicates = [id for id in unique_ids if ids.count(id) > 1]
    for dup in duplicates:
        print(f"      - {dup} appears {ids.count(dup)} times")
    sys.exit(1)

print(f"   ✓ All {len(ids)} decision IDs are unique")
EOF

# 6. Validate decision structure (required fields)
echo "6. Checking decision structure..."
python3 << 'EOF'
import yaml
import sys

with open('docs/curriculum/curriculum-decision-register.yml', 'r') as f:
    data = yaml.safe_load(f)

decisions = data['decisions']
required_fields = ['id', 'title', 'domain', 'decision', 'status', 'confidence',
                   'rationale', 'implications', 'applies_to', 'evidence', 
                   'related_decisions']

errors = []
for i, decision in enumerate(decisions):
    for field in required_fields:
        if field not in decision:
            errors.append(f"Decision {i} ({decision.get('id', 'UNKNOWN')}): missing '{field}'")

if errors:
    print("   ✗ Structure errors found:")
    for error in errors:
        print(f"      - {error}")
    sys.exit(1)

print(f"   ✓ All decisions have required fields")
EOF

# 7. Validate controlled vocabulary for status
echo "7. Checking status controlled vocabulary..."
python3 << 'EOF'
import yaml
import sys

with open('docs/curriculum/curriculum-decision-register.yml', 'r') as f:
    data = yaml.safe_load(f)

decisions = data['decisions']
valid_statuses = set(data['status_definitions'].keys())

errors = []
for decision in decisions:
    status = decision.get('status')
    if status not in valid_statuses:
        errors.append(f"{decision['id']}: invalid status '{status}'")

if errors:
    print("   ✗ Invalid status values found:")
    for error in errors:
        print(f"      - {error}")
    sys.exit(1)

status_counts = {}
for decision in decisions:
    status = decision.get('status')
    status_counts[status] = status_counts.get(status, 0) + 1

print(f"   ✓ All status values are valid")
print(f"      Status distribution: {dict(sorted(status_counts.items()))}")
EOF

# 8. Validate controlled vocabulary for confidence
echo "8. Checking confidence controlled vocabulary..."
python3 << 'EOF'
import yaml
import sys

with open('docs/curriculum/curriculum-decision-register.yml', 'r') as f:
    data = yaml.safe_load(f)

decisions = data['decisions']
valid_confidence = {'high', 'medium', 'low'}

errors = []
for decision in decisions:
    confidence = decision.get('confidence')
    if confidence not in valid_confidence:
        errors.append(f"{decision['id']}: invalid confidence '{confidence}'")

if errors:
    print("   ✗ Invalid confidence values found:")
    for error in errors:
        print(f"      - {error}")
    sys.exit(1)

confidence_counts = {}
for decision in decisions:
    confidence = decision.get('confidence')
    confidence_counts[confidence] = confidence_counts.get(confidence, 0) + 1

print(f"   ✓ All confidence values are valid")
print(f"      Confidence distribution: {dict(sorted(confidence_counts.items()))}")
EOF

# 9. Validate that every decision has evidence
echo "9. Checking evidence presence..."
python3 << 'EOF'
import yaml
import sys

with open('docs/curriculum/curriculum-decision-register.yml', 'r') as f:
    data = yaml.safe_load(f)

decisions = data['decisions']
errors = []

for decision in decisions:
    evidence = decision.get('evidence', [])
    if not evidence or len(evidence) == 0:
        errors.append(f"{decision['id']}: no evidence items")
    else:
        for i, ev in enumerate(evidence):
            if 'source_type' not in ev:
                errors.append(f"{decision['id']}: evidence[{i}] missing source_type")
            if 'path' not in ev:
                errors.append(f"{decision['id']}: evidence[{i}] missing path")

if errors:
    print("   ✗ Evidence errors found:")
    for error in errors:
        print(f"      - {error}")
    sys.exit(1)

total_evidence = sum(len(d.get('evidence', [])) for d in decisions)
print(f"   ✓ All decisions have evidence ({total_evidence} evidence items total)")
EOF

# 10. Validate decision references
echo "10. Checking decision references..."
python3 << 'EOF'
import yaml
import sys

with open('docs/curriculum/curriculum-decision-register.yml', 'r') as f:
    data = yaml.safe_load(f)

decisions = data['decisions']
all_ids = set(d['id'] for d in decisions)

errors = []
for decision in decisions:
    related = decision.get('related_decisions', {})
    
    for rel_type in ['supports', 'depends_on', 'qualifies', 'conflicts_with', 'supersedes', 'superseded_by']:
        refs = related.get(rel_type, []) or []
        for ref_id in refs:
            if ref_id not in all_ids:
                errors.append(f"{decision['id']}: {rel_type} references undefined ID '{ref_id}'")
            elif ref_id == decision['id']:
                errors.append(f"{decision['id']}: self-referential {rel_type}")

if errors:
    print("   ✗ Reference errors found:")
    for error in errors:
        print(f"      - {error}")
    sys.exit(1)

print(f"   ✓ All decision references are valid")
EOF

# 11. Validate domain list
echo "11. Checking domain values..."
python3 << 'EOF'
import yaml
import sys

with open('docs/curriculum/curriculum-decision-register.yml', 'r') as f:
    data = yaml.safe_load(f)

decisions = data['decisions']
valid_domains = {
    'educational-purpose', 'audit-judgement', 'statistical-foundations',
    'statistical-learning', 'competency-model', 'bloom-taxonomy',
    'learning-objectives', 'curriculum-sequencing', 'chapter-architecture',
    'manuscript-role', 'workshop-role', 'exercise-design', 'review-questions',
    'assessment', 'software-use', 'case-and-data-design', 'quality-assurance',
    'curriculum-governance'
}

warnings = []
for decision in decisions:
    domains = decision.get('domain', []) or []
    if not isinstance(domains, list):
        domains = [domains]
    
    for domain in domains:
        if domain not in valid_domains:
            warnings.append(f"{decision['id']}: domain '{domain}' not in controlled vocabulary")

if warnings:
    echo "   ⚠ Domain warnings:"
    for warning in warnings:
        echo "      - {warning}"
else:
    print(f"   ✓ All domains are in controlled vocabulary")
EOF

# 12. Summary
echo ""
echo "=========================================="
echo "Validation Complete"
echo "=========================================="
echo ""
echo -e "${GREEN}All validation checks passed!${NC}"
echo ""
echo "Summary:"
echo "  - YAML syntax: Valid"
echo "  - Schema: Valid"
echo "  - Decision count: $(python3 -c "import yaml; print(len(yaml.safe_load(open('docs/curriculum/curriculum-decision-register.yml'))['decisions']))")"
echo "  - Required fields: Present in all decisions"
echo "  - Controlled vocabulary: Valid"
echo "  - References: All valid"
echo ""
