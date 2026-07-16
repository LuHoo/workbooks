---
title: Volume 1 Transformation Blueprint
authors:
  - Lucas Hoogduin
  - Paul Touw
status: Draft
version: 2.0
created: 2026-07-16
related_documents:
  - competency-model.md
  - volume1-curriculum-map.md
---

# Volume 1 Transformation Blueprint

## Audit Data Analysis – Volume 1

### Strategic Redesign Proposal

---

# Executive Summary

Volume 1 is already a strong statistics-for-auditors textbook.

However, the revised Competency Model suggests a transition from:

> Teaching statistical methods

towards:

> Teaching auditors how to evaluate statistical evidence and determine which conclusions are supported by that evidence.

The statistical content of Volume 1 remains largely unchanged.

The transformation primarily affects:

- learning objectives;
- chapter architecture;
- exercises;
- concept questions;
- audit questions;
- workshop design;
- case conclusions;
- narrative flow.

The central design principle is:

> Every chapter should explicitly develop Technical Skills, Statistical Reasoning, and Professional Judgment.

A second principle emerged from the Chapter 5 pilot redesign:

> Professional Judgment in Volume 1 focuses on evidence evaluation rather than audit response.

Students should learn how to evaluate evidence.

They are not yet expected to determine the full audit response to that evidence.

That progression is reserved for Volume 2.

---

# Educational Objective of Volume 1

The purpose of Volume 1 is to develop students who can:

1. Perform statistical analyses.
2. Understand and justify statistical methods.
3. Evaluate statistical evidence.
4. Determine what conclusions are supported by that evidence.

The book should therefore follow a progression from:

```text
Calculation
        ↓
Interpretation
        ↓
Evidence Evaluation
        ↓
Supported Conclusion
```

rather than ending with the statistical result itself.

---

# The Volume 1 Competency Model

## Technical Skills

Students learn how to perform analyses.

Guiding question:

> How do I perform the analysis?

Examples:

- calculating probabilities;
- constructing confidence intervals;
- fitting regression models;
- executing statistical procedures in software.

---

## Statistical Reasoning

Students learn how to understand and justify analyses.

Guiding question:

> Why is this method appropriate?

Examples:

- selecting methods;
- evaluating assumptions;
- interpreting results;
- assessing limitations.

---

## Professional Judgment

Students learn how to evaluate evidence.

Guiding question:

> What conclusions are supported by the available evidence?

Examples:

- evaluating uncertainty;
- identifying supported conclusions;
- identifying unsupported conclusions;
- assessing the strength of evidence;
- avoiding overinterpretation.

Professional Judgment in Volume 1 is therefore evidence-focused rather than action-focused.

---

# Assessment Philosophy

The three competencies should not be assessed through identical educational mechanisms.

Different competencies require different forms of learning.

| Competency | Primary Learning Mechanism |
|------------|----------------------------|
| Technical Skills | Exercises |
| Statistical Reasoning | Exercises and Concept Questions |
| Professional Judgment | Audit Questions and Cases |

Not every learning objective should appear in every educational format.

The educational mechanism should match the nature of the competency being developed.

---

# Proposed Chapter Architecture

Every substantive chapter should follow a common structure:

```text
Audit Problem
        ↓
Statistical Method
        ↓
Technical Execution
        ↓
Statistical Interpretation
        ↓
Evidence Evaluation
        ↓
Supported Conclusion
```

Students should never leave a chapter at the statistical output.

Every chapter should explicitly address:

> What conclusions are supported by the available evidence?

and

> What uncertainty remains?

---

# Chapter-by-Chapter Transformation

---

# Chapter 1

## Probability Distributions

### Current Position

Primarily technical.

Students learn:

- hypergeometric distribution;
- binomial distribution;
- Poisson distribution;
- normal distribution;
- t distribution;
- χ² distribution;
- F distribution.

---

## Desired Position

### Technical Skills

Students can:

- calculate probabilities;
- use distribution functions in R and Python;
- perform distribution approximations.

