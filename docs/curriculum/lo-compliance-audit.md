# LO Compliance Audit

## Executive Summary

- Total active learning objectives audited: 114
- Fully compliant learning objectives: 0
- Partially compliant learning objectives: 0
- Non-compliant learning objectives: 114
- Active chapter-level objectives: 103
- Active section-level objectives: 11

## Inventory

- Authoritative standard used: `docs/curriculum/learning-objective-authoring-standard.md`
- Learning-objective source audited: `metadata/traceability/learning_objectives.yml`
- Traceability source files audited: `metadata/traceability/lo_to_workshop.yml`, `metadata/traceability/lo_to_review.yml`
- Supporting entity files inspected: `metadata/traceability/workshop_exercises.yml`, `metadata/traceability/review_questions.yml`
- Total LO records in metadata: 114
- Active LO records: 114
- Active chapter distribution: {1: 16, 2: 14, 3: 16, 4: 16, 5: 27, 6: 25}
- Bloom distribution: {'analyze': 17, 'apply': 25, 'create': 13, 'evaluate': 15, 'remember': 20, 'understand': 24}
- Competency distribution: {'professional_judgment': 26, 'statistical_reasoning': 34, 'technical_skills': 37}
- Active records with competency classification: 97
- Active records missing competency classification: 17
- Active records with any explicit traceability link: 17
- Active records without any explicit traceability link: 97

## Rule-Level Findings

### LO-001 Single Primary Action

- Pass count: 97
- Fail count: 10
- Needs-review count: 7
- Failure rate: 8.8%

### LO-002 Clear Learning Object

- Pass count: 113
- Fail count: 1
- Needs-review count: 0
- Failure rate: 0.9%

### LO-003 Assessability

- Pass count: 111
- Fail count: 2
- Needs-review count: 1
- Failure rate: 1.8%

### LO-004 Bloom Classification Assigned

- Pass count: 96
- Fail count: 18
- Needs-review count: 0
- Failure rate: 15.8%

### LO-005 Competency Classification Assigned

- Pass count: 97
- Fail count: 17
- Needs-review count: 0
- Failure rate: 14.9%

### LO-006 Scope Compliance

- Pass count: 103
- Fail count: 11
- Needs-review count: 0
- Failure rate: 9.6%

### LO-007 Granularity Compliance

- Pass count: 102
- Fail count: 12
- Needs-review count: 0
- Failure rate: 10.5%

### LO-008 Activity-vs-Outcome Separation

- Pass count: 112
- Fail count: 2
- Needs-review count: 0
- Failure rate: 1.8%

### LO-009 Traceability Link Presence

- Pass count: 17
- Fail count: 97
- Needs-review count: 0
- Failure rate: 85.1%

### LO-010 Metadata Conformance

- Pass count: 97
- Fail count: 17
- Needs-review count: 0
- Failure rate: 14.9%

### LO-011 Stable Identifier Governance

- Pass count: 0
- Fail count: 0
- Needs-review count: 114
- Failure rate: 0.0%

### LO-012 Language and Form Consistency

- Pass count: 102
- Fail count: 12
- Needs-review count: 0
- Failure rate: 10.5%

## Defect Distribution

### By Chapter

- Chapter 1: 16 non-compliant LOs, 27 total FAIL findings
- Chapter 2: 14 non-compliant LOs, 17 total FAIL findings
- Chapter 3: 16 non-compliant LOs, 19 total FAIL findings
- Chapter 4: 16 non-compliant LOs, 24 total FAIL findings
- Chapter 5: 27 non-compliant LOs, 73 total FAIL findings
- Chapter 6: 25 non-compliant LOs, 39 total FAIL findings

### By Rule

- LO-009: 97 FAIL findings (Traceability Link Presence)
- LO-004: 18 FAIL findings (Bloom Classification Assigned)
- LO-005: 17 FAIL findings (Competency Classification Assigned)
- LO-010: 17 FAIL findings (Metadata Conformance)
- LO-012: 12 FAIL findings (Language and Form Consistency)
- LO-007: 12 FAIL findings (Granularity Compliance)
- LO-006: 11 FAIL findings (Scope Compliance)
- LO-001: 10 FAIL findings (Single Primary Action)
- LO-003: 2 FAIL findings (Assessability)
- LO-008: 2 FAIL findings (Activity-vs-Outcome Separation)
- LO-002: 1 FAIL findings (Clear Learning Object)

### By Severity

- HIGH: 114 LOs with at least one high-severity FAIL
- MEDIUM: 0 LOs with at least one medium-severity FAIL
- LOW: 0 LOs with at least one low-severity FAIL

## Top Recurring Defects

- traceability gaps: 97
- Bloom assignment mismatches or invalid values: 18
- missing competency classifications: 17
- metadata conformance failures: 17
- granularity problems: 12
- language/form inconsistencies: 12
- legacy scope violations: 11
- compound objectives: 10
- activity statements: 2
- assessability failures: 2

## Curriculum Metrics

- LO count by chapter: {1: 16, 2: 14, 3: 16, 4: 16, 5: 27, 6: 25}
- Bloom distribution: {'analyze': 17, 'apply': 25, 'create': 13, 'evaluate': 15, 'remember': 20, 'understand': 24}
- Competency distribution: {'professional_judgment': 26, 'statistical_reasoning': 34, 'technical_skills': 37}
- Multiple-primary-competency count: 0
- Missing metadata counts: {'missing_competency': 17, 'missing_bloom': 0, 'non_chapter_scope': 11}
- Traceability coverage: {'los_with_any_traceability': 17, 'los_without_any_traceability': 97, 'los_with_workshop_links': 17, 'los_with_review_links': 4, 'total_workshop_link_rows': 202, 'total_review_link_rows': 5, 'mapped_workshop_exercises': 174, 'total_workshop_exercises': 174, 'mapped_review_questions': 5, 'total_review_questions': 5}
- Rule violation frequency: {'LO-001': 10, 'LO-004': 18, 'LO-005': 17, 'LO-010': 17, 'LO-012': 12, 'LO-006': 11, 'LO-007': 12, 'LO-009': 97, 'LO-003': 2, 'LO-008': 2, 'LO-002': 1}
- Top 10 most common violations: [('LO-009', 97), ('LO-004', 18), ('LO-005', 17), ('LO-010', 17), ('LO-012', 12), ('LO-007', 12), ('LO-006', 11), ('LO-001', 10), ('LO-003', 2), ('LO-008', 2)]

## Risk Assessment

### HIGH

- Explicit traceability is absent for 97 active LOs, limiting coverage assurance and automated alignment reporting.
- Competency classification is missing or invalid for 17 active LOs, weakening governance analysis and curriculum reporting.
- 11 active LOs remain outside the chapter-only scope model, and 17 active records fail current metadata conformance checks.

### MEDIUM

- Form/granularity defects affect 10 compound objectives and 12 granularity failures, reducing interpretability of the baseline LO set.
- Bloom mismatch heuristics flag 18 assignments for review, creating classification reliability risk for downstream analytics.

### LOW

- Language/style-related defects appear in 12 form-consistency cases, 2 assessability cases, and 2 activity-vs-outcome cases.

## Automation Boundary

- Rules that could be automated immediately: ['LO-004', 'LO-005', 'LO-006', 'LO-009', 'LO-010']
- Rules that require human review: ['LO-001', 'LO-002', 'LO-003', 'LO-007', 'LO-008', 'LO-011', 'LO-012']

## Defect Register

### LO-C1-01

- Chapter: 1
- Scope: chapter
- Text: Define a probability distribution and explain its role in describing possible outcomes of an experiment.
- LO-001: FAIL
  Reason: Multiple observable actions appear in one objective: "define" and "explain". Evidence: "Define a probability distribution and explain its role in describing possible outcomes of an experiment."
- LO-004: FAIL
  Reason: The assigned Bloom level "apply" conflicts with the leading verb "define". Evidence: "Define a probability distribution and explain its role in describing possible outcomes of an experiment."
- LO-005: FAIL
  Reason: No competency classification is present in the active LO record.
- LO-010: FAIL
  Reason: Required competency metadata is missing or invalid.
- LO-012: FAIL
  Reason: The sentence structure is not form-consistent because it contains multiple primary actions. Evidence: "Define a probability distribution and explain its role in describing possible outcomes of an experiment."
- LO-011: NEEDS HUMAN REVIEW
  Reason: Identifier stability over time cannot be confirmed from the current repository snapshot alone; historical change review is required.

### LO-C3-01

- Chapter: 3
- Scope: chapter
- Text: Define point estimation and interval estimation for population parameters.
- LO-004: FAIL
  Reason: The assigned Bloom level "apply" conflicts with the leading verb "define". Evidence: "Define point estimation and interval estimation for population parameters."
