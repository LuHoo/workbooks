---
title: End-of-Chapter Activities Guide
subtitle: Design Standards for Exercises, Concept Questions, and Audit Questions
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

# End-of-Chapter Activities Guide

## Purpose

This document establishes the design standards for end-of-chapter activities in *Audit Data Analysis – Volume 1*.

The activities are intended to support the three competency levels defined in the Competency Model:

- Technical Skills (TS)
- Statistical Reasoning (SR)
- Professional Judgment (PJ)

The purpose of these activities is not merely to test whether students have read a chapter.

Instead, they provide structured opportunities to:

1. perform statistical analyses;
2. understand and justify statistical methods;
3. evaluate statistical evidence.

---

# Educational Philosophy

The Competency Model distinguishes three educational goals:

```text
Technical Skills
        ↓
Statistical Reasoning
        ↓
Professional Judgment
```

Different competencies require different forms of learning.

Consequently, a single type of question is insufficient.

Volume 1 therefore uses three categories of end-of-chapter activities:

1. Exercises
2. Concept Questions
3. Audit Questions

Each category serves a distinct educational purpose.

---

# Relationship with Volume 1

Volume 1 focuses on:

```text
Statistical Analysis
        ↓
Evidence Evaluation
```

The purpose of end-of-chapter activities is therefore to help students evaluate evidence and determine what conclusions are supported.

Students are not yet expected to:

- design audit programmes;
- determine audit responses;
- reassess audit risk;
- formulate audit strategies.

These topics belong primarily to Volume 2.

---

# Activity Taxonomy

## Exercises

Primary Competency:

**Technical Skills**

Purpose:

> Can the student perform the analysis?

---

## Concept Questions

Primary Competency:

**Statistical Reasoning**

Purpose:

> Can the student explain and justify the analysis?

---

## Audit Questions

Primary Competency:

**Professional Judgment**

Purpose:

> Can the student evaluate statistical evidence and determine which conclusions are supported?

---

# Exercises

## Objective

Exercises develop Technical Skills.

Students should actively perform calculations rather than merely review concepts.

The emphasis is on application.

---

## Typical Activities

Students may be required to:

- calculate probabilities;
- determine sample sizes;
- estimate population parameters;
- evaluate confidence intervals;
- perform hypothesis tests;
- fit regression models;
- perform Benford analyses;
- reproduce results using R or Python.

---

## Typical Verbs

- calculate
- estimate
- determine
- construct
- execute
- reproduce
- implement
- perform

---

## Examples

### Probability Distributions

Calculate the probability of observing exactly three deviations in a sample.

---

### Estimation

Construct a 95% confidence interval for the population mean.

---

### Regression

Build a regression model using the provided dataset.

---

### Goodness-of-Fit

Perform a χ² goodness-of-fit test.

---

## Design Principles

Exercises should:

- have objective answers;
- emphasize execution;
- require use of chapter methods;
- focus on correctness;
- prepare students for workshop activities.

Exercises should not primarily assess judgment or interpretation.

---

# Concept Questions

## Objective

Concept Questions develop Statistical Reasoning.

Students should explain, justify, compare, and interpret.

The emphasis is understanding rather than calculation.

---

## Typical Activities

Students may be required to:

- explain assumptions;
- compare methods;
- interpret output;
- justify decisions;
- evaluate model quality;
- assess limitations.

---

## Typical Verbs

- explain
- compare
- interpret
- justify
- assess
- analyze
- evaluate
- distinguish

---

## Examples

### Probability Distributions

Why is the hypergeometric distribution preferred over the binomial distribution in this situation?

---

### Estimation

Why does increasing the sample size reduce interval width?

---

### Hypothesis Testing

Why does a larger sample size generally increase test power?

---

### Regression

Why is a high R² not sufficient evidence that a model is useful?

---

### Benford's Law

Why do Benford deviations not automatically imply fraud?

---

## Design Principles

Concept Questions should:

- emphasize reasoning;
- focus on understanding;
- avoid unnecessary computation;
- encourage explanation;
- stimulate discussion.

A student should be able to answer most Concept Questions without using software.

---

# Audit Questions

## Objective

Audit Questions develop Professional Judgment.

In Volume 1, Professional Judgment means:

> evaluating statistical evidence and determining which conclusions are supported by that evidence.

Audit Questions should therefore focus on evidence evaluation, not audit response.

