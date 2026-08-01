# Curriculum Decision Register: Extraction and Coverage Report

**Issue:** #232  
**Branch:** `issue-232-curriculum-decision-register`  
**Generated:** 2026-07-28  
**Status:** First extraction and analysis

## 2026-08-01 Addendum: CURR-021 Adoption Analysis

This addendum records the governance analysis used to create CURR-021
("Learning Objective Authoring Standard is authoritative curriculum policy").

### Supporting decisions

- CURR-004 (Bloom taxonomy classification): provides mandatory Bloom classification foundation adopted as binding by CURR-021.
- CURR-008 (LO alignment anchor): provides alignment and mapping architecture formalized into mandatory controls by CURR-021.
- CURR-012 (ID stability): provides persistence contract required for governed migration and re-audit continuity.
- CURR-014 (validation fail-loudly): provides the validation-governance mechanism expanded by CURR-021 through LO-001 to LO-012 controls.

### Qualified decisions

- CURR-005: CURR-021 qualifies LO governance form and classification expectations used to express audit-evidence capabilities.
- CURR-007: CURR-021 clarifies that workshop/review distinctness does not remove the requirement for explicit LO traceability controls.
- CURR-015: CURR-021 confirms student-facing display policy remains text-oriented while internal governance is strengthened.

### Superseded decisions

- CURR-011 is superseded for active-architecture scope policy.
- CURR-021 replaces the mixed chapter/section active-scope model with chapter-only active scope.

### Open questions resolved by CURR-021

- Scope ambiguity is resolved: active LOs are chapter-only.
- Competency-model ambiguity is resolved: only technical_skills, statistical_reasoning, professional_judgment.
- Audit Judgment category ambiguity is resolved: governed inside professional_judgment, not a fourth category.
- Validation-policy ambiguity is resolved: LO-001 to LO-012 are binding governance controls.

### Baseline evidence grounding

- `docs/curriculum/learning-objective-authoring-standard.md` is adopted as authoritative policy.
- `docs/curriculum/lo-compliance-audit.md` provides baseline measurements for migration governance:
	- 114 active LOs audited;
	- 11 active section-level legacy LOs;
	- 97 active LOs without explicit traceability links;
	- competency and metadata conformance gaps.

## Purpose and Scope

This report documents the extraction, analysis, and validation of curriculum-related architectural decisions from the ADA repository. It accompanies `docs/curriculum/curriculum-decision-register.yml`, which contains machine-readable decision data.

The scope includes:

- **Repository documentation**: Architecture files, traceability specifications, authoring guides.
- **Curriculum metadata**: Learning objective models, identifier conventions, mapping structures.
- **Manuscript structure**: Chapter organization, workshop roles, exercise design principles.
- **Educational philosophy**: Principles about single-source-of-truth, audit judgment focus, pedagogical alignment.
- **Quality assurance**: Validation policies, publication gates, consistency requirements.

## Extraction Methodology

### Phase 1: Source Discovery

Searched the repository for files containing curriculum-related keywords and concepts:

- Documentation files in `docs/architecture/`, `docs/authoring/`, `docs/traceability/`
- Metadata files in `metadata/traceability/`
- Manuscript source files (`ada_volume1.tex`, `ada_volume2.tex`, `chap*.tex`)
- Repository-wide grep searches for: "learning objective", "Bloom", "competency", "educational", "curriculum", "pedagogy", "assessment", "exercise", "learning goal"

### Phase 2: Evidence Extraction

For each identified decision, collected:

- **Source location**: File path, line range, section heading where decision is stated or implied.
- **Quotation**: Direct excerpt from source material.
- **Status assessment**: Confirmed (explicit + implemented), Inferred (implemented but not documented), Proposed (documented but not fully implemented), Open (raised but unresolved), Superseded (replaced by newer decision).
- **Confidence level**: High (strong evidence), Medium (reasonable inference), Low (tentative).
- **Rationale**: Why this decision matters.
- **Implications**: Consequences for curriculum design and maintenance.

### Phase 3: Relationship Mapping

Identified relationships between decisions:

- **Supports**: Decision A is a prerequisite or foundation for Decision B.
- **Depends_on**: Decision A cannot be implemented without Decision B.
- **Qualifies**: Decision A modifies or refines the scope of Decision B.
- **Conflicts_with**: Decision A is incompatible with Decision B.
- **Supersedes**: Decision A replaces Decision B.
- **Superseded_by**: Decision A is replaced by Decision B.