### Statistical Reasoning

Students can:

- determine which distribution applies;
- justify approximations;
- explain assumptions underlying probability models.

### Professional Judgment

Students can:

- assess whether observed outcomes appear unusual;
- evaluate uncertainty associated with sample results;
- explain the implications of probabilistic evidence.

---

## Suggested End-of-Chapter Activities

### Exercises

Examples:

- Calculate P(k = 0).
- Calculate confidence limits.
- Evaluate approximation conditions.

### Concept Questions

Examples:

- Why is the hypergeometric distribution more appropriate than the binomial distribution?
- Under what conditions is a normal approximation appropriate?
- Which assumptions underlie the selected probability model?

### Audit Questions

Examples:

- Does the observed result appear unusual?
- How much uncertainty remains?
- What conclusions are supported by the available evidence?

---

# Chapter 2

## Estimation

### Current Position

Strongly focused on estimation methodology.

Topics include:

- confidence intervals;
- sample-size determination;
- proportion estimation;
- finite-population corrections.

---

## Desired Position

### Technical Skills

Students can:

- calculate estimates;
- construct confidence intervals;
- calculate sample sizes.

### Statistical Reasoning

Students can:

- explain the relationship between precision and confidence;
- assess estimation assumptions;
- select appropriate estimation approaches.

### Professional Judgment

Students can:

- determine whether evidence is persuasive;
- assess residual uncertainty;
- determine which conclusions are supported by the estimate.

---

## New Discussion Theme

Every estimate should explicitly raise the questions:

- What does the estimate tell us?
- What does the estimate not tell us?
- What uncertainty remains?
- Which conclusions are justified?

---

# Chapter 3

## Auxiliary Variables and Stratification

### Current Position

Primarily quantitative.

Topics include:

- MPU estimation;
- ratio estimation;
- difference estimation;
- regression estimation;
- stratification.

---

## Desired Position

### Technical Skills

Students can:

- perform alternative estimation methods;
- stratify populations;
- allocate samples.

### Statistical Reasoning

Students can:

- select estimators;
- compare estimator performance;
- evaluate stratification strategies.

### Professional Judgment

Students can:

- evaluate the strength of evidence generated by alternative estimators;
- assess whether achieved precision is sufficient;
- determine which conclusions are supported.

---

## New Recurring Feature

### Evaluating the Evidence

Example:

> Does the additional precision obtained through regression estimation materially strengthen the conclusions supported by the evidence?

---

# Chapter 4

## Hypothesis Testing and Audit Sampling

### Current Position

Already strongly connected to audit applications.

Topics include:

- acceptance and rejection;
- attribute sampling;
- MUS;
- interpretation of results.

---

## Desired Position

### Technical Skills

Students can:

- determine sample sizes;
- evaluate samples;
- calculate confidence bounds.

### Statistical Reasoning

Students can:

- explain Type I and Type II risk;
- interpret operating characteristic curves;
- justify decision thresholds.

### Professional Judgment

Students can:

- evaluate sampling evidence;
- assess sampling uncertainty;
- determine which conclusions are supported by the sample results.

---

## Recommendation

This chapter should become the benchmark for connecting statistical methods to evidence evaluation.

---

# Chapter 5

## Regression Analysis

### Current Position

Technically sophisticated and highly relevant to auditing.

---

## Desired Position

### Technical Skills

Students can:

- build regression models;
- perform diagnostics;
- generate predictions;
- evaluate assumptions.

### Statistical Reasoning

Students can:

- assess model validity;
- compare competing models;
- distinguish significance from relevance.

### Professional Judgment

Students can:

- determine whether the model provides persuasive evidence;
- assess limitations of the model;
- determine which conclusions are justified;
- evaluate residual uncertainty.

---

## Critical Addition

Introduce a recurring question:

> What conclusions are supported by the model, and what conclusions remain uncertain?

This shifts attention from model construction to evidence evaluation.

---

# Chapter 6

## Goodness-of-Fit and Benford's Law

### Current Position