- LO-005: FAIL
  Reason: No competency classification is present in the active LO record.
- LO-010: FAIL
  Reason: Required competency metadata is missing or invalid.
- LO-011: NEEDS HUMAN REVIEW
  Reason: Identifier stability over time cannot be confirmed from the current repository snapshot alone; historical change review is required.

### LO-C4-01

- Chapter: 4
- Scope: chapter
- Text: Define auxiliary variables and stratification in the context of sampling.
- LO-004: FAIL
  Reason: The assigned Bloom level "apply" conflicts with the leading verb "define". Evidence: "Define auxiliary variables and stratification in the context of sampling."
- LO-005: FAIL
  Reason: No competency classification is present in the active LO record.
- LO-010: FAIL
  Reason: Required competency metadata is missing or invalid.
- LO-011: NEEDS HUMAN REVIEW
  Reason: Identifier stability over time cannot be confirmed from the current repository snapshot alone; historical change review is required.

### LO-C5-01

- Chapter: 5
- Scope: chapter
- Text: Define regression analysis and identify its primary components: dependent variable, independent variable, and error term.
- LO-001: FAIL
  Reason: Multiple observable actions appear in one objective: "define" and "identify". Evidence: "Define regression analysis and identify its primary components: dependent variable, independent variable, and error term."
- LO-004: FAIL
  Reason: The assigned Bloom level "apply" conflicts with the leading verb "define". Evidence: "Define regression analysis and identify its primary components: dependent variable, independent variable, and error term."
- LO-005: FAIL
  Reason: No competency classification is present in the active LO record.
- LO-010: FAIL
  Reason: Required competency metadata is missing or invalid.
- LO-012: FAIL
  Reason: The sentence structure is not form-consistent because it contains multiple primary actions. Evidence: "Define regression analysis and identify its primary components: dependent variable, independent variable, and error term."
- LO-011: NEEDS HUMAN REVIEW
  Reason: Identifier stability over time cannot be confirmed from the current repository snapshot alone; historical change review is required.

### LO-C5S5.1-01

- Chapter: 5
- Scope: section
- Text: Define regression analysis and identify its primary components: dependent variable, independent variable, and error term.
- LO-001: FAIL
  Reason: Multiple observable actions appear in one objective: "define" and "identify". Evidence: "Define regression analysis and identify its primary components: dependent variable, independent variable, and error term."
- LO-004: FAIL
  Reason: The assigned Bloom level "understand" conflicts with the leading verb "define". Evidence: "Define regression analysis and identify its primary components: dependent variable, independent variable, and error term."
- LO-005: FAIL
  Reason: No competency classification is present in the active LO record.
- LO-006: FAIL
  Reason: Scope is "section" but the standard permits only chapter-level active LOs.
- LO-007: FAIL
  Reason: The objective is section-scoped and therefore below the required chapter-level outcome granularity. Evidence: "Define regression analysis and identify its primary components: dependent variable, independent variable, and error term."
- LO-010: FAIL
  Reason: Scope value "section" is non-compliant with the chapter-only active LO model.
- LO-012: FAIL
  Reason: The sentence structure is not form-consistent because it contains multiple primary actions. Evidence: "Define regression analysis and identify its primary components: dependent variable, independent variable, and error term."
- LO-011: NEEDS HUMAN REVIEW
  Reason: Identifier stability over time cannot be confirmed from the current repository snapshot alone; historical change review is required.

### LO-C5S5.2-01

- Chapter: 5
- Scope: section
- Text: List the key assumptions underlying regression analysis: linearity in the parameters, random sampling, sample variation, and zero-conditional mean of errors.
- LO-004: FAIL
  Reason: The assigned Bloom level "understand" conflicts with the leading verb "list". Evidence: "List the key assumptions underlying regression analysis: linearity in the parameters, random sampling, sample variation, and zero-conditional mean of errors."
- LO-005: FAIL
  Reason: No competency classification is present in the active LO record.
- LO-006: FAIL
  Reason: Scope is "section" but the standard permits only chapter-level active LOs.
- LO-007: FAIL
  Reason: The objective is section-scoped and therefore below the required chapter-level outcome granularity. Evidence: "List the key assumptions underlying regression analysis: linearity in the parameters, random sampling, sample variation, and zero-conditional mean of errors."
- LO-010: FAIL
  Reason: Scope value "section" is non-compliant with the chapter-only active LO model.
- LO-011: NEEDS HUMAN REVIEW
  Reason: Identifier stability over time cannot be confirmed from the current repository snapshot alone; historical change review is required.

### LO-C5S5.3-01

- Chapter: 5
- Scope: section
- Text: Identify steps for summarizing and plotting data to explore relationships.
- LO-004: FAIL
  Reason: The assigned Bloom level "apply" appears higher than the stated identification demand. Evidence: "Identify steps for summarizing and plotting data to explore relationships."
- LO-005: FAIL
  Reason: No competency classification is present in the active LO record.
- LO-006: FAIL
  Reason: Scope is "section" but the standard permits only chapter-level active LOs.
- LO-007: FAIL
  Reason: The objective is section-scoped and therefore below the required chapter-level outcome granularity. Evidence: "Identify steps for summarizing and plotting data to explore relationships."
- LO-010: FAIL
  Reason: Scope value "section" is non-compliant with the chapter-only active LO model.
- LO-011: NEEDS HUMAN REVIEW
  Reason: Identifier stability over time cannot be confirmed from the current repository snapshot alone; historical change review is required.

### LO-C5S5.4-01

- Chapter: 5
- Scope: section
- Text: Define linear regression and describe key components like predictors, response, and error terms.
- LO-001: FAIL
  Reason: Multiple observable actions appear in one objective: "define" and "describe". Evidence: "Define linear regression and describe key components like predictors, response, and error terms."
- LO-004: FAIL
  Reason: The assigned Bloom level "apply" conflicts with the leading verb "define". Evidence: "Define linear regression and describe key components like predictors, response, and error terms."
- LO-005: FAIL
  Reason: No competency classification is present in the active LO record.
- LO-006: FAIL
  Reason: Scope is "section" but the standard permits only chapter-level active LOs.
- LO-007: FAIL
  Reason: The objective is section-scoped and therefore below the required chapter-level outcome granularity. Evidence: "Define linear regression and describe key components like predictors, response, and error terms."
- LO-010: FAIL
  Reason: Scope value "section" is non-compliant with the chapter-only active LO model.
- LO-012: FAIL
  Reason: The sentence structure is not form-consistent because it contains multiple primary actions. Evidence: "Define linear regression and describe key components like predictors, response, and error terms."
- LO-011: NEEDS HUMAN REVIEW
  Reason: Identifier stability over time cannot be confirmed from the current repository snapshot alone; historical change review is required.

### LO-C5S5.5-01

- Chapter: 5
- Scope: section
- Text: List common diagnostic tools for detecting outliers and influential observations.
- LO-004: FAIL
  Reason: The assigned Bloom level "analyze" conflicts with the leading verb "list". Evidence: "List common diagnostic tools for detecting outliers and influential observations."
- LO-005: FAIL
  Reason: No competency classification is present in the active LO record.
- LO-006: FAIL
  Reason: Scope is "section" but the standard permits only chapter-level active LOs.
- LO-007: FAIL
  Reason: The objective is section-scoped and therefore below the required chapter-level outcome granularity. Evidence: "List common diagnostic tools for detecting outliers and influential observations."
- LO-010: FAIL
  Reason: Scope value "section" is non-compliant with the chapter-only active LO model.
- LO-011: NEEDS HUMAN REVIEW
  Reason: Identifier stability over time cannot be confirmed from the current repository snapshot alone; historical change review is required.

### LO-C5S5.6-01

- Chapter: 5
- Scope: section
- Text: State the purpose of analysis of variance (ANOVA) in the context of regression models.
- LO-004: FAIL
  Reason: The assigned Bloom level "understand" conflicts with the leading verb "state". Evidence: "State the purpose of analysis of variance (ANOVA) in the context of regression models."
- LO-005: FAIL
  Reason: No competency classification is present in the active LO record.
- LO-006: FAIL
  Reason: Scope is "section" but the standard permits only chapter-level active LOs.
- LO-007: FAIL
  Reason: The objective is section-scoped and therefore below the required chapter-level outcome granularity. Evidence: "State the purpose of analysis of variance (ANOVA) in the context of regression models."
- LO-010: FAIL
  Reason: Scope value "section" is non-compliant with the chapter-only active LO model.
- LO-011: NEEDS HUMAN REVIEW
  Reason: Identifier stability over time cannot be confirmed from the current repository snapshot alone; historical change review is required.

### LO-C5S5.7-01

