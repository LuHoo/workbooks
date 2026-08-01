# Chapter 5 Educational Architecture Review and Redesign (2026-08-01)

Status: Design proposal only (no implementation)
Scope: Chapter 5 (Regression Analysis), Volume 1

## 1. Chapter 5 Educational Architecture Review (Current State)

### 1.1 Evidence base used

- Policy and philosophy:
  - docs/curriculum/educational-philosophy-vol1.md
  - docs/curriculum/learning-objective-authoring-standard.md
  - docs/curriculum/curriculum-decision-register.yml
  - docs/curriculum/curriculum-decision-register-report.md
  - docs/curriculum/curriculum-baseline-audit-2026-08-01.md
  - docs/curriculum/volume1-bloom-competency-sanity-check.md
- Current Chapter 5 artifacts:
  - regression-analysis.tex
  - notebooks/support/regression-analysis/support.Rmd
  - review_questions.tex
  - metadata/traceability/learning_objectives.yml
  - metadata/traceability/lo_to_workshop.yml
  - metadata/traceability/lo_to_review.yml

### 1.2 Current Chapter 5 objective inventory

Current active chapter-level objectives: 18 (LO-C5-01 to LO-C5-18).

Current Bloom distribution:
- Remember: 4
- Understand: 4
- Apply: 4
- Analyze: 2
- Evaluate: 2
- Create: 2

Current competency distribution:
- Technical Skills: 8
- Statistical Reasoning: 6
- Professional Judgment: 4

### 1.3 Objective-by-objective critique

| Objective | Educational purpose | Bloom | Competency | Strengths | Weaknesses |
|---|---|---|---|---|---|
| LO-C5-01 | Define regression components | Apply | Technical Skills | Clear foundational scope | Bloom appears overstated for mostly definitional demand; overlaps LO-C5-03 |
| LO-C5-02 | Explain regression purpose in substantive procedures | Remember | Technical Skills | Links to expectation/residual/uncertainty language | Bloom understated for explanatory demand; competency should be Statistical Reasoning-led |
| LO-C5-03 | Define key terms (residual, leverage, Cook, VIF, etc.) | Remember | Technical Skills | Necessary vocabulary foundation | Overloaded term list; could separate core vs advanced terms by progression stage |
| LO-C5-04 | State classical assumptions | Remember | Technical Skills | Strong base for diagnostics | Assumption statements alone do not ensure interpretation of implications |
| LO-C5-05 | List end-to-end steps of regression procedure | Remember | Technical Skills | Provides process map | Procedural recall only; does not require interpretation quality controls |
| LO-C5-06 | Explain suitability of regression for audit problem | Understand | Statistical Reasoning | Good relevance to data and relationship plausibility | Still audit-framed; should center expectation-setting before audit-sufficiency framing |
| LO-C5-07 | Explain why assumptions/diagnostics/data quality matter | Understand | Statistical Reasoning | Strong conceptual bridge | Very broad; difficult to assess reliably as written |
| LO-C5-08 | Describe role of R2/adjusted R2/information criteria | Understand | Statistical Reasoning | Includes key model-comparison metrics | Should explicitly bound comparisons to same response and explain trade-offs |
| LO-C5-09 | Explain effects of outliers/influence diagnostics | Understand | Statistical Reasoning | Targets an important reliability risk | Mixes concept, detection, and audit conclusion language in one objective |
| LO-C5-10 | Use output/uncertainty/materiality for consistency assessment | Apply | Technical Skills | Captures central applied chapter question | Needs clearer separation between statistical consistency assessment vs audit decision |
| LO-C5-11 | Fit simple/multiple models and interpret outputs | Apply | Technical Skills | Core Perform capability | Too many sub-outcomes in one objective (fit + interpret + multiple output families) |
| LO-C5-12 | Apply diagnostics/tests for assumptions | Apply | Technical Skills | Directly assessable procedural capability | Aggregates distinct diagnostic domains without explicit interpretation consequences |
| LO-C5-13 | Interpret relationships/unusual observations in business terms | Analyze | Statistical Reasoning | Strong interpretive orientation | Includes audit risk language that may invite premature Volume 2 drift |
| LO-C5-14 | Examine coefficients, ANOVA, residual plots for adequacy | Analyze | Statistical Reasoning | Good synthesis of model components | Model adequacy criteria remain implicit; can create inconsistent assessment expectations |
| LO-C5-15 | Evaluate whether model can be relied upon as audit evidence | Evaluate | Professional Judgment | Explicit evaluative stance | Violates intended Volume 1/Volume 2 boundary by making evidence-reliance decision central |
| LO-C5-16 | Assess sufficiency of regression evidence for audit conclusion | Evaluate | Professional Judgment | High-level evidence focus | Engagement-level sufficiency decision belongs primarily in Volume 2 |
| LO-C5-17 | Design full regression-based audit procedure | Create | Professional Judgment | Integrative planning capability | Too advanced for Volume 1; shifts toward audit procedure design |
| LO-C5-18 | Communicate results, limitations, audit implications | Create | Professional Judgment | Communication emphasis is educationally useful | Audit implication framing too close to decision-level ownership expected in Volume 2 |