Focused on:

- χ² testing;
- Benford's Law;
- anomaly detection.

---

## Desired Position

### Technical Skills

Students can:

- perform goodness-of-fit testing;
- conduct Benford analyses.

### Statistical Reasoning

Students can:

- evaluate expected distributions;
- assess assumptions;
- interpret deviations.

### Professional Judgment

Students can:

- distinguish anomalies from conclusions;
- evaluate the strength of anomaly evidence;
- determine which conclusions are justified.

---

## Important Message

Students should repeatedly encounter the statement:

> Benford deviations are not conclusions.
>
> They are evidence that requires evaluation.

---

# Educational Components

## Exercises

Primary Competency:

**Technical Skills**

Purpose:

> Can the student perform the analysis?

Examples:

- calculations;
- software implementation;
- statistical procedures.

---

## Concept Questions

Primary Competency:

**Statistical Reasoning**

Purpose:

> Can the student explain and justify the analysis?

Examples:

- assumptions;
- interpretation;
- method selection;
- comparison of alternatives.

---

## Audit Questions

Primary Competency:

**Professional Judgment**

Purpose:

> Can the student evaluate the evidence and determine what conclusions are supported?

Examples:

- assessment of evidence;
- evaluation of uncertainty;
- supported conclusions;
- unsupported conclusions;
- limitations of evidence.

---

# Workshop Transformation

Current workshop structure:

```text
Theory
    ↓
Code
    ↓
Output
```

Future workshop structure:

```text
Theory
    ↓
Execution
    ↓
Interpretation
    ↓
Evidence Evaluation
```

where:

- Execution develops Technical Skills;
- Interpretation develops Statistical Reasoning;
- Evidence Evaluation develops Professional Judgment.

---

# Standard Workshop Structure

## Part A – Execute

Purpose:

Develop Technical Skills.

Examples:

- run analyses;
- calculate values;
- reproduce results.

---

## Part B – Interpret

Purpose:

Develop Statistical Reasoning.

Questions:

- What does the output mean?
- Which assumptions matter?
- Are those assumptions reasonable?
- What limitations exist?

---

## Part C – Evaluate Evidence

Purpose:

Develop Professional Judgment.

Questions:

- What evidence has been obtained?
- How persuasive is the evidence?
- What uncertainty remains?
- Which conclusions are supported?
- Which conclusions are not supported?

---

# Learning Objectives Blueprint

The redesign does not replace Bloom's Taxonomy.

Instead:

```text
Bloom Taxonomy
        ×
Competency Model
```

Every chapter should contain objectives across all three competency levels.

| Competency | Dominant Bloom Levels |
|------------|-----------------------|
| Technical Skills | Remember, Apply |
| Statistical Reasoning | Understand, Analyze |
| Professional Judgment | Evaluate, Create |

---

# Changes to Cases

Many current cases conclude with:

- a point estimate;
- a confidence interval;
- a test result;
- a p-value.

Future cases should conclude with:

### Evidence Evaluation

What evidence was obtained?

### Remaining Uncertainty

What remains unknown?

### Supported Conclusions

What conclusions are justified?

### Unsupported Conclusions

What conclusions cannot yet be justified?

---

# Changes to Front Matter

Introduce the competency model:

```text
Professional Judgment
        ↑
Statistical Reasoning
        ↑
Technical Skills
```

Explain that:

- software increasingly performs calculations;
- auditors remain responsible for evaluating evidence;
- evidence must be interpreted before conclusions can be drawn;
- statistically informed professional judgment requires all three competencies.

---

# Proposed Tagging System

Introduce competency indicators throughout the text.

### TS

Technical Skills

### SR

Statistical Reasoning

### PJ

Professional Judgment

These tags help students and instructors identify the primary competency being developed.

---

# Definition of Success

A student who completes Volume 1 should be able to:

## Technical Skills

Perform modern statistical analyses.

## Statistical Reasoning

Select, explain, justify, and interpret statistical methods.

## Professional Judgment