- Chapter: 5
- Scope: section
- Text: Identify the assumptions underlying linear regression (e.g., normality, homoscedasticity, independence).
- LO-004: FAIL
  Reason: The assigned Bloom level "analyze" appears higher than the stated identification demand. Evidence: "Identify the assumptions underlying linear regression (e.g., normality, homoscedasticity, independence)."
- LO-005: FAIL
  Reason: No competency classification is present in the active LO record.
- LO-006: FAIL
  Reason: Scope is "section" but the standard permits only chapter-level active LOs.
- LO-007: FAIL
  Reason: The objective is section-scoped and therefore below the required chapter-level outcome granularity. Evidence: "Identify the assumptions underlying linear regression (e.g., normality, homoscedasticity, independence)."
- LO-010: FAIL
  Reason: Scope value "section" is non-compliant with the chapter-only active LO model.
- LO-011: NEEDS HUMAN REVIEW
  Reason: Identifier stability over time cannot be confirmed from the current repository snapshot alone; historical change review is required.

### LO-C5S5.8-01

- Chapter: 5
- Scope: section
- Text: Recall the null and alternative hypotheses for testing coefficients and the overall model.
- LO-004: FAIL
  Reason: The assigned Bloom level "evaluate" conflicts with the leading verb "recall". Evidence: "Recall the null and alternative hypotheses for testing coefficients and the overall model."
- LO-005: FAIL
  Reason: No competency classification is present in the active LO record.
- LO-006: FAIL
  Reason: Scope is "section" but the standard permits only chapter-level active LOs.
- LO-007: FAIL
  Reason: The objective is section-scoped and therefore below the required chapter-level outcome granularity. Evidence: "Recall the null and alternative hypotheses for testing coefficients and the overall model."
- LO-010: FAIL
  Reason: Scope value "section" is non-compliant with the chapter-only active LO model.
- LO-011: NEEDS HUMAN REVIEW
  Reason: Identifier stability over time cannot be confirmed from the current repository snapshot alone; historical change review is required.

### LO-C5S5.9-01

- Chapter: 5
- Scope: section
- Text: State the definitions of confidence and prediction intervals, and define the difference between predictions for new data points and predictions for mean responses.
- LO-001: FAIL
  Reason: Multiple observable actions appear in one objective: "state" and "define". Evidence: "State the definitions of confidence and prediction intervals, and define the difference between predictions for new data points and predictions for mean responses."
- LO-004: FAIL
  Reason: The assigned Bloom level "apply" conflicts with the leading verb "state". Evidence: "State the definitions of confidence and prediction intervals, and define the difference between predictions for new data points and predictions for mean responses."
- LO-005: FAIL
  Reason: No competency classification is present in the active LO record.
- LO-006: FAIL
  Reason: Scope is "section" but the standard permits only chapter-level active LOs.
- LO-007: FAIL
  Reason: The objective is section-scoped and therefore below the required chapter-level outcome granularity. Evidence: "State the definitions of confidence and prediction intervals, and define the difference between predictions for new data points and predictions for mean responses."
- LO-010: FAIL
  Reason: Scope value "section" is non-compliant with the chapter-only active LO model.
- LO-012: FAIL
  Reason: The sentence structure is not form-consistent because it contains multiple primary actions. Evidence: "State the definitions of confidence and prediction intervals, and define the difference between predictions for new data points and predictions for mean responses."
- LO-011: NEEDS HUMAN REVIEW
  Reason: Identifier stability over time cannot be confirmed from the current repository snapshot alone; historical change review is required.

### LO-C6-01

- Chapter: 6
- Scope: chapter
- Text: Define goodness of fit and explain its purpose in statistical analysis.
- LO-001: FAIL
  Reason: Multiple observable actions appear in one objective: "define" and "explain". Evidence: "Define goodness of fit and explain its purpose in statistical analysis."
- LO-004: FAIL
  Reason: The assigned Bloom level "understand" conflicts with the leading verb "define". Evidence: "Define goodness of fit and explain its purpose in statistical analysis."
- LO-005: FAIL
  Reason: No competency classification is present in the active LO record.
- LO-010: FAIL
  Reason: Required competency metadata is missing or invalid.
- LO-012: FAIL
  Reason: The sentence structure is not form-consistent because it contains multiple primary actions. Evidence: "Define goodness of fit and explain its purpose in statistical analysis."
- LO-011: NEEDS HUMAN REVIEW
  Reason: Identifier stability over time cannot be confirmed from the current repository snapshot alone; historical change review is required.

### LO-C6-02

- Chapter: 6
- Scope: chapter
- Text: Distinguish statistical evidence of anomaly from conclusive evidence of fraud.
- LO-005: FAIL
  Reason: No competency classification is present in the active LO record.
- LO-010: FAIL
  Reason: Required competency metadata is missing or invalid.
- LO-011: NEEDS HUMAN REVIEW
  Reason: Identifier stability over time cannot be confirmed from the current repository snapshot alone; historical change review is required.

### LO-C6S6.2-01

- Chapter: 6
- Scope: section
- Text: Apply Benford-based expected frequencies to interpret observed-versus-expected deviations.
- LO-005: FAIL
  Reason: No competency classification is present in the active LO record.
- LO-006: FAIL
  Reason: Scope is "section" but the standard permits only chapter-level active LOs.
- LO-007: FAIL
  Reason: The objective is section-scoped and therefore below the required chapter-level outcome granularity. Evidence: "Apply Benford-based expected frequencies to interpret observed-versus-expected deviations."
- LO-010: FAIL
  Reason: Scope value "section" is non-compliant with the chapter-only active LO model.
- LO-001: NEEDS HUMAN REVIEW
  Reason: The objective may combine one primary action with an integrated infinitive purpose ("apply ... to interpret"). Evidence: "Apply Benford-based expected frequencies to interpret observed-versus-expected deviations."
- LO-011: NEEDS HUMAN REVIEW
  Reason: Identifier stability over time cannot be confirmed from the current repository snapshot alone; historical change review is required.

### LO-C6S6.2-02

- Chapter: 6
- Scope: section
- Text: Evaluate whether identified digit anomalies warrant additional audit procedures.
- LO-005: FAIL
  Reason: No competency classification is present in the active LO record.
- LO-006: FAIL
  Reason: Scope is "section" but the standard permits only chapter-level active LOs.
- LO-007: FAIL
  Reason: The objective is section-scoped and therefore below the required chapter-level outcome granularity. Evidence: "Evaluate whether identified digit anomalies warrant additional audit procedures."
- LO-010: FAIL
  Reason: Scope value "section" is non-compliant with the chapter-only active LO model.
- LO-011: NEEDS HUMAN REVIEW
  Reason: Identifier stability over time cannot be confirmed from the current repository snapshot alone; historical change review is required.

### LO-C1-02

- Chapter: 1
- Scope: chapter
- Text: define a probability distribution and explain its role in describing possible outcomes of an experiment.
- LO-001: FAIL
  Reason: Multiple observable actions appear in one objective: "define" and "explain". Evidence: "define a probability distribution and explain its role in describing possible outcomes of an experiment."
- LO-009: FAIL
  Reason: No explicit workshop or review-question traceability link is present for this active LO.
- LO-012: FAIL
  Reason: The sentence structure is not form-consistent because it contains multiple primary actions. Evidence: "define a probability distribution and explain its role in describing possible outcomes of an experiment."
- LO-011: NEEDS HUMAN REVIEW
  Reason: Identifier stability over time cannot be confirmed from the current repository snapshot alone; historical change review is required.

### LO-C1-03

- Chapter: 1
- Scope: chapter
- Text: recall examples of discrete and continuous probability distributions (e.g., hypergeometric, binomial, normal).
- LO-009: FAIL
  Reason: No explicit workshop or review-question traceability link is present for this active LO.
- LO-011: NEEDS HUMAN REVIEW
  Reason: Identifier stability over time cannot be confirmed from the current repository snapshot alone; historical change review is required.

### LO-C1-04

- Chapter: 1
- Scope: chapter
- Text: list common distributions used in statistics, including the hypergeometric, binomial, Poisson, normal, Student’s t, χ^2, and F distributions.
- LO-009: FAIL
  Reason: No explicit workshop or review-question traceability link is present for this active LO.
- LO-011: NEEDS HUMAN REVIEW
  Reason: Identifier stability over time cannot be confirmed from the current repository snapshot alone; historical change review is required.

### LO-C1-05

- Chapter: 1
- Scope: chapter
- Text: explain the difference between sampling with and without replacement and its impact on the distribution of successes (e.g., hypergeometric versus binomial).
- LO-009: FAIL
  Reason: No explicit workshop or review-question traceability link is present for this active LO.
- LO-011: NEEDS HUMAN REVIEW
  Reason: Identifier stability over time cannot be confirmed from the current repository snapshot alone; historical change review is required.

### LO-C1-06

