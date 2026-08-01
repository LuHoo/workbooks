# Executive Summary

Date: 2026-08-01
Branch: issue-250-traceability-remediation
Decision context: CURR-021 Phase 4 (traceability completion)

This remediation repaired explicit LO traceability where defensible evidence already existed in workshop and review-question sources, without rewriting learning objectives, altering Bloom classifications, changing competencies, or redesigning the curriculum.

Key outcome on the current active LO set:

- Active chapter-level LOs: 103
- LOs with any explicit traceability before remediation: 14 workshop-linked + 4 with both = 14 total workshop, 4 total review, 89 uncovered
- LOs with any explicit traceability after remediation: 94 with workshop coverage, 17 with review coverage, 17 with both, 9 uncovered
- LO-009 failures on the current active set reduced from 89 to 9
- Workshop exercise entity coverage improved from 174 mapped / 174 total to 190 mapped / 190 total
- Review question entity coverage improved from 5 mapped / 5 total to 13 mapped / 13 total

This work also verified that the original audit finding of 97 LO-009 failures was historically correct for the pre-Phase-2/3 114-active-LO baseline, but overstated the current unresolved gap because the active set had already changed before this phase began.

# Audit Verification

## Historical baseline versus current starting point

The published LO compliance audit reported:

- 114 active learning objectives
- 17 active objectives with any explicit traceability links
- 97 LO-009 failures
- 174 workshop exercises already mapped
- 5 review-question mappings

That baseline is historically accurate for the earlier mixed state. However, at the start of this Phase 4 branch:

- active chapter-level LOs = 103
- active section-level LOs had already been retired in Phase 2
- competency gaps had already been resolved in Phase 3
- current LO-009 failures on the active set were 89, not 97

## Source verification findings

Reviewed sources:

- docs/curriculum/learning-objective-authoring-standard.md
- docs/curriculum/educational-philosophy-vol1.md
- docs/curriculum/curriculum-decision-register.yml
- docs/curriculum/curriculum-decision-register-report.md
- docs/curriculum/lo-compliance-audit.md
- metadata/traceability/learning_objectives.yml
- metadata/traceability/workshop_exercises.yml
- metadata/traceability/review_questions.yml
- metadata/traceability/lo_to_workshop.yml
- metadata/traceability/lo_to_review.yml
- review_questions.tex
- notebooks/support/**/support.Rmd
- docs/traceability/learning-objective-metadata-model.md

Verified conclusions:

1. Review questions for Chapters 1-5 are structurally present in review_questions.tex but have no exercise content.
2. Chapter 6 review questions exist in source beyond the 5 rows represented in metadata.
3. Workshop support content exists for all six Volume 1 chapters, including population-estimation (Chapter 2).
4. Chapter 2 workshop exercise entities were missing entirely from workshop_exercises.yml despite generated workshop outputs existing.
5. Many active chapter-level LOs had implicit curricular support in workshop or review sources, but that support was not represented in metadata.
6. No explicit case-study mapping metadata model exists in the repository, so the architecture layer "Workshop Exercises -> Case Studies -> Review Questions" is only partially representable in current metadata tooling.

# Root Cause Analysis

The LO-009 failures were not caused by one problem.

## Root cause 1: stale coarse-grained legacy mappings

Existing workshop mappings were concentrated on a small set of legacy chapter anchors such as LO-C1-01, LO-C3-01, LO-C4-01, LO-C5-01, and a few Chapter 6 records. When richer manuscript-derived chapter-level LO sets were added, those newer active LOs were not given corresponding metadata links.

## Root cause 2: missing workshop exercise entity metadata for Chapter 2

Population Estimation workshop source and generated exercise chunks existed, but workshop_exercises.yml had no Chapter 2 entries. This was a metadata-layer omission, not a curriculum absence.

## Root cause 3: incomplete review-question entity metadata for Chapter 6

Chapter 6 review questions existed in review_questions.tex, but only 5 were represented in review_questions.yml. This suppressed valid LO-to-review traceability.

## Root cause 4: genuine assessment sparsity outside Chapter 6

