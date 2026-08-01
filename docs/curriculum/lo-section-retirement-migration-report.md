# LO Section Retirement Migration Report

Date: 2026-08-01
Branch: issue-248-retire-section-los
Decision context: CURR-021 and Learning Objective Authoring Standard (chapter-only LO scope)

## Summary

This migration retires all active section-level learning objectives from the active curriculum model without redesigning chapter-level objectives, Bloom levels, or competency classifications.

Result:

- Active section-level LOs reduced from 11 to 0.
- Active chapter-level LOs remain authoritative.
- Traceability links previously attached to section-level LOs were remapped to chapter-level LOs.
- Retired section-level LOs remain discoverable in metadata history via status and supersession fields.

## Migration Inventory (Phase 1)

All 11 active section-level objectives identified in metadata/traceability/learning_objectives.yml were in Chapters 5 and 6.

| ID | Chapter | Current Scope (before) | Current Status (before) | Traceability Links (before) | Overlapping Chapter LO(s) |
|---|---:|---|---|---|---|
| LO-C5S5.1-01 | 5 | section | active | WX-regression-analysis-5.1-1 | LO-C5-01 (exact duplicate) |
| LO-C5S5.2-01 | 5 | section | active | WX-regression-analysis-5.2-1 | LO-C5-04 |
| LO-C5S5.3-01 | 5 | section | active | WX-regression-analysis-5.3-1 | LO-C5-05 |
| LO-C5S5.4-01 | 5 | section | active | WX-regression-analysis-5.4-1 | LO-C5-03, LO-C5-01 |
| LO-C5S5.5-01 | 5 | section | active | WX-regression-analysis-5.5-1 | LO-C5-09, LO-C5-12 |
| LO-C5S5.6-01 | 5 | section | active | WX-regression-analysis-5.6-1 | LO-C5-14 |
| LO-C5S5.7-01 | 5 | section | active | WX-regression-analysis-5.7-1 | LO-C5-04, LO-C5-12 |
| LO-C5S5.8-01 | 5 | section | active | WX-regression-analysis-5.8-1 | LO-C5-11 |
| LO-C5S5.9-01 | 5 | section | active | WX-regression-analysis-5.9-1 | LO-C5-11 |
| LO-C6S6.2-01 | 6 | section | active | 5 workshop links, 2 review links | LO-C6-13, LO-C6-15 |
| LO-C6S6.2-02 | 6 | section | active | 7 workshop links, 1 review link | LO-C6-23, LO-C6-20 |

## Impact Analysis (Phase 2)

Decision categories:

- A: duplicates existing chapter-level LO
- B: should merge into existing chapter-level LO
- C: requires traceability remap
- D: can be retired

| Section LO | Category | Remap Target | Justification |
|---|---|---|---|
| LO-C5S5.1-01 | A, C, D | LO-C5-01 | Exact text duplicate of chapter objective; section record is redundant under chapter-only scope. |
| LO-C5S5.2-01 | B, C, D | LO-C5-04 | Assumptions-focused content aligns to chapter-level assumptions objective. |
| LO-C5S5.3-01 | B, C, D | LO-C5-05 | Data summarization/plot exploration is part of chapter-level regression procedure workflow. |
| LO-C5S5.4-01 | B, C, D | LO-C5-03 | Terminology/component framing overlaps chapter-level definitions of regression terms/components. |
| LO-C5S5.5-01 | B, C, D | LO-C5-09 | Outlier/influence diagnostics align to chapter-level objective on leverage and Cook's distance impacts. |
| LO-C5S5.6-01 | B, C, D | LO-C5-14 | ANOVA purpose in regression aligns with chapter-level model-component evaluation including ANOVA decomposition. |
| LO-C5S5.7-01 | B, C, D | LO-C5-04 | Regression assumptions are directly covered by chapter-level assumptions objective. |
| LO-C5S5.8-01 | B, C, D | LO-C5-11 | Hypothesis interpretation is within chapter-level model fitting and coefficient/test interpretation workflow. |
| LO-C5S5.9-01 | B, C, D | LO-C5-11 | Confidence/prediction interval distinctions are included in chapter-level model interpretation objective. |
| LO-C6S6.2-01 | B, C, D | LO-C6-13 | Benford expected vs observed comparison aligns directly with chapter-level Benford application objective. |
| LO-C6S6.2-02 | B, C, D | LO-C6-23 | Determining follow-up procedures from anomalies aligns with chapter-level recommendations objective. |

