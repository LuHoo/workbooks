# Learning Objective Standard

Status: Normative Standard (Authoritative)
Version: 1.1.0
Effective date: 2026-08-05
Applies to: Audit Data Analysis curriculum (all volumes), with explicit implementation profile for Volume 1
Normative language: MUST, MUST NOT, SHOULD, MAY are used in RFC 2119-style usage.

## 0. Purpose and Authority

This document is the authoritative standard for learning objective design, classification, authoring, review, validation, and maintenance.

It governs:

- objective quality;
- scope and granularity;
- Bloom classification;
- competency classification;
- review and validation;
- metadata consistency;
- traceability expectations.

Where this standard conflicts with prior LO conventions, this standard prevails.

Related authoritative references:

- docs/curriculum/educational-philosophy-vol1.md
- docs/curriculum/curriculum-decision-register.yml (especially CURR-004, CURR-005, CURR-021, CURR-022)
- docs/traceability/learning-objective-metadata-model.md
- docs/traceability/identifier-conventions.md

## 1. Governing Principles

### 1.1 Learning Objectives Are Alignment Anchors

Learning objectives anchor alignment across:

Competency
  -> Learning Objective
  -> Chapter Content
  -> Learning Activity
  -> Assessment

An LO MUST therefore be usable for curriculum design, student communication, traceability, and assessment alignment.

### 1.2 Bloom and Competency Are Independent Dimensions

Bloom level and competency MUST be assigned independently.

- Bloom describes cognitive demand.
- Competency describes dominant capability.

Classification MUST NOT be inferred mechanically from a verb alone.

### 1.3 One Primary Competency, Optional Secondary

Every active LO MUST have exactly one primary competency.

Allowed primary competency values are fixed to:

- technical_skills
- statistical_reasoning
- professional_judgment

A secondary competency MAY be recorded only when justified under Section 7.

### 1.4 Volume 1 Professional Judgment Boundary

In Volume 1, professional_judgment is limited to evaluating what conclusions are and are not justified by statistical evidence.

Volume 1 LOs SHOULD NOT be framed as:

- audit strategy design;
- engagement-level planning;
- full audit-response selection;
- design of an integrated portfolio of audit procedures.

If an LO crosses this boundary, it MUST be rewritten, moved to Volume 2, or explicitly justified in governance notes.

## 2. Definition of a Valid Learning Objective

A valid LO is a concise statement of an observable capability that a student should demonstrate after instruction.

A valid LO normally contains:

1. one principal cognitive action;
2. a clear object of that action;
3. context or condition only where needed;
4. an observable or assessable outcome.

Examples:

- Good: Interpret a confidence interval for a population mean in the context of the audit question.
- Weak: Understand confidence intervals.
- Not an LO: Complete the regression workshop.

Canonical form:

Action + Object + Optional Context

## 3. Authoring Rules

### 3.1 Core Rules

LO text MUST:

- use one principal active verb;
- use observable and assessable language;
- describe a learning outcome, not a learning activity;
- remain concise and specific.

LO text MUST NOT:

- use vague verbs as core action (know, learn, appreciate, unqualified understand);
- bundle independently assessable outcomes into one LO;
- include unnecessary methodological detail at chapter level;
- exist only to satisfy a taxonomy quota.

### 3.2 Multiple Verbs Rule

Multiple verbs are acceptable only when they describe one integrated performance.

Overloaded example:

- Calculate the estimate, explain the interval, evaluate the assumptions, and design an audit response.

This SHOULD be split into separate LOs.

### 3.3 Activity-vs-Outcome Rule

Statements beginning with complete, perform exercises, discuss in class, or similar activity wording are not compliant LOs unless rewritten as outcomes.

## 4. Scope and Granularity

### 4.1 Scope Types and Intended Use

Permitted scope types in curriculum design are:

- chapter
- section
- workshop

Intended use:

- Chapter scope: primary alignment anchor for student communication, curriculum planning, and traceability.
- Section scope: only when a section develops a distinct capability not adequately represented by chapter scope and the additional maintenance cost is justified.
- Workshop scope: usually represented through mapping to chapter or section objectives; distinct workshop LOs SHOULD exist only when a workshop develops a genuinely separate capability.

### 4.2 Current Implementation Profile (Binding)

Under CURR-021 and LO migration decisions, the active canonical model is chapter-only.

- Active section and workshop LOs are not part of the current canonical active architecture.
- Legacy section-level records may remain as retired historical records.

