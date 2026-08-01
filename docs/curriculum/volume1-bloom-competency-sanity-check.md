# Executive Summary

Date: 2026-08-01
Branch: issue-252-volume1-bloom-competency-sanity-check
Status: Analysis only
Scope: Volume 1 Bloom and competency sanity check

This review assesses whether the current Volume 1 learning-objective portfolio supports the intended educational progression:

Perform
-> Interpret
-> Evaluate

and the competency progression:

Technical Skills
-> Statistical Reasoning
-> Professional Judgment

The central conclusion is that the curriculum is not globally broken. The current active chapter-level portfolio is broadly distributed across Bloom levels and competencies, and every chapter includes at least some higher-order outcomes. However, the portfolio is too regularized across chapters. It appears designed for formal balance more than for developmental progression.

That creates the main curriculum-quality risk:

- the curriculum looks balanced in aggregate;
- but it does not intensify from chapter to chapter as clearly as the educational philosophy implies it should.

The biggest weakness is Chapter 5, where objective density is lowest and the educational architecture still underrepresents judgment relative to the chapter's actual purpose. Chapter 6 is the strongest exemplar of philosophy-aligned progression and assessment relevance.

A second major finding is that the competency system is highly stratified, almost too cleanly:

- technical_skills carries nearly all remember/apply outcomes;
- statistical_reasoning carries nearly all understand/analyze outcomes;
- professional_judgment carries nearly all evaluate/create outcomes.

This supports conceptual clarity, but it also suggests too few bridge objectives that connect technical execution directly to evidential judgment. In practice, students need more visible transitions, not just well-separated buckets.

## 1. Curriculum Bloom Analysis

### 1.1 Source basis

This analysis uses:

- docs/curriculum/educational-philosophy-vol1.md
- docs/curriculum/learning-objective-authoring-standard.md
- docs/curriculum/curriculum-decision-register.yml
- docs/curriculum/curriculum-decision-register-report.md
- docs/curriculum/lo-compliance-audit.md
- metadata/traceability/learning_objectives.yml

### 1.2 Baseline context versus current state

The published LO compliance audit is a historical baseline. It reported:

- 114 active learning objectives
- Bloom distribution: Remember 20, Understand 24, Apply 25, Analyze 17, Evaluate 15, Create 13

That baseline included active section-level objectives before subsequent remediation phases.

The current active chapter-level Volume 1 portfolio is now:

- 103 active learning objectives
- Bloom distribution:
  - Remember: 20
  - Understand: 21
  - Apply: 21
  - Analyze: 15
  - Evaluate: 13
  - Create: 13

### 1.3 Portfolio-level Bloom summary

| Bloom level | Count | Share |
|---|---:|---:|
| Remember | 20 | 19% |
| Understand | 21 | 20% |
| Apply | 21 | 20% |
| Analyze | 15 | 15% |
| Evaluate | 13 | 13% |
| Create | 13 | 13% |

Grouped progression view:

| Group | Count | Share |
|---|---:|---:|
| Low Bloom: Remember + Understand | 41 | 40% |
| Mid Bloom: Apply + Analyze | 36 | 35% |
| High Bloom: Evaluate + Create | 26 | 25% |

### 1.4 Interpretation

This is not an obviously poor distribution. A Volume 1 curriculum should still carry a substantial foundational load. The problem is subtler.

The current portfolio has:

- enough higher-order outcomes to avoid being rote;
- enough low-level outcomes to provide foundations;
- but not enough curricular drift upward across chapters.

Instead of a strong developmental arc, the curriculum often reproduces similar chapter-level Bloom mixes.

## 2. Curriculum Competency Analysis

### 2.1 Portfolio-level competency distribution

| Competency | Count | Share |
|---|---:|---:|
| Technical Skills | 42 | 41% |
| Statistical Reasoning | 34 | 33% |
| Professional Judgment | 27 | 26% |

### 2.2 Bloom by competency

| Competency | Bloom pattern |
|---|---|
| Technical Skills | Remember 20, Apply 21, Understand 1 |
| Statistical Reasoning | Understand 20, Analyze 14 |
| Professional Judgment | Analyze 1, Evaluate 13, Create 13 |

### 2.3 Interpretation

This is one of the strongest and most revealing findings in the entire review.

The competency model is extremely clean:

- Technical Skills is almost entirely foundational recall plus procedural execution.
- Statistical Reasoning is almost entirely conceptual explanation plus interpretation.
- Professional Judgment is almost entirely evaluative and productive output.

This is philosophically legible and highly structured. It mirrors the intended progression very closely at a conceptual level.

However, it may be too clean.

In an educationally mature curriculum, one expects more bridge objectives such as:

- applying technical skills in order to interpret evidence;
- interpreting results in order to support professional judgment;
- making evaluative claims that still explicitly depend on statistical reasoning.

The current pattern suggests the competency model is operating more like a taxonomy partition than a developmental continuum.

## 3. Curriculum Inventory

### 3.1 Chapter objective counts

| Chapter | Title | Active chapter-level LOs |
|---|---|---:|
| 1 | Probability Distributions | 16 |
| 2 | Estimating the Population Mean and Proportion | 14 |
| 3 | Estimation with Auxiliary Variables and Stratification | 16 |
| 4 | Hypothesis Testing | 16 |
| 5 | Regression Analysis | 18 |
| 6 | Goodness of Fit | 23 |

### 3.2 Objective density per chapter

Using current manuscript line counts:

| Chapter | Lines | LOs | LOs per 100 lines |
|---|---:|---:|---:|
| 1 | 1,055 | 16 | 1.52 |
| 2 | 712 | 14 | 1.97 |
| 3 | 1,793 | 16 | 0.89 |
| 4 | 1,044 | 16 | 1.53 |
| 5 | 3,490 | 18 | 0.52 |
| 6 | 1,195 | 23 | 1.92 |

Interpretation:

- Chapter 5 is by far the sparsest chapter relative to content size.
- Chapter 6 is the densest among the conceptually advanced chapters.
- Chapter 3 also has relatively low density for its size, but not nearly as severe as Chapter 5.

### 3.3 Bloom by chapter

| Chapter | Bloom distribution |
|---|---|
| 1 | R3 U3 A3 An3 E2 C2 |
| 2 | R3 U3 A2 An2 E2 C2 |
| 3 | R3 U3 A4 An2 E2 C2 |
| 4 | R3 U3 A4 An2 E2 C2 |
| 5 | R4 U4 A4 An2 E2 C2 |
| 6 | R4 U5 A4 An4 E3 C3 |

### 3.4 Competency by chapter

| Chapter | Competency distribution |
|---|---|
| 1 | TS6 SR6 PJ4 |
| 2 | TS5 SR5 PJ4 |
| 3 | TS7 SR5 PJ4 |
| 4 | TS7 SR5 PJ4 |
| 5 | TS8 SR6 PJ4 |
| 6 | TS9 SR7 PJ7 |

### 3.5 Educational significance of the inventory

The distribution is remarkably consistent, almost to the point of standardization by template. That is the key curriculum-level concern.

The current portfolio appears to have been authored with a strong preference for formal symmetry across chapters:

- similar counts of remember/understand outcomes;
- similar counts of evaluate/create outcomes;
- similar competency mixes.

This creates neat metadata and balanced tables, but it can work against authentic chapter-specific educational purpose.

## 4. Educational Philosophy Alignment

### 4.1 What the philosophy expects

The philosophy of Volume 1 expects three things:

1. Students should progress from performing analysis to interpreting results to evaluating evidence.
2. Technical Skills should not be the endpoint; they should lead into Statistical Reasoning and Professional Judgment.
3. Audit-relevant chapters should make evidence evaluation visible rather than leaving it implicit.

### 4.2 Current alignment at curriculum level

At a high level, the curriculum does align with the philosophy.

Evidence of alignment:

- Every chapter includes objectives across multiple Bloom levels.
- Professional Judgment is present in every chapter.
- Later chapters, especially Chapter 6, connect statistical models to evidential interpretation and audit implication.
- Case studies and workshops are strongly integrated into the curriculum architecture.

Evidence of misalignment:

- The chapter mixes are too uniform to represent a strong developmental arc.
- Several chapters still spend too much visible objective space on foundational or definitional outcomes.
- The strongest audit-evidence chapters do not consistently increase Professional Judgment representation enough relative to their role.
- The curriculum progression is flatter than the philosophy suggests.

### 4.3 Overall alignment judgment

Overall alignment: moderate to strong

