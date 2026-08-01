# LO Competency Remediation Report

Date: 2026-08-01
Branch: issue-249-add-missing-lo-competencies
Decision context: CURR-021 Phase 3 (competency completion)

## Summary

This remediation completes missing competency classifications for all active learning objectives in the current post-Phase-2 active LO set.

Key outcome:

- Active LOs missing competency metadata reduced from 6 to 0.
- Active LOs with invalid competency values remains 0.
- LO-005 and competency-related LO-010 failures for active LOs reduced to 0.

Scope boundaries respected:

- No LO text rewrites.
- No Bloom changes.
- No scope changes.
- No traceability mapping changes.

## Objectives Classified

The following active LOs were missing competency metadata and were updated:

| LO ID | Chapter | Text | Current Metadata (before) | Assigned competency |
|---|---:|---|---|---|
| LO-C1-01 | 1 | Define a probability distribution and explain its role in describing possible outcomes of an experiment. | chapter, active, bloom=apply, competency missing | technical_skills |
| LO-C3-01 | 3 | Define point estimation and interval estimation for population parameters. | chapter, active, bloom=apply, competency missing | technical_skills |
| LO-C4-01 | 4 | Define auxiliary variables and stratification in the context of sampling. | chapter, active, bloom=apply, competency missing | technical_skills |
| LO-C5-01 | 5 | Define regression analysis and identify its primary components: dependent variable, independent variable, and error term. | chapter, active, bloom=apply, competency missing | technical_skills |
| LO-C6-01 | 6 | Define goodness of fit and explain its purpose in statistical analysis. | chapter, active, bloom=understand, competency missing | technical_skills |
| LO-C6-02 | 6 | Distinguish statistical evidence of anomaly from conclusive evidence of fraud. | chapter, active, bloom=analyze, competency missing | professional_judgment |

## Classification Rationale

Competency definitions applied exactly from the standard:

- technical_skills: execution-oriented method/procedure knowledge and operational statistical capability.
- statistical_reasoning: interpretation of assumptions, uncertainty, limitations, implications.
- professional_judgment: evaluative conclusions about evidence sufficiency/defensibility and audit implications.

Per-LO rationale:

- LO-C1-01 -> technical_skills
  - Foundational method-concept definition objective; aligned with existing Chapter 1 competency pattern for definition-oriented outcomes.
- LO-C3-01 -> technical_skills
  - Foundational estimation concept objective; consistent with existing technical classification for parallel point/interval objectives in active metadata.
- LO-C4-01 -> technical_skills
  - Core sampling-method terminology objective; primarily conceptual-method execution foundation.
- LO-C5-01 -> technical_skills
  - Regression component identification objective supporting method execution; aligned with neighboring chapter-level technical entries.
- LO-C6-01 -> technical_skills
  - Baseline goodness-of-fit concept objective; aligned with the active manuscript-parallel objective LO-C6-03 classification.
- LO-C6-02 -> professional_judgment
  - Explicitly distinguishes statistical anomaly evidence from fraud conclusions; this is a defensibility/evidence-judgment outcome.

Multiple-primary and secondary competency review:

- No LO required multiple primary competencies.
- No LO required secondary competency metadata to preserve validity.
- Existing repository schema and conventions are single-primary via competency field; no schema expansion was introduced in this remediation.

## Challenge to Baseline Audit (Phase 3)

The baseline audit reported 17 active LOs missing competency metadata. That figure was correct at the time of the baseline snapshot (before section-level retirement).

Current challenge result (post-Phase-2 reality):

- Active LO set now contains 103 records.
- Missing competency records in active set before this remediation: 6 (not 17).
- The 11-record difference is explained by retired section-level LOs from Phase 2.

Human-judgment-sensitive classification cases reviewed:

- LO-C6-01 could be argued as statistical_reasoning due to "explain its purpose" phrasing.
  - Final assignment kept as technical_skills for consistency with the chapter's parallel foundational objective pattern and metadata precedent.
- LO-C6-02 could be argued as mixed reasoning/judgment.
  - Final assignment uses professional_judgment as primary because the central demand is evidential conclusion discipline (what can/cannot be concluded from anomaly signals).

## Files Modified

- metadata/traceability/learning_objectives.yml
- generated/traceability/learning-objective-coverage.csv
- generated/traceability/learning-objective-bloom-summary.csv
- generated/traceability/workshop-exercise-to-lo.csv
- generated/traceability/review-question-to-lo.csv
- generated/traceability/lo-to-workshop-links.csv
- generated/traceability/lo-to-review-links.csv
- generated/traceability/traceability-exceptions.csv
- generated/traceability/learning-objective-coverage.md

## Before and After Metrics

### Competency completeness

| Metric | Before | After |
|---|---:|---:|
| Active LOs | 103 | 103 |
| Active LOs with competency | 97 | 103 |
| Active LOs missing competency | 6 | 0 |
| Active LOs with invalid competency values | 0 | 0 |

### Competency distribution

| Competency | Before | After |
|---|---:|---:|
| technical_skills | 37 | 42 |
| statistical_reasoning | 34 | 34 |
| professional_judgment | 26 | 27 |
| multiple-primary count | 0 | 0 |
| secondary-competency count | 0 | 0 |

## Validation Results

Validation tooling executed:

1. Rscript scripts/generate-traceability-reports.R
- Completed successfully; traceability reports regenerated.

2. Python validator: docs/curriculum/validate-register.py
- Completed successfully; all checks passed.

3. Active LO competency conformance check
- LO-005 failures (missing/invalid competency) reduced to 0.
- Competency-related LO-010 failures reduced to 0.
- Approved vocabulary enforcement preserved (technical_skills/statistical_reasoning/professional_judgment only).

No unintended curriculum changes detected within remediation scope.

## Open Questions

1. Should the repository formally introduce explicit competency_primary and secondary_competency fields in schema documentation, or keep competency as the canonical single-primary field?
2. Should LO-C6-01 be periodically reviewed for potential statistical_reasoning classification if chapter-level competency balancing policy is introduced?

## Recommendations

1. Keep single-primary competency assignment as default policy unless a LO explicitly contains inseparable dual competency demands.
2. Run a full LO compliance re-audit (Phase 6) to refresh lo-compliance-audit.md and lo-compliance-audit.yml against the post-Phase-2 and post-Phase-3 state.
3. Add a lightweight automated check in CI to fail on active LOs missing competency.