### Phase 4: Gap Analysis

Identified gaps where:

- Decisions are proposed but implementation status is unclear.
- Decisions apply to specific chapters but are not documented as chapter-specific.
- Open questions exist without resolution.
- Coverage reports are mentioned but not found in repository.

## Summary Statistics

### Decision Count by Status

| Status | Count | Notes |
|---|---|---|
| **Confirmed** | 14 | Explicitly stated and consistently implemented |
| **Inferred** | 3 | Consistently implemented but not formally documented |
| **Proposed** | 2 | Documented proposals, unclear implementation status |
| **Open** | 0 | No unresolved decision threads identified |
| **Superseded** | 0 | No replacement relationships identified |
| **TOTAL** | 20 | Comprehensive first extraction |

### Decision Count by Domain

| Domain | Count | Example Decisions |
|---|---|---|
| **Educational Purpose** | 2 | Single source, Audit judgment connection |
| **Learning Objectives** | 6 | LO granularity, Bloom classification, ID stability |
| **Audit Judgment** | 3 | Judgment focus, Regression restructuring, Technique-evidence connection |
| **Workshop Role** | 5 | Support.Rmd source, Notebook equivalence, Exercise design |
| **Curriculum Governance** | 4 | Validation, ID stability, Exporter architecture |
| **Chapter Architecture** | 1 | Regression chapter restructuring |
| **Quality Assurance** | 2 | Validation failure, Publication gates |
| **Other** | Several | Case design, Instructor materials, Assessment |

### Decision Count by Applies_To

| Applies_To | Count | Description |
|---|---|---|
| **Whole Curriculum** | 3 | Affect all educational content |
| **Manuscript** | 7 | Book structure and generation |
| **Chapters** | 4 | Chapter-level pedagogy and design |
| **Workshops** | 9 | Workshop authoring, generation, publication |
| **Exercises** | 7 | Exercise design and pedagogy |
| **Learning Objectives** | 7 | LO specification and governance |
| **Review Questions** | 3 | Assessment and coverage |
| **Repository** | 3 | Institutional policies and infrastructure |

## Confirmed Themes

### Theme 1: Single Canonical Source

Five decisions collectively define the principle that one authoritative source produces all derived materials:

- **CURR-001**: Single source of truth principle
- **CURR-002**: Support.Rmd as canonical source
- **CURR-006**: Distribution notebooks generated automatically
- **CURR-020**: Generated content never becomes independent source
- **CURR-016**: Book generation from validated-execution, not hand-edits

**Implication**: The entire curriculum infrastructure is designed around preventing divergence. Violations of this principle (e.g., manually editing generated notebooks) create silent inconsistencies that cascade across student materials.

### Theme 2: Educational Content Must Connect to Audit Practice

Four decisions require that statistical and methodological content remain explicitly grounded in audit evidence and professional judgment:

- **CURR-005**: Technique-to-audit-evidence connection
- **CURR-009**: Shift from calculation to judgment objectives
- **CURR-010**: Regression chapter restructuring around judgment
- **CURR-008**: Learning objectives as alignment anchor

**Implication**: This curriculum is not teaching statistics in the abstract; it is teaching statistics for auditors. Every technique must answer the question: "Why does this matter for audit conclusions?"

### Theme 3: Learning Objective Traceability Infrastructure

Six decisions establish the governance and infrastructure for learning objective management:

- **CURR-004**: Bloom taxonomy classification
- **CURR-008**: LO alignment anchor
- **CURR-011**: Granularity (chapter vs. section)
- **CURR-012**: ID stability
- **CURR-013**: Metadata editability
- **CURR-014**: Validation failure
- **CURR-015**: Display (text, not IDs)

**Implication**: The repository has invested substantially in traceability infrastructure. This infrastructure is intended to support curriculum alignment audits and gap analysis. The system is designed for both human authors and automated validation.

### Theme 4: Workshop Architecture as Pedagogical Centerpiece

Five decisions define workshop as the primary pedagogical delivery mechanism:

- **CURR-002**: Support.Rmd as source
- **CURR-003**: R/Python educational equivalence
- **CURR-006**: Clean distribution notebooks
- **CURR-017**: Exporter architecture freeze
- **CURR-018**: Stable behavior + chapter variability

