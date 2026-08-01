# Regression Analysis Learning-Objective Architecture Redesign

Date: 2026-08-01
Branch: issue-251-regression-lo-redesign
Status: Design recommendation only
Scope: Chapter-level educational architecture redesign for Regression Analysis

## Executive Summary

Regression Analysis is the chapter where the current learning-objective architecture diverges most clearly from the educational philosophy of Volume 1.

The chapter itself already teaches regression as audit evidence: the manuscript case, chapter overview, and workshop progression all culminate in questions about reliability, expectation-setting, anomaly investigation, materiality, assurance, and audit conclusion. The current learning-objective architecture does not surface that design clearly enough. Instead, it overrepresents definitions, procedural substeps, and section-level statistical mechanics as if they were the primary chapter outcomes.

This review recommends replacing the current Chapter 5 architecture with a smaller chapter-level set of seven outcomes built around the progression:

Perform -> Interpret -> Evaluate

The proposed architecture preserves the substantive curriculum, preserves the case-based pedagogy, preserves the workshop progression, and aligns the visible learning outcomes with the actual educational purpose of the chapter: judging whether regression analysis provides reliable audit evidence.

## 1. Chapter 5 Educational Architecture Review

### 1.1 Authoritative grounding

This redesign is based on the following sources:

- docs/curriculum/learning-objective-authoring-standard.md
- docs/curriculum/educational-philosophy-vol1.md
- docs/curriculum/curriculum-decision-register.yml
- docs/curriculum/curriculum-decision-register-report.md
- docs/curriculum/lo-compliance-audit.md
- docs/traceability/regression-learning-objectives-review.md
- regression-analysis.tex
- notebooks/support/regression-analysis/support.Rmd
- review_questions.tex

### 1.2 Current chapter evidence

The chapter narrative is already more coherent than the current LO set suggests.

The manuscript frames regression as an analytical procedure for audit evidence, not merely as a statistical computation. The US SteamCo case objectives explicitly emphasize:

- assessing the strength and reasonableness of the relationship;
- identifying influential or unusual observations;
- developing expectations for the hold-out period;
- evaluating whether recorded revenue is consistent with expectations;
- determining the level of assurance obtained.

Those case objectives are closer to the desired educational architecture than the current learning-objective list.

The workshop sequence reinforces that same design. The exercise flow moves from data familiarization and model construction into diagnostics, model comparison, expectation-setting, and assurance evaluation. That is a Perform -> Interpret -> Evaluate learning pathway, even though the visible LO architecture still foregrounds remember-level outcomes.

### 1.3 Current objective inventory

Current Chapter 5 footprint:

- 18 active chapter-level learning objectives
- 9 retired legacy section-level learning objectives
- 27 total historical/current Chapter 5 LO records represented in metadata

Category legend:

- A: Foundational knowledge
- B: Technical execution
- C: Statistical interpretation
- D: Evidence evaluation
- E: Professional judgment

#### Active chapter-level objectives