- Chapter: 1
- Scope: chapter
- Text: describe the central limit theorem and its implications for the distribution of the sample mean as sample size increases.
- LO-009: FAIL
  Reason: No explicit workshop or review-question traceability link is present for this active LO.
- LO-011: NEEDS HUMAN REVIEW
  Reason: Identifier stability over time cannot be confirmed from the current repository snapshot alone; historical change review is required.

### LO-C1-07

- Chapter: 1
- Scope: chapter
- Text: discuss the historical and practical significance of approximating one probability distribution with another.
- LO-009: FAIL
  Reason: No explicit workshop or review-question traceability link is present for this active LO.
- LO-003: NEEDS HUMAN REVIEW
  Reason: "discuss" is observable but may not define sufficiently specific assessment evidence without rubric context. Evidence: "discuss the historical and practical significance of approximating one probability distribution with another."
- LO-011: NEEDS HUMAN REVIEW
  Reason: Identifier stability over time cannot be confirmed from the current repository snapshot alone; historical change review is required.

### LO-C1-08

- Chapter: 1
- Scope: chapter
- Text: compute probabilities using the hypergeometric, binomial, Poisson, normal, Student’s t, χ^2, and F distributions.
- LO-009: FAIL
  Reason: No explicit workshop or review-question traceability link is present for this active LO.
- LO-011: NEEDS HUMAN REVIEW
  Reason: Identifier stability over time cannot be confirmed from the current repository snapshot alone; historical change review is required.

### LO-C1-09

- Chapter: 1
- Scope: chapter
- Text: perform probability calculations in R or Python to solve practical problems using these distributions.
- LO-009: FAIL
  Reason: No explicit workshop or review-question traceability link is present for this active LO.
- LO-011: NEEDS HUMAN REVIEW
  Reason: Identifier stability over time cannot be confirmed from the current repository snapshot alone; historical change review is required.

### LO-C1-10

- Chapter: 1
- Scope: chapter
- Text: assess the conditions under which the binomial distribution can approximate the hypergeometric distribution.
- LO-009: FAIL
  Reason: No explicit workshop or review-question traceability link is present for this active LO.
- LO-011: NEEDS HUMAN REVIEW
  Reason: Identifier stability over time cannot be confirmed from the current repository snapshot alone; historical change review is required.

### LO-C1-11

- Chapter: 1
- Scope: chapter
- Text: determine when the Poisson distribution can be used to approximate the binomial distribution.
- LO-009: FAIL
  Reason: No explicit workshop or review-question traceability link is present for this active LO.
- LO-011: NEEDS HUMAN REVIEW
  Reason: Identifier stability over time cannot be confirmed from the current repository snapshot alone; historical change review is required.

### LO-C1-12

- Chapter: 1
- Scope: chapter
- Text: evaluate whether the normal distribution can approximate the t-distribution under given circumstances.
- LO-004: FAIL
  Reason: The assigned Bloom level "analyze" conflicts with the leading verb "evaluate". Evidence: "evaluate whether the normal distribution can approximate the t-distribution under given circumstances."
- LO-009: FAIL
  Reason: No explicit workshop or review-question traceability link is present for this active LO.
- LO-011: NEEDS HUMAN REVIEW
  Reason: Identifier stability over time cannot be confirmed from the current repository snapshot alone; historical change review is required.

### LO-C1-13

- Chapter: 1
- Scope: chapter
- Text: judge the appropriateness of approximations between distributions in modern computational contexts.
- LO-009: FAIL
  Reason: No explicit workshop or review-question traceability link is present for this active LO.
- LO-011: NEEDS HUMAN REVIEW
  Reason: Identifier stability over time cannot be confirmed from the current repository snapshot alone; historical change review is required.

### LO-C1-14

- Chapter: 1
- Scope: chapter
- Text: critique the usefulness of such approximations in specific professional or theoretical applications, even when computing power is not a limitation.
- LO-009: FAIL
  Reason: No explicit workshop or review-question traceability link is present for this active LO.
- LO-011: NEEDS HUMAN REVIEW
  Reason: Identifier stability over time cannot be confirmed from the current repository snapshot alone; historical change review is required.

### LO-C1-15

- Chapter: 1
- Scope: chapter
- Text: design a simulation study to illustrate the central limit theorem, showing how the sample mean approaches a normal distribution with increasing sample size.
- LO-009: FAIL
  Reason: No explicit workshop or review-question traceability link is present for this active LO.
- LO-011: NEEDS HUMAN REVIEW
  Reason: Identifier stability over time cannot be confirmed from the current repository snapshot alone; historical change review is required.

### LO-C1-16

- Chapter: 1
- Scope: chapter
- Text: conduct exercises in R or Python to calculate probabilities for various distributions, enabling students to apply statistical concepts using programming tools.
- LO-003: FAIL
  Reason: The statement is framed as an activity rather than directly assessable student performance. Evidence: "conduct exercises in R or Python to calculate probabilities for various distributions, enabling students to apply statistical concepts using programming tools."
- LO-007: FAIL
  Reason: The objective describes an activity bundle rather than a chapter-level capability. Evidence: "conduct exercises in R or Python to calculate probabilities for various distributions, enabling students to apply statistical concepts using programming tools."
- LO-008: FAIL
  Reason: The objective is framed as an activity rather than an outcome. Evidence: "conduct exercises in R or Python to calculate probabilities for various distributions, enabling students to apply statistical concepts using programming tools."
- LO-009: FAIL
  Reason: No explicit workshop or review-question traceability link is present for this active LO.
- LO-012: FAIL
  Reason: The wording is not aligned with the action-first outcome style because it foregrounds activity participation. Evidence: "conduct exercises in R or Python to calculate probabilities for various distributions, enabling students to apply statistical concepts using programming tools."
- LO-001: NEEDS HUMAN REVIEW
  Reason: The objective may combine one primary action with an integrated infinitive purpose ("conduct ... to apply"). Evidence: "conduct exercises in R or Python to calculate probabilities for various distributions, enabling students to apply statistical concepts using programming tools."
- LO-011: NEEDS HUMAN REVIEW
  Reason: Identifier stability over time cannot be confirmed from the current repository snapshot alone; historical change review is required.

### LO-C2-01

- Chapter: 2
- Scope: chapter
- Text: define point estimation and interval estimation for population parameters.
- LO-009: FAIL
  Reason: No explicit workshop or review-question traceability link is present for this active LO.
- LO-011: NEEDS HUMAN REVIEW
  Reason: Identifier stability over time cannot be confirmed from the current repository snapshot alone; historical change review is required.

### LO-C2-02

- Chapter: 2
- Scope: chapter
- Text: identify the difference between population mean, population total, and population proportion.
- LO-009: FAIL
  Reason: No explicit workshop or review-question traceability link is present for this active LO.
- LO-011: NEEDS HUMAN REVIEW
  Reason: Identifier stability over time cannot be confirmed from the current repository snapshot alone; historical change review is required.

### LO-C2-03

- Chapter: 2
- Scope: chapter
- Text: recall the purpose of the finite population correction factor.
- LO-009: FAIL
  Reason: No explicit workshop or review-question traceability link is present for this active LO.
- LO-011: NEEDS HUMAN REVIEW
  Reason: Identifier stability over time cannot be confirmed from the current repository snapshot alone; historical change review is required.

### LO-C2-04

- Chapter: 2
- Scope: chapter
- Text: explain the relationship between sample size, confidence level, and precision in estimation.
- LO-009: FAIL
  Reason: No explicit workshop or review-question traceability link is present for this active LO.
- LO-011: NEEDS HUMAN REVIEW
  Reason: Identifier stability over time cannot be confirmed from the current repository snapshot alone; historical change review is required.

### LO-C2-05

- Chapter: 2
- Scope: chapter
- Text: describe the importance of distinguishing between qualitative and quantitative characteristics in estimation.
- LO-009: FAIL
  Reason: No explicit workshop or review-question traceability link is present for this active LO.
- LO-011: NEEDS HUMAN REVIEW
  Reason: Identifier stability over time cannot be confirmed from the current repository snapshot alone; historical change review is required.

### LO-C2-06

- Chapter: 2
- Scope: chapter
- Text: explain the assumptions underlying the normality of the sample mean and recognize when these assumptions may be invalid.
- LO-009: FAIL
  Reason: No explicit workshop or review-question traceability link is present for this active LO.
- LO-011: NEEDS HUMAN REVIEW
  Reason: Identifier stability over time cannot be confirmed from the current repository snapshot alone; historical change review is required.

### LO-C2-07

- Chapter: 2
- Scope: chapter
- Text: calculate point estimates for the population mean, population total, and population proportion using sample data.
- LO-009: FAIL
  Reason: No explicit workshop or review-question traceability link is present for this active LO.
- LO-011: NEEDS HUMAN REVIEW
  Reason: Identifier stability over time cannot be confirmed from the current repository snapshot alone; historical change review is required.

