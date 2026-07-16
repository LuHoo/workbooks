---
title: Chapter 4 Pilot Redesign
subtitle: Hypothesis Testing and Audit Sampling
authors:
  - Lucas Hoogduin
  - Paul Touw
status: Draft
version: 1.0
created: 2026-07-16
related_documents:
  - competency-model.md
  - volume1-transformation-blueprint.md
  - volume1-curriculum-map.md
---

# Chapter 4 Pilot Redesign

## Purpose

This document serves as the second pilot implementation of the Competency Model within *Audit Data Analysis – Volume 1*.

Where Chapter 5 validated the distinction between statistical analysis and evidence evaluation, Chapter 4 serves a different purpose:

> It validates the boundary between evidence evaluation (Volume 1) and audit decision-making (Volume 2).

Hypothesis testing and audit sampling form a natural bridge between statistics and auditing.

The challenge in redesigning this chapter is ensuring that students learn how to evaluate sampling evidence without prematurely moving into audit planning, audit responses, or audit strategy.

---

# Professional Judgment in Volume 1

Within Volume 1, Professional Judgment focuses on evaluating statistical evidence.

Students learn to determine:

- the strength of evidence;
- the uncertainty associated with evidence;
- whether conclusions are supported;
- whether conclusions are unsupported.

Students are not yet expected to determine:

- follow-up audit procedures;
- audit strategies;
- responses to identified risks;
- audit planning decisions.

Those topics belong primarily to Volume 2.

The central question for this chapter therefore becomes:

> What conclusions are justified by the sample evidence?

rather than:

> What should the auditor do next?

---

# Current Structure

The chapter currently focuses on:

1. Hypothesis testing
2. Statistical decision-making
3. Attribute sampling
4. Monetary Unit Sampling (MUS)
5. Evaluation of sampling results
6. Audit interpretation

---

# Current Competency Mapping

## Technical Skills

Strongly represented.

Students learn:

- sample-size determination;
- confidence-bound calculations;
- accept/reject procedures;
- MUS evaluation;
- implementation in R and Python.

---

## Statistical Reasoning

Well represented.

Students learn:

- Type I and Type II error;
- significance levels;
- power;
- operating characteristic curves;
- sampling risk.

---

## Professional Judgment

Present throughout the chapter.

However, several discussions naturally drift toward audit responses rather than evaluation of evidence.

The redesign should sharpen this distinction.

---

# Proposed Competency Distribution

```text
Technical Skills          ████
Statistical Reasoning     █████
Professional Judgment     ████
```

Unlike Chapter 5, Chapter 4 remains strongly statistical.

The redesign does not reduce statistical rigor.

Instead, it makes the interpretation of evidence more explicit.

---

# Redesigned Chapter Architecture

The intellectual flow of the chapter should be:

```text
Audit Objective
        ↓
Sampling Design
        ↓
Sample Evaluation
        ↓
Statistical Conclusion
        ↓
Evidence Evaluation
        ↓
Supported Conclusion
```

Importantly, the progression ends at supported conclusions.

Subsequent audit actions belong to Volume 2.

---

# Learning Objectives

## Technical Skills

After completing this chapter, the student can:

- determine sample sizes;
- apply attribute sampling methods;
- apply Monetary Unit Sampling;
- calculate confidence bounds;
- evaluate sample results using statistical procedures;
- perform sampling analyses in R and Python.

---

## Statistical Reasoning

After completing this chapter, the student can:

- explain Type I and Type II errors;
- interpret confidence levels;
- assess sampling risk;
- explain operating characteristic curves;
- compare alternative sampling approaches;
- evaluate the statistical implications of sample findings.

---

## Professional Judgment

After completing this chapter, the student can:

- evaluate the strength of sampling evidence;
- assess uncertainty associated with sample conclusions;
- distinguish supported conclusions from unsupported conclusions;
- determine whether sampling evidence is persuasive;
- explain limitations of sampling evidence;
- formulate conclusions consistent with the evidence obtained.

---

# Proposed Section-Level Redesign

## Hypothesis Testing

### Technical Skills

Students learn:

- null and alternative hypotheses;
- test statistics;
- critical regions;
- p-values.

### Statistical Reasoning

Students learn:

- why hypothesis testing works;
- interpretation of significance levels;
- consequences of Type I and Type II errors.

### Professional Judgment

New discussion box:

### Evaluating Evidence

> Does rejection of a hypothesis prove that the alternative is true?

Students should recognize that statistical evidence supports conclusions but rarely proves them with certainty.

---

## Sampling Risk

### Technical Skills

Students calculate:

- confidence levels;
- sample sizes;
- operating characteristics.

### Statistical Reasoning

Students interpret:

- detection risk;
- acceptance risk;
- rejection risk.

### Professional Judgment

New question:

> How much uncertainty remains after the sample has been evaluated?

---

## Attribute Sampling

### Technical Skills

Students:

- determine sample sizes;
- evaluate deviation rates.

### Statistical Reasoning

Students:

- evaluate tolerable and expected deviation rates;
- interpret statistical conclusions.

### Professional Judgment

New discussion:

> Which conclusions are justified by the observed deviation rate?