This standard defines general scope principles while preserving the currently binding chapter-only implementation profile.

### 4.3 Granularity Rules

An LO is too broad when one or more are true:

- it spans several independent capabilities;
- it cannot be assessed through one coherent performance;
- achievement cannot be determined clearly;
- it uses umbrella phrasing (for example, understand regression analysis).

An LO is too narrow when one or more are true:

- it describes one isolated command or mechanical step;
- it captures an incidental example detail;
- it creates traceability overhead without educational value.

Granularity test:

Can this objective govern a meaningful unit of teaching and be assessed through one coherent performance or a closely related performance set?

If no, revise.

No fixed LO count per chapter is allowed as a quality rule.

## 5. Bloom Classification Standard

### 5.1 Required Bloom Field

Every active LO MUST have exactly one Bloom level from:

- remember
- understand
- apply
- analyze
- evaluate
- create

### 5.2 Decision Process

Assign Bloom by evaluating:

- actual cognitive performance;
- performance context;
- independence expected;
- complexity of evidence/problem;
- whether diagnosis, comparison, judgment, or design is required.

Verb alone is insufficient.

### 5.3 Operational Definitions and Examples

Remember:

- Retrieve or recognize facts, assumptions, formulas, definitions, or terminology.
- Example: Recall assumptions of the hypergeometric model.

Understand:

- Explain meaning, summarize concepts, distinguish related ideas, interpret straightforward representations.
- Example: Explain why finite population correction affects precision.

Apply:

- Use a known method in a familiar or clearly specified setting.
- Example: Construct a two-sided confidence interval under stated assumptions.

Analyze:

- Decompose evidence, compare alternatives, diagnose assumptions, identify why outcomes differ.
- Example: Diagnose whether residual patterns indicate model misspecification.

Evaluate:

- Judge quality, appropriateness, validity, strength, or limitations against explicit criteria.
- Example: Evaluate whether evidence supports the stated threshold conclusion.

Create:

- Design or construct a coherent analysis, simulation, model, or solution not fully specified in advance.
- Example: Design a simulation to test estimator behavior under defined assumptions.

### 5.4 Classification Cautions

- Using software is not automatically apply.
- Interpreting output is not automatically understand.
- Evaluating diagnostics is often statistical_reasoning, not automatically professional_judgment.
- Create-level tasks may still be technical_skills or statistical_reasoning depending on dominant capability.

## 6. Competency Classification Standard

### 6.1 Fixed Competency Vocabulary

Primary competency MUST be one of:

- technical_skills
- statistical_reasoning
- professional_judgment

No additional competency category may be introduced without formal governance decision.

### 6.2 Competency Decision Process

Classify by dominant demonstrated capability.

technical_skills when dominant capability is executing, calculating, coding, validating, implementing, or constructing method outputs correctly.

statistical_reasoning when dominant capability is interpreting, explaining, comparing, diagnosing, or reasoning about assumptions, uncertainty, variation, and model behavior.

professional_judgment when dominant capability is evaluating what evidence supports, what it does not support, what uncertainty remains, and whether additional evidence is needed.

### 6.3 Same Bloom, Different Competency

Examples at evaluate level:

- Evaluate numerical accuracy of a confidence interval calculation.
  - Primary competency: technical_skills
- Evaluate whether model assumptions justify interpretation of coefficients.
  - Primary competency: statistical_reasoning
- Evaluate whether statistical evidence supports the recorded revenue amount.
  - Primary competency: professional_judgment

## 7. Primary and Secondary Competency Rules

### 7.1 Primary Competency Rule

Every active LO MUST have exactly one primary competency.

### 7.2 Secondary Competency Rule

A secondary competency MAY be recorded only when all are true:

- the outcome materially requires the second capability;
- the secondary capability is necessary to demonstrate the objective;
- recording it improves curriculum interpretation.

Secondary competency MUST NOT be added merely because statistical work eventually affects judgment.

Example:

- Interpret estimator precision and explain how that precision limits the audit conclusion.
  - Primary: statistical_reasoning
  - Secondary: professional_judgment

## 8. Review and Validation Criteria

### 8.1 Reviewer Checklist

Reviewer must be able to answer yes to all applicable checks:

1. Is the outcome observable and assessable?
2. Is there one dominant performance?
3. Is scope appropriate?
4. Is granularity appropriate (neither broad nor narrow)?
5. Is Bloom classification correct for actual demand?
6. Is primary competency correctly assigned?
7. If secondary competency exists, is it justified?
8. Is the objective within Volume 1 boundary?
9. Is it supported by chapter content?
10. Can it be taught, practised, or assessed?
11. Does it avoid duplication with active objectives?
12. Is it an outcome rather than an activity statement?