This is not a curriculum that contradicts its philosophy. It is a curriculum whose objective architecture under-expresses its own philosophical ambition.

## 5. Chapter-by-Chapter Review

### Chapter 1: Probability Distributions

1. What is the chapter attempting to teach?
- foundational statistical distributions and approximation logic used later across the curriculum.

2. What Bloom profile would be expected?
- strong Remember and Understand presence;
- meaningful Apply;
- selective Analyze and Evaluate around approximation judgments.

3. What Bloom profile currently exists?
- R3 U3 A3 An3 E2 C2.

4. What competency profile would be expected?
- Technical Skills and Statistical Reasoning dominant;
- limited but real Professional Judgment.

5. What competency profile currently exists?
- TS6 SR6 PJ4.

6. Does the chapter overemphasize low-level objectives?
- not severely; the chapter is foundational and concept-heavy.

7. Does the chapter underrepresent interpretation?
- slightly, but not critically.

8. Does the chapter underrepresent judgment?
- modestly; higher-order approximation judgment exists but remains secondary.

9. Are any objectives educationally misplaced?
- the create-level simulation and programming objectives are educationally useful, but they sit slightly awkwardly in a chapter whose main role is conceptual foundation.

Assessment:
- broadly appropriate and well-balanced for an opening quantitative foundations chapter.

### Chapter 2: Estimating the Population Mean and Proportion

1. What is the chapter attempting to teach?
- how to estimate population parameters and reason about confidence, precision, and sample adequacy.

2. Expected Bloom profile
- strong Apply, plus meaningful Evaluate around precision and assumptions.

3. Current Bloom profile
- R3 U3 A2 An2 E2 C2.

4. Expected competency profile
- Technical Skills and Statistical Reasoning roughly balanced;
- some Professional Judgment around adequacy of evidence.

5. Current competency profile
- TS5 SR5 PJ4.

6. Overemphasis on low-level objectives?
- moderate. For a chapter centered on interval reasoning and precision, Apply could be more prominent.

7. Underrepresentation of interpretation?
- somewhat. Confidence interpretation and adequacy judgment are present, but the visible architecture still leans foundational.

8. Underrepresentation of judgment?
- slight. Professional judgment is present, but not strongly foregrounded.

9. Educationally misplaced objectives?
- not strongly misplaced, but the chapter still reads more like a statistics unit than an evidence-adequacy unit.

Assessment:
- sound, but slightly too cautious in its shift from procedure to evaluative interpretation.

### Chapter 3: Estimation with Auxiliary Variables and Stratification

1. What is the chapter attempting to teach?
- how design choices improve estimation precision and validity.

2. Expected Bloom profile
- Apply and Analyze should be stronger than in Chapter 2, because the chapter is about methodological improvement and design choice.

3. Current Bloom profile
- R3 U3 A4 An2 E2 C2.

4. Expected competency profile
- Technical Skills strong, Statistical Reasoning strong, Professional Judgment modest but present.

5. Current competency profile
- TS7 SR5 PJ4.

6. Overemphasis on low-level objectives?
- mild. The chapter does carry more application than earlier chapters.

7. Underrepresentation of interpretation?
- yes, somewhat. Analyze is slightly low for a chapter about choosing among estimation strategies.

8. Underrepresentation of judgment?
- somewhat. Design choices are evaluative in nature, but the LO profile does not fully surface that.

9. Educationally misplaced objectives?
- the create-level strategies for violated normality are helpful, but the chapter could use more explicit decision-oriented analysis instead of another fairly even spread.

Assessment:
- strong mid-curriculum technical chapter, but a little underweighted on strategic comparison and judgment.

### Chapter 4: Hypothesis Testing

1. What is the chapter attempting to teach?
- how auditors use statistical hypothesis testing to make defensible pass/fail or sufficiency judgments.

2. Expected Bloom profile
- Apply, Analyze, and Evaluate should all be strong.

3. Current Bloom profile
- R3 U3 A4 An2 E2 C2.

4. Expected competency profile
- Technical Skills strong, but Professional Judgment should be visibly more central than in early chapters.

5. Current competency profile
- TS7 SR5 PJ4.

6. Overemphasis on low-level objectives?
- mild to moderate. The chapter still opens with definition-heavy architecture.