**Implication**: Workshops are not optional supplements; they are the primary instructional format. The entire notebook generation, validation, and publication pipeline exists to deliver workshops reliably and consistently. Any future curriculum enhancement must work within this architecture.

### Theme 5: Clear Separation of Publication and Development Concerns

Three decisions prevent confusion about where students get materials and what development artifacts are:

- **CURR-006**: Distribution notebooks without outputs
- **CURR-016**: Book generation from validated-execution, not distribution
- **CURR-019**: Canonical publication target is workbooks

**Implication**: The publication boundary is intentional and well-guarded. Distribution (notebooks without outputs) and book generation (from validated-executed notebooks) follow different paths. This allows students to run code interactively while the book presents fixed, validated results.

## Inferred Principles

In addition to explicit decisions, the repository's structure and repeated implementations reflect these inferred principles:

### Inferred Principle A: Pedagogical Distinctness of Workshop and Assessment

**Evidence**: The metadata structure in `metadata/traceability/learning_objectives.yml` supports many-to-many mapping between objectives and exercises, and between objectives and review questions. The absence of a requirement that every objective has both is deliberate.

**Implication**: Workshop exercises and review questions serve distinct purposes. Workshops scaffold learning; review questions assess independence. These should not be forced to align one-to-one.

**Decision Candidate**: CURR-007 (currently "inferred")

### Inferred Principle B: Author Ownership of Curriculum

**Evidence**: Metadata uses YAML, Markdown, and plain text (not databases or binary formats). Version control is the authoritative storage. Documentation is meant to be readable in the repository and in diffs.

**Implication**: Curriculum designers and instructors are expected to own their curriculum documentation. If it required special tools or expertise, they would avoid it and it would become unreliable.

**Decision Candidate**: CURR-013 (currently "confirmed" but could be higher profile)

## Open Questions

These issues are raised by the curriculum documentation but not yet fully resolved:

### Question A: Current Bloom Level Deployment

**Status**: Bloom taxonomy is defined in the traceability model (CURR-004), and Bloom levels are proposed in the regression objectives review (CURR-009).

**Open Issue**: Are Bloom levels currently:
- Assigned to all learning objectives?
- Validated in automated checks?
- Displayed in student-facing materials (syllabi, notebooks)?
- Used to analyze curriculum balance (e.g., % of recall vs. evaluate objectives)?

**Evidence Gap**: No repository file documents current Bloom level assignment or usage patterns across all chapters.

### Question B: Implementation Status of Judgment-Focused Regression Objectives

**Status**: CURR-009 and CURR-010 are documented as proposals in a specific branch.

**Open Issue**: Has the Regression chapter been restructured? Are the proposed objectives now implemented? Is this a model for other chapters?

**Evidence Gap**: The regression-learning-objectives-review.md is a proposal, but there is no evidence file showing that it has been implemented in `chap07.tex` or that chapter content has been reorganized.

### Question C: Learning Objective Coverage Gaps

**Status**: CURR-008 states that LOs are the alignment anchor and that gaps in mapping indicate problems.

**Open Issue**: Are there current coverage gaps? Which learning objectives lack mapped exercises? Which lack review questions? What is the prioritization for remediation?

**Evidence Gap**: No coverage report file was found showing current gap analysis.

### Question D: Chapter-Specific Curriculum Decisions

**Status**: CURR-010 focuses on the Regression chapter specifically, but many curriculum decisions are stated at whole-curriculum level.

**Open Issue**: Which curriculum decisions have chapter-specific variations? For example, should different chapters prioritize different Bloom levels? Should all chapters follow the judgment-centered objective structure?

**Evidence Gap**: No documented policy for chapter-specific decision customization.

### Question E: Validation Automation Coverage

**Status**: CURR-014 requires that validation "fail loudly" but does not specify which checks are implemented.

**Open Issue**: Which validation rules are currently automated? Which exist only as manual review checklist? Which are aspirational (documented but not implemented)?

**Evidence Gap**: No validation specification or implementation audit was found.

## Unresolved Conflicts

### Potential Conflict: Granularity vs. Student Clarity

**CURR-011** (Granularity decision) permits both chapter and section-level objectives. **CURR-015** (Display decision) suggests prioritizing chapter-level for students. There is a potential conflict if:

- Section-level objectives are so numerous that displaying all of them creates cognitive overload.
- Chapter-level objectives are so broad that they lack actionability for instructors.

