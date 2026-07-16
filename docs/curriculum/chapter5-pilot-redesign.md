---
title: Chapter 5 Pilot Redesign
subtitle: Regression Analysis
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

# Chapter 5 Pilot Redesign

## Purpose

This document serves as the first practical implementation of the Competency Model within *Audit Data Analysis – Volume 1*.

The objective is not to redesign the statistical content of Chapter 5, but to redesign how students engage with that content.

The chapter should explicitly develop:

1. Technical Skills
2. Statistical Reasoning
3. Professional Judgment

The chapter therefore becomes the first example of statistically informed audit decision-making.

---

# Current Structure

Chapter 5 currently consists of:

1. What is regression analysis
2. Assumptions underlying regression results
3. Obtaining and testing data
4. Modeling
5. Diagnostics checking
6. Analysis of variance
7. Testing model assumptions
8. Testing significance
9. Expectations
10. Evaluation
11. Workshop R
12. Workshop Python

---

# Current Competency Mapping

## Technical Skills

Strongly represented.

Current sections:

- What is regression analysis
- Obtaining and testing data
- Modeling
- Workshop R
- Workshop Python

Students learn:

- how to construct models;
- how to estimate coefficients;
- how to calculate predictions;
- how to use software.

---

## Statistical Reasoning

Moderately represented.

Current sections:

- Assumptions underlying regression results
- Diagnostics checking
- Analysis of variance
- Testing model assumptions
- Testing significance

Students learn:

- how to interpret output;
- how to evaluate assumptions;
- how to compare models.

---

## Professional Judgment

Present but largely concentrated near the end of the chapter.

Current sections:

- Expectations
- Evaluation

Students learn:

- how to use expectations;
- how to evaluate deviations;
- how to determine assurance.

This competency is currently underrepresented relative to its importance in audit practice.

---

# Proposed Competency Distribution

```text
Technical Skills          ███
Statistical Reasoning     ████
Professional Judgment     ████
```

The redesign intentionally shifts emphasis from model construction towards model evaluation and audit use.

The objective is not to produce data scientists.

The objective is to produce auditors who can defend analytical procedures.

---

# Redesigned Chapter Architecture

Every major section should explicitly connect the three competency levels.

```text
Audit Problem
        ↓
Model Construction
        ↓
Model Validation
        ↓
Model Interpretation
        ↓
Audit Evaluation
        ↓
Professional Judgment
```

---

# Learning Objectives

## Technical Skills

After completing this chapter, the student can:

- construct regression models using audit data;
- estimate model coefficients;
- assess model fit;
- generate confidence and prediction intervals;
- perform regression analysis in R and Python;
- execute regression diagnostics.

---

## Statistical Reasoning

After completing this chapter, the student can:

- explain the assumptions underlying regression analysis;
- assess whether those assumptions are satisfied;
- compare competing models;
- distinguish statistical significance from practical relevance;
- evaluate the reliability of model predictions;
- interpret regression output in its proper statistical context.

---

## Professional Judgment

After completing this chapter, the student can:

- determine whether a regression model provides persuasive audit evidence;
- evaluate whether unexpected deviations require investigation;
- determine whether analytical procedures achieve their audit objective;
- assess whether additional procedures are necessary;
- defend the use of a regression model during inspection or review;
- formulate audit conclusions based on model results.

---

# Proposed Section-Level Redesign

## 5.1 What Is Regression Analysis?

### Technical Skills

Focus:

- constructing regression equations;
- understanding variables.

### Statistical Reasoning

Focus:

- why regression is useful;
- limitations of correlation.

### Professional Judgment

New discussion box:

### Why Does the Auditor Care?

> Under what circumstances would regression provide stronger audit evidence than simple comparison procedures?

---

## 5.2 Assumptions Underlying Regression Results

### Technical Skills

Students identify assumptions.

### Statistical Reasoning

Students explain:

- normality;
- homoskedasticity;
- independence;
- linearity.

### Professional Judgment

New question:

> If one assumption is violated, does the analytical procedure automatically become unusable?

---

## 5.3 Obtaining and Testing Data

### Technical Skills

Data preparation.

### Statistical Reasoning

Data quality assessment.

### Professional Judgment

New discussion:

> Which data quality issues would cause you to reject the use of the model altogether?

---

## 5.4 Modeling

### Technical Skills

Model construction.

### Statistical Reasoning

Model selection.

### Professional Judgment

New recurring feature:

### Auditor's Decision

> Which model would you use in practice?
>
> Why?

---

## 5.5 Diagnostics Checking