---

## Central Design Principle

Audit Questions should answer:

> What conclusions are supported?

and

> What uncertainty remains?

They should not primarily answer:

> What audit procedure should be performed next?

That latter question belongs primarily to Volume 2.

---

## Typical Activities

Students may be required to:

- evaluate evidence;
- assess uncertainty;
- distinguish supported conclusions from unsupported conclusions;
- assess evidential strength;
- identify limitations;
- communicate conclusions appropriately.

---

## Typical Verbs

- evaluate
- assess
- conclude
- determine
- justify
- defend
- communicate

---

## Examples

### Estimation

An upper confidence limit falls below performance materiality.

Which conclusions are supported by the available evidence?

---

### Sampling

No deviations were identified in the sample.

What conclusions are supported?

What uncertainty remains?

---

### Regression

The model explains 85% of the observed variation.

How persuasive is the evidence obtained?

Which conclusions are supported?

---

### Benford's Law

A Benford analysis reveals significant deviations.

Which conclusions are supported by these results?

Which conclusions are not supported?

---

## Design Principles

Audit Questions should:

- focus on evidence evaluation;
- require interpretation of uncertainty;
- avoid requiring audit methodology knowledge;
- avoid requiring detailed audit responses;
- remain answerable using Volume 1 material alone.

---

# Cases

## Purpose

Cases integrate all three competencies.

They serve as the capstone activity of a chapter.

---

## Required Structure

Every case should conclude with:

### Statistical Result

What was observed?

---

### Interpretation

What does the result mean?

---

### Evidence Evaluation

How persuasive is the evidence?

---

### Remaining Uncertainty

What remains unknown?

---

### Supported Conclusions

What conclusions are justified?

---

### Unsupported Conclusions

What conclusions are not justified?

---

## Example

Instead of concluding with:

> The upper bound on projected misstatement equals €125,000.

a case should conclude with:

> The upper bound on projected misstatement equals €125,000.
>
> The available evidence supports the conclusion that material misstatement is unlikely.
>
> However, uncertainty remains because the upper confidence bound remains relatively close to performance materiality.

---

# Relationship with Workshops

End-of-chapter activities complement workshops.

The relationship should be:

```text
Workshop
        ↓
Exercises
        ↓
Concept Questions
        ↓
Audit Questions
```

---

## Workshop Part A

Execution

Primary competency:

Technical Skills

---

## Workshop Part B

Interpretation

Primary competency:

Statistical Reasoning

---

## Workshop Part C

Evidence Evaluation

Primary competency:

Professional Judgment

---

# Recommended Distribution

The exact balance may vary between chapters.

A recommended distribution is:

| Activity Type | Typical Share |
|---------------|---------------|
| Exercises | 40–50% |
| Concept Questions | 25–35% |
| Audit Questions | 20–30% |

Chapters later in the book generally contain a larger proportion of Audit Questions.

For example:

- Chapter 1 contains relatively few Audit Questions.
- Chapters 4–6 contain substantially more Audit Questions.

---

# Quality Checklist

## Exercises

Can the student perform the analysis?

- [ ] Requires execution
- [ ] Has a clear answer
- [ ] Uses chapter techniques
- [ ] Reinforces workshops

---

## Concept Questions

Can the student explain the analysis?

- [ ] Requires explanation
- [ ] Focuses on assumptions
- [ ] Encourages comparison
- [ ] Avoids routine calculation

---

## Audit Questions

Can the student evaluate the evidence?

- [ ] Focuses on evidence
- [ ] Considers uncertainty
- [ ] Evaluates conclusions
- [ ] Avoids Volume 2 material
- [ ] Can be answered using Volume 1 content

---

# Validation Rule

Every learning objective should be linked to at least one educational activity.

Not every learning objective must appear in all activity categories.

Instead:

| Competency | Primary Activity |
|------------|------------------|
| Technical Skills | Exercises |
| Statistical Reasoning | Concept Questions |
| Professional Judgment | Audit Questions |

The educational mechanism should match the competency being developed.

---

# Success Criteria

The guide is successful if it leads to activities that help students progress through the complete Volume 1 learning sequence:

```text
Perform the analysis
        ↓
Understand the analysis
        ↓
Evaluate the evidence
        ↓
Determine supported conclusions
```

This progression reflects the central educational objective of Volume 1:

> developing statistically informed evidence evaluation.