**Status**: This is not a contradiction, but a design tension that may require negotiation in implementation.

## Recommended Review Sequence

If reviewing or implementing curriculum decisions, the recommended order is:

1. **Start with principles** (CURR-001, CURR-002, CURR-005): Understand the educational philosophy.
2. **Then traceability infrastructure** (CURR-008, CURR-004, CURR-011, CURR-012): Understand how LOs are managed.
3. **Then workshop architecture** (CURR-017, CURR-018, CURR-006, CURR-003): Understand how content is authored and delivered.
4. **Then publication and governance** (CURR-019, CURR-013, CURR-014, CURR-020): Understand publication contracts and quality gates.
5. **Then proposals and open items** (CURR-009, CURR-010): Understand proposed enhancements and their status.

## Coverage Gaps

### Gap 1: Interleaving of Topics

**Issue**: The current learning objectives structure does not seem to have an explicit curriculum sequencing decision. Are topics intentionally sequenced? Are prerequisites defined? Is spiral curriculum used?

**Recommendation**: Extract or create explicit curriculum sequencing decisions.

### Gap 2: Python-Specific Pedagogy

**Issue**: While CURR-003 requires educational equivalence, there is no decision about whether Python-specific examples, libraries, or pedagogical approaches should differ.

**Recommendation**: Document whether Python has distinct pedagogical goals or whether it is purely a translation of R content.

### Gap 3: Instructor Materials and Supplementary Content

**Issue**: Several decisions mention "instructor materials" but there is no explicit curriculum decision about instructor resources.

**Recommendation**: Create decisions about instructor materials design, version control, and relationship to student-facing content.

### Gap 4: Assessment Beyond Review Questions

**Issue**: CURR-008 mentions assessment but focuses on review questions. What about projects, case studies, or formative assessment?

**Recommendation**: Expand assessment decisions to include full spectrum of assessment types.

### Gap 5: Accessibility and Inclusive Design

**Issue**: No curriculum decision addresses accessibility (alt text, color contrast, screen reader compatibility, language accessibility).

**Recommendation**: If accessibility is a curriculum value, create explicit decisions about it.

## Validation Results

The curriculum-decision-register.yml file has been validated for:

- ✅ Valid YAML syntax (schema_version, generated_for_issue, decisions array, each decision structure)
- ✅ Unique decision IDs (CURR-001 through CURR-020, no duplicates)
- ✅ Controlled vocabulary for status, confidence, domains, applies_to
- ✅ Required fields present in all decision objects (id, title, domain, decision, status, confidence, rationale, implications, applies_to, evidence, related_decisions)
- ✅ Evidence items have required source_type and path fields
- ✅ Related decisions reference only valid IDs (no forward references to undefined decisions)
- ✅ No self-referential relationships

See `docs/curriculum/curriculum-decision-register-validation.sh` for automated validation script.

## Next Steps

### Immediate (This PR)

1. ✅ Create YAML register with 20 initial decisions
2. ✅ Create this coverage report
3. ✅ Create validation script
4. ✅ Commit to feature branch and create PR

### Short-term (Follow-up Issues/PRs)

1. Implement missing validation automation (Question E)
2. Audit coverage gaps (Question C)
3. Document Python-specific pedagogy decision (Gap 2)
4. Create curriculum sequencing decisions (Gap 1)
5. Clarify Bloom level deployment status (Question A)

### Medium-term (Curriculum Enhancement)

1. Implement judgment-focused regression objectives (Question B)
2. Apply similar restructuring to other chapters (Question B)
3. Create instructor materials curriculum decisions (Gap 3)
4. Expand assessment decisions to cover all types (Gap 4)
5. Create accessibility and inclusive design decisions (Gap 5)

## Conclusion

The ADA curriculum is built on strong, explicitly documented architectural principles. The single-source-of-truth principle, combined with the requirement that techniques connect to audit evidence, provides a coherent framework. The learning objective traceability infrastructure is ambitious and well-designed.

However, several decisions are still proposed or partially implemented. The register will serve as the baseline for (1) confirming implementation status of known proposals, (2) identifying gaps in curriculum coverage or alignment, and (3) tracking future curriculum enhancements with clear evidence trails.

This first extraction establishes the foundation. Continued expansion and refinement of the register will improve curriculum governance and transparency.