---

## Monetary Unit Sampling

### Technical Skills

Students:

- calculate sampling intervals;
- evaluate misstatements;
- determine upper bounds.

### Statistical Reasoning

Students:

- understand the role of probability proportional to size;
- interpret confidence bounds.

### Professional Judgment

New discussion:

> What conclusions are supported by the calculated upper bound?

---

## Evaluation of Results

This becomes the capstone section of the chapter.

### Technical Skills

Calculation of:

- projected misstatement;
- upper misstatement bound.

### Statistical Reasoning

Interpretation of:

- confidence levels;
- uncertainty;
- sampling risk.

### Professional Judgment

Evaluation of:

- strength of evidence;
- supported conclusions;
- unsupported conclusions.

---

# New Recurring Feature

## What Does the Sample Allow Us to Conclude?

This recurring feature should appear throughout the chapter.

Examples:

### Example 1

The upper bound on projected misstatement exceeds performance materiality.

Question:

> Which conclusions are supported?

### Example 2

No deviations were identified in an attribute sample.

Question:

> What conclusions are supported?

> What uncertainty remains?

### Example 3

A sample result is statistically significant.

Question:

> Does statistical significance imply a strong audit conclusion?

---

# Redesigned Workshop Structure

## Part A – Execute

Primary Competency:

Technical Skills

Students:

- determine sample sizes;
- evaluate samples;
- calculate confidence limits;
- perform MUS evaluation.

---

## Part B – Interpret

Primary Competency:

Statistical Reasoning

Questions:

- What is the meaning of the confidence level?
- What assumptions are being made?
- What does sampling risk imply?
- How should the confidence bound be interpreted?

---

## Part C – Evaluate Evidence

Primary Competency:

Professional Judgment

Questions:

- What evidence has been obtained?
- How persuasive is that evidence?
- What uncertainty remains?
- Which conclusions are justified?
- Which conclusions are not justified?

---

# Suggested End-of-Chapter Activities

## Exercises (Technical Skills)

### Exercise 4.1

Determine the required sample size for an attribute sample.

### Exercise 4.2

Evaluate a sample and calculate the upper deviation limit.

### Exercise 4.3

Perform a Monetary Unit Sampling evaluation.

### Exercise 4.4

Calculate projected and upper-bound misstatements.

---

## Concept Questions (Statistical Reasoning)

### Question 4.1

Why is sampling risk unavoidable?

### Question 4.2

What is the relationship between sample size and confidence level?

### Question 4.3

Why does Type I risk matter to auditors?

### Question 4.4

Why is an upper confidence bound more informative than a point estimate alone?

### Question 4.5

Why does the absence of observed errors not imply that the population is error-free?

---

## Audit Questions (Professional Judgment)

### Question 4.1

An attribute sample reveals no deviations.

Which conclusions are supported by the evidence?

What uncertainty remains?

---

### Question 4.2

The projected misstatement is below performance materiality, but the upper confidence bound exceeds performance materiality.

Which conclusions are supported?

Which conclusions are not supported?

---

### Question 4.3

A sample result is statistically significant.

To what extent does the evidence support a conclusion regarding the population?

---

### Question 4.4

The sample supports the conclusion that material misstatement is unlikely.

Does this mean that material misstatement has been ruled out?

Explain.

---

### Question 4.5

Two auditors analyse the same sample.

Both agree on the calculations.

One argues that the evidence is persuasive.

The other argues that substantial uncertainty remains.

Which arguments can be supported by the sample results?

---

# Case Redesign

## Current Ending

The case currently concludes with:

- sample results;
- confidence limits;
- projected misstatements.

---

## Proposed Ending

### Evidence Obtained

What evidence did the sample provide?

### Remaining Uncertainty

What uncertainty remains?

### Supported Conclusions

Which conclusions are justified?

### Unsupported Conclusions

Which conclusions cannot be justified?

### Strength of Evidence

How persuasive is the evidence?

---

# Relationship with Volume 2

This chapter intentionally stops at evidence evaluation.

Questions such as:

- Should additional audit procedures be performed?
- How should audit risk be reassessed?
- What is the appropriate audit response?

belong to Volume 2 and should not be central learning objectives of this chapter.

The chapter therefore serves as the bridge between:

```text
Statistical Analysis
        ↓
Evidence Evaluation
```

while Volume 2 begins at:

```text
Evidence Evaluation
        ↓
Audit Decision-Making
```

---

# Pilot Success Criteria

The redesign is successful if a student completing Chapter 4 can:

## Technical Skills

Perform hypothesis testing and sampling evaluations correctly.

## Statistical Reasoning

Explain the meaning and limitations of sampling results.

## Professional Judgment

Evaluate sampling evidence and determine which conclusions are supported by the evidence obtained.

---

# Expected Contribution to Volume 1

Chapter 4 becomes the clearest demonstration of the Volume 1 philosophy:

```text
Technical Skills
        ↓
Statistical Reasoning
        ↓
Evidence Evaluation
```

It therefore serves as the principal validation chapter for the distinction between:

```text
Volume 1
    Statistical Evidence Evaluation

Volume 2
    Evidence-Based Audit Decision-Making
```