7. Underrepresentation of interpretation?
- somewhat. There is room for more explicit reasoning about test meaning and limitation.

8. Underrepresentation of judgment?
- yes, slightly. Hypothesis testing in audit context should probably lean harder into judgment than the current competency counts suggest.

9. Educationally misplaced objectives?
- the step-by-step planning and design outcomes are authentic, but the chapter could do more to foreground what test results actually permit an auditor to conclude.

Assessment:
- educationally solid, but still more method-centered than philosophy-centered.

### Chapter 5: Regression Analysis

1. What is the chapter attempting to teach?
- how to use regression as audit evidence, from model construction through expectation-setting and assurance evaluation.

2. Expected Bloom profile
- Analyze, Evaluate, and Create should be much more prominent than in earlier chapters.

3. Current Bloom profile
- R4 U4 A4 An2 E2 C2.

4. Expected competency profile
- Statistical Reasoning and Professional Judgment should be visibly dominant or at least co-dominant.

5. Current competency profile
- TS8 SR6 PJ4.

6. Overemphasis on low-level objectives?
- yes, clearly.

7. Underrepresentation of interpretation?
- yes.

8. Underrepresentation of judgment?
- yes, especially relative to the chapter’s actual role in the curriculum.

9. Educationally misplaced objectives?
- yes. Definitions, terminology, assumptions-as-recall, and workflow steps consume too much of the architecture.

Assessment:
- this is the chapter with the clearest mismatch between educational philosophy and visible LO design.

### Chapter 6: Goodness of Fit

1. What is the chapter attempting to teach?
- how to test whether observed data fit expected patterns and how to interpret deviations without overclaiming fraud or anomaly significance.

2. Expected Bloom profile
- balanced foundational base plus strong Analyze, Evaluate, and Create.

3. Current Bloom profile
- R4 U5 A4 An4 E3 C3.

4. Expected competency profile
- strong Statistical Reasoning and strong Professional Judgment, with Technical Skills still necessary.

5. Current competency profile
- TS9 SR7 PJ7.

6. Overemphasis on low-level objectives?
- some, but less concerning here because the chapter introduces a conceptually distinct method family and fraud-risk caveats.

7. Underrepresentation of interpretation?
- no. The chapter has a strong interpretive spine.

8. Underrepresentation of judgment?
- no. It explicitly addresses unsupported conclusions, model appropriateness, evidential value, and additional procedures.

9. Educationally misplaced objectives?
- a few definitional objectives remain, but the chapter overall is well aligned.

Assessment:
- strongest chapter in the portfolio for explicit philosophy alignment.

## 6. Chapter 5 Deep Dive

### 6.1 Why Chapter 5 matters specially

Regression Analysis should be one of the most important chapters for the shift from technical execution to evidence evaluation.

The manuscript itself already frames the chapter that way:

- appropriateness of the business relationship;
- diagnostics and reliability;
- significance and model validity;
- expectation-setting;
- evaluation of whether recorded amounts are consistent with expectations;
- level of assurance obtained.

### 6.2 Current LO architecture problems

1. Too many definitional objectives
- regression purpose identification
- terminology definition
- assumption recall
- workflow step listing

2. Bloom is too low for the chapter’s role
- 8 of 18 objectives are Remember or Understand
- only 4 of 18 are Evaluate or Create

3. Judgment is visibly underweighted
- only 4 Professional Judgment objectives in the largest and most audit-decisive chapter
- that count equals smaller chapters whose evidential stakes are lower

4. The architecture is flatter than the chapter
- the case and workshop are richer than the LO set
- the chapter itself points toward reliability, uncertainty, and audit sufficiency
- the LO set still advertises procedures and definitions too prominently

### 6.3 Educational critique

Chapter 5 does not fail because it lacks higher-order outcomes entirely. It fails because it hides them behind too many lower-level thresholds.

The effect is pedagogical mis-signaling:

- students are told that terms, assumptions, and procedures are the named outcomes;
- but the chapter actually wants them to judge whether the model provides credible audit evidence.

This is the clearest redesign priority in the curriculum.

## 7. Chapter 6 Deep Dive

### 7.1 Why Chapter 6 matters specially

Goodness of Fit is the chapter where statistical evidence evaluation becomes highly visible. It also directly trains students to recognize the difference between statistical anomaly and unsupported substantive accusation.