### 1.4 Structural findings

Redundancy:
- LO-C5-01 and LO-C5-03 overlap on definitional scope.
- LO-C5-07 and LO-C5-12 overlap on assumptions/diagnostics without explicit role separation.

Over-fragmentation:
- Some objectives are too narrow and definitional (list/state/define) while others are too compound (fit + interpret + diagnose + conclude).

Missing capabilities:
- Explicit interpretation of prediction uncertainty at monthly vs aggregated expectation level.
- Explicit sensitivity reasoning (how specification and influence treatment shift expectations).
- Explicit boundary statement of what Chapter 5 conclusions can and cannot claim.

Misplaced objectives (Volume 1 vs Volume 2 boundary):
- LO-C5-15, LO-C5-16, LO-C5-17 are primarily decision-oriented in an engagement sense and should not anchor a Bachelor-level expectation-setting chapter.

### 1.5 Current architecture diagnosis

Current Chapter 5 is content-rich in manuscript/workshop, but objective architecture is mixed:
- It starts with useful foundations.
- It develops strong modeling and diagnostics activities.
- It then crosses the boundary into audit decision ownership too early.

The chapter already contains the right technical and interpretive raw material, but objective framing should be shifted to expectation-setting and statistical interpretation.

## 2. Chapter 5 Redesign Proposal (Educational Architecture)

### 2.1 Chapter Purpose

Chapter 5 develops students' ability to build, interpret, and diagnose regression models as expectation-setting tools, and to evaluate whether recorded revenue figures are statistically consistent with model-based expectations under explicit uncertainty.

### 2.2 Core Educational Question

Are the recorded revenue figures consistent with expectations?

### 2.3 Learning progression

1. Perform (technical construction):
- prepare data, fit models, produce model outputs, and compute diagnostic evidence.

2. Interpret (statistical meaning):
- interpret coefficients, fit metrics, diagnostics, assumptions, and prediction uncertainty.

3. Evaluate (bounded statistical judgment):
- evaluate consistency/inconsistency with expectations and communicate limitations of what can be concluded statistically.

### 2.4 Required competencies

Primary competency: Statistical Reasoning

Supporting competency: Technical Skills

Limited competency presence: Professional Judgment (only for bounded communication of evidence limits; not for audit strategy/procedure decisions).

### 2.5 Assessment evidence model

Students should produce evidence in four forms:
- Correct model execution artifacts (code, model summaries, diagnostics).
- Interpretation artifacts (narrative explanations of outputs and diagnostic implications).
- Expectation-comparison artifacts (recorded vs expected with uncertainty bounds).
- Boundary-aware conclusions (what results indicate statistically; what they do not justify at engagement level).

### 2.6 Relationship to Volume 2

Inside Chapter 5 (Volume 1):
- fit and compare regression models;
- assess assumptions and diagnostics;
- interpret expected values and deviations;
- evaluate model limitations and uncertainty.

