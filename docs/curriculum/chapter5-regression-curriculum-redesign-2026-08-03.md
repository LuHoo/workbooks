# Chapter 5 Regression Analysis Curriculum Redesign (2026-08-03)

Status: Design specification
Scope: Volume 1, Chapter 5 (Regression Analysis)
Audience: First-year and second-year bachelor students in accounting and auditing
Design premise: Curriculum-philosophy redesign, not a technical rewrite

## 1) Assessment of Current Chapter Purpose

Current chapter materials already aim at a meaningful audit-education question: whether recorded amounts are consistent with a statistically supported expectation. That is a strong identity and should be retained.

Current architecture weakness is not chapter content quality but chapter signaling quality. The visible objective structure makes Chapter 5 look like a sequence of definitions and procedures, while the chapter itself actually tries to teach expectation credibility, evidence interpretation, and assurance implications.

Conclusion: the chapter purpose is valid in substance, under-expressed in architecture.

## 2) Assessment of Philosophy Alignment

Volume 1 philosophy requires:

- progression: Perform -> Interpret -> Evaluate
- competency progression: Technical Skills -> Statistical Reasoning -> Professional Judgment

Current Chapter 5 partially aligns by including modeling and diagnostics, but it underweights Statistical Reasoning in the objective architecture and overweights procedural and recall framing.

Target alignment for Chapter 5 should be:

- strongest emphasis on Statistical Reasoning;
- Technical Skills as enabling layer;
- Professional Judgment present but bounded;
- no early shift to engagement-level audit response decisions.

## 3) Architectural Weaknesses

Primary weaknesses:

1. Over-allocation to low-level outcomes (terminology, definitions, workflow listing).
2. Under-allocation to model-quality reasoning and evidential interpretation.
3. Fragmentation: diagnostics, expectation quality, and evidence meaning are separated instead of chained.
4. Implicit boundary drift toward Volume 2 decision ownership.
5. Weak explicit correction of common misconceptions.

Educational consequence: students can execute steps without being able to justify evidential confidence.

## 4) Recommended Chapter Positioning Statement

Recommended positioning statement:

"Regression analysis in Chapter 5 is taught as an expectation-setting and evidence-evaluation method for substantive analytical procedures, used to judge whether recorded amounts are statistically consistent with supported expectations and to explain the resulting assurance implications."

Working definition:

"Regression analysis is a method for constructing and evaluating statistically supported expectations in order to assess the evidential value of recorded amounts."

## 5) Recommended Chapter Narrative Arc

1. Why this chapter exists in audit practice (ISA 520 analytical procedures).
2. What question Chapter 5 answers (expected amount vs recorded amount).
3. How expectation quality is built (model specification, diagnostics, uncertainty).
4. How expectations are used to evaluate recorded amounts.
5. What assurance implications follow.
6. What remains outside Chapter 5 scope (response decisions in Volume 2).

Pedagogical contrast to Chapter 4 should be explicit:

- Chapter 4: population accept/reject via sampling evidence.
- Chapter 5: expectation credibility and deviation interpretation via model-based evidence.

## 6) Recommended Chapter Learning Journey

Suggested learning journey:

1. Frame the expectation question.
2. Build a baseline expectation model.
3. Diagnose and improve expectation credibility.
4. Compare recorded amounts to expected ranges.
5. Interpret evidential meaning and limitations.
6. Explain assurance implications without deciding audit response.

## 7) Recommended Bloom Profile

Target chapter-level profile (12 objectives):

- Remember: 1
- Understand: 2
- Apply: 2
- Analyze: 4
- Evaluate: 2
- Create: 1

Rationale:

- preserve minimal foundational recall;
- keep operational capability;
- shift center of gravity to Analyze and Evaluate;
- include one bounded Create objective for structured communication.

## 8) Recommended Competency Profile

Target emphasis:

- Statistical Reasoning: dominant
- Technical Skills: secondary but strong
- Professional Judgment: present, bounded

Approximate distribution (primary competency across 12 objectives):

- Statistical Reasoning: 7
- Technical Skills: 4
- Professional Judgment: 1

## 9) Complete Redesigned Chapter-Level Learning Objectives

### Objective Set

- C5R-01: Explain regression as an expectation-setting method for substantive analytical procedures and distinguish it from prediction-only framing.
- C5R-02: Explain why expectation credibility depends on both model specification and diagnostic evidence.
- C5R-03: Construct a baseline regression expectation using appropriate variables, data partitioning, and reproducible workflow steps.
- C5R-04: Apply diagnostic tests and plots to identify limitations in linearity, variance behavior, distributional plausibility, influence, and multicollinearity.
- C5R-05: Analyze how changes in specification or influential observations alter expected values, uncertainty, and evidential confidence.
- C5R-06: Analyze regression output to determine whether high fit statistics are supported by credible assumptions and stable diagnostics.
- C5R-07: Analyze whether observed deviations from expectation are statistically unusual given prediction uncertainty and stated thresholds.
- C5R-08: Evaluate the evidential strength of a regression-based expectation for the specific balance or subtotal under examination.
- C5R-09: Evaluate what conclusions are justified and not justified from the model results, including explicit uncertainty limits.
- C5R-10: Explain assurance implications of expectation-consistency results without selecting audit response actions.
- C5R-11: Create a concise evidence narrative that links model quality, deviation interpretation, and assurance implications for a non-technical stakeholder.
- C5R-12: Explain why the following claims are incorrect or incomplete: (a) high R2 means good model, (b) correlation implies causation, (c) significance alone implies reliable evidence, (d) regression establishes truth, (e) strong fit implies sufficient assurance.