### LO-C2-08

- Chapter: 2
- Scope: chapter
- Text: construct two-sided and one-sided confidence intervals for the population mean, population total, and population proportion.
- LO-009: FAIL
  Reason: No explicit workshop or review-question traceability link is present for this active LO.
- LO-011: NEEDS HUMAN REVIEW
  Reason: Identifier stability over time cannot be confirmed from the current repository snapshot alone; historical change review is required.

### LO-C2-09

- Chapter: 2
- Scope: chapter
- Text: assess the effect of the finite population correction factor on interval estimates.
- LO-009: FAIL
  Reason: No explicit workshop or review-question traceability link is present for this active LO.
- LO-011: NEEDS HUMAN REVIEW
  Reason: Identifier stability over time cannot be confirmed from the current repository snapshot alone; historical change review is required.

### LO-C2-10

- Chapter: 2
- Scope: chapter
- Text: evaluate the adequacy of sample findings in achieving desired precision and determine the need for additional sampling.
- LO-001: FAIL
  Reason: Multiple observable actions appear in one objective: "evaluate" and "determine". Evidence: "evaluate the adequacy of sample findings in achieving desired precision and determine the need for additional sampling."
- LO-004: FAIL
  Reason: The assigned Bloom level "analyze" conflicts with the leading verb "evaluate". Evidence: "evaluate the adequacy of sample findings in achieving desired precision and determine the need for additional sampling."
- LO-009: FAIL
  Reason: No explicit workshop or review-question traceability link is present for this active LO.
- LO-012: FAIL
  Reason: The sentence structure is not form-consistent because it contains multiple primary actions. Evidence: "evaluate the adequacy of sample findings in achieving desired precision and determine the need for additional sampling."
- LO-011: NEEDS HUMAN REVIEW
  Reason: Identifier stability over time cannot be confirmed from the current repository snapshot alone; historical change review is required.

### LO-C2-11

- Chapter: 2
- Scope: chapter
- Text: judge the precision of interval estimates and their consistency with recorded population characteristics.
- LO-009: FAIL
  Reason: No explicit workshop or review-question traceability link is present for this active LO.
- LO-011: NEEDS HUMAN REVIEW
  Reason: Identifier stability over time cannot be confirmed from the current repository snapshot alone; historical change review is required.

### LO-C2-12

- Chapter: 2
- Scope: chapter
- Text: critique the validity of the normality assumption in specific sampling scenarios.
- LO-009: FAIL
  Reason: No explicit workshop or review-question traceability link is present for this active LO.
- LO-011: NEEDS HUMAN REVIEW
  Reason: Identifier stability over time cannot be confirmed from the current repository snapshot alone; historical change review is required.

### LO-C2-13

- Chapter: 2
- Scope: chapter
- Text: design a sampling plan that ensures target precision at a given confidence level.
- LO-009: FAIL
  Reason: No explicit workshop or review-question traceability link is present for this active LO.
- LO-011: NEEDS HUMAN REVIEW
  Reason: Identifier stability over time cannot be confirmed from the current repository snapshot alone; historical change review is required.

### LO-C2-14

- Chapter: 2
- Scope: chapter
- Text: develop strategies to handle cases where the normality assumption for the sample mean does not hold.
- LO-009: FAIL
  Reason: No explicit workshop or review-question traceability link is present for this active LO.
- LO-011: NEEDS HUMAN REVIEW
  Reason: Identifier stability over time cannot be confirmed from the current repository snapshot alone; historical change review is required.

### LO-C3-02

- Chapter: 3
- Scope: chapter
- Text: define auxiliary variables and stratification in the context of sampling.
- LO-009: FAIL
  Reason: No explicit workshop or review-question traceability link is present for this active LO.
- LO-011: NEEDS HUMAN REVIEW
  Reason: Identifier stability over time cannot be confirmed from the current repository snapshot alone; historical change review is required.

### LO-C3-03

- Chapter: 3
- Scope: chapter
- Text: list the four estimators discussed: mean-per-unit, regression, ratio, and difference estimation.
- LO-009: FAIL
  Reason: No explicit workshop or review-question traceability link is present for this active LO.
- LO-011: NEEDS HUMAN REVIEW
  Reason: Identifier stability over time cannot be confirmed from the current repository snapshot alone; historical change review is required.

### LO-C3-04

- Chapter: 3
- Scope: chapter
- Text: recall the assumption of normality for the sample mean and the conditions under which it may be violated.
- LO-009: FAIL
  Reason: No explicit workshop or review-question traceability link is present for this active LO.
- LO-011: NEEDS HUMAN REVIEW
  Reason: Identifier stability over time cannot be confirmed from the current repository snapshot alone; historical change review is required.

### LO-C3-05

- Chapter: 3
- Scope: chapter
- Text: explain how auxiliary variables improve the precision of estimates.
- LO-009: FAIL
  Reason: No explicit workshop or review-question traceability link is present for this active LO.
- LO-011: NEEDS HUMAN REVIEW
  Reason: Identifier stability over time cannot be confirmed from the current repository snapshot alone; historical change review is required.

### LO-C3-06

- Chapter: 3
- Scope: chapter
- Text: describe the benefits of stratifying a population and how it supports normality of the sample mean.
- LO-009: FAIL
  Reason: No explicit workshop or review-question traceability link is present for this active LO.
- LO-011: NEEDS HUMAN REVIEW
  Reason: Identifier stability over time cannot be confirmed from the current repository snapshot alone; historical change review is required.

### LO-C3-07

- Chapter: 3
- Scope: chapter
- Text: differentiate between the four estimators (mean-per-unit, regression, ratio, and difference estimation) and explain their appropriate use cases.
- LO-009: FAIL
  Reason: No explicit workshop or review-question traceability link is present for this active LO.
- LO-011: NEEDS HUMAN REVIEW
  Reason: Identifier stability over time cannot be confirmed from the current repository snapshot alone; historical change review is required.

### LO-C3-08

- Chapter: 3
- Scope: chapter
- Text: stratify a population based on available data.
- LO-009: FAIL
  Reason: No explicit workshop or review-question traceability link is present for this active LO.
- LO-011: NEEDS HUMAN REVIEW
  Reason: Identifier stability over time cannot be confirmed from the current repository snapshot alone; historical change review is required.

### LO-C3-09

- Chapter: 3
- Scope: chapter
- Text: allocate a calculated sample size to strata using proportional or optimal allocation methods.
- LO-009: FAIL
  Reason: No explicit workshop or review-question traceability link is present for this active LO.
- LO-011: NEEDS HUMAN REVIEW
  Reason: Identifier stability over time cannot be confirmed from the current repository snapshot alone; historical change review is required.

### LO-C3-10

- Chapter: 3
- Scope: chapter
- Text: evaluate the results of a stratified sample to estimate population characteristics.
- LO-004: FAIL
  Reason: The assigned Bloom level "apply" conflicts with the leading verb "evaluate". Evidence: "evaluate the results of a stratified sample to estimate population characteristics."
- LO-009: FAIL
  Reason: No explicit workshop or review-question traceability link is present for this active LO.
- LO-011: NEEDS HUMAN REVIEW
  Reason: Identifier stability over time cannot be confirmed from the current repository snapshot alone; historical change review is required.

### LO-C3-11

- Chapter: 3
- Scope: chapter
- Text: assess sampling situations to determine whether auxiliary variables or stratification would improve estimation precision.
- LO-009: FAIL
  Reason: No explicit workshop or review-question traceability link is present for this active LO.
- LO-001: NEEDS HUMAN REVIEW
  Reason: The objective may combine one primary action with an integrated infinitive purpose ("assess ... to determine"). Evidence: "assess sampling situations to determine whether auxiliary variables or stratification would improve estimation precision."
- LO-011: NEEDS HUMAN REVIEW
  Reason: Identifier stability over time cannot be confirmed from the current repository snapshot alone; historical change review is required.

### LO-C3-12

- Chapter: 3
- Scope: chapter
- Text: examine the impact of stratification and auxiliary variables on reducing bias and promoting normality.
- LO-009: FAIL
  Reason: No explicit workshop or review-question traceability link is present for this active LO.
- LO-011: NEEDS HUMAN REVIEW
  Reason: Identifier stability over time cannot be confirmed from the current repository snapshot alone; historical change review is required.

### LO-C3-13

- Chapter: 3
- Scope: chapter
- Text: critically assess whether the assumption of normality for the sample mean holds in specific sampling scenarios.
- LO-009: FAIL
  Reason: No explicit workshop or review-question traceability link is present for this active LO.
- LO-011: NEEDS HUMAN REVIEW
  Reason: Identifier stability over time cannot be confirmed from the current repository snapshot alone; historical change review is required.

### LO-C3-14