## Migration Implementation (Phase 3)

### Metadata updates

- Marked all 11 section-level LO records as retired in metadata/traceability/learning_objectives.yml.
- Added superseded_by on each retired section-level LO to preserve migration lineage.
- Added retirement_note on each retired section-level LO with policy basis (chapter-only scope, CURR-021).

### Traceability remap updates

- Replaced section-level LO IDs with chapter-level LO IDs in metadata/traceability/lo_to_workshop.yml.
- Replaced section-level LO IDs with chapter-level LO IDs in metadata/traceability/lo_to_review.yml.
- No link was left pointing to a section-level LO.

## Validation (Phase 4)

### Tooling run

1. Rscript scripts/generate-traceability-reports.R

- Regenerated:
  - generated/traceability/learning-objective-coverage.csv
  - generated/traceability/learning-objective-bloom-summary.csv
  - generated/traceability/workshop-exercise-to-lo.csv
  - generated/traceability/review-question-to-lo.csv
  - generated/traceability/lo-to-workshop-links.csv
  - generated/traceability/lo-to-review-links.csv
  - generated/traceability/traceability-exceptions.csv
  - generated/traceability/learning-objective-coverage.md

2. Python governance validator

- docs/curriculum/validate-register.py passed all checks.

3. Post-migration LO scope checks

- active_total = 103
- active_chapter = 103
- active_section = 0
- retired_section = 11
- active non-chapter scope count (LO-006 scope signal) = 0
- section-scope links remaining in lo_to_workshop = 0
- section-scope links remaining in lo_to_review = 0
- unknown LO references in mapping files = 0

### Required confirmations

- Active section-level objective count = 0: confirmed.
- LO-006 violations caused by section scope = 0: confirmed for active LOs.
- Metadata integrity valid: confirmed via traceability report generation and zero unknown references.
- Traceability internal consistency: confirmed via successful report generation and remapped references.

## Files Modified

- metadata/traceability/learning_objectives.yml
- metadata/traceability/lo_to_workshop.yml
- metadata/traceability/lo_to_review.yml
- generated/traceability/learning-objective-coverage.csv
- generated/traceability/learning-objective-bloom-summary.csv
- generated/traceability/workshop-exercise-to-lo.csv
- generated/traceability/review-question-to-lo.csv
- generated/traceability/lo-to-workshop-links.csv
- generated/traceability/lo-to-review-links.csv
- generated/traceability/traceability-exceptions.csv
- generated/traceability/learning-objective-coverage.md

## Before and After Counts (Phase 5)

| Metric | Before | After |
|---|---:|---:|
| Active learning objectives | 114 | 103 |
| Active chapter-level learning objectives | 103 | 103 |
| Active section-level learning objectives | 11 | 0 |
| Retired section-level learning objectives | 0 | 11 |
| Active LO-006 scope violations (non-chapter active scope) | 11 | 0 |

## Remaining Risks

- docs/curriculum/lo-compliance-audit.md and docs/curriculum/lo-compliance-audit.yml are baseline artifacts from pre-remediation and still describe pre-migration counts; they should be interpreted as historical baseline until rerun in a dedicated audit refresh task.
- Semantic traceability quality (beyond ID consistency) may still need human curriculum review, but this is outside Phase 2 scope migration.

## Open Follow-Up Work

1. Refresh the full LO compliance audit artifacts (md/yml/pdf) in a dedicated follow-up issue to reflect post-migration state.
2. Continue later roadmap phases (authoring quality, Bloom alignment, competency completeness) without reintroducing section-level active LOs.