## 10) Bloom Classification for Every Objective

| Objective | Bloom Level |
|---|---|
| C5R-01 | Understand |
| C5R-02 | Understand |
| C5R-03 | Apply |
| C5R-04 | Apply |
| C5R-05 | Analyze |
| C5R-06 | Analyze |
| C5R-07 | Analyze |
| C5R-08 | Evaluate |
| C5R-09 | Evaluate |
| C5R-10 | Analyze |
| C5R-11 | Create |
| C5R-12 | Remember |

## 11) Competency Classification for Every Objective

| Objective | Primary Competency | Secondary Competency |
|---|---|---|
| C5R-01 | Statistical Reasoning | Technical Skills |
| C5R-02 | Statistical Reasoning | Technical Skills |
| C5R-03 | Technical Skills | Statistical Reasoning |
| C5R-04 | Technical Skills | Statistical Reasoning |
| C5R-05 | Statistical Reasoning | Technical Skills |
| C5R-06 | Statistical Reasoning | Technical Skills |
| C5R-07 | Statistical Reasoning | Technical Skills |
| C5R-08 | Statistical Reasoning | Professional Judgment |
| C5R-09 | Statistical Reasoning | Professional Judgment |
| C5R-10 | Professional Judgment | Statistical Reasoning |
| C5R-11 | Technical Skills | Statistical Reasoning |
| C5R-12 | Statistical Reasoning | Professional Judgment |

## 12) Identification of Bridge Objectives

Required bridge 1: Construct expectation -> Assess expectation quality

- C5R-03
- C5R-04
- C5R-05
- C5R-06

Required bridge 2: Assess expectation quality -> Interpret evidential value

- C5R-05
- C5R-06
- C5R-07
- C5R-08

Required bridge 3: Interpret evidential value -> Explain assurance implications

- C5R-08
- C5R-09
- C5R-10
- C5R-11

Boundary guard (not included by design):

- Interpret evidence -> Determine audit response

This bridge is explicitly deferred to Volume 2.

## 13) Mapping Against Perform -> Interpret -> Evaluate

| Objective | Perform | Interpret | Evaluate |
|---|---|---|---|
| C5R-01 |  | X |  |
| C5R-02 |  | X |  |
| C5R-03 | X |  |  |
| C5R-04 | X | X |  |
| C5R-05 |  | X | X |
| C5R-06 |  | X | X |
| C5R-07 |  | X | X |
| C5R-08 |  |  | X |
| C5R-09 |  |  | X |
| C5R-10 |  | X | X |
| C5R-11 | X | X | X |
| C5R-12 |  | X |  |

Interpretation of progression balance:

- Perform is present but not dominant.
- Interpret is the heaviest layer.
- Evaluate is substantial and bounded to evidential conclusions.

## 14) Explicit Boundary Analysis

### Chapter 5 vs Chapter 6

Chapter 5 endpoint:

- evaluate expectation quality and deviation meaning for a modeled relationship.

Chapter 6 starting focus:

- interpret broader anomaly patterns and diagnostic evidence responsibly across contexts, including model/fit limitations that may not be central in Chapter 5 case structure.

Boundary rule:

- Chapter 5 centers expectation-consistency evidence construction.
- Chapter 6 centers anomaly interpretation breadth and robustness.

### Chapter 5 vs Volume 2 Chapter 1

Chapter 5 includes:

- assurance implications from statistical evidence.

Volume 2 Chapter 1 includes:

- selecting audit responses, additional procedures, and strategy implications.

Boundary rule:

- Chapter 5 can say "evidence appears weaker/stronger".
- Chapter 5 should not say "therefore perform procedure X" as a required student outcome.

### Chapter 5 vs Volume 2 Chapter 2

Chapter 5 includes:

- single-stream regression evidence evaluation and limits.

Volume 2 Chapter 2 includes:

- combining multiple evidence streams;
- determining sufficiency in integrated audit decision contexts;
- designing follow-up work where assurance is insufficient.

Boundary rule:

- Chapter 5 trains evidential interpretation discipline.
- Volume 2 operationalizes that discipline into consequential audit decisions.

## 15) Risks, Trade-offs, and Implementation Considerations

### Key risks

1. Over-correction risk: reducing technical fluency too much while boosting interpretation.
2. Assessment drift risk: assessments still reward computation over reasoning.
3. Boundary leakage risk: instructors prematurely require response decisions.
4. Cognitive-load risk for early-year learners if diagnostics are introduced without staged scaffolding.

### Trade-offs

1. Fewer standalone definitional objectives means more integrated assessment design is required.
2. More Analyze/Evaluate emphasis may reduce short-term grading simplicity.
3. One bounded Create objective increases communication authenticity but requires clear rubric design.

### Implementation considerations

1. Keep chapter text mostly intact; refactor objective framing and assessment prompts first.
2. Insert misconception-check prompts in workshop and review questions.
3. Add explicit "justified vs unjustified conclusion" checkpoint after expectation comparison.
4. Add instructor guidance on Volume 1/Volume 2 boundary language.
5. Validate LO-to-workshop and LO-to-review traceability after objective replacement.

## Success-Criteria Check

This redesign strengthens:

- curriculum progression clarity (Ch4 -> Ch5 -> Ch6 -> V2);
- expectation-setting identity;
- evidence-evaluation identity;
- bridge objectives;
- Statistical Reasoning center of gravity;
- explicit Perform -> Interpret -> Evaluate alignment.

It also keeps the chapter realistic for first-year and second-year bachelor students by limiting decision-level professional judgment expectations.
