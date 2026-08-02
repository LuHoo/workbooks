# Hypothesis Testing Redesign (Volume 1, Bachelor Level)

Date: 2026-08-02
Status: Architecture and objective redesign proposal (no implementation)
Scope: Volume 1 chapter on Hypothesis Testing (substantive sampling and MUS)

## 1. Assessment of current chapter purpose

Current chapter purpose (as implemented) is mixed but coherent:
- introduce statistical hypothesis testing in auditing contexts;
- apply the nine-step testing workflow;
- teach attribute sampling and Monetary Unit Sampling (MUS);
- connect sampling outcomes to audit-oriented interpretation.

The chapter already functions as a practical bridge between foundational estimation chapters and later model-based chapters.

Current strengths:
- clear technical workflow (nine-step approach);
- explicit treatment of Type I/Type II error, significance, critical regions, and confidence bounds;
- rich MUS examples including partial errors and sample-size logic;
- strong workshop execution support.

Current tension:
- several learning objectives frame end-state as audit decision ownership rather than statistical interpretation ownership, which is too advanced for this chapter’s intended role in Volume 1.

## 2. Assessment of alignment with educational philosophy

Educational philosophy target:
- Perform -> Interpret -> Evaluate
- Technical Skills -> Statistical Reasoning -> Professional Judgment
- Professional Judgment in Volume 1 is limited and should not become engagement-level response design.

Current alignment assessment:
- Perform: strong
- Interpret: moderate
- Evaluate: partially mispositioned

Why:
- the chapter content itself contains strong interpretive material (uncertainty, confidence levels, fail-to-reject logic, limitations);
- current objective architecture still gives substantial weight to Professional Judgment outcomes that imply audit response and procedure design;
- this creates a mismatch between intended chapter level and objective end-state.

## 3. Identification of current weaknesses

1. Boundary drift into Volume 2 responsibilities:
- current objectives include language about determining whether audit objectives have been met and designing MUS procedures as if engagement-level ownership is expected.

2. Misconception handling is under-explicit in objectives:
- p-value interpretation limits and fail-to-reject interpretation are discussed in content but not consistently foregrounded as objective-level outcomes.

3. Overemphasis on procedural accomplishment:
- execution outcomes are explicit; evidential meaning outcomes are present but not dominant enough.

4. Objective quality inconsistencies:
- objective LO-C4-01 in metadata is currently cross-chapter/misaligned text (auxiliary variables and stratification), indicating architecture-level quality drift.

5. Bridge design under-specified:
- transfer function to Regression Analysis and Goodness of Fit exists in prose but is not fully operationalized in objective language.

## 4. Recommended chapter positioning statement

Recommended positioning statement:

Hypothesis Testing is the substantive sampling interpretation chapter of Volume 1. Students learn to execute hypothesis tests and MUS procedures, but the primary educational endpoint is to interpret what test outcomes mean, quantify uncertainty, and state defensible evidence-limited conclusions without making full audit-response decisions.

## 5. Recommended chapter narrative arc

Narrative arc (retain existing structure; shift emphasis):

1. Why hypothesis testing for auditors:
- from estimation to decision-under-uncertainty.

2. Technical execution foundation:
- nine-step method, critical region, significance, sample size, and MUS mechanics.

3. Statistical interpretation core:
- p-values, Type I/Type II trade-offs, non-significant outcomes, uncertainty communication, and evidential limits.

4. Bounded evaluation:
- what can be concluded from test evidence;
- what cannot be concluded yet;
- explicit handoff to later chapters and Volume 2 for response decisions.

## 6. Recommended Bloom profile

Recommended Bloom profile (target set of 16 objectives):
- Remember: 3
- Understand: 4
- Apply: 4
- Analyze: 3
- Evaluate: 2
- Create: 0

Rationale:
- preserves foundational terminology and test mechanics;
- visibly increases interpretation density relative to procedural-only framing;
- retains bounded evaluation;
- avoids forcing Create-level objectives that imply premature professional decision ownership.