That is central to the philosophy of Volume 1.

### 7.2 Current strengths

1. Explicit evidence-evaluation logic
- the chapter repeatedly emphasizes that deviations do not prove fraud;
- the review questions ask students to distinguish statistical findings from evidential conclusions.

2. Strong higher-order presence
- Analyze 4, Evaluate 3, Create 3
- Professional Judgment 7

3. Strong assessment alignment
- Chapter 6 is the only chapter with populated review-question content in source, and those questions strongly emphasize explanation, appropriateness, limitation, and follow-up procedures.

4. Strong philosophy alignment
- the chapter directly teaches what can and cannot be concluded from patterns in data.

### 7.3 Remaining critique

1. There are still several definitional or concept-establishing objectives.
2. Technical Skills remains the largest competency bucket at 9.
3. The chapter is strong, but it still shows the same regularizing tendency as the rest of the curriculum.

### 7.4 Educational judgment

Chapter 6 is not the problem chapter. It is the best current model for how Volume 1 can connect method, interpretation, and evidential judgment.

## 8. Curriculum Progression Analysis

### 8.1 Strengths of progression

The curriculum does achieve a broad progression from foundational probability and estimation toward more judgment-intensive model-based chapters.

Strengths:

- early chapters establish statistical foundations;
- middle chapters move into inference and design choices;
- later chapters introduce stronger evidential reasoning and audit implication;
- Chapter 6 explicitly trains students against overclaiming from statistical evidence.

### 8.2 Weaknesses of progression

The progression is not as coherent as it should be.

#### Flat chapter structure

Each chapter tends to reproduce a familiar six-tier Bloom spread instead of showing more chapter-specific developmental emphasis.

#### Weak upward drift

If students are meant to progress through the curriculum, one would expect:

- later chapters to contain relatively less remember-level content;
- stronger representation of analyze/evaluate/create;
- more professional-judgment concentration in the later chapters.

That drift exists slightly, but not strongly enough.

#### Missing transitions

There are too few objectives that explicitly bridge:

- applying a method and interpreting its evidential meaning;
- interpreting results and deciding what can be concluded;
- technical execution and professional communication.

### 8.3 Abrupt jumps, regressions, repetition

Abrupt jumps:
- not many in raw counts; the curriculum is too smooth rather than too abrupt.

Regressions:
- later chapters sometimes revert to low-level definitional framing even when the chapter role is evaluative.

Unnecessary repetition:
- repeated chapter-level slots for definitions, assumptions, and step lists.
- repeated symmetrical Bloom structures whether or not the chapter content warrants them.

Missing transitions:
- stronger cross-chapter movement from "how to run the technique" to "how to reason from the technique" is needed.

## 9. Ideal vs Current Curriculum Comparison

### 9.1 Ideal Bloom distribution for Volume 1

This is a reasoned benchmark, not a formula.

A philosophically aligned Volume 1 would likely aim for approximately:

- Remember: 12-15%
- Understand: 16-20%
- Apply: 18-22%
- Analyze: 18-20%
- Evaluate: 16-18%
- Create: 10-12%

Interpretation:

- foundational levels should remain substantial, but not dominant;
- Analyze and Evaluate should together rival or exceed Remember and Understand;
- Create should be present, but not overused.

### 9.2 Ideal competency distribution for Volume 1

A reasonable curriculum-wide benchmark would be approximately:

- Technical Skills: 30-35%
- Statistical Reasoning: 35-40%
- Professional Judgment: 25-30%

Interpretation:

- Technical Skills remains essential because students must perform analyses;
- Statistical Reasoning should be slightly dominant because Volume 1 is about interpreting evidence, not just computing it;
- Professional Judgment should be strong, especially in later chapters, but constrained because Volume 2 owns broader audit-strategy judgment.

### 9.3 Current versus ideal

Current Bloom profile:

- Remember: 19% -> overrepresented
- Understand: 20% -> acceptable, slightly high
- Apply: 20% -> appropriate
- Analyze: 15% -> underrepresented
- Evaluate: 13% -> underrepresented
- Create: 13% -> appropriate to slightly high

Current competency profile:

- Technical Skills: 41% -> overrepresented
- Statistical Reasoning: 33% -> slightly underrepresented
- Professional Judgment: 26% -> appropriate overall, but weakly concentrated where it matters most

