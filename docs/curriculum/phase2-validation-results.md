# Validation Results

Validation checks executed after remediation:
- YAML parse and schema-level loading for all traceability metadata files.
- Referential integrity: LO-to-workshop and LO-to-review references resolved.
- Duplicate mapping check.
- Generated traceability report regeneration via scripts/generate-traceability-reports.R.

Results:
- Broken workshop references: 0
- Broken review references: 0
- Missing LO references in workshop map: 0
- Missing LO references in review map: 0
- Duplicate workshop mapping pairs (extra rows): 0
- Duplicate review mapping pairs (extra rows): 0

LO-009 recalculation:
- Before (baseline audit): FAIL=97, PASS=17
- After (current active chapter-level LOs): FAIL=9, PASS=94

Remaining LO-009 violations (active chapter-level):
- LO-C1-06: no explicit workshop/review mapping in current metadata.
- LO-C1-07: no explicit workshop/review mapping in current metadata.
- LO-C1-13: no explicit workshop/review mapping in current metadata.
- LO-C1-14: no explicit workshop/review mapping in current metadata.
- LO-C1-15: no explicit workshop/review mapping in current metadata.
- LO-C2-06: no explicit workshop/review mapping in current metadata.
- LO-C2-12: no explicit workshop/review mapping in current metadata.
- LO-C2-14: no explicit workshop/review mapping in current metadata.
- LO-C3-09: no explicit workshop/review mapping in current metadata.