### Technical Skills

Execution of diagnostic procedures.

### Statistical Reasoning

Interpretation of diagnostics.

### Professional Judgment

New question:

> Would you rely on a model that fails one diagnostic test but performs well on all others?

---

## 5.6 Analysis of Variance

### Technical Skills

Understanding ANOVA output.

### Statistical Reasoning

Explaining variance decomposition.

### Professional Judgment

New discussion:

> How much explanatory power is sufficient in an audit context?

---

## 5.7 Testing Model Assumptions

### Technical Skills

Performing formal tests.

### Statistical Reasoning

Interpreting results.

### Professional Judgment

New question:

> Which failed assumption would concern you most as an auditor?

---

## 5.8 Testing Significance

### Technical Skills

Interpreting p-values.

### Statistical Reasoning

Understanding significance.

### Professional Judgment

New discussion:

> Why does statistical significance not automatically imply audit relevance?

---

## 5.9 Expectations

### Technical Skills

Generating predictions.

### Statistical Reasoning

Understanding prediction intervals.

### Professional Judgment

Central question:

> Does the observed value fall outside a range that the auditor considers reasonable?

---

## 5.10 Evaluation

This section becomes the capstone section of the chapter.

### Technical Skills

Calculation of assurance.

### Statistical Reasoning

Interpretation of assurance.

### Professional Judgment

Audit conclusion.

The final section should explicitly answer:

1. What evidence was obtained?
2. What uncertainty remains?
3. Is the evidence persuasive?
4. What conclusion is justified?

---

# Redesigned Workshop Structure

## Part A – Execute

Primary Competency:

Technical Skills

Activities:

- construct models;
- generate diagnostics;
- calculate prediction intervals;
- produce expectations.

---

## Part B – Interpret

Primary Competency:

Statistical Reasoning

Questions:

- Why was this model selected?
- Which assumptions matter most?
- Which diagnostics are most important?
- Are the assumptions satisfied?

---

## Part C – Audit Evaluation

Primary Competency:

Professional Judgment

Questions:

- Would you rely on this model?
- Does this model provide persuasive audit evidence?
- Is additional testing required?
- How would you defend the model during inspection?

---

# Suggested End-of-Chapter Activities

## Exercises (Technical Skills)

### Exercise 5.1

Construct a regression model using the provided dataset.

### Exercise 5.2

Calculate confidence and prediction intervals.

### Exercise 5.3

Perform residual diagnostics.

### Exercise 5.4

Compare two alternative models.

---

## Concept Questions (Statistical Reasoning)

### Question 5.1

Why is a high R² not sufficient evidence that a model is useful?

### Question 5.2

Why might a statistically significant variable still have little practical value?

### Question 5.3

Which regression assumptions are most important for prediction?

### Question 5.4

Why can a simpler model sometimes be preferable?

### Question 5.5

What is the difference between explanation and prediction?

---

## Audit Questions (Professional Judgment)

### Question 5.1

The model passes all statistical tests, but management cannot provide a plausible explanation for the observed relationships.

Would you rely on the model?

Why or why not?

---

### Question 5.2

The predicted annual revenue is €190 million.

The recorded value is €178 million.

Performance materiality equals €15 million.

What audit conclusion would you draw?

---

### Question 5.3

A regulator challenges the use of your model.

How would you defend it?

---

### Question 5.4

The model explains only 45% of variation.

Can it still provide useful audit evidence?

Explain your reasoning.

---

### Question 5.5

The model identifies a significant unexplained deviation.

What would your next audit step be?

---

# Case Redesign

## Current Ending

The case currently concludes with:

- model results;
- prediction intervals;
- assurance calculations.

---

## Proposed Ending

### Audit Evaluation

What evidence was obtained?

### Remaining Uncertainty

What cannot be concluded?

### Alternative Explanations

What explanations remain possible?

### Further Procedures

What additional work might be performed?

### Recommended Audit Conclusion

What conclusion is justified based on the available evidence?

---

# Pilot Success Criteria

The redesign is successful if a student completing Chapter 5 can:

### Technical Skills

Build and evaluate regression models.

### Statistical Reasoning

Explain why a model should or should not be trusted.

### Professional Judgment

Use regression evidence to support and defend an audit conclusion.

---

# Expected Contribution to Volume 1

Chapter 5 becomes the first chapter in Volume 1 where students explicitly experience the complete competency progression:

```text
Technical Skills
        ↓
Statistical Reasoning
        ↓
Professional Judgment
```

As such, it serves as the prototype for future redesign of the remaining chapters.