Evaluate statistical evidence and determine which conclusions are supported by that evidence.

---

# Implementation Roadmap

## Phase 1 – Curriculum Design

- Competency Model
- Volume 1 Curriculum Map
- Volume 1 Transformation Blueprint

## Phase 2 – Pilot Implementation

- Chapter 5 redesign
- Chapter 4 redesign
- Validation of competency architecture

## Phase 3 – Volume-Wide Rollout

- Chapter 1 implementation
- Chapter 2 implementation
- Chapter 3 implementation
- Chapter 4 implementation
- Chapter 5 implementation
- Chapter 6 implementation

## Phase 4 – External Positioning

- University positioning document
- Bachelor curriculum mapping
- Post-master curriculum mapping

---

# Final Positioning Statement

> Volume 1 develops auditors who can perform statistical analyses, understand their implications, evaluate the resulting evidence, and determine which conclusions are supported by that evidence.
>
> The objective is not merely to teach statistical methods.
>
> The objective is to develop statistically informed evidence evaluation.- assess
- justify

Central question:

> Why is this method appropriate?

---

## Level 3: Professional Judgment

Students learn how to use evidence.

Typical verbs:

- evaluate
- conclude
- determine
- defend
- recommend
- communicate

Central question:

> What should the auditor conclude?

---

# Assessment Philosophy

The three competency levels should not be assessed through identical educational mechanisms.

Different competencies require different forms of learning.

| Competency | Primary Learning Mechanism |
|------------|----------------------------|
| Technical Skills | Exercises |
| Statistical Reasoning | Exercises and Concept Questions |
| Professional Judgment | Audit Questions and Case Discussions |

Accordingly, not every learning objective should be represented by both an exercise and a question.

The educational mechanism should match the nature of the competency being developed.

---

# Proposed Chapter Architecture

Each substantive chapter should follow the same intellectual pathway:

```text
Audit Problem
        ↓
Statistical Method
        ↓
Technical Execution
        ↓
Statistical Interpretation
        ↓
Audit Evaluation
        ↓
Professional Judgment
```

Students should never leave a chapter at the statistical output.

The chapter should always end with the question:

> What does this imply for the audit?

---

# Chapter-by-Chapter Transformation

---

# Chapter 1

## Probability Distributions

### Current Position

Primarily technical.

Students learn:

- hypergeometric distributions;
- binomial distributions;
- Poisson distributions;
- normal distributions;
- t distributions;
- χ² distributions;
- F distributions.

---

## Desired Position

### Technical Skills

Students can:

- calculate probabilities;
- use distribution functions in R and Python;
- perform distribution approximations.

---

### Statistical Reasoning

Students can:

- determine which distribution applies;
- justify approximations;
- explain the assumptions behind sampling models.

---

### Professional Judgment

Students can:

- determine whether observed sample results are unusual;
- assess whether observed deviations warrant further audit attention;
- explain uncertainty to a non-statistical audience.

---

## Suggested End-of-Chapter Activities

### Exercises (Technical Skills)

Demonstrate your ability to perform the analysis.

Examples:

- Calculate P(k = 0).
- Calculate confidence limits.
- Determine whether approximation conditions are satisfied.

---

### Concept Questions (Statistical Reasoning)

Demonstrate your understanding of the analysis.

Examples:

- Why is the hypergeometric distribution more appropriate than the binomial distribution in this situation?
- Under what conditions would a normal approximation be justified?
- Why might a normal approximation be inappropriate?
- Which assumptions underlie the selected probability model?

---

### Audit Questions (Professional Judgment)

Demonstrate your ability to use statistical evidence in an audit context.

Example scenario:

A sample reveals four deviations.

Questions:

- Does this indicate a potential control issue?
- What additional information would you require before reaching a conclusion?
- Would additional audit procedures be appropriate?
- How would you communicate these findings to the engagement partner?

---

# Chapter 2

## Estimation

### Current Position

Strongly focused on methodology.

Topics include:

- confidence intervals;
- sample size calculations;
- proportion estimation;
- finite-population corrections.

