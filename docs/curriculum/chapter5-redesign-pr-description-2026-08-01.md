# Summary

This PR proposes a full educational redesign architecture for Chapter 5 (Regression Analysis) in Volume 1.

The redesign does not repair existing objectives in place. It defines a new target architecture and derives a new chapter-level learning-objective set from that architecture.

Scope is analysis and proposal only. No curriculum metadata, mappings, workshop files, or manuscript text are modified in this PR.

# Educational Problem

Current Chapter 5 contains strong technical material but an objective architecture that is educationally mixed:
- objective granularity is uneven (some overly narrow, some overly compound);
- diagnostic and interpretation capabilities are not consistently separated;
- multiple objectives drift into engagement-level audit decision territory that belongs primarily in Volume 2.

This creates a boundary misalignment between Bachelor-level expectation-setting and Post-Master-level audit decision ownership.

# Architectural Decisions

Binding decisions applied:
- Chapter 5 remains a Volume 1 chapter (Bachelor level).
- Core chapter question: Are the recorded revenue figures consistent with expectations?
- Regression is framed primarily as an expectation-setting tool, not an audit decision tool.
- Primary competency is Statistical Reasoning.
- Supporting competency is Technical Skills.
- Professional Judgment has limited presence only.
- Chapter 5 objectives must not require engagement-level sufficiency decisions, audit strategy selection, or audit procedure decisions.

# Chapter Purpose

Chapter 5 develops students' ability to:
- build and fit regression models;
- interpret model output and uncertainty;
- assess assumptions and diagnostics;
- evaluate whether recorded observations are statistically consistent with model-based expectations;
- communicate what is and is not justified by the statistical evidence.

# Proposed Learning Objective Architecture

Proposed target set:
- 19 chapter-level objectives (C5R-01 to C5R-19).
- Progression logic: Perform -> Interpret -> Evaluate.
- Definitional objectives are retained but bounded.
- Diagnostics are treated explicitly (residuals, influence, multicollinearity, assumptions consequences).
- Model selection metrics (R2, adjusted R2, AIC/BIC) are retained with comparability constraints.
- Alternative specifications are included in constrained Volume 1 form (no advanced model engineering requirement).

# Bloom Impact

Current Chapter 5 Bloom profile:
- Remember 4, Understand 4, Apply 4, Analyze 2, Evaluate 2, Create 2.

Proposed Chapter 5 Bloom profile:
- Remember 2, Understand 4, Apply 6, Analyze 5, Evaluate 2, Create 0.

Interpretation:
- The redesign increases applied and analytical capability density.
- Remember and Understand remain sufficiently represented.
- Evaluate remains present but bounded.
- No artificial Create targets are added purely for distribution symmetry.

# Competency Impact

Current competency profile:
- Technical Skills 8, Statistical Reasoning 6, Professional Judgment 4.

Proposed competency profile:
- Technical Skills 8, Statistical Reasoning 10, Professional Judgment 1.

Interpretation:
- Statistical Reasoning becomes dominant, matching Chapter 5 educational purpose.
- Technical Skills remain strong as enabling capability.
- Professional Judgment is constrained to boundary-aware communication, not engagement-level audit decisions.

# Relationship to Volume 2

Inside Chapter 5 (Volume 1):
- model fitting and diagnostics;
- interpretation of model behavior and uncertainty;
- expectation-based consistency assessment.

Deferred to Volume 2:
- deciding evidence sufficiency for engagement conclusions;
- selecting additional audit procedures;
- setting audit strategy or reliance decisions.

# Traceability Impact

Workshop impact:
- Existing Chapter 5 workshop content is extensive and likely reusable for most target objectives with remapping and prompt reframing.

Review-question impact:
- Major gap identified: no explicit Chapter 5 objective-to-review mappings currently in lo_to_review metadata.
- Chapter 5 review-question authoring and mapping become priority follow-up work for traceability completeness.

Migration impact:
- Requires future objective retirement/supersession, target objective insertion, workshop remapping, review-question build, and validation re-audit.

# Risks

- Mapping complexity risk during transition from LO-C5-* to C5R-* objective architecture.
- Temporary traceability incompleteness while review-question layer is built.
- Risk of accidental language drift back into Volume 2 decision framing during manuscript rewrite phase.

# Follow-Up Work

1. Approve target architecture and objective set.
2. Implement metadata transition (new objectives, retirement aliases).
3. Re-map workshop links to target objectives.
4. Author Chapter 5 review-question content aligned to interpret/evaluate targets.
5. Reframe manuscript purpose and evaluation language to expectation-setting boundaries.
6. Run validation and publish updated traceability audit.

# Checklist

- [x] Full Chapter 5 architecture critique completed.
- [x] New Chapter 5 educational architecture designed from scratch.
- [x] New chapter-level objective set proposed.
- [x] Bloom analysis completed.
- [x] Competency analysis completed.
- [x] Current vs target comparison completed.
- [x] Traceability impact assessment completed.
- [x] Migration recommendation completed.
- [x] Executive recommendation completed.
- [x] Proposal stays within Volume 1 boundary.
- [x] Proposal does not redesign Chapter 5 as an audit-decision chapter.