- Chapter: 3
- Scope: chapter
- Text: compare the precision and accuracy of different estimators in varied sampling contexts.
- LO-009: FAIL
  Reason: No explicit workshop or review-question traceability link is present for this active LO.
- LO-011: NEEDS HUMAN REVIEW
  Reason: Identifier stability over time cannot be confirmed from the current repository snapshot alone; historical change review is required.

### LO-C3-15

- Chapter: 3
- Scope: chapter
- Text: design a sampling plan incorporating stratification and auxiliary variables to achieve precise and unbiased estimates.
- LO-009: FAIL
  Reason: No explicit workshop or review-question traceability link is present for this active LO.
- LO-011: NEEDS HUMAN REVIEW
  Reason: Identifier stability over time cannot be confirmed from the current repository snapshot alone; historical change review is required.

### LO-C3-16

- Chapter: 3
- Scope: chapter
- Text: develop strategies to address cases where the assumption of normality is violated.
- LO-009: FAIL
  Reason: No explicit workshop or review-question traceability link is present for this active LO.
- LO-011: NEEDS HUMAN REVIEW
  Reason: Identifier stability over time cannot be confirmed from the current repository snapshot alone; historical change review is required.

### LO-C4-02

- Chapter: 4
- Scope: chapter
- Text: define the purpose of a hypothesis test and describe the steps involved in carrying it out.
- LO-001: FAIL
  Reason: Multiple observable actions appear in one objective: "define" and "describe". Evidence: "define the purpose of a hypothesis test and describe the steps involved in carrying it out."
- LO-009: FAIL
  Reason: No explicit workshop or review-question traceability link is present for this active LO.
- LO-012: FAIL
  Reason: The sentence structure is not form-consistent because it contains multiple primary actions. Evidence: "define the purpose of a hypothesis test and describe the steps involved in carrying it out."
- LO-011: NEEDS HUMAN REVIEW
  Reason: Identifier stability over time cannot be confirmed from the current repository snapshot alone; historical change review is required.

### LO-C4-03

- Chapter: 4
- Scope: chapter
- Text: distinguish between Type I and Type II errors, including their definitions and implications.
- LO-004: FAIL
  Reason: The assigned Bloom level "remember" conflicts with the leading verb "distinguish". Evidence: "distinguish between Type I and Type II errors, including their definitions and implications."
- LO-009: FAIL
  Reason: No explicit workshop or review-question traceability link is present for this active LO.
- LO-011: NEEDS HUMAN REVIEW
  Reason: Identifier stability over time cannot be confirmed from the current repository snapshot alone; historical change review is required.

### LO-C4-04

- Chapter: 4
- Scope: chapter
- Text: list the conditions under which hypothesis tests are valid.
- LO-009: FAIL
  Reason: No explicit workshop or review-question traceability link is present for this active LO.
- LO-011: NEEDS HUMAN REVIEW
  Reason: Identifier stability over time cannot be confirmed from the current repository snapshot alone; historical change review is required.

### LO-C4-05

- Chapter: 4
- Scope: chapter
- Text: explain how the required sample size is determined for a hypothesis test, taking into account factors like significance level, effect size, and power.
- LO-009: FAIL
  Reason: No explicit workshop or review-question traceability link is present for this active LO.
- LO-011: NEEDS HUMAN REVIEW
  Reason: Identifier stability over time cannot be confirmed from the current repository snapshot alone; historical change review is required.

### LO-C4-06

- Chapter: 4
- Scope: chapter
- Text: identify scenarios where hypothesis testing is feasible and appropriate.
- LO-009: FAIL
  Reason: No explicit workshop or review-question traceability link is present for this active LO.
- LO-011: NEEDS HUMAN REVIEW
  Reason: Identifier stability over time cannot be confirmed from the current repository snapshot alone; historical change review is required.

### LO-C4-07

- Chapter: 4
- Scope: chapter
- Text: describe how the theory of hypothesis testing is applied within the context of Monetary Unit Sampling (MUS).
- LO-009: FAIL
  Reason: No explicit workshop or review-question traceability link is present for this active LO.
- LO-011: NEEDS HUMAN REVIEW
  Reason: Identifier stability over time cannot be confirmed from the current repository snapshot alone; historical change review is required.

### LO-C4-08

- Chapter: 4
- Scope: chapter
- Text: conduct a hypothesis test using sample data, including interpreting the results in the context of an audit.
- LO-003: FAIL
  Reason: The statement is framed as an activity rather than directly assessable student performance. Evidence: "conduct a hypothesis test using sample data, including interpreting the results in the context of an audit."
- LO-008: FAIL
  Reason: The objective is framed as an activity rather than an outcome. Evidence: "conduct a hypothesis test using sample data, including interpreting the results in the context of an audit."
- LO-009: FAIL
  Reason: No explicit workshop or review-question traceability link is present for this active LO.
- LO-012: FAIL
  Reason: The wording is not aligned with the action-first outcome style because it foregrounds activity participation. Evidence: "conduct a hypothesis test using sample data, including interpreting the results in the context of an audit."
- LO-011: NEEDS HUMAN REVIEW
  Reason: Identifier stability over time cannot be confirmed from the current repository snapshot alone; historical change review is required.

### LO-C4-09

- Chapter: 4
- Scope: chapter
- Text: implement selection methods for a Monetary Unit Sample, ensuring adherence to best practices and auditing standards.
- LO-009: FAIL
  Reason: No explicit workshop or review-question traceability link is present for this active LO.
- LO-011: NEEDS HUMAN REVIEW
  Reason: Identifier stability over time cannot be confirmed from the current repository snapshot alone; historical change review is required.

### LO-C4-10

- Chapter: 4
- Scope: chapter
- Text: use MUS to evaluate the sufficiency and reliability of audit evidence.
- LO-009: FAIL
  Reason: No explicit workshop or review-question traceability link is present for this active LO.
- LO-001: NEEDS HUMAN REVIEW
  Reason: The objective may combine one primary action with an integrated infinitive purpose ("use ... to evaluate"). Evidence: "use MUS to evaluate the sufficiency and reliability of audit evidence."
- LO-011: NEEDS HUMAN REVIEW
  Reason: Identifier stability over time cannot be confirmed from the current repository snapshot alone; historical change review is required.

### LO-C4-11

- Chapter: 4
- Scope: chapter
- Text: assess the role of sample size, selection methods, and assumptions in determining the validity and reliability of a hypothesis test.
- LO-009: FAIL
  Reason: No explicit workshop or review-question traceability link is present for this active LO.
- LO-011: NEEDS HUMAN REVIEW
  Reason: Identifier stability over time cannot be confirmed from the current repository snapshot alone; historical change review is required.

### LO-C4-12

- Chapter: 4
- Scope: chapter
- Text: compare the pros and cons of different selection methods in Monetary Unit Sampling, such as random sampling versus systematic selection.
- LO-009: FAIL
  Reason: No explicit workshop or review-question traceability link is present for this active LO.
- LO-011: NEEDS HUMAN REVIEW
  Reason: Identifier stability over time cannot be confirmed from the current repository snapshot alone; historical change review is required.

### LO-C4-13

- Chapter: 4
- Scope: chapter
- Text: evaluate the results of a Monetary Unit Sample to determine whether audit objectives have been met.
- LO-009: FAIL
  Reason: No explicit workshop or review-question traceability link is present for this active LO.
- LO-001: NEEDS HUMAN REVIEW
  Reason: The objective may combine one primary action with an integrated infinitive purpose ("evaluate ... to determine"). Evidence: "evaluate the results of a Monetary Unit Sample to determine whether audit objectives have been met."
- LO-011: NEEDS HUMAN REVIEW
  Reason: Identifier stability over time cannot be confirmed from the current repository snapshot alone; historical change review is required.

### LO-C4-14

- Chapter: 4
- Scope: chapter
- Text: critically appraise the robustness of a hypothesis test or MUS procedure, identifying potential limitations or areas for improvement.
- LO-009: FAIL
  Reason: No explicit workshop or review-question traceability link is present for this active LO.
- LO-011: NEEDS HUMAN REVIEW
  Reason: Identifier stability over time cannot be confirmed from the current repository snapshot alone; historical change review is required.

### LO-C4-15

- Chapter: 4
- Scope: chapter
- Text: develop a step-by-step plan for carrying out a hypothesis test tailored to a specific audit scenario.
- LO-009: FAIL
  Reason: No explicit workshop or review-question traceability link is present for this active LO.
- LO-011: NEEDS HUMAN REVIEW
  Reason: Identifier stability over time cannot be confirmed from the current repository snapshot alone; historical change review is required.

### LO-C4-16

- Chapter: 4
- Scope: chapter
- Text: design a Monetary Unit Sampling procedure, including sample selection and evaluation methods, to achieve audit objectives effectively.
- LO-009: FAIL
  Reason: No explicit workshop or review-question traceability link is present for this active LO.
