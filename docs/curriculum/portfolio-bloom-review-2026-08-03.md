# Portfolio Bloom Review (Level 4 Analysis)

Date: 2026-08-03
Scope: Volume 1 and Volume 2 portfolio governance review
Review type: Analytical review (not curriculum redesign)

## Findings First (Ordered by Severity)

### 1. Critical: Portfolio cannot yet be validated as a full Volume 1 plus Volume 2 LO architecture
Evidence:
- Active objective inventory currently reports chapter distribution only for Chapters 1 to 6: [docs/curriculum/curriculum-baseline-audit-2026-08-01.md](docs/curriculum/curriculum-baseline-audit-2026-08-01.md#L26).
- The same baseline reports 103 active objectives in that set: [docs/curriculum/curriculum-baseline-audit-2026-08-01.md](docs/curriculum/curriculum-baseline-audit-2026-08-01.md#L23).
- Standard scope is all volumes: [docs/curriculum/learning-objective-authoring-standard.md](docs/curriculum/learning-objective-authoring-standard.md#L6).

Why this is problematic:
- Programme-level progression claims cannot be fully tested if the active LO portfolio being measured is effectively Volume 1 only.

Implication:
- Current analytics are reliable for Volume 1 progression quality and governance readiness, but only provisional for full programme progression.

### 2. High: Curriculum progression pattern is flatter than intended, with limited chapter-to-chapter escalation
Evidence:
- Governance requires progression-first review beyond local compliance: [docs/curriculum/curr-022-curriculum-progression-governance.md](docs/curriculum/curr-022-curriculum-progression-governance.md#L13).
- Progression is explicitly defined as Perform -> Interpret -> Evaluate: [docs/curriculum/educational-philosophy-vol1.md](docs/curriculum/educational-philosophy-vol1.md#L159).
- Active chapter profiles are highly regular (counts by chapter: 16, 14, 16, 16, 18, 23): [docs/curriculum/curriculum-baseline-audit-2026-08-01.md](docs/curriculum/curriculum-baseline-audit-2026-08-01.md#L26).

Why this is problematic:
- Regularity improves symmetry but can reduce visible developmental contrast across sequential chapters.

Implication:
- Students may experience competent local chapter design without perceiving a strong programme learning arc.

### 3. High: Bridge-objective density is low relative to progression ambition
Evidence:
- Bridge objectives are mandated in advanced technical chapters under CURR-022: [docs/curriculum/curr-022-curriculum-progression-governance.md](docs/curriculum/curr-022-curriculum-progression-governance.md#L59).
- Bridge standard defines bridge objectives as explicit cognitive transitions and rejects classification-only compliance: [docs/curriculum/bridge-objective-standard.md](docs/curriculum/bridge-objective-standard.md#L13), [docs/curriculum/bridge-objective-standard.md](docs/curriculum/bridge-objective-standard.md#L17).
- Heuristic portfolio scan of active chapter LOs found only 9 clearly bridge-like objectives out of 103.

Why this is problematic:
- Competency distribution can look balanced while instructional movement remains implicit.

Implication:
- Progression quality risk remains even with acceptable Bloom and competency totals.

### 4. Medium-High: Several Bloom classifications appear linguistically misaligned with objective demand
Evidence (examples):
- LO-C1-01 is led by define but tagged apply: [metadata/traceability/learning_objectives.yml](metadata/traceability/learning_objectives.yml#L1).
- LO-C3-01 is led by define but tagged apply: [metadata/traceability/learning_objectives.yml](metadata/traceability/learning_objectives.yml#L8).
- LO-C5-01 is led by define and identify but tagged apply: [metadata/traceability/learning_objectives.yml](metadata/traceability/learning_objectives.yml#L22).
- LO-C3-10 starts with evaluate but tagged apply: [metadata/traceability/learning_objectives.yml](metadata/traceability/learning_objectives.yml#L478).
- LO-C6-14 starts with interpret but tagged apply: [metadata/traceability/learning_objectives.yml](metadata/traceability/learning_objectives.yml#L928).

Why this is problematic:
- Classification credibility weakens when stated cognitive action and assigned level diverge.

Implication:
- Portfolio diagnostics become less reliable for progression monitoring and audit reporting.

### 5. Medium: Competency progression signal is uneven, with a sharp Professional Judgment dip in Hypothesis Testing
Evidence:
- Intended progression is Technical Skills -> Statistical Reasoning -> Professional Judgment: [docs/curriculum/educational-philosophy-vol1.md](docs/curriculum/educational-philosophy-vol1.md#L115), [docs/curriculum/educational-philosophy-vol1.md](docs/curriculum/educational-philosophy-vol1.md#L132).
- Current metadata-driven chapter competency profile shows Chapter 4 with very low Professional Judgment share (1 out of 16 LOs), then increase again in Chapters 5 and 6.

Why this is problematic:
- A local chapter decision may be justified, but sequence continuity can become less visible if the dip is not explicitly explained in progression terms.

Implication:
- Reviewers should verify this as a pedagogically intentional staging choice, not an architectural omission.

### 6. Medium: Volume 2 competency framing is still conceptually inconsistent across governance documents
Evidence:
- Volume 2 philosophy describes adding a fourth competency: [docs/curriculum/learning-philosophy-vol2.md](docs/curriculum/learning-philosophy-vol2.md#L37).
- LO standard prohibits a fourth LO competency category and requires Audit Judgment to remain under Professional Judgment: [docs/curriculum/learning-objective-authoring-standard.md](docs/curriculum/learning-objective-authoring-standard.md#L44).

Why this is problematic:
- Policy-language inconsistency can produce downstream classification drift when Volume 2 LOs are expanded.

Implication:
- Without clarification, future Volume 2 LO governance may bifurcate into competing competency schemas.

## Open Questions and Assumptions

- Assumption: active LO metadata is the authoritative source for portfolio analytics.
- Open question: are Volume 2 chapter-level LOs intentionally deferred, or currently stored outside the primary metadata registry?
- Open question: should Chapter 4 Professional Judgment compression be preserved as a deliberate phase boundary or moderately expanded?

## Analytical Scope and Method

Data sources used:
- [metadata/traceability/learning_objectives.yml](metadata/traceability/learning_objectives.yml)
- [docs/curriculum/curriculum-baseline-audit-2026-08-01.md](docs/curriculum/curriculum-baseline-audit-2026-08-01.md)
- [docs/curriculum/learning-objective-authoring-standard.md](docs/curriculum/learning-objective-authoring-standard.md)
- [docs/curriculum/educational-philosophy-vol1.md](docs/curriculum/educational-philosophy-vol1.md)
- [docs/curriculum/learning-philosophy-vol2.md](docs/curriculum/learning-philosophy-vol2.md)
- [docs/curriculum/curr-022-curriculum-progression-governance.md](docs/curriculum/curr-022-curriculum-progression-governance.md)
- [docs/curriculum/bridge-objective-standard.md](docs/curriculum/bridge-objective-standard.md)
- [docs/curriculum/lo-traceability-remediation-report.md](docs/curriculum/lo-traceability-remediation-report.md)

Analytical method:
- Active chapter-level objective extraction.
- Bloom and competency distribution analysis at LO, chapter, volume, programme levels.
- Progression-pattern analysis across chapter sequence.
- Linguistic classification-sanity checks for possible Bloom mismatch.
- Bridge-objective heuristic scan for explicit transition wording.

## 1) Bloom Taxonomy Quality

Current active portfolio Bloom distribution (n=103):
- remember: 20
- understand: 22
- apply: 21
- analyze: 16
- evaluate: 13
- create: 11

Interpretation:
- Lower/mid levels dominate overall, which is acceptable for Volume 1 coverage.
- Analyze plus Evaluate plus Create are present but relatively light for a portfolio explicitly aiming to culminate in defensible evidence judgment.
- Create appears reduced versus earlier baselines, suggesting recent corrections away from inflated higher-order labeling.

Quality judgment:
- Moderate.
- The portfolio is no longer strongly misbalanced, but classification precision and progression signaling still need work.

## 2) Competency Classification Quality

Current active portfolio competency distribution (n=103):
- technical_skills: 40
- statistical_reasoning: 39
- professional_judgment: 24

Interpretation:
- Technical Skills and Statistical Reasoning are nearly co-dominant.
- Professional Judgment remains materially smaller, which aligns with Volume 1 boundary logic.
- Chapter-level distribution is not monotonic and includes abrupt variation in Chapter 4.

Quality judgment:
- Moderate to strong at portfolio level.
- Moderate at sequence level due to uneven chapter-to-chapter handoff visibility.

## 3) Curriculum Progression (Programme-Level)

Intended spine:
- Perform -> Interpret -> Evaluate: [docs/curriculum/educational-philosophy-vol1.md](docs/curriculum/educational-philosophy-vol1.md#L159).

Observed programme signal:
- Portfolio includes all Bloom levels and all three competencies.
- Progression exists in aggregate, but sequencing is only partially visible in chapter transitions.

Judgment:
- Partial alignment.
- Stronger than pre-remediation historical baseline, but still not a high-clarity progression architecture.

## 4) Chapter-to-Chapter Progression

Chapter profile observations:
- Probability Distributions and Estimation carry expected foundational load.
- Estimation with Auxiliary Variables and Stratification shows bridge potential but remains mixed between execution and interpretation.
- Hypothesis Testing strongly emphasizes Statistical Reasoning with constrained Professional Judgment.
- Regression Analysis remains more technical in outward LO architecture than in intended educational role.
- Goodness of Fit shows the clearest advanced progression profile in the current set.

Judgment:
- Sequence is educationally plausible.
- Transition strength is uneven and occasionally too implicit.

## 5) Volume-to-Volume Progression

Evidence status:
- Volume 2 philosophy is clearly articulated: [docs/curriculum/learning-philosophy-vol2.md](docs/curriculum/learning-philosophy-vol2.md).
- Active LO portfolio measured in baseline and metadata currently maps to Chapters 1 to 6 only: [docs/curriculum/curriculum-baseline-audit-2026-08-01.md](docs/curriculum/curriculum-baseline-audit-2026-08-01.md#L26).

Judgment:
- Conceptual progression to Volume 2 is defined.
- Empirical LO-level validation across Volume 2 is currently incomplete in the active measured portfolio.

## 6) Bridge Objective Analysis

Bridge presence findings:
- Explicit bridge wording appears in a minority of objectives.
- Heuristic scan classified 9 of 103 active chapter LOs as clear bridge-like transitions.

Bridge quality pattern:
- Strongest bridge potential appears in later chapters (especially Regression Analysis and Goodness of Fit).
- Many objectives remain single-stage procedure or single-stage interpretation statements without explicit transition logic.

Governance alignment:
- Current state improves feasibility for bridge governance but does not yet satisfy the spirit of bridge-first progression at scale.

## 7) Balance Between Competencies

Portfolio balance:
- Technical Skills and Statistical Reasoning are close in volume.
- Professional Judgment is present but lighter.

Educational interpretation:
- This is appropriate for Volume 1 boundary protection if and only if bridges make progression explicit.
- Without explicit bridges, balanced counts risk producing siloed competencies rather than developmental flow.

## 8) Alignment with Educational Philosophy

Alignment strengths:
- Philosophy is explicit and coherent in Volume 1 documentation.
- Chapter set includes Perform, Interpret, and Evaluate outcomes.
- Goodness of Fit strongly models evidence-evaluation framing.

Alignment gaps:
- Objective architecture still over-signals definitional or procedural framing in some advanced areas.
- Transition from method output to evidential meaning is often implied rather than explicit.

Overall alignment judgment:
- Moderate to strong in intent.
- Moderate in objective-level implementation fidelity.

## 9) Alignment with Curriculum Governance Decisions

Strong alignment:
- Chapter-only LO governance is now structurally in force: [docs/curriculum/learning-objective-authoring-standard.md](docs/curriculum/learning-objective-authoring-standard.md#L25).
- Progression-first governance is explicitly adopted: [docs/curriculum/curr-022-curriculum-progression-governance.md](docs/curriculum/curr-022-curriculum-progression-governance.md#L13).

Partial alignment:
- Bridge-objective governance is defined but not yet deeply embedded in majority LO wording.
- Cross-document competency framing for Volume 2 needs harmonization.

## 10) LO-Level Significant Findings (Classification and Design Signals)

Potential Bloom reclassification candidates (for review, not automatic change):
- LO-C1-01: likely remember or understand rather than apply.
- LO-C3-01: likely remember rather than apply.
- LO-C5-01: likely remember rather than apply.
- LO-C6-01: likely remember or understand depending on assessment evidence.
- LO-C3-10: likely analyze or evaluate rather than apply.
- LO-C6-14: likely analyze rather than apply.

Additional candidate cases needing expert adjudication:
- LO-C1-12
- LO-C2-10
- LO-C3-14
- LO-C5-16
- LO-C6-20

Source anchors:
- [metadata/traceability/learning_objectives.yml](metadata/traceability/learning_objectives.yml#L1)
- [metadata/traceability/learning_objectives.yml](metadata/traceability/learning_objectives.yml#L8)
- [metadata/traceability/learning_objectives.yml](metadata/traceability/learning_objectives.yml#L22)
- [metadata/traceability/learning_objectives.yml](metadata/traceability/learning_objectives.yml#L110)
- [metadata/traceability/learning_objectives.yml](metadata/traceability/learning_objectives.yml#L478)
- [metadata/traceability/learning_objectives.yml](metadata/traceability/learning_objectives.yml#L928)
- [metadata/traceability/learning_objectives.yml](metadata/traceability/learning_objectives.yml#L235)
- [metadata/traceability/learning_objectives.yml](metadata/traceability/learning_objectives.yml#L361)
- [metadata/traceability/learning_objectives.yml](metadata/traceability/learning_objectives.yml#L514)
- [metadata/traceability/learning_objectives.yml](metadata/traceability/learning_objectives.yml#L802)
- [metadata/traceability/learning_objectives.yml](metadata/traceability/learning_objectives.yml#L982)

Educational implication:
- These cases affect Bloom analytics integrity and progression interpretation confidence.

## 11) Future Redesign Priorities (Analytical Recommendations Only)

Priority 1: Complete full-programme LO observability
- Ensure active portfolio includes both volumes in one authoritative registry snapshot for programme-level progression analysis.

Priority 2: Run a focused Bloom adjudication pass on the flagged LO subset
- Use assessment-evidence-based tie-breaks from the LO standard, not verb-only reassignment.

Priority 3: Increase explicit bridge wording in advanced technical chapters
- Especially where objectives currently state procedure and interpretation separately without explicit transition.

Priority 4: Publish chapter transition intent notes
- For each chapter boundary, state intended progression shift and acceptable temporary dips.

Priority 5: Harmonize Volume 2 competency language across philosophy and LO standard
- Prevent downstream schema drift before Volume 2 expansion.

## 12) Conclusion

This portfolio is not structurally broken. It is governance-mature and substantially improved after remediation.

The core risk is not missing categories. The core risk is developmental visibility.

The current objective architecture supports local compliance and broad balance, but it still under-expresses progression intensity and bridge logic needed to fully realize the Perform -> Interpret -> Evaluate philosophy at programme scale.
