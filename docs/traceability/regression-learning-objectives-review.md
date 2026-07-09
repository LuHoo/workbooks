# Regression Learning Objectives Review

Date: 2026-07-09
Branch: `91-rewrite-regression-chapter-learning-objectives-around-audit-judgement`

## Purpose

This document reviews the current learning objectives for the Regression Analysis chapter and proposes a reduced, judgement-oriented replacement set.

The aim is to align the objectives with the chapter's educational purpose: preparing auditors to evaluate regression analysis as audit evidence, rather than merely perform regression calculations.

This is a review draft only. It does not yet replace the student-facing objectives in `chap07.tex`.

## Current Structure Extracted From The Chapter

The current chapter distributes learning objectives across nine section-level blocks in `chap07.tex`:

| Section | Current emphasis | Current pattern |
|---|---|---|
| 5.1 What is regression analysis | definitions, purposes, EDA vs CDA, simple exploration | concept-heavy and method-introductory |
| 5.2 Assumptions underlying regression results | assumptions, violations, checklists, remedies | technically important, partly audit-relevant |
| 5.3 Obtaining and testing data | data wrangling, plotting, hold-out sets, variable testing | procedural and workflow-oriented |
| 5.4 Modeling | transformations, interactions, stepwise methods, model design | strongly technique-driven |
| 5.5 Diagnostics checking | outliers, influential observations, handling responses | highly aligned with audit judgement |
| 5.6 Analysis of variance | partitioning variation, $F$ testing, model quality | supportive statistical inference |
| 5.7 Testing model assumptions | normality, homoskedasticity, autocorrelation, corrective action | model-reliability focused |
| 5.8 Testing significance | coefficient testing, practical significance, multicollinearity | statistical significance interpretation |
| 5.9 Expectations | intervals, assurance, predictions, materiality | directly tied to audit evidence and conclusion |

## Current Learning Objectives By Section

The present structure is detailed and section-driven. In practice, many objectives correspond to individual statistical procedures rather than broader professional capabilities.

### 5.1 What is regression analysis

- Define regression analysis and its components.
- Distinguish exploratory and confirmatory analysis.
- Use simple regression and plots to explore a relationship.
- Justify simple regression as a starting point.

### 5.2 Assumptions underlying regression results

- List and define core regression assumptions.
- Explain why they matter.
- Identify assumption violations and possible remedies.
- Develop a checklist for checking assumptions.

### 5.3 Obtaining and testing data

- Summarize, wrangle, and visualize data.
- Test variable relevance and independence.
- Split data into estimation and hold-out sets.
- Design a data-preparation workflow.

### 5.4 Modeling

- Define linear regression model components.
- Explain transformations and interactions.
- Perform stepwise procedures.
- Compare alternative model forms.

### 5.5 Diagnostics checking

- Identify outliers and influential observations.
- Distinguish different types of unusual observations.
- Assess their impact on validity.
- Recommend appropriate responses.

### 5.6 Analysis of variance

- State the purpose of ANOVA in regression.
- Explain explained versus residual variation.
- Calculate and interpret $F$ statistics.
- Compare ANOVA across model contexts.

### 5.7 Testing model assumptions

- Identify inference assumptions.
- Perform normality, heteroskedasticity, and autocorrelation checks.
- Interpret plots and tests.
- Recommend corrective action.

### 5.8 Testing significance

- State coefficient and model hypotheses.
- Explain links between $t$ and $F$ testing.
- Conduct significance tests.
- Assess practical significance and multicollinearity implications.

### 5.9 Expectations

- Distinguish confidence and prediction intervals.
- Construct expectations and assurance measures.
- Compare observed and expected values.
- Interpret reliability of conclusions for audit use.

## Diagnostic Review Of The Current Set

The current set has three main strengths:

- it is comprehensive;
- it mirrors the internal structure of the chapter;
- it gives explicit attention to diagnostics, assumptions, and expectation uncertainty.

It also has three main weaknesses:

- it is too granular for chapter-level educational messaging;
- it often frames procedural skills as ends in themselves;
- it does not foreground the audit judgement question strongly enough.

In particular, objectives such as performing stepwise regression, calculating $F$ statistics, or splitting data into hold-out sets are better treated as supporting skills than as the central capabilities students should retain.

## Proposed Reduced Core Chapter-Level Objectives

The revised chapter-level objective set should be smaller, broader, and framed around professional judgement.

### Proposed objective 1: Model appropriateness