- LO-011: NEEDS HUMAN REVIEW
  Reason: Identifier stability over time cannot be confirmed from the current repository snapshot alone; historical change review is required.

### LO-C5-02

- Chapter: 5
- Scope: chapter
- Text: identify the purpose of regression analysis in substantive analytical procedures and the role of expectations, residuals, and prediction uncertainty in evaluating audit evidence.
- LO-009: FAIL
  Reason: No explicit workshop or review-question traceability link is present for this active LO.
- LO-011: NEEDS HUMAN REVIEW
  Reason: Identifier stability over time cannot be confirmed from the current repository snapshot alone; historical change review is required.

### LO-C5-03

- Chapter: 5
- Scope: chapter
- Text: define the key terms used in regression analysis, including regression coefficient, standard error, residual, leverage, Cook's distance, and variance inflation factor (VIF).
- LO-009: FAIL
  Reason: No explicit workshop or review-question traceability link is present for this active LO.
- LO-011: NEEDS HUMAN REVIEW
  Reason: Identifier stability over time cannot be confirmed from the current repository snapshot alone; historical change review is required.

### LO-C5-04

- Chapter: 5
- Scope: chapter
- Text: state the assumptions of the classical linear regression model, including linearity, random sampling, sample variation in the independent variable, and zero conditional mean.
- LO-009: FAIL
  Reason: No explicit workshop or review-question traceability link is present for this active LO.
- LO-011: NEEDS HUMAN REVIEW
  Reason: Identifier stability over time cannot be confirmed from the current repository snapshot alone; historical change review is required.

### LO-C5-05

- Chapter: 5
- Scope: chapter
- Text: list the main steps in building and applying a regression-based analytical procedure, from data collection and model selection through evaluation and documentation.
- LO-009: FAIL
  Reason: No explicit workshop or review-question traceability link is present for this active LO.
- LO-011: NEEDS HUMAN REVIEW
  Reason: Identifier stability over time cannot be confirmed from the current repository snapshot alone; historical change review is required.

### LO-C5-06

- Chapter: 5
- Scope: chapter
- Text: explain when regression analysis is suitable for an audit problem, taking into account the plausibility of the underlying business relationship and the availability of relevant data.
- LO-009: FAIL
  Reason: No explicit workshop or review-question traceability link is present for this active LO.
- LO-011: NEEDS HUMAN REVIEW
  Reason: Identifier stability over time cannot be confirmed from the current repository snapshot alone; historical change review is required.

### LO-C5-07

- Chapter: 5
- Scope: chapter
- Text: explain why model assumptions, diagnostics, and data quality affect the evidential value of regression results.
- LO-009: FAIL
  Reason: No explicit workshop or review-question traceability link is present for this active LO.
- LO-011: NEEDS HUMAN REVIEW
  Reason: Identifier stability over time cannot be confirmed from the current repository snapshot alone; historical change review is required.

### LO-C5-08

- Chapter: 5
- Scope: chapter
- Text: describe how model selection criteria — including R^2, adjusted R^2, and information criteria — are used to choose among competing regression models.
- LO-009: FAIL
  Reason: No explicit workshop or review-question traceability link is present for this active LO.
- LO-011: NEEDS HUMAN REVIEW
  Reason: Identifier stability over time cannot be confirmed from the current repository snapshot alone; historical change review is required.

### LO-C5-09

- Chapter: 5
- Scope: chapter
- Text: explain how outliers and influential observations, identified through leverage and Cook's distance, can distort regression estimates and affect audit conclusions.
- LO-009: FAIL
  Reason: No explicit workshop or review-question traceability link is present for this active LO.
- LO-011: NEEDS HUMAN REVIEW
  Reason: Identifier stability over time cannot be confirmed from the current repository snapshot alone; historical change review is required.

### LO-C5-10

- Chapter: 5
- Scope: chapter
- Text: use regression output, prediction uncertainty, and materiality to assess whether recorded amounts are consistent with audit expectations.
- LO-009: FAIL
  Reason: No explicit workshop or review-question traceability link is present for this active LO.
- LO-001: NEEDS HUMAN REVIEW
  Reason: The objective may combine one primary action with an integrated infinitive purpose ("use ... to assess"). Evidence: "use regression output, prediction uncertainty, and materiality to assess whether recorded amounts are consistent with audit expectations."
- LO-011: NEEDS HUMAN REVIEW
  Reason: Identifier stability over time cannot be confirmed from the current repository snapshot alone; historical change review is required.

### LO-C5-11

- Chapter: 5
- Scope: chapter
- Text: fit a simple and multiple linear regression model to audit data and interpret the estimated coefficients, prediction intervals, and goodness-of-fit measures.
- LO-009: FAIL
  Reason: No explicit workshop or review-question traceability link is present for this active LO.
- LO-011: NEEDS HUMAN REVIEW
  Reason: Identifier stability over time cannot be confirmed from the current repository snapshot alone; historical change review is required.

### LO-C5-12

- Chapter: 5
- Scope: chapter
- Text: apply regression diagnostics, including residual plots, leverage statistics, and tests for normality, homoskedasticity, and autocorrelation, to verify that model assumptions hold.
- LO-009: FAIL
  Reason: No explicit workshop or review-question traceability link is present for this active LO.
- LO-011: NEEDS HUMAN REVIEW
  Reason: Identifier stability over time cannot be confirmed from the current repository snapshot alone; historical change review is required.

### LO-C5-13

- Chapter: 5
- Scope: chapter
- Text: interpret regression relationships and unusual observations in terms of underlying business processes, audit risk, and possible explanations.
- LO-009: FAIL
  Reason: No explicit workshop or review-question traceability link is present for this active LO.
- LO-011: NEEDS HUMAN REVIEW
  Reason: Identifier stability over time cannot be confirmed from the current repository snapshot alone; historical change review is required.

### LO-C5-14

- Chapter: 5
- Scope: chapter
- Text: examine the components of a regression model — coefficients, R^2, ANOVA decomposition, and residual plots — to assess whether the model adequately captures the underlying business relationship.
- LO-009: FAIL
  Reason: No explicit workshop or review-question traceability link is present for this active LO.
- LO-011: NEEDS HUMAN REVIEW
  Reason: Identifier stability over time cannot be confirmed from the current repository snapshot alone; historical change review is required.

### LO-C5-15

- Chapter: 5
- Scope: chapter
- Text: evaluate whether a regression model can be relied upon as audit evidence and whether further investigation, adjustment, or alternative procedures are required.
- LO-009: FAIL
  Reason: No explicit workshop or review-question traceability link is present for this active LO.
- LO-011: NEEDS HUMAN REVIEW
  Reason: Identifier stability over time cannot be confirmed from the current repository snapshot alone; historical change review is required.

### LO-C5-16

- Chapter: 5
- Scope: chapter
- Text: assess whether the evidence obtained from a regression analysis is sufficient to support an audit conclusion at the required level of assurance.
- LO-009: FAIL
  Reason: No explicit workshop or review-question traceability link is present for this active LO.
- LO-011: NEEDS HUMAN REVIEW
  Reason: Identifier stability over time cannot be confirmed from the current repository snapshot alone; historical change review is required.

### LO-C5-17

- Chapter: 5
- Scope: chapter
- Text: design a regression-based analytical procedure for a specific audit objective, specifying the dependent and independent variables, data requirements, estimation period, precision threshold, and decision rule.
- LO-009: FAIL
  Reason: No explicit workshop or review-question traceability link is present for this active LO.
- LO-011: NEEDS HUMAN REVIEW
  Reason: Identifier stability over time cannot be confirmed from the current repository snapshot alone; historical change review is required.

### LO-C5-18

- Chapter: 5
- Scope: chapter
- Text: communicate the results, limitations, and audit implications of a regression analysis in a manner appropriate for audit documentation and professional discussion.
- LO-009: FAIL
  Reason: No explicit workshop or review-question traceability link is present for this active LO.
- LO-011: NEEDS HUMAN REVIEW
  Reason: Identifier stability over time cannot be confirmed from the current repository snapshot alone; historical change review is required.

### LO-C6-03

- Chapter: 6
- Scope: chapter
- Text: define goodness of fit and explain its purpose in statistical analysis.
- LO-001: FAIL
  Reason: Multiple observable actions appear in one objective: "define" and "explain". Evidence: "define goodness of fit and explain its purpose in statistical analysis."
- LO-009: FAIL
  Reason: No explicit workshop or review-question traceability link is present for this active LO.
- LO-012: FAIL
  Reason: The sentence structure is not form-consistent because it contains multiple primary actions. Evidence: "define goodness of fit and explain its purpose in statistical analysis."