Outside Chapter 5 (Volume 2):
- determine evidence sufficiency for engagement conclusion;
- decide additional audit procedures;
- set audit strategy or reliance decisions.

## 3. Proposed Learning Objective Set (Target Architecture)

Design notes:
- Chapter-level only.
- Aligned to the Learning Objective Authoring Standard.
- Optimized for educational coherence, not numeric symmetry.
- Definitional objectives retained but bounded.

### 3.1 Proposed objective table

| Proposed ID | Objective text | Bloom | Primary competency | Secondary competency | Progression tag | Rationale |
|---|---|---|---|---|---|---|
| C5R-01 | Define regression analysis as an expectation-setting method for relating recorded outcomes to explanatory drivers. | remember | statistical_reasoning | technical_skills | Interpret | Establishes conceptual frame and prevents tool-as-end misunderstanding. |
| C5R-02 | Define core regression terms used in the chapter, including fitted value, residual, prediction interval, leverage, and influence. | remember | technical_skills | statistical_reasoning | Perform | Preserves vocabulary foundation needed for later diagnostics and interpretation. |
| C5R-03 | Explain why the central question for Chapter 5 is whether recorded revenue is consistent with model-based expectations. | understand | statistical_reasoning | technical_skills | Interpret | Anchors all chapter activities to one recurring educational question. |
| C5R-04 | Explain how estimation-set and hold-out design supports valid expectation testing in regression workflows. | understand | statistical_reasoning | technical_skills | Interpret | Makes data partition logic explicit rather than procedural folklore. |
| C5R-05 | Explain the key regression assumptions and how each assumption affects interpretation of model output and uncertainty. | understand | statistical_reasoning | technical_skills | Interpret | Links assumptions directly to meaning, not only checklist compliance. |
| C5R-06 | Explain when alternative specifications are educationally useful in Volume 1 and when advanced model engineering should be deferred. | understand | statistical_reasoning | professional_judgment | Evaluate | Clarifies scope boundary for model refinement in Bachelor-level context. |
| C5R-07 | Prepare regression-ready data, including variable construction, partitioning, and basic quality checks. | apply | technical_skills | statistical_reasoning | Perform | Captures practical readiness without expanding into advanced data engineering. |
| C5R-08 | Fit simple and multiple linear regression models in software and extract key output for interpretation. | apply | technical_skills | statistical_reasoning | Perform | Core operational model-building capability. |
| C5R-09 | Construct and report confidence and prediction intervals for model-based expectations at observation and aggregate levels. | apply | technical_skills | statistical_reasoning | Perform | Builds explicit prediction-uncertainty capability central to expectation-setting. |
| C5R-10 | Compute and interpret residual diagnostics to check linearity, variance behavior, and distributional plausibility. | apply | technical_skills | statistical_reasoning | Perform | Gives residual analysis independent operational status. |
| C5R-11 | Compute leverage and influence diagnostics and identify observations requiring contextual follow-up. | apply | technical_skills | statistical_reasoning | Perform | Gives influence analysis independent operational status. |
| C5R-12 | Compute VIF or adjusted GVIF metrics and determine whether multicollinearity is likely to impair coefficient interpretation. | apply | technical_skills | statistical_reasoning | Perform | Gives multicollinearity independent operational status. |
| C5R-13 | Interpret regression coefficients, interaction terms, and lag terms in the context of expected revenue behavior. | analyze | statistical_reasoning | technical_skills | Interpret | Emphasizes meaning of model structure in business context. |
| C5R-14 | Compare model fit and parsimony using R2, adjusted R2, and information criteria for models fitted to comparable response data. | analyze | statistical_reasoning | technical_skills | Interpret | Retains model selection metrics with correct comparability constraints. |
| C5R-15 | Analyze how diagnostic findings and specification changes alter expectation precision and deviation interpretation. | analyze | statistical_reasoning | technical_skills | Interpret | Integrates diagnostics with expectation consequences, not isolated checks. |
| C5R-16 | Analyze whether observed deviations are statistically unusual given prediction uncertainty and stated thresholds. | analyze | statistical_reasoning | technical_skills | Interpret | Directly supports the chapter’s central educational question. |
| C5R-17 | Analyze model limitations and unresolved uncertainty to determine the strength and limits of statistical conclusions. | analyze | statistical_reasoning | professional_judgment | Evaluate | Keeps judgment bounded to statistical interpretation rather than audit action decisions. |
| C5R-18 | Evaluate whether recorded revenue observations are statistically consistent or inconsistent with model-based expectations. | evaluate | statistical_reasoning | technical_skills | Evaluate | Defines the endpoint of Volume 1 Chapter 5 evaluation. |
| C5R-19 | Evaluate and communicate what the regression analysis supports and what it does not support without making engagement-level audit decisions. | evaluate | professional_judgment | statistical_reasoning | Evaluate | Provides limited, explicit Professional Judgment while preserving Volume 2 boundary. |