Determine whether regression analysis is suitable for a given audit problem, taking into account the nature of the account, the plausibility of the business relationship, and the available data.

Suggested Bloom level: `evaluate`

### Proposed objective 2: Model reliability

Evaluate whether a regression model can be relied upon as audit evidence by assessing assumptions, diagnostics, model specification, and important limitations.

Suggested Bloom level: `evaluate`

### Proposed objective 3: Interpretation of relationships

Interpret regression output in terms of underlying business relationships and audit relevance, rather than relying on statistical measures alone.

Suggested Bloom level: `analyze`

### Proposed objective 4: Investigation of anomalies

Identify unusual or influential observations and determine whether they require investigation, adjustment, explanation, or rejection of the model for audit use.

Suggested Bloom level: `evaluate`

### Proposed objective 5: Expectation and uncertainty

Use regression-based expectations, prediction uncertainty, and materiality to assess whether recorded values are consistent with audit expectations.

Suggested Bloom level: `apply`

### Proposed objective 6: Audit conclusion

Assess whether the evidence obtained from a regression analysis is sufficient to support an audit conclusion at the required level of assurance.

Suggested Bloom level: `evaluate`

### Proposed objective 7: Communication

Communicate the results, limitations, and implications of a regression analysis in a manner appropriate for audit documentation and professional discussion.

Suggested Bloom level: `create`

## Side-By-Side Comparison

| Current emphasis | Proposed capability | Bloom | Recommendation |
|---|---|---|---|
| Definitions of regression, EDA/CDA, model components | Model appropriateness | evaluate | merge and reframe |
| Assumptions and their violations | Model reliability | evaluate | retain, but elevate from technical checklist to evidence judgement |
| Data wrangling, variable testing, hold-out sets | Model appropriateness / Model reliability | evaluate | retain as supporting skill, not primary LO |
| Transformations, interactions, stepwise modeling | Model reliability / Interpretation of relationships | analyze / evaluate | retain selectively as supporting technique |
| Outliers and influential observations | Investigation of anomalies | evaluate | retain strongly |
| ANOVA and model fit statistics | Interpretation of relationships / Model reliability | analyze / evaluate | merge into broader evaluation capability |
| Normality, heteroskedasticity, autocorrelation | Model reliability | evaluate | retain strongly |
| Coefficient and model significance | Interpretation of relationships / Model reliability | analyze / evaluate | reframe away from test mechanics |
| Expectations, intervals, assurance, materiality | Expectation and uncertainty / Audit conclusion | apply / evaluate | retain strongly |
| Reporting implications | Communication | create | strengthen explicitly |

## Supporting Procedural Skills

These remain important, but should be treated as supporting skills rather than headline chapter objectives:

- generate summary statistics and plots;
- split estimation and hold-out samples;
- perform transformations and include interactions;
- compute and interpret $t$ tests and $F$ tests;
- run diagnostic tests for normality, heteroskedasticity, and autocorrelation;
- calculate confidence intervals, prediction intervals, and assurance measures.

These are still taught in the chapter, but they support the broader audit-evidence judgement capabilities above.

## Section-Level Disposition Review

| Section | Suggested disposition | Rationale |
|---|---|---|
| 5.1 What is regression analysis | merge | concepts should support model appropriateness and interpretation |
| 5.2 Assumptions underlying regression results | retain and reframe | central to audit reliance |
| 5.3 Obtaining and testing data | merge | workflow support, not end goal |
| 5.4 Modeling | reframe | techniques matter only insofar as they improve audit evidence |
| 5.5 Diagnostics checking | retain strongly | directly tied to auditor investigation and judgement |
| 5.6 Analysis of variance | merge | statistical support rather than primary professional capability |
| 5.7 Testing model assumptions | retain strongly | central to model reliability |
| 5.8 Testing significance | reframe | significance is evidence input, not educational endpoint |
| 5.9 Expectations | retain strongly | directly tied to audit conclusion and assurance |

## Recommended Student-Facing Direction

If the chapter text is revised later, the visible learning objectives should likely be presented as a single chapter-level set of six or seven professional capabilities, rather than a long list distributed across section-level statistical mechanics.

The main message to the student should be:

- not “I can run regression procedures,” but
- “I can judge whether regression analysis provides reliable audit evidence.”

## Proposed Next Step

If approved, the next step is to rewrite the student-facing Regression Analysis learning objectives in `chap07.tex` using the proposed reduced set, and then decide which section-level objective blocks should be removed, condensed, or retained in shortened form.