---
title: Volume 1 Transformation Blueprint
authors:
  - Lucas Hoogduin
  - Paul Touw
status: Draft
version: 1.0
created: 2026-07-16
related_issue: "#<issue-number>"
---

# Volume 1 Transformation Blueprint

## Audit Data Analysis – Volume 1

### Version 1.0 – Strategic Redesign Proposal

***

# Executive Summary

Volume 1 is already a strong statistics-for-auditors textbook. However, the proposed competency model suggests a shift from:

> "Teaching statistical methods"

towards:

> "Teaching how auditors use statistical evidence to support professional judgments."

The statistical content remains largely unchanged.

The transformation primarily affects:

* learning objectives;
* chapter architecture;
* review questions;
* workshop design;
* case conclusions;
* narrative flow.

The key principle is:

> Every chapter should explicitly develop Technical Skills, Statistical Reasoning, and Professional Judgment. [\[ada_volume1.pdf \| PDF\]](https://onedrive-global.kpmg.com/personal/hoogduin_lucas_kpmg_nl/Documents/Microsoft%20Copilot%20Chat%20Files/ada_volume1.pdf)

***

# The New Educational Framework

## Level 1: Technical Skills

Students learn how to perform analyses.

Typical verbs:

* calculate
* estimate
* execute
* construct
* reproduce
* implement

Question:

> How do I perform the analysis?

***

## Level 2: Statistical Reasoning

Students learn how to think statistically.

Typical verbs:

* select
* interpret
* compare
* explain
* assess
* justify

Question:

> Why is this method appropriate?

***

## Level 3: Professional Judgment

Students learn how to use evidence.

Typical verbs:

* evaluate
* conclude
* determine
* defend
* recommend
* communicate

Question:

> What should the auditor conclude?

***

# Proposed Chapter Architecture

Each substantive chapter should use the same intellectual pathway:

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

The chapter should end with:

> "What does this imply for the audit?"

***

# Chapter-by-Chapter Transformation

***

# Chapter 1

## Probability Distributions

### Current Position

Primarily technical.

Students learn:

* hypergeometric distribution;
* binomial distribution;
* Poisson distribution;
* normal distribution;
* t distribution;
* χ² distribution;
* F distribution. [\[ada_volume1.pdf \| PDF\]](https://onedrive-global.kpmg.com/personal/hoogduin_lucas_kpmg_nl/Documents/Microsoft%20Copilot%20Chat%20Files/ada_volume1.pdf)

***

## Desired Position

### Technical Skills

Student can:

* calculate probabilities;
* use distribution functions in R and Python;
* perform distribution approximations.

***

### Statistical Reasoning

Student can:

* determine which distribution applies;
* justify approximations;
* explain the assumptions behind sampling models.

***

### Professional Judgment

Student can:

* determine whether observed sample results are unusual;
* assess whether observed deviations warrant further audit attention;
* explain uncertainty to a non-statistical audience.

***

## Additional Review Questions

### Technical

Calculate:

* P(k=0)
* confidence limits
* approximation conditions

### Reasoning

Explain:

* Why hypergeometric instead of binomial?
* Why not use a normal approximation?

### Professional Judgment

Suppose a sample reveals four deviations.

Does this indicate a potential control issue?

Why?

***

# Chapter 2

## Estimation

### Current Position

Strong on methodology.

Focus:

* confidence intervals;
* sample size calculations;
* proportions;
* finite-population corrections. [\[ada_volume1.pdf \| PDF\]](https://onedrive-global.kpmg.com/personal/hoogduin_lucas_kpmg_nl/Documents/Microsoft%20Copilot%20Chat%20Files/ada_volume1.pdf)

***

## Desired Position

### Technical Skills

Student can:

* calculate estimates and intervals;
* determine sample size;
* compute correction factors.

***

### Statistical Reasoning

Student can:

* explain the relationship between confidence and precision;
* determine when assumptions are valid;
* select appropriate estimation approaches.

***

### Professional Judgment

Student can:

* determine whether evidence is sufficiently persuasive;
* assess residual uncertainty;
* judge whether further testing is needed.

***

## New Professional Discussion

Every estimate should conclude with:

* What uncertainty remains?
* Is this uncertainty acceptable?
* What audit risk remains?

***

# Chapter 3

## Auxiliary Variables and Stratification

### Current Position

Heavily quantitative.

Focus:

* MPU;
* regression;
* difference estimation;
* ratio estimation;
* stratification. [\[ada_volume1.pdf \| PDF\]](https://onedrive-global.kpmg.com/personal/hoogduin_lucas_kpmg_nl/Documents/Microsoft%20Copilot%20Chat%20Files/ada_volume1.pdf)

***

## Desired Position

### Technical Skills

Student can:

* perform alternative estimations;
* stratify populations;
* allocate samples.

***

### Statistical Reasoning

Student can:

* select an estimator;
* explain estimator trade-offs;
* assess when stratification is beneficial.

***

### Professional Judgment

Student can:

* defend estimator choices;
* justify audit decisions using estimation outcomes;
* evaluate whether precision achieved is sufficient.

***

## Major Opportunity

Introduce a recurring box:

### Auditor's Decision

Example:

> Why would an auditor prefer regression estimation despite its greater complexity?

This bridges methodology and audit practice.

***

# Chapter 4

## Hypothesis Testing and Sampling

### Current Position

Closest to the proposed framework already.

Focus:

* audit decisions;
* acceptance/rejection;
* attribute sampling;
* MUS;
* interpretation.

***

## Desired Position

### Technical Skills

Student can:

* determine sample size;
* evaluate samples;
* calculate bounds.

***

### Statistical Reasoning

Student can:

* understand Type I and Type II risks;
* interpret OC curves;
* explain decision thresholds.

***

### Professional Judgment

Student can:

* determine whether sufficient audit evidence exists;
* assess whether additional procedures are warranted;
* defend a sampling conclusion.

***

## Recommendation

Make this chapter the benchmark for the whole book.

Many later chapters should emulate its audit-oriented reasoning style.

***

# Chapter 5

## Regression Analysis

### Current Position

Technically excellent.

Potentially the chapter most affected by the redesign.

***

## Technical Skills

Student can:

* build models;
* perform diagnostics;
* calculate predictions;
* test assumptions.

***

## Statistical Reasoning

Student can:

* determine whether assumptions hold;
* evaluate model validity;
* understand significance versus relevance.

***

## Professional Judgment

Student can:

* assess whether the model provides persuasive audit evidence;
* evaluate whether the model supports substantive analytical procedures;
* determine whether the resulting assurance is sufficient.

***

## Critical Addition

New recurring question:

> If this model were challenged during inspection, could you defend its use?

That single question elevates the chapter substantially.

***

# Chapter 6

## Goodness-of-Fit and Benford's Law

### Current Position

Focuses on:

* χ² analysis;
* Benford’s Law;
* anomaly detection.

***

## Desired Position

### Technical Skills

Student can:

* perform goodness-of-fit testing;
* conduct Benford analyses.

***

### Statistical Reasoning

Student can:

* evaluate appropriateness of expected distributions;
* interpret deviations appropriately.

***

### Professional Judgment

Student can:

* distinguish anomaly detection from evidence of fraud;
* determine appropriate follow-up procedures;
* avoid overinterpreting statistical findings.

***

## Important Message

Students should repeatedly hear:

> Benford deviations are not conclusions.
>
> They are audit leads.

***

# Workshops Transformation

Current workshop structure:

```text
Theory
→ Code
→ Output
```

Proposed structure:

```text
Theory
→ Code
→ Output
→ Interpretation
→ Audit Evaluation
```

***

# New Standard Workshop Template

## Part A – Execute

Run analysis.

***

## Part B – Interpret

Questions:

* What does the output mean?
* Which assumptions are visible?

***

## Part C – Audit Evaluation

Questions:

* What evidence was obtained?
* What uncertainty remains?
* What conclusion may be drawn?
* What further procedures are indicated?

***

# Review Questions Blueprint

Each chapter receives three sections.

***

## Section A

### Technical Skills

Computational.

Examples:

* Calculate.
* Construct.
* Estimate.

***

## Section B

### Statistical Reasoning

Interpretative.

Examples:

* Explain.
* Compare.
* Justify.

***

## Section C

### Professional Judgment

Audit-focused.

Examples:

* Evaluate.
* Conclude.
* Recommend.

***

# Learning Objectives Blueprint

Current learning objectives already follow Bloom's taxonomy reasonably well. The redesign should not replace Bloom.

Instead:

```text
Bloom Taxonomy
        ×
Competency Layer
```

Every chapter should contain objectives spanning:

| Competency            | Bloom Focus          |
| --------------------- | -------------------- |
| Technical Skills      | Remember / Apply     |
| Statistical Reasoning | Understand / Analyze |
| Professional Judgment | Evaluate / Create    |

***

# Changes to Cases

Current cases often end with:

> an estimate;
>
> a confidence interval;
>
> a p-value.

Future cases should end with:

### Audit Evaluation

### Remaining Uncertainty

### Possible Actions

### Recommended Conclusion

***

# Changes to Front Matter

## New Introductory Figure

Introduce the model:

```text
Professional Judgment
        ↑
Statistical Reasoning
        ↑
Technical Skills
```

Explain:

* software increasingly performs calculations;
* auditors remain responsible for conclusions;
* therefore all three levels are required.

***

# Proposed Tagging System

Throughout the book add margin icons:

### TS

Technical Skills

### SR

Statistical Reasoning

### PJ

Professional Judgment

This allows instructors to tailor courses more easily.

***

# Definition of Success

A student who completes Volume 1 should be able to:

### Technical Skills

Perform modern statistical analyses.

### Statistical Reasoning

Select and justify statistical methods.

### Professional Judgment

Use statistical evidence to support audit conclusions.

***

# Final Positioning Statement

> Volume 1 develops auditors who can perform statistical analyses, understand their implications, and exercise sound professional judgment on the basis of statistical evidence.
>
> The objective is not merely to teach statistics.
>
> The objective is to teach statistically informed audit decision-making.