Chapters 1-5 have empty review-question chapters in review_questions.tex. This is not a metadata omission; it is a real absence of review-question assessment artifacts in the current repository state.

## Root cause 5: real instructional coverage gaps for some higher-order objectives

A small residual set of LOs still lacks defensible workshop or review coverage. These are primarily higher-order or concept-expansion outcomes whose supporting chapter content exists, but whose workshop/review evidence is not explicit.

# Traceability Inventory

## Coverage state before remediation on the current active set

- Active chapter-level LOs: 103
- With workshop mappings: 14
- With review mappings: 4
- With both: 4
- With workshop only: 10
- With review only: 0
- With no explicit traceability: 89

## Gap categories for original LO-009 failures

Category A: Fully traceable but metadata incomplete
- Count: 13
- IDs: LO-C6-04, LO-C6-05, LO-C6-06, LO-C6-10, LO-C6-14, LO-C6-15, LO-C6-16, LO-C6-17, LO-C6-18, LO-C6-19, LO-C6-20, LO-C6-21, LO-C6-22
- Evidence basis: Chapter 6 workshop content plus existing/populated review-question source supported explicit traceability, but metadata was incomplete.

Category B: Traceable through workshop exercises but not review questions
- Count: 67
- IDs: LO-C1-02, LO-C1-03, LO-C1-04, LO-C1-05, LO-C1-08, LO-C1-09, LO-C1-10, LO-C1-11, LO-C1-12, LO-C1-16, LO-C2-01, LO-C2-02, LO-C2-03, LO-C2-04, LO-C2-05, LO-C2-07, LO-C2-08, LO-C2-09, LO-C2-10, LO-C2-11, LO-C2-13, LO-C3-02, LO-C3-03, LO-C3-04, LO-C3-05, LO-C3-06, LO-C3-07, LO-C3-08, LO-C3-10, LO-C3-11, LO-C3-12, LO-C3-13, LO-C3-14, LO-C3-15, LO-C3-16, LO-C4-02, LO-C4-03, LO-C4-04, LO-C4-05, LO-C4-06, LO-C4-07, LO-C4-08, LO-C4-09, LO-C4-10, LO-C4-11, LO-C4-12, LO-C4-13, LO-C4-14, LO-C4-15, LO-C4-16, LO-C5-02, LO-C5-06, LO-C5-07, LO-C5-08, LO-C5-10, LO-C5-12, LO-C5-13, LO-C5-15, LO-C5-16, LO-C5-17, LO-C5-18, LO-C6-03, LO-C6-07, LO-C6-08, LO-C6-09, LO-C6-11, LO-C6-12
- Evidence basis: workshop sources clearly addressed these outcomes, but review-question coverage is absent or intentionally sparse.

Category C: Traceable through chapter content but lacking exercise coverage
- Count: 9
- IDs: LO-C1-06, LO-C1-07, LO-C1-13, LO-C1-14, LO-C1-15, LO-C2-06, LO-C2-12, LO-C2-14, LO-C3-09
- Evidence basis: these objectives are represented in chapter-level curriculum intent, but no workshop or review artifact in the current repository state provided sufficiently explicit evidence to justify a metadata link.

Category D: No identifiable traceability
- Count: 0
- IDs: none

## Coverage state after remediation

- With workshop mappings: 94
- With review mappings: 17
- With both: 17
- With workshop only: 77
- With review only: 0
- With no explicit traceability: 9

# Remediation Actions

## Metadata entities added

Added workshop exercise entities for Chapter 2 in metadata/traceability/workshop_exercises.yml:

- 16 new WX rows covering exercises 2.1 through 2.6 and their generated chunk IDs

Added review-question entities for Chapter 6 in metadata/traceability/review_questions.yml:

- 8 new RQ rows (RQ-C6-004 through RQ-C6-011)

## Relationship rows added

Added explicit LO-to-workshop mappings in metadata/traceability/lo_to_workshop.yml:

- 146 new workshop mapping rows

Added explicit LO-to-review mappings in metadata/traceability/lo_to_review.yml:

- 15 new review mapping rows

Corrected existing mappings:

- 0 existing relationship rows were rewritten; this phase added missing explicit links rather than reclassifying prior valid links.

## Remediation boundaries honored

- No learning objectives were rewritten.
- No Bloom classifications were modified.
- No competency classifications were modified.
- No scope metadata was altered.
- No objectives were retired or merged.

# Coverage Metrics

## LO coverage

| Metric | Before | After |
|---|---:|---:|
| Active chapter-level LOs | 103 | 103 |
| LOs with workshop mappings | 14 | 94 |
| LOs with review mappings | 4 | 17 |
| LOs with both workshop and review mappings | 4 | 17 |
| LOs with no explicit traceability | 89 | 9 |

## Workshop coverage

| Metric | Before | After |
|---|---:|---:|
| Workshop exercise entities | 174 | 190 |
| Mapped workshop exercises | 174 | 190 |
| Unmapped workshop exercises | 0 | 0 |

## Review-question coverage

| Metric | Before | After |
|---|---:|---:|
| Review-question entities | 5 | 13 |
| Mapped review questions | 5 | 13 |
| Unmapped review questions | 0 | 0 |

## Relationship counts

| Metric | Before | After |
|---|---:|---:|
| LO-to-workshop rows | 202 | 348 |
| LO-to-review rows | 5 | 20 |

## Chapter-by-chapter coverage after remediation

| Chapter | Both | Workshop Only | Review Only | None |
|---|---:|---:|---:|---:|
| 1 | 0 | 11 | 0 | 5 |
| 2 | 0 | 11 | 0 | 3 |
| 3 | 0 | 15 | 0 | 1 |
| 4 | 0 | 16 | 0 | 0 |
| 5 | 0 | 18 | 0 | 0 |
| 6 | 17 | 6 | 0 | 0 |

# Validation Results

Validation executed after each metadata edit slice:

1. Rscript scripts/generate-traceability-reports.R
- Passed after initial remediation edit
- Passed after Chapter 6 workshop-link follow-up edit
- Passed after Chapter 2 chunk-coverage follow-up edit

2. docs/curriculum/validate-register.py
- Passed all checks

Confirmed outcomes:

- LO-009 failures before remediation on current active set: 89
- LO-009 failures after remediation on current active set: 9
- Metadata integrity: valid
- YAML/schema consistency: valid under existing repository validation flow
- No unintended curriculum modifications detected in LO text/Bloom/competency/scope fields

# Remaining Gaps

Remaining active LOs failing LO-009 after remediation:

- LO-C1-06
- LO-C1-07
- LO-C1-13
- LO-C1-14
- LO-C1-15
- LO-C2-06
- LO-C2-12
- LO-C2-14
- LO-C3-09

Explanation of why they remain:

- Chapter 1: central limit theorem, approximation-judgment, and simulation-design objectives do not have sufficiently explicit supporting workshop/review artifacts in the current repository state.
- Chapter 2: normality-assumption critique/strategy objectives are present at chapter level, but not explicitly evidenced in workshop exercises or review questions.
- Chapter 3: sample-size allocation to strata is not explicit enough in current workshop exercise metadata/evidence to justify a traceability claim without over-mapping.

# Risks

1. Chapters 1-5 still lack populated review-question content, so workshop-only coverage remains the dominant traceability mode outside Chapter 6.
2. The current metadata model has no explicit entity layer for chapter-content or case-study traceability, so some architecture layers are only partially representable.
3. Some added mappings are intentionally minimal, providing one defensible explicit link rather than exhaustive coverage across all possible supporting artifacts.

# Recommendations

1. Refresh the full LO compliance audit artifacts after this phase so LO-009 counts reflect the current 103-active-LO baseline instead of the historical 114-LO snapshot.
2. Consider a follow-on issue to introduce explicit chapter-content and case-study traceability metadata if that architecture layer is intended to become auditable.
3. Populate or formally defer review-question coverage for Chapters 1-5; the current emptiness is a real assessment-coverage constraint, not a metadata bug.
4. Address the 9 remaining Category C LOs in a later curriculum coverage issue rather than forcing unsupported mappings in this phase.