---

## Desired Position

### Technical Skills

Students can:

- calculate estimates and confidence intervals;
- determine sample sizes;
- calculate correction factors.

---

### Statistical Reasoning

Students can:

- explain the relationship between confidence and precision;
- determine whether assumptions are satisfied;
- select appropriate estimation approaches.

---

### Professional Judgment

Students can:

- determine whether evidence is sufficiently persuasive;
- assess residual uncertainty;
- determine whether further testing is needed.

---

## New Professional Discussion

Every estimate should conclude with explicit discussion of:

- What uncertainty remains?
- Is that uncertainty acceptable?
- What audit risk remains?
- Is additional work required?

---

# Chapter 3

## Auxiliary Variables and Stratification

### Current Position

Heavily quantitative.

Topics include:

- MPU estimation;
- regression estimation;
- difference estimation;
- ratio estimation;
- stratification.

---

## Desired Position

### Technical Skills

Students can:

- perform alternative estimation techniques;
- stratify populations;
- allocate samples.

---

### Statistical Reasoning

Students can:

- select an estimator;
- explain estimator trade-offs;
- assess whether stratification is beneficial.

---

### Professional Judgment

Students can:

- defend estimator choices;
- justify audit decisions using estimation outcomes;
- evaluate whether achieved precision is sufficient.

---

## Major Opportunity

Introduce a recurring feature:

### Auditor's Decision

Example:

> Why would an auditor prefer regression estimation despite its additional complexity?

This feature creates a direct bridge between methodology and audit practice.

---

# Chapter 4

## Hypothesis Testing and Sampling

### Current Position

Already closely aligned with the proposed framework.

Topics include:

- audit decisions;
- acceptance and rejection;
- attribute sampling;
- MUS;
- interpretation of results.

---

## Desired Position

### Technical Skills

Students can:

- determine sample sizes;
- evaluate samples;
- calculate statistical bounds.

---

### Statistical Reasoning

Students can:

- explain Type I and Type II risks;
- interpret operating characteristic curves;
- justify decision thresholds.

---

### Professional Judgment

Students can:

- determine whether sufficient audit evidence exists;
- assess whether additional procedures are warranted;
- defend sampling conclusions.

---

## Recommendation

This chapter should become the benchmark for the remainder of the book.

Its audit-oriented reasoning should serve as the model for later chapters.

---

# Chapter 5

## Regression Analysis

### Current Position

Technically excellent.

Potentially the chapter most affected by the redesign.

---

### Technical Skills

Students can:

- build regression models;
- perform diagnostics;
- calculate predictions;
- test assumptions.

---

### Statistical Reasoning

Students can:

- determine whether assumptions hold;
- evaluate model validity;
- distinguish significance from relevance.

---

### Professional Judgment

Students can:

- assess whether a model provides persuasive audit evidence;
- determine whether analytical procedures are reliable;
- assess whether resulting assurance is sufficient.

---

## Critical Addition

Introduce a recurring question:

> If this model were challenged during inspection, could you defend its use?

This single question links statistical validity to professional accountability.

---

# Chapter 6

## Goodness-of-Fit and Benford's Law

### Current Position

Focuses on:

- χ² analysis;
- Benford's Law;
- anomaly detection.

---

## Desired Position

### Technical Skills

Students can:

- perform goodness-of-fit tests;
- perform Benford analyses.

---

### Statistical Reasoning

Students can:

- evaluate expected distributions;
- assess assumptions;
- interpret deviations appropriately.

---

### Professional Judgment

Students can:

- distinguish anomaly detection from evidence of fraud;
- determine appropriate follow-up procedures;
- avoid overinterpreting statistical findings.

---

## Important Message

Students should repeatedly encounter the message:

> Benford deviations are not conclusions.
>
> They are audit leads.

---

# Workshops Transformation

Current workshop structure:

```text
Theory
    ↓
Code
    ↓
Output
```

Future workshop structure:

```text
Theory
    ↓
Execution
    ↓
Interpretation
    ↓
Audit Evaluation
```

where:

- Execution primarily develops Technical Skills;
- Interpretation primarily develops Statistical Reasoning;
- Audit Evaluation primarily develops Professional Judgment.

---

# Standard Workshop Template

## Part A – Execute

Purpose:

Develop Technical Skills.

Examples:

- run analyses;
- calculate values;
- reproduce results.

---

## Part B – Interpret

Purpose:

Develop Statistical Reasoning.

Questions:

- What does the output mean?
- What assumptions are involved?
- Are the assumptions reasonable?
- What are the limitations?

---

## Part C – Audit Evaluation

Purpose:

Develop Professional Judgment.

Questions:

- What evidence was obtained?
- What uncertainty remains?
- What conclusion may be drawn?
- What additional procedures, if any, are needed?

---

# End-of-Chapter Activities Blueprint

Each chapter should contain three categories of learning activities aligned with the competency model.

---

## Exercises (Technical Skills)

Purpose:

> Can the student perform the analysis?

Examples:

- Calculate.
- Construct.
- Estimate.
- Execute.

---

## Concept Questions (Statistical Reasoning)

Purpose:

> Can the student explain and justify the analysis?

Examples:

- Explain.
- Compare.
- Interpret.
- Justify.

---

## Audit Questions (Professional Judgment)

Purpose:

> Can the student use the analysis to support an audit decision?

Examples:

- Evaluate.
- Conclude.
- Recommend.
- Defend.

---

# Learning Objectives Blueprint

The redesign does not replace Bloom's taxonomy.

Instead, the competency model and Bloom's taxonomy operate together.

```text
Bloom Taxonomy
        ×
Competency Model
```

Each chapter should include objectives spanning:

| Competency | Dominant Bloom Levels |
|------------|-----------------------|
| Technical Skills | Remember, Apply |
| Statistical Reasoning | Understand, Analyze |
| Professional Judgment | Evaluate, Create |

---

# Changes to Cases

Current cases often end with:

- a point estimate;
- a confidence interval;
- a p-value.

Future cases should conclude with:

### Audit Evaluation

What was learned?

### Remaining Uncertainty

What remains unknown?

### Possible Actions

What options are available?

### Recommended Conclusion

What should the auditor conclude?

---

# Changes to Front Matter

## New Introductory Figure

Introduce the competency model:

```text
Professional Judgment
        ↑
Statistical Reasoning
        ↑
Technical Skills
```

Explain that:

- software increasingly performs calculations;
- auditors remain responsible for conclusions;
- statistical competence includes more than execution alone;
- all three competency levels are required.

---

# Proposed Tagging System

Introduce margin indicators throughout the book.

### TS

Technical Skills

### SR

Statistical Reasoning

### PJ

Professional Judgment

This enables instructors and students to see which competency is being developed.

---

# Definition of Success

A student who completes Volume 1 should be able to:

## Technical Skills

Perform modern statistical analyses used in auditing.

## Statistical Reasoning

Select, explain, justify and evaluate statistical methods.

## Professional Judgment

Use statistical evidence to support defensible audit conclusions.

---

# Implementation Roadmap

## Phase 1 – Curriculum Design

- Competency Model
- Volume 1 Transformation Blueprint
- Volume 1 Curriculum Map

## Phase 2 – Pilot Chapter

- Chapter 2 redesign
- Workshop redesign
- Exercises
- Concept Questions
- Audit Questions

## Phase 3 – Volume-Wide Rollout

- Chapter 1–6 implementation
- Case redesign
- Workshop redesign
- End-of-chapter activity redesign

## Phase 4 – External Positioning

- University positioning document
- Bachelor curriculum mapping
- Post-master curriculum mapping

---

# Final Positioning Statement

> Volume 1 develops auditors who can perform statistical analyses, understand their implications, and exercise sound professional judgment on the basis of statistical evidence.
>
> The objective is not merely to teach statistics.
>
> The objective is to teach statistically informed audit decision-making.