### 8.2 Rejection Reasons and Remedies

- Vague/non-observable wording.
  - Remedy: rewrite with explicit action and object.
- Overloaded objective.
  - Remedy: split into separate LOs.
- Scope mismatch.
  - Remedy: promote to chapter level or retire into mapping metadata according to implementation profile.
- Bloom mismatch.
  - Remedy: reclassify based on demand, not verb.
- Competency mismatch.
  - Remedy: reclassify by dominant capability.
- Outside Volume 1 judgment boundary.
  - Remedy: rewrite to evidence-evaluation boundary or defer to Volume 2.
- Duplicate active objective.
  - Remedy: merge or retire duplicate.

## 9. Relationship to Assessment and Traceability

Each active LO should be traceable to where it is:

- taught;
- practised;
- assessed.

However, this standard does not require every LO to have:

- a unique exercise;
- both workshop and review mappings;
- representation in every artifact type.

Coverage reports identify potential gaps. Human review determines educational significance.

## 10. Metadata Consistency Standard

### 10.1 Required Metadata Fields

Active LO records MUST maintain consistent use of:

- stable id
- chapter
- scope
- text
- bloom
- primary competency representation
- status
- source

Optional fields may include section (for legacy retired section records), notes, and migration rationale fields.

### 10.2 Current Schema Compatibility

Current canonical file metadata/traceability/learning_objectives.yml uses field name competency.

Interpretation under this standard:

- competency currently represents primary competency.

secondary_competency is conceptually supported by this standard but is not introduced as a mandatory schema field in this revision.

If secondary competency must be persisted structurally, it SHOULD be delivered as a controlled follow-up change with validator and reporting updates.

### 10.3 Identifier Stability

LO identifiers MUST be stable and never repurposed for new outcome meaning.

## 11. Quality Rule Set (LO-001 to LO-012)

The following rule IDs remain binding and map to this standard:

- LO-001: Single primary action
- LO-002: Clear learning object
- LO-003: Assessability
- LO-004: Bloom assigned and demand-consistent
- LO-005: Competency assigned and valid
- LO-006: Scope compliance with active implementation profile
- LO-007: Granularity compliance
- LO-008: Activity-vs-outcome separation
- LO-009: Traceability link presence or approved exception
- LO-010: Metadata conformance
- LO-011: Stable identifier governance
- LO-012: Language and form consistency

## 12. Examples and Corrections

### 12.1 Good Objective

- Interpret a prediction interval in relation to materiality and explain its evidential implication.

### 12.2 Vague Objective (Incorrect)

- Understand regression models.

Correction:

- Explain what residual behavior indicates about model reliability.

### 12.3 Overloaded Objective (Incorrect)

- Calculate estimates, explain assumptions, evaluate sufficiency, and design audit response.

Correction:

- Construct interval estimates under stated assumptions.
- Evaluate whether resulting uncertainty supports the proposed conclusion.

### 12.4 Activity Statement as Objective (Incorrect)

- Complete workshop 5.2.

Correction:

- Apply model diagnostics to identify influential observations.

### 12.5 Bloom Misclassification Example

- Define point estimation. Bloom: apply (incorrect for most uses).

Likely correction:

- Bloom: remember (or understand if explanatory demand is explicit).

### 12.6 Competency Misclassification Example

- Evaluate model assumptions for interpretation validity. Competency: professional_judgment (often incorrect if no conclusion-sufficiency judgment is required).

Likely correction:

- Primary competency: statistical_reasoning.

## 13. Design Restraint

This standard intentionally avoids:

- scoring systems;
- mandatory numerical Bloom distributions;
- fixed LO counts per chapter;
- new governance layers;
- metadata expansion without demonstrated value;
- rules that cannot be applied consistently.

The objective is to reduce disagreement and rework, not create compliance burden.

## 14. Compliance Statement

An LO is compliant when:

- it satisfies the valid-objective definition;
- form and authoring rules are met;
- scope and granularity are appropriate;
- Bloom and competency are correctly and independently assigned;
- metadata is valid and stable;
- traceability expectations are satisfied or exceptions are approved;
- LO-001 through LO-012 pass, or approved exceptions exist.

Non-compliant objectives MUST be corrected before inclusion in the canonical active curriculum set.