### 9.4 Where the curriculum is strongest

1. It does not neglect higher-order work entirely.
2. The competency taxonomy is clear and coherent.
3. Chapter 6 is strongly aligned with the philosophy.
4. Workshops and case studies provide a richer learning experience than the raw LO counts alone suggest.

### 9.5 Where the curriculum is weakest

1. Chapter 5 architecture.
2. Over-regularized chapter templates.
3. Too much technical-skills weight at the portfolio level.
4. Too few bridge objectives connecting analysis to evidential judgment.
5. Too much chapter-level real estate given to foundational knowledge statements in advanced chapters.

## 10. Strategic Recommendations

### Level 1: Minor adjustments

1. Use chapter-specific rather than template-driven Bloom balancing when authoring or reviewing LOs.
2. Treat definitions, terminology, and workflow step lists as supporting content rather than default chapter-level endpoints.
3. In advanced chapters, require an explicit check that interpretation and evaluation outcomes are visibly represented before adding more foundational objectives.

Expected impact: moderate

### Level 2: Chapter redesign opportunities

1. Prioritize Chapter 5 for full architectural redesign around evidential reliability, expectation-setting, anomaly investigation, and audit conclusion.
2. Review Chapter 4 for stronger explicit judgment framing around hypothesis-test meaning and limitation.
3. Review Chapter 3 for stronger analysis of design tradeoffs and estimator choice.

Expected impact: high

### Level 3: Curriculum architecture changes

1. Introduce a governance expectation that later chapters should show stronger Analyze/Evaluate/Professional Judgment representation than earlier chapters unless a chapter-specific rationale exists.
2. Add a curricular progression review step to future LO audits so balance is assessed not only within chapters but across the whole sequence.
3. Consider adding a formal "bridge-objective" design principle: every major technical chapter should include outcomes that explicitly connect method execution to evidential meaning and judgment.

Expected impact: very high

## 11. Governance Implications

### Learning Objective Authoring Standard

The standard is strong at local objective quality, but it does not yet explicitly govern curriculum-wide progression.

Potential implication:
- add guidance that chapter-level LO sets should be evaluated not only for internal compliance but also for their role in program-level developmental sequencing.

### CURR-021

CURR-021 correctly establishes binding rules for chapter-level scope, Bloom, competency, and validation. However, this review suggests a next governance question:

- how should the curriculum define expected chapter-to-chapter progression in Bloom and competency emphasis?

### LO remediation roadmap

This analysis suggests the roadmap should not stop at compliance cleanup. After compliance stabilization, the next major value lies in architecture review of chapters whose objectives are technically valid but educationally misweighted.

Priority order suggested by this review:

1. Chapter 5 redesign
2. Chapter 4 and Chapter 3 refinement
3. broader progression governance across the portfolio

### Future curriculum audits

Future audits should include a curriculum-level section that tests:

- Bloom distribution by chapter and by curriculum stage;
- competency distribution by chapter and portfolio;
- density and progression signals;
- presence of bridge objectives;
- whether later chapters visibly intensify judgment and evidence evaluation.

### Competency classification practice

The current competency practice is coherent but very siloed. Future reviews should ask whether an objective classification is accurate and whether the portfolio contains enough objectives that connect categories developmentally.

### Additional curriculum decisions that may be needed

1. A decision on curriculum-level progression expectations across chapters.
2. A decision on how much chapter-to-chapter symmetry is desirable versus how much chapter-specific differentiation is expected.
3. A decision on whether advanced audit-evidence chapters must meet higher Professional Judgment thresholds than foundational chapters.

## 12. Final Judgment

The Volume 1 curriculum is stronger than a compliance-only reading would suggest. It has a real philosophical backbone, and its strongest chapters already embody the intended movement from analysis to interpretation to evidence evaluation.

The main problem is not chaos. The main problem is over-control.

The portfolio has been normalized into a chapter pattern that is tidy, auditable, and internally coherent, but not always developmentally expressive.

The next phase of curriculum quality improvement should therefore focus less on numerical balance and more on educational differentiation:

- foundational chapters may remain foundational;
- advanced evidence chapters should visibly become more judgment-heavy;
- students should be able to feel the curriculum moving upward, not merely see every chapter repeat the same Bloom template.