## 7. Recommended competency profile

Recommended competency profile (primary competency per objective):
- Statistical Reasoning: 10
- Technical Skills: 5
- Professional Judgment: 1

Rationale:
- Statistical Reasoning is the center of gravity for this chapter;
- Technical Skills remain substantial because execution quality is required;
- Professional Judgment remains intentionally limited and boundary-controlled.

## 8. Complete redesigned chapter-level learning objectives

Design constraints applied:
- chapter-level only;
- content continuity with current chapter and workshop;
- stronger interpretation orientation;
- no shift of engagement-level audit response responsibilities into this chapter.

| Proposed ID | Objective text | Bloom | Primary competency | Secondary competency |
|---|---|---|---|---|
| HT-01 | Define the purpose of statistical hypothesis testing in substantive sampling and MUS contexts. | remember | technical_skills | statistical_reasoning |
| HT-02 | Define and distinguish null hypothesis, alternative hypothesis, significance level, p-value, critical region, and one-sided confidence bound. | remember | technical_skills | statistical_reasoning |
| HT-03 | Distinguish Type I error, Type II error, and test power in terms of evidential risk. | remember | statistical_reasoning | technical_skills |
| HT-04 | Explain how sample size, significance level, tolerable misstatement, expected error, and critical region jointly affect test design. | understand | statistical_reasoning | technical_skills |
| HT-05 | Explain when attribute testing and MUS are appropriate and what types of conclusions each can support. | understand | statistical_reasoning | technical_skills |
| HT-06 | Explain why p-values do not prove hypotheses and why failure to reject does not imply acceptance of the null hypothesis. | understand | statistical_reasoning |  |
| HT-07 | Explain the assumptions and validity conditions required for interpreting hypothesis-test outcomes in this chapter. | understand | statistical_reasoning | technical_skills |
| HT-08 | Compute required sample size and critical-region specifications for stated sampling scenarios. | apply | technical_skills | statistical_reasoning |
| HT-09 | Execute attribute-sampling hypothesis tests and compute decision quantities using critical-region, p-value, and confidence-bound approaches. | apply | technical_skills | statistical_reasoning |
| HT-10 | Execute MUS selection and evaluation procedures for 100 percent and partial-error settings using appropriate evaluation methods. | apply | technical_skills | statistical_reasoning |
| HT-11 | Apply structured uncertainty communication to report test outcomes using confidence language and explicit error-risk framing. | apply | statistical_reasoning | technical_skills |
| HT-12 | Analyze how alternative design choices (alpha, critical region width, expected error, and selection method) change inferential outcomes. | analyze | statistical_reasoning | technical_skills |
| HT-13 | Analyze non-significant outcomes to distinguish insufficient evidence from evidence of no material misstatement. | analyze | statistical_reasoning | technical_skills |
| HT-14 | Compare sampling-selection methods in terms of statistical behavior, practical feasibility, and interpretation consequences. | analyze | statistical_reasoning | technical_skills |
| HT-15 | Evaluate whether observed test results support a conclusion of statistical consistency with the stated misstatement threshold, including explicit limitations. | evaluate | statistical_reasoning | professional_judgment |
| HT-16 | Evaluate and communicate what the chapter’s hypothesis-test evidence supports and does not support, without prescribing audit-response actions. | evaluate | professional_judgment | statistical_reasoning |

## 9. Bloom classification for each learning objective

Bloom mapping:
- Remember: HT-01, HT-02, HT-03
- Understand: HT-04, HT-05, HT-06, HT-07
- Apply: HT-08, HT-09, HT-10, HT-11
- Analyze: HT-12, HT-13, HT-14
- Evaluate: HT-15, HT-16
- Create: none

## 10. Competency classification for each learning objective