| ID | Bloom | Competency | Apparent educational purpose | Category | Strengths | Weaknesses |
|---|---|---|---|---|---|---|
| LO-C5-01 | apply | technical_skills | introduces regression and its parts | A | establishes entry concept | compound, misclassified Bloom, definitional rather than outcome-oriented |
| LO-C5-02 | remember | technical_skills | names the purpose of regression in audit use | A | connects regression to audit evidence | still framed as identification, not capability |
| LO-C5-03 | remember | technical_skills | defines regression vocabulary | A | useful support terminology | low-value as independent chapter outcome |
| LO-C5-04 | remember | technical_skills | states classical assumptions | A | names conditions for validity | assumption recall is not a sufficient chapter endpoint |
| LO-C5-05 | remember | technical_skills | lists process steps | B | reflects workflow | procedural checklist framed as retained outcome |
| LO-C5-06 | understand | statistical_reasoning | explains when regression is suitable | C | starts to address appropriateness | stronger as evaluative judgment than explanation |
| LO-C5-07 | understand | statistical_reasoning | explains why assumptions and diagnostics matter | C | connects mechanics to evidence quality | still indirect and explanatory rather than applied |
| LO-C5-08 | understand | statistical_reasoning | explains model selection criteria | C | supports comparative reasoning | criterion mechanics overemphasized relative to audit use |
| LO-C5-09 | understand | statistical_reasoning | explains why unusual observations matter | C | aligns to audit interpretation | should likely be tied to investigation decisions |
| LO-C5-10 | apply | technical_skills | uses output, uncertainty, materiality against expectations | D | directly linked to audit expectation use | split between statistical and audit judgment without clarifying endpoint |
| LO-C5-11 | apply | technical_skills | fits models and interprets outputs | B | central technical capability | overloaded with multiple outcomes in one statement |
| LO-C5-12 | apply | technical_skills | applies diagnostics and tests assumptions | B | important model-validation skill | still tool/procedure centered |
| LO-C5-13 | analyze | statistical_reasoning | interprets relationships and unusual observations | C | meaning-focused and audit-relevant | overlaps substantially with LO-C5-09 and LO-C5-14 |
| LO-C5-14 | analyze | statistical_reasoning | examines model components to assess adequacy | D | good bridge from output to reliability | still partially organized around statistical artifacts |
| LO-C5-15 | evaluate | professional_judgment | evaluates whether model can be relied upon | E | strongly aligned to philosophy | should be a central architecture anchor |
| LO-C5-16 | evaluate | professional_judgment | assesses sufficiency for audit conclusion | E | explicitly judgment-centered | should be preserved conceptually |
| LO-C5-17 | create | professional_judgment | designs regression-based analytical procedure | B | authentic audit task | design intent is strong, but too detached from validation and conclusion chain |
| LO-C5-18 | create | professional_judgment | communicates results and limitations | E | authentic professional output | should be preserved conceptually |

#### Retired legacy section-level objectives

| ID | Section | Bloom | Apparent educational purpose | Category | Strengths | Weaknesses |
|---|---|---|---|---|---|---|
| LO-C5S5.1-01 | 5.1 | understand | define regression and components | A | aligned to introductory section | exact conceptual duplicate of LO-C5-01 |
| LO-C5S5.2-01 | 5.2 | understand | list assumptions | A | reflects validity concerns | section-grain checklist outcome |
| LO-C5S5.3-01 | 5.3 | apply | identify plotting and summary steps | B | ties to data exploration | too narrow to stand as chapter outcome |
| LO-C5S5.4-01 | 5.4 | apply | define linear regression structure | A | modeling entry point | definitional duplication at wrong grain size |
| LO-C5S5.5-01 | 5.5 | analyze | list diagnostic tools | B | points to diagnostics | tool inventory, not student capability |
| LO-C5S5.6-01 | 5.6 | understand | state ANOVA purpose | A | acknowledges inferential support | supportive concept, not a destination outcome |
| LO-C5S5.7-01 | 5.7 | analyze | identify model assumptions | A | reinforces inference conditions | duplicates assumption coverage again |
| LO-C5S5.8-01 | 5.8 | evaluate | recall model hypotheses | A | links to significance testing | Bloom mismatch and overly mechanical |
| LO-C5S5.9-01 | 5.9 | apply | state confidence/prediction interval definitions | A | touches expectations | definitional framing blocks audit-evidence use |

### 1.4 Current design counts

Active chapter-level Bloom distribution:

- Remember: 4
- Understand: 4
- Apply: 4
- Analyze: 2
- Evaluate: 2
- Create: 2

Active chapter-level competency distribution:

- Technical Skills: 8
- Statistical Reasoning: 6
- Professional Judgment: 4

Active chapter-level purpose distribution used in this review:

- Foundational knowledge: 4
- Technical execution: 4
- Statistical interpretation: 4
- Evidence evaluation: 2
- Professional judgment: 4

The counts look superficially balanced, but the architecture is not. The earlier objectives occupy the chapter's visible entry point and frame the chapter as a definitions-and-procedures unit. The later judgment-centered outcomes are stronger, but they appear as the end of a long list rather than as the chapter's organizing design.

## 2. Current vs Target Analysis: Critique of the Current Design

### 2.1 What the chapter is implicitly trying to teach

The chapter is implicitly trying to teach students how to use regression as audit evidence by moving through five broad judgments:

1. Is regression appropriate for this audit problem?
2. Can I build a model that represents the business relationship credibly?
3. Is the model statistically reliable enough to interpret?
4. Do the results and anomalies change what I believe about the recorded amounts?
5. Is the resulting evidence sufficient for an audit conclusion?

That implicit structure is strong.

### 2.2 What the current objective set appears to teach instead

The current objective set makes the chapter appear to be primarily about:

- definitions and terminology;
- assumptions as recall items;
- procedural steps and statistical subroutines;
- model mechanics split across section boundaries.

This is why the chapter looks more technique-driven in the LO layer than it actually is in the case, workshop, and later evaluative sections.

### 2.3 Structural weaknesses

#### Excessive emphasis on low-level outcomes

- 8 of 18 active chapter-level objectives are Remember or Understand.
- 12 of 18 are at Apply or below.
- Several of the lowest-level objectives are not threshold chapter outcomes but supporting knowledge or procedural subskills.

#### Too many definitional or checklist outcomes

The current set spends independent chapter-level slots on:

- purpose identification;
- terminology definition;
- assumption recall;
- step listing.

Those items have instructional value, but not enough educational value to remain headline chapter outcomes in a curriculum that prioritizes interpretation and evidence evaluation.

#### Wrong grain size

Objectives about ANOVA purpose, stepwise methods, diagnostic tool names, or listing steps in a workflow are at the wrong level of abstraction for chapter-level architecture. They belong as enabling knowledge inside broader capabilities.

#### Redundancy and fragmentation

There is repeated coverage of:

- definitions and model components;
- assumptions and assumption checking;
- unusual observations and their effects;
- expectations, intervals, and evaluation.

The LO set fragments these themes across multiple statements rather than presenting them as integrated capabilities.

#### Weakly surfaced professional judgment

The strongest Chapter 5 outcomes are the ones closest to the chapter's actual purpose:

- LO-C5-15
- LO-C5-16
- LO-C5-18

But those are not the architecture's organizing anchors. They arrive late, after the visible chapter identity has already been defined by lower-level content.

### 2.4 Objectives that add relatively little independent educational value

These objectives are better treated as supporting knowledge than chapter-level end states:

- LO-C5-01
- LO-C5-02
- LO-C5-03
- LO-C5-04
- LO-C5-05
- LO-C5S5.1-01
- LO-C5S5.2-01
- LO-C5S5.4-01
- LO-C5S5.5-01
- LO-C5S5.6-01
- LO-C5S5.8-01
- LO-C5S5.9-01

### 2.5 Objectives that are conceptually strongest

These are the most educationally valuable seeds for the redesign:

- LO-C5-06
- LO-C5-10
- LO-C5-13
- LO-C5-14
- LO-C5-15
- LO-C5-16
- LO-C5-17
- LO-C5-18

## 3. Chapter 5 Target Educational Model

### Chapter Purpose

Regression Analysis should teach students how to use regression modeling to evaluate whether statistical evidence supports an audit conclusion, not merely how to run regression procedures.

### Core Educational Question

When does a regression model provide audit evidence that is strong enough to support a conclusion, and when does it not?

### Desired Student Progression

The chapter should make the following progression explicit:

1. Perform a defensible regression-based analytical procedure.
2. Interpret what the model output and diagnostics mean.
3. Evaluate what conclusions are justified for audit purposes.

### Required Competencies

- Technical Skills: model construction, diagnostic execution, expectation generation.
- Statistical Reasoning: interpretation of fit, assumptions, residual behavior, uncertainty, and alternative explanations.
- Professional Judgment: deciding whether the evidence is suitable, sufficient, and appropriately communicated.

### Expected Assessment Evidence

A successful student should be able to produce evidence such as:

- a documented regression-based analytical procedure design;
- a fitted model with diagnostics and justified modeling choices;
- an interpretation of model output in business terms;
- an analysis of unusual observations or model weaknesses;
- an evaluation of whether recorded amounts are consistent with expectations;
- an audit-style conclusion about evidence sufficiency and limitations;
- a concise professional communication of the result.

### Required Capability Areas

- appropriateness of regression for the audit problem;
- model construction and validation;
- interpretation of statistical output in business context;
- investigation of anomalies and model threats;
- evaluation of expectation consistency and evidential sufficiency;
- communication of conclusion and limitations.