- LO-011: NEEDS HUMAN REVIEW
  Reason: Identifier stability over time cannot be confirmed from the current repository snapshot alone; historical change review is required.

### LO-C6-04

- Chapter: 6
- Scope: chapter
- Text: identify the null and alternative hypotheses used in goodness-of-fit testing.
- LO-009: FAIL
  Reason: No explicit workshop or review-question traceability link is present for this active LO.
- LO-011: NEEDS HUMAN REVIEW
  Reason: Identifier stability over time cannot be confirmed from the current repository snapshot alone; historical change review is required.

### LO-C6-05

- Chapter: 6
- Scope: chapter
- Text: state the main characteristics and expected digit frequencies of Benford's Law.
- LO-009: FAIL
  Reason: No explicit workshop or review-question traceability link is present for this active LO.
- LO-011: NEEDS HUMAN REVIEW
  Reason: Identifier stability over time cannot be confirmed from the current repository snapshot alone; historical change review is required.

### LO-C6-06

- Chapter: 6
- Scope: chapter
- Text: recall the assumptions and conditions required for the application of goodness-of-fit tests.
- LO-009: FAIL
  Reason: No explicit workshop or review-question traceability link is present for this active LO.
- LO-011: NEEDS HUMAN REVIEW
  Reason: Identifier stability over time cannot be confirmed from the current repository snapshot alone; historical change review is required.

### LO-C6-07

- Chapter: 6
- Scope: chapter
- Text: explain how goodness-of-fit tests compare observed frequencies with expected frequencies.
- LO-009: FAIL
  Reason: No explicit workshop or review-question traceability link is present for this active LO.
- LO-011: NEEDS HUMAN REVIEW
  Reason: Identifier stability over time cannot be confirmed from the current repository snapshot alone; historical change review is required.

### LO-C6-08

- Chapter: 6
- Scope: chapter
- Text: describe the rationale behind Benford's Law and why it applies to many naturally occurring datasets.
- LO-009: FAIL
  Reason: No explicit workshop or review-question traceability link is present for this active LO.
- LO-011: NEEDS HUMAN REVIEW
  Reason: Identifier stability over time cannot be confirmed from the current repository snapshot alone; historical change review is required.

### LO-C6-09

- Chapter: 6
- Scope: chapter
- Text: explain the relationship between test statistics, degrees of freedom, and statistical significance.
- LO-009: FAIL
  Reason: No explicit workshop or review-question traceability link is present for this active LO.
- LO-011: NEEDS HUMAN REVIEW
  Reason: Identifier stability over time cannot be confirmed from the current repository snapshot alone; historical change review is required.

### LO-C6-10

- Chapter: 6
- Scope: chapter
- Text: understand the strengths and limitations of Benford's Law as a tool for fraud detection.
- LO-002: FAIL
  Reason: The learning object is vague or underspecified. Evidence: "understand the strengths and limitations of Benford's Law as a tool for fraud detection."
- LO-009: FAIL
  Reason: No explicit workshop or review-question traceability link is present for this active LO.
- LO-011: NEEDS HUMAN REVIEW
  Reason: Identifier stability over time cannot be confirmed from the current repository snapshot alone; historical change review is required.

### LO-C6-11

- Chapter: 6
- Scope: chapter
- Text: construct observed and expected frequency tables for goodness-of-fit analyses.
- LO-009: FAIL
  Reason: No explicit workshop or review-question traceability link is present for this active LO.
- LO-011: NEEDS HUMAN REVIEW
  Reason: Identifier stability over time cannot be confirmed from the current repository snapshot alone; historical change review is required.

### LO-C6-12

- Chapter: 6
- Scope: chapter
- Text: perform a chi-square goodness-of-fit test using statistical software.
- LO-009: FAIL
  Reason: No explicit workshop or review-question traceability link is present for this active LO.
- LO-011: NEEDS HUMAN REVIEW
  Reason: Identifier stability over time cannot be confirmed from the current repository snapshot alone; historical change review is required.

### LO-C6-13

- Chapter: 6
- Scope: chapter
- Text: apply Benford's Law to a dataset and compare observed digit frequencies with expected frequencies.
- LO-009: FAIL
  Reason: No explicit workshop or review-question traceability link is present for this active LO.
- LO-011: NEEDS HUMAN REVIEW
  Reason: Identifier stability over time cannot be confirmed from the current repository snapshot alone; historical change review is required.

### LO-C6-14

- Chapter: 6
- Scope: chapter
- Text: interpret p-values and test results in the context of auditing and data analysis.
- LO-009: FAIL
  Reason: No explicit workshop or review-question traceability link is present for this active LO.
- LO-011: NEEDS HUMAN REVIEW
  Reason: Identifier stability over time cannot be confirmed from the current repository snapshot alone; historical change review is required.

### LO-C6-15

- Chapter: 6
- Scope: chapter
- Text: investigate discrepancies between observed and expected frequencies.
- LO-009: FAIL
  Reason: No explicit workshop or review-question traceability link is present for this active LO.
- LO-011: NEEDS HUMAN REVIEW
  Reason: Identifier stability over time cannot be confirmed from the current repository snapshot alone; historical change review is required.

### LO-C6-16

- Chapter: 6
- Scope: chapter
- Text: determine which categories or digits contribute most to a lack of fit.
- LO-009: FAIL
  Reason: No explicit workshop or review-question traceability link is present for this active LO.
- LO-011: NEEDS HUMAN REVIEW
  Reason: Identifier stability over time cannot be confirmed from the current repository snapshot alone; historical change review is required.

### LO-C6-17

- Chapter: 6
- Scope: chapter
- Text: assess whether deviations from Benford's Law are likely due to natural variation or require further investigation.
- LO-009: FAIL
  Reason: No explicit workshop or review-question traceability link is present for this active LO.
- LO-011: NEEDS HUMAN REVIEW
  Reason: Identifier stability over time cannot be confirmed from the current repository snapshot alone; historical change review is required.

### LO-C6-18

- Chapter: 6
- Scope: chapter
- Text: evaluate the appropriateness of a goodness-of-fit model for a particular dataset.
- LO-009: FAIL
  Reason: No explicit workshop or review-question traceability link is present for this active LO.
- LO-011: NEEDS HUMAN REVIEW
  Reason: Identifier stability over time cannot be confirmed from the current repository snapshot alone; historical change review is required.

### LO-C6-19

- Chapter: 6
- Scope: chapter
- Text: judge whether the assumptions underlying a goodness-of-fit test have been satisfied.
- LO-009: FAIL
  Reason: No explicit workshop or review-question traceability link is present for this active LO.
- LO-011: NEEDS HUMAN REVIEW
  Reason: Identifier stability over time cannot be confirmed from the current repository snapshot alone; historical change review is required.

### LO-C6-20

- Chapter: 6
- Scope: chapter
- Text: assess the evidential value of Benford analysis in an audit or fraud examination.
- LO-009: FAIL
  Reason: No explicit workshop or review-question traceability link is present for this active LO.
- LO-011: NEEDS HUMAN REVIEW
  Reason: Identifier stability over time cannot be confirmed from the current repository snapshot alone; historical change review is required.

### LO-C6-21

- Chapter: 6
- Scope: chapter
- Text: design a goodness-of-fit analysis to assess whether observed data follow a specified distribution.
- LO-009: FAIL
  Reason: No explicit workshop or review-question traceability link is present for this active LO.
- LO-001: NEEDS HUMAN REVIEW
  Reason: The objective may combine one primary action with an integrated infinitive purpose ("design ... to assess"). Evidence: "design a goodness-of-fit analysis to assess whether observed data follow a specified distribution."
- LO-011: NEEDS HUMAN REVIEW
  Reason: Identifier stability over time cannot be confirmed from the current repository snapshot alone; historical change review is required.

### LO-C6-22

- Chapter: 6
- Scope: chapter
- Text: develop a Benford's Law testing procedure for use in an audit or forensic investigation.
- LO-009: FAIL
  Reason: No explicit workshop or review-question traceability link is present for this active LO.
- LO-011: NEEDS HUMAN REVIEW
  Reason: Identifier stability over time cannot be confirmed from the current repository snapshot alone; historical change review is required.

### LO-C6-23

- Chapter: 6
- Scope: chapter
- Text: formulate recommendations for additional audit procedures based on the results of a goodness-of-fit analysis.
- LO-009: FAIL
  Reason: No explicit workshop or review-question traceability link is present for this active LO.
- LO-011: NEEDS HUMAN REVIEW
  Reason: Identifier stability over time cannot be confirmed from the current repository snapshot alone; historical change review is required.

## Audit Discipline Check

- No learning objective text was rewritten.
- No Bloom classifications were modified.
- No competency classifications were modified.
- No traceability mappings were modified.
- Audit outputs were generated on a dedicated feature branch and worktree.