### 3.2 Diagnostic design decisions and justification

Residual analysis:
- Independent objective (C5R-10).
- Justification: residual behavior is foundational for assumption interpretation and cannot be treated as a minor sub-step.

Influential observations:
- Independent objective (C5R-11).
- Justification: influence affects stability of fitted relationships and expectation intervals directly.

Multicollinearity:
- Independent objective (C5R-12).
- Justification: coefficient interpretability and variance inflation require explicit treatment, especially with interaction terms.

Assumption testing:
- Integrated between C5R-05 (conceptual assumptions) and C5R-10/C5R-15 (operational and consequence analysis).
- Justification: avoids fragmented checklist objectives while preserving conceptual and applied depth.

Model specification:
- Integrated across C5R-06, C5R-14, C5R-15.
- Justification: specification should be learned as a constrained comparative reasoning activity, not as open-ended model engineering.

### 3.3 Model selection and alternative specifications

R2 and adjusted R2:
- Included explicitly (C5R-14).
- Reason: they are core interpretive tools in current manuscript/workshop and important for explaining explanatory strength vs complexity.

Information criteria (AIC/BIC):
- Included explicitly (C5R-14).
- Reason: useful for disciplined comparison among candidate models in Volume 1 when comparability constraints are clear.

Alternative specifications:
- Included in constrained form (C5R-06, C5R-14, C5R-15).
- Reason: students should compare plausible alternatives and interpret consequences.
- Boundary: no requirement to perform advanced feature engineering or optimization-heavy selection strategies.

## 4. Bloom and Competency Analysis (Target)

### 4.1 Target Bloom profile

Proposed distribution (19 objectives):
- Remember: 2
- Understand: 4
- Apply: 6
- Analyze: 5
- Evaluate: 2
- Create: 0

Interpretation:
- Remember is present and appropriate for definitional grounding.
- Understand is substantial enough to support meaning-making before execution.
- Apply plus Analyze dominates, which fits model-building plus diagnostics interpretation.
- Evaluate remains present but bounded to statistical consistency judgments.
- No forced Create objective is introduced; this avoids artificial complexity and premature shift into Volume 2 responsibilities.

### 4.2 Target competency profile

Proposed distribution:
- Statistical Reasoning primary: 10
- Technical Skills primary: 8
- Professional Judgment primary: 1

Interpretation:
- Statistical Reasoning is dominant, as required.
- Technical Skills remain strongly represented as enabling capability.
- Professional Judgment is limited and explicitly boundary-controlled.

### 4.3 Architecture-level checks

Is Remember appropriately represented?
- Yes. Two foundational objectives preserve terminology and conceptual orientation.

Is Understand sufficiently represented?
- Yes. Four objectives establish conceptual coherence (question framing, assumptions, partition logic, specification scope).

Is Statistical Reasoning dominant?
- Yes. It is the largest primary competency category in the target set.

Does the architecture support expectation-setting?
- Yes. Objectives repeatedly target expected values, uncertainty bounds, and consistency judgments.

Does the architecture avoid premature Volume 2 transition?
- Yes. Objectives avoid engagement-level sufficiency and procedure-selection decisions.

## 5. Current vs Target Comparison