## 4. Chapter 5 Target Learning Objective Architecture

Recommended target objective count: 7

This is intentionally smaller than the current 18 active chapter-level objectives. The goal is not compression for its own sake; it is architectural clarity.

| Proposed objective | Bloom | Primary competency | Supports stage | Rationale |
|---|---|---|---|---|
| Construct a regression-based analytical procedure for an audit objective by selecting relevant data, variables, estimation design, and decision criteria. | create | technical_skills | Perform | elevates design from checklist to authentic analytical setup |
| Apply model-fitting, diagnostic, and assumption checks to produce a regression model suitable for statistical inference and expectation-setting. | apply | technical_skills | Perform | keeps execution visible but clearly subordinate to evidential use |
| Interpret regression coefficients, fit measures, and residual behavior in terms of the underlying business relationship and the limits of the model. | analyze | statistical_reasoning | Interpret | turns output reading into meaning-making rather than statistic naming |
| Analyze unusual observations and model instability to determine how they affect the reliability of the regression evidence. | analyze | statistical_reasoning | Interpret | integrates diagnostics, outliers, leverage, and multicollinearity into one capability |
| Evaluate whether regression analysis is an appropriate source of audit evidence for the problem at hand, given business plausibility, data quality, and model limitations. | evaluate | professional_judgment | Evaluate | makes appropriateness a professional decision rather than an explanatory footnote |
| Evaluate whether model-based expectations, prediction uncertainty, and materiality support the conclusion that recorded amounts are consistent with audit expectations. | evaluate | professional_judgment | Evaluate | directly reflects the chapter's case objective and audit use of regression |
| Communicate the evidential conclusion, limitations, and required follow-up actions from a regression analysis in a form suitable for audit documentation and professional discussion. | create | professional_judgment | Evaluate | preserves the authentic output expected from an auditor |

### Why this architecture is preferable

- it is chapter-level rather than section-level;
- each objective has one dominant observable action;
- it avoids definitional objectives as headline outcomes;
- it makes audit evidence evaluation, not computation, the chapter's visible purpose;
- it reflects what the case and workshop already ask students to do.

## 5. Alignment with Educational Philosophy

### Perform -> Interpret -> Evaluate mapping

#### Perform

- Objective 1: Construct a regression-based analytical procedure
- Objective 2: Apply model-fitting, diagnostic, and assumption checks

#### Interpret

- Objective 3: Interpret coefficients, fit, and residual behavior
- Objective 4: Analyze unusual observations and model instability

#### Evaluate

- Objective 5: Evaluate whether regression is appropriate evidence
- Objective 6: Evaluate whether expectations and uncertainty support the conclusion
- Objective 7: Communicate the evidential conclusion and limitations

### Balance assessment

The target architecture intentionally shifts the visible center of gravity:

- away from recall and terminology;
- away from section-local procedures as independent outcomes;
- toward interpretation, reliability, evidential judgment, and professional communication.

That better reflects the philosophy of Volume 1:

- students do not stop at output;
- students do not move straight from calculations to audit conclusions without interpretation;
- students are expected to reason about what the evidence does and does not support.

## 6. Current vs Target Analysis

### Current architecture

- Historical/current Chapter 5 LO footprint: 27 records
- Current active chapter-level objective count: 18
- Current Bloom distribution: Remember 4, Understand 4, Apply 4, Analyze 2, Evaluate 2, Create 2
- Current competency distribution: Technical Skills 8, Statistical Reasoning 6, Professional Judgment 4

Major weaknesses:

- too many low-value foundational outcomes;
- wrong grain size for chapter-level architecture;
- professional judgment appears too late and too weakly as organizing purpose;
- visible architecture does not match the chapter's actual case-driven learning design.

### Target architecture

- Recommended objective count: 7
- Recommended Bloom distribution: Apply 1, Analyze 2, Evaluate 2, Create 2
- Recommended primary competency distribution: Technical Skills 2, Statistical Reasoning 2, Professional Judgment 3

Expected strengths:

- clearer student-facing identity;
- explicit alignment to audit-evidence use;
- stronger progression from doing to interpreting to judging;
- easier traceability to case-based assessment evidence;
- fewer redundant or definition-only objectives.

### Disposition guidance

#### Objectives to retire conceptually