Primary competency mapping:
- Technical Skills: HT-01, HT-02, HT-08, HT-09, HT-10
- Statistical Reasoning: HT-03, HT-04, HT-05, HT-06, HT-07, HT-11, HT-12, HT-13, HT-14, HT-15
- Professional Judgment: HT-16

Secondary competencies provide bridge support, especially between execution and interpretation.

## 11. Identification of bridge objectives

Bridge objectives connect stage transitions and chapter-to-chapter transfer.

Perform -> Interpret bridges:
- HT-09: execution with three interpretation routes (critical region, p-value, confidence-bound)
- HT-10: MUS mechanics tied to inference meaning
- HT-11: explicit uncertainty communication after computation

Interpret -> Evaluate bridges:
- HT-13: interpretation of non-significant outcomes as inconclusive evidence, not proof of null
- HT-15: bounded evidential conclusion against threshold with limitations
- HT-16: explicit statement of support/non-support boundaries before any response decisions

Forward-transfer bridges (to later chapters):
- HT-06 and HT-11 prepare p-value and uncertainty reasoning reused in Regression Analysis and Goodness of Fit.
- HT-12 prepares sensitivity thinking for model diagnostics and anomaly interpretation.

## 12. Mapping against Perform -> Interpret -> Evaluate

| Stage | Objectives | Stage intent |
|---|---|---|
| Perform | HT-01, HT-02, HT-08, HT-09, HT-10 | Build procedural fluency and valid computation workflows. |
| Interpret | HT-03, HT-04, HT-05, HT-06, HT-07, HT-11, HT-12, HT-13, HT-14 | Make statistical meaning explicit, including uncertainty and limitations. |
| Evaluate | HT-15, HT-16 | Produce bounded evidence-level conclusions without audit-response prescription. |

## 13. Risks, trade-offs, and implementation considerations

Risks:
1. Perceived de-emphasis of professional realism:
- some instructors may expect stronger response language in this chapter.

2. Assessment redesign effort:
- existing assessments may over-reward computation and under-assess interpretation language.

3. Terminology inertia:
- if existing chapter wording remains unchanged, old “accept/reject as proof” habits can persist.

Trade-offs:
1. Less Create-level activity now, stronger developmental pacing later:
- deliberate choice to keep bachelor appropriateness and protect Volume 2 role.

2. More interpretation prompts may reduce coverage speed:
- but increases conceptual retention and transfer quality.

Implementation considerations:
1. Preserve existing chapter sections and workshop exercises where possible.
2. Re-tag assessment prompts to require interpretation statements, not only numeric outputs.
3. Add explicit misconception checks tied to HT-06 and HT-13.
4. Ensure metadata and mapping cleanup addresses LO-C4-01 misalignment during implementation phase.
5. Keep language consistent: conclude on statistical consistency and uncertainty, not on audit response.

## 14. Preparation pathway for Regression Analysis, Goodness of Fit, and Volume 2

Preparation for Regression Analysis:
- students carry forward p-value meaning, confidence interpretation, and “fail to reject is not proof” logic into model significance and diagnostics interpretation.
- HT-12 sensitivity reasoning supports understanding how model choices affect inference.

Preparation for Goodness of Fit:
- students transfer test-outcome interpretation discipline to anomaly contexts.
- HT-13 directly supports distinguishing statistical deviation from substantive conclusions.

Preparation for Volume 2 Chapter 1:
- students arrive with clean evidence-language habits:
  - what evidence supports;
  - what remains uncertain;
  - what cannot be concluded yet.
- this enables Volume 2 to focus on professional judgment and audit-response design without reteaching foundational inferential interpretation.

## Final recommendation

Adopt this redesigned objective architecture while preserving most existing chapter content and workflow structure.

This yields a chapter that remains fully appropriate for first- or second-year bachelor students, strengthens interpretation and statistical reasoning, explicitly corrects common hypothesis-testing misconceptions, and prepares learners for advanced judgment responsibilities in Volume 2 without importing those responsibilities prematurely.