| Dimension | Current Chapter 5 | Proposed Chapter 5 |
|---|---|---|
| Objective count | 18 | 19 |
| Bloom profile | R4 U4 A4 An2 E2 C2 | R2 U4 A6 An5 E2 C0 |
| Competency profile | TS8 SR6 PJ4 | TS8 SR10 PJ1 |
| Dominant chapter narrative | Mixed: expectation-setting plus audit-reliance decisions | Expectation-setting and statistical interpretation |
| Boundary alignment (Vol 1/Vol 2) | Partial; several objectives drift into Volume 2 | Strong; explicit boundary guardrails |
| Diagnostic coverage design | Present but unevenly bundled | Explicit and coherent (residual, influence, collinearity, assumptions consequences) |
| Model selection treatment | Present | Retained with comparability constraints and scope limits |
| Educational coherence | Moderate | High (single recurring question and progression logic) |

## 6. Traceability Impact Assessment (Analysis Only)

### 6.1 Workshop impact

Evidence indicates very strong Chapter 5 workshop coverage already exists in the support notebook and workshop mappings.

Impact assessment:
- Most proposed Perform/Interpret objectives can be mapped to existing exercises with limited refactoring.
- Main work is remapping and re-bundling exercise evidence around new objective boundaries.
- Highest mapping complexity expected for C5R-15 to C5R-19 (integrated interpretation and bounded evaluation statements).

### 6.2 Review-question impact

Current state observation:
- No explicit Chapter 5 objective-to-review mappings are present in metadata/traceability/lo_to_review.yml.
- review_questions.tex currently does not contain substantive Chapter 5 review-question content.

Impact assessment:
- Chapter 5 review-question layer requires substantial authoring and mapping uplift to support balanced objective evidence.
- This is the largest traceability gap for migration and should be treated as priority follow-up after objective approval.

### 6.3 Content impact

Manuscript content impact (analysis only):
- Keep most technical and diagnostic sections.
- Reframe chapter purpose text away from audit-evidence reliance decisions and toward expectation interpretation.
- Reframe evaluation section to statistical consistency and uncertainty communication boundaries.

Workshop content impact (analysis only):
- Keep majority of exercises.
- Add clearer prompts that explicitly distinguish:
  - statistical consistency judgments;
  - uncertainty and model limitation statements;
  - non-permitted engagement-level audit decisions.

### 6.4 Migration impact

Metadata migration:
- Retire/supersede LO-C5-01 to LO-C5-18 after governance approval.
- Introduce C5R-01 to C5R-19 in learning_objectives.yml (future implementation step, not executed here).

Mapping migration:
- Re-map workshop links from legacy objective IDs to target IDs.
- Create Chapter 5 review-question entities and objective mappings.

Validation migration:
- Re-run LO rule checks and traceability checks after metadata changes.
- Expect temporary needs-review states during staged remapping.

## 7. Migration Recommendation

Recommended sequence:

1. Governance approval:
- Approve Chapter 5 target architecture and objective set as policy-aligned redesign baseline.

2. Metadata implementation phase:
- Add target objectives and stage retirement aliases for current Chapter 5 objectives.

3. Workshop remapping phase:
- Re-map existing workshop exercise links to target objective IDs.

4. Review-question build phase:
- Author Chapter 5 review questions intentionally aligned to C5R-13 through C5R-19.
- Add objective mappings in lo_to_review.yml.

5. Manuscript reframing phase:
- Update purpose/evaluation language to expectation-setting boundaries.

6. Validation and re-audit phase:
- Run deterministic validation and publish updated chapter-level traceability report.

## 8. Executive Recommendation

Approve the Chapter 5 redesign architecture with the proposed 19-objective set.

Rationale:
- It preserves foundational definitions without allowing terminology to dominate.
- It makes Statistical Reasoning the center of gravity while retaining required Technical Skills.
- It keeps Professional Judgment present but limited.
- It aligns strongly with Volume 1 purpose and protects Volume 2 decision responsibilities.
- It directly supports the chapter question: Are the recorded revenue figures consistent with expectations?

Final educational outcome:
- Students can build, interpret, diagnose, and understand regression models as expectation-setting tools, and can reason correctly about what the statistical output means.