- LO-C5-01
- LO-C5-02
- LO-C5-03
- LO-C5-04
- LO-C5-05
- all retired legacy section-level objectives as independent architecture elements

#### Objectives to merge or absorb

- LO-C5-07 into model-reliability and evidential-appropriateness capabilities
- LO-C5-08 into model interpretation and comparison capabilities
- LO-C5-09 into anomaly analysis capability
- LO-C5-11 and LO-C5-12 into performance/model-validation capabilities
- LO-C5-13 and LO-C5-14 into interpretation and evidence-reliability capabilities

#### Objectives to preserve conceptually, but not necessarily verbatim

- LO-C5-06
- LO-C5-10
- LO-C5-15
- LO-C5-16
- LO-C5-17
- LO-C5-18

#### Objectives to replace rather than preserve

- all existing objectives whose main value is definition, naming, or step-list recall

## 7. Traceability Impact

This phase does not implement traceability changes. It identifies redesign implications only.

### Chapter content

The chapter content can support the target architecture without structural rewrite. The manuscript already clusters naturally into:

- appropriateness and design;
- model construction and diagnostics;
- interpretation of output and anomalies;
- expectations and evaluation;
- assurance and conclusion.

### Workshops

The regression workshop already provides strong support for the target architecture. The 36 existing exercises can be remapped from the current 18-objective structure to the proposed 7-objective architecture.

Expected remapping pattern:

- Exercises 5.2-5.10 primarily support Objectives 1-3
- Exercises 5.11-5.18 primarily support Objective 4
- Exercises 5.19-5.30 support Objectives 2-5
- Exercises 5.31-5.36 support Objectives 6-7

### Case study

The US SteamCo case is already the strongest alignment anchor for the target architecture. Its stated objectives are effectively a prototype of the redesigned LO architecture.

### Review questions

There is currently no populated Regression Analysis review-question content in review_questions.tex. That means future traceability work will require either:

- creation of chapter-level review questions for Regression Analysis; or
- an explicit governance decision accepting workshop-only traceability for some outcomes.

## 8. Migration Recommendation

### Phase A: Design approval

- review and approve the target architecture as the intended educational model for Regression Analysis;
- confirm that the chapter is judged primarily by evidential reasoning outcomes, not definitional completeness.

### Phase B: LO replacement

- replace the current active Chapter 5 LO set with the proposed chapter-level target set;
- ensure the student-facing chapter display presents only the redesigned architecture.

### Phase C: Bloom review

- validate Bloom assignments for the new set against assessment evidence;
- confirm that no objective is carrying hidden multiple primary actions.

### Phase D: Competency review

- review primary competency assignments against the fixed three-competency model;
- use multiple primaries only if a target objective truly requires them.

### Phase E: Traceability remapping

- remap workshop exercises from the current 18-objective structure to the new 7-objective architecture;
- create or explicitly defer review-question coverage;
- preserve ID governance and migration traceability decisions.

### Phase F: Compliance re-audit

- re-run the LO compliance audit after replacement and remapping;
- confirm reductions in LO-001, LO-004, LO-007, LO-012, and Chapter 5-specific structural findings.

## 9. Risk Assessment

1. If the chapter adopts the new architecture without traceability remapping, the LO layer and metadata layer will diverge.
2. If the chapter preserves too many current objectives "for continuity," the redesign will collapse back into a procedural checklist model.
3. If no Chapter 5 review-question content is created later, higher-order evaluative objectives may remain under-assessed outside the workshop pathway.
4. If the redesign is interpreted as eliminating technical skills, the chapter could overcorrect; the target model still requires strong performance skills, but as supporting means rather than visible endpoints.

## 10. Executive Recommendation

Adopt the target architecture and replace the current Chapter 5 LO set rather than attempting incremental cleanup.

The chapter already contains the right educational substance. The redesign challenge is architectural, not cosmetic.

The most defensible direction is:

- fewer chapter-level objectives;
- no definitional objectives as headline outcomes;
- explicit progression from model construction to interpretation to audit judgment;
- visible emphasis on reliability, uncertainty, sufficiency, and conclusion.

In short: Regression Analysis should be presented to students not as a chapter about running regression, but as a chapter about deciding when regression provides trustworthy audit evidence.