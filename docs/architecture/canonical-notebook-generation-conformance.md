# Canonical Notebook Generation Conformance Report

Date: 2026-07-13  
Scope: local/static inspection only (no workflow execution, no code changes)

Related policy:

- `docs/architecture/artifact-provenance-and-ownership.md`

## Context and source-of-truth note

This review is anchored to the Architecture Decision Record text provided by the project owner on 2026-07-13:

- "Architecture Decision Record: Canonical Notebook Generation and Publication Architecture" (Status: Proposed; related issues #108, #89, #90)

Repository-grounded conformance was assessed through static inspection of implementation and supporting architecture documents, including:

- `docs/architecture/workshop-model-renderer-separation.md`
- `docs/architecture/workshop-ir-python-renderer.md`
- `docs/architecture/workshop-ir-schema-v1.md`
- `docs/architecture/workshop-ir-validation.md`
- `docs/architecture/binder-notebook-execution.md`
- `README.md`, `notebooks/README.md`

Note: the ADR text is treated as authoritative for this report even though the exact ADR filename/path appears to differ across references (`architecture` vs `atchitecture`, and decision-record naming variants).

## Conformance legend

- `conforms`
- `partially conforms`
- `does not conform`
- `not yet implemented`

## 1) Canonical authoring sources

Classification: `conforms`

Implementation (files/functions):

- Canonical source declaration in docs: `notebooks/README.md`, `README.md`
- Workshop source registry: `scripts/workshop-export-config.R`
  - `get_workshop_export_configs()`
  - `resolve_workshop_export_config()`
  - `resolve_workshop_export_config_by_id()`
- Derived compatibility manifest: `scripts/notebook-manifest.R`

Conformance evidence:

- Canonical support notebooks are consistently referenced as `notebooks/support/<slug>/support.Rmd`.
- Both R chunk export and Python notebook export resolve source paths through config.
- Public R notebook metadata is now derived from `scripts/workshop-export-config.R` via `get_notebook_manifest()`.

Gaps / duplicated paths / obsolete logic:

- `support/analytical-procedures/support.Rmd` is documented as canonical/private-only in `notebooks/README.md` but is outside the configured export graph; this is intentional but increases drift risk if undocumented in ADR form.

Smallest remediation:

- Keep `scripts/workshop-export-config.R` as the only hand-authored workshop registry and derive compatibility views from it.

## 2) Workshop Model / IR parsing

Classification: `conforms`

Implementation (files/functions):

- Parser: `scripts/workshop-ir.R`
  - `parse_support_notebook_to_ir()`
  - directive parsing/validation helpers (`parse_directive_attrs()`, `make_parse_error()`, etc.)
- IR validator: `scripts/workshop-ir-validate.R`
  - `validate_workshop_ir()`
  - `validate_support_notebook_ir()`
- Model wrapper: `scripts/workshop-model.R`
  - `build_workshop_model()`
  - `as_workshop_model()`
- IR schema: `scripts/workshop-ir-schema-v1.json`

Conformance evidence:

- Deterministic IR with explicit schema version, directives, source spans, and block identity.
- Validation catches structural, directive, and config-compatibility errors with actionable diagnostics.

Gaps / duplicated paths / obsolete logic:

- Validator docs still mention v1.0 language in places, while implementation accepts v1.0 and v1.1.

Smallest remediation:

- Align validation doc wording to current accepted schema versions and directive set.

## 3) R notebook generation

Classification: `partially conforms`

Implementation (files/functions):

- Public R workshop generation: `scripts/export-workshops.R`
  - `export_workshops()`
  - `export_notebook()`
  - `strip_support_only()`
  - `strip_language_overrides()`
- Render entrypoint: `scripts/render-notebooks.R`

Conformance evidence:

- R workbooks are generated from canonical support notebooks.
- Support-only and Python directive regions are excluded from public R exports.

Gaps / duplicated paths / obsolete logic:

- `export-workshops.R` re-implements directive parsing/stripping independently of IR/model layer.
- This creates a second parser path, conflicting with the ADR "Parse once, render many" principle.

Smallest remediation:

- Refactor `export-workshops.R` to consume IR/model output instead of line-based directive parsing.

## 4) Python notebook generation

Classification: `partially conforms`

Implementation (files/functions):

- Orchestration: `scripts/export-python-notebooks.R`
  - `resolve_configs()`
  - `render_config()`
- Renderer: `scripts/workshop-ir-python-renderer.py`
  - `validate_ir_structure()`
  - `resolve_blocks_for_language()`
  - `render_notebook()`
  - `write_notebook()`
  - cell constructors `as_markdown_cell()` / `as_code_cell()`

Conformance evidence:

- Renderer consumes IR JSON and writes deterministic notebooks with stable metadata and empty outputs.
- Language-aware directives and overrides are resolved before cell generation.

Gaps / duplicated paths / obsolete logic:

- Renderer contains substantial chapter-specific conversion heuristics and fallback logic (including `ada_run_r(...)` path for chapter 5), increasing maintenance burden and risking divergence from source intent.
- Python generation quality depends on embedded conversion rules beyond pure IR mapping.

Smallest remediation:

- Move chapter-specific transformations into explicit source-level Python overrides (`ADA:BEGIN ...`) and shrink renderer heuristics to generic mapping.

## 5) Distribution notebooks without outputs

Classification: `partially conforms`

Implementation (files/functions):

- Notebook generation contract: `scripts/workshop-ir-python-renderer.py`
  - `as_code_cell()` sets `execution_count = None` and `outputs = []`
- Publication copy step: `scripts/publish-python-notebooks.R`
  - `publish_python_notebooks()`

Conformance evidence:

- Generated notebooks are created output-free by design.

Gaps / duplicated paths / obsolete logic:

- Publish step copies notebooks without re-validating output-free contract.
- If a non-canonical notebook is placed in input dir, outputs could leak to distribution.

Smallest remediation:

- Add a lightweight pre-publish validation step that fails if any code cell has non-empty outputs or non-null execution count.

## 6) Controlled notebook execution

Classification: `partially conforms`

Implementation (files/functions):

- Local control gate: `scripts/ci/local-notebook-validation-gate.sh`
- Python execution with timeout and structured failure diagnostics: `scripts/ci/execute-generated-python-notebooks.py`
  - `execute_notebook()`
  - `find_error_cell()`
- R smoke execution: `scripts/ci/execute-r-workshop-smoke.R`

Conformance evidence:

- Execution flow is ordered and explicitly gated (generate -> guardrail -> parity -> execute).
- Python execution uses per-cell timeout and artifact output.

Gaps / duplicated paths / obsolete logic:

- R execution is smoke-only for two notebooks, not full workshop coverage.

Smallest remediation:

- Expand R execution set to all exported R workshop notebooks (or define/document explicit chapter sampling policy in ADR).

## 7) Executed-notebook validation

Classification: `partially conforms`

Implementation (files/functions):

- Raw syntax guardrail: `scripts/ci/check-generated-python-notebooks.py`
- Cross-language parity: `scripts/ci/assert-r-python-equivalence.py`
- Structural parity/traceability checks: `scripts/ci/validate-parity-and-traceability.R`
  - `run_exercise_parity()`
  - `run_lo_mapping_parity()`
  - `run_fsaudit_coverage()`

Conformance evidence:

- Validation exists for syntax contamination, parity, LO mapping, and required FSAudit block coverage.

Gaps / duplicated paths / obsolete logic:

- Validation stack is strong, but fragmented across multiple scripts with overlapping assumptions.
- No single local command emits a consolidated pass/fail report for all ADR validation stages (generation, notebook, execution, book) plus publication readiness.

Smallest remediation:

- Add one aggregator script that runs all validation steps and emits one canonical machine-readable report.

## 8) R notebook-to-LaTeX rendering

Classification: `conforms`

Implementation (files/functions):

- Canonical chunk export CLI: `scripts/export-workshop-output.R`
  - `export_single_chunk()`
  - `export_workshop_by_config_id()`
- Renderer boundary: `scripts/workshop-renderer.R`
  - `create_workshop_renderer()`
  - `render_workshop_chunk()`
- LaTeX backend: `scripts/workshop-renderer-latex.R`
  - `render_latex_workshop_chunk()`
  - `render_r_chunk_to_latex()`
  - `markdown_to_latex()`
  - `compose_tex_document()`
  - `validate_generated_output()`

Conformance evidence:

- R to LaTeX pipeline is explicit, structured, and renderer-separated.
- IR path is default and legacy parser is explicit rollback mode.

Gaps / duplicated paths / obsolete logic:

- Legacy parser path still exists (`--parser-engine legacy`), which is intentional rollback but extra maintenance surface.

Smallest remediation:

- Keep legacy path but add deprecation criteria/timeline in architecture docs.

## 9) Python notebook-to-LaTeX rendering

Classification: `partially conforms`

Implementation (files/functions):

- Notebook-to-TeX exporter: `scripts/export-python-workshop.py`
  - `export_notebook()`
  - `render_markdown_cell()`
  - `render_code_cell()`
  - `metadata_export_context()`
- Chapter wrapper currently invoking it: `scripts/export-probability-distributions-workshop.R`

Conformance evidence:

- Python notebook to LaTeX conversion exists and validates generated metadata when requested.

Gaps / duplicated paths / obsolete logic:

- Integration appears chapter-specific (chapter 1 wrapper) rather than uniform across all Python chapters.
- Wrapper includes legacy fallback to `notebooks/python/workshop02_python.ipynb`, indicating non-canonical path still active.

Smallest remediation:

- Route all Python-to-LaTeX exports through generated IR notebooks only; remove legacy notebook fallback once migration is complete.

## 10) Publication to workbooks and audit-data-analysis

Classification: `partially conforms`

Implementation (files/functions):

- Workbooks publication copy: `scripts/publish-python-notebooks.R`
  - `publish_python_notebooks()`
- Workbooks linkage: `.gitmodules` (`notebooks/workshops` -> `https://github.com/LuHoo/workbooks.git`)
- Binder/docs references: `notebooks/workshops/README.md`, `docs/architecture/binder-notebook-execution.md`

Conformance evidence:

- Publication path to `workbooks` (submodule) is explicit.

Gaps / duplicated paths / obsolete logic:

- No local script explicitly publishes to a separate `audit-data-analysis` target; relationship is indirect/documented rather than codified in repository tooling.

Smallest remediation:

- Add a local publication contract document/script clarifying whether this repository itself is the audit-data-analysis target or whether a second explicit publish target exists.

## 11) Binder-facing ownership

Classification: `partially conforms`

Implementation (files/functions):

- Binder readiness checker: `scripts/ci/binder-launch-smoke.py`
- Root Binder config: `.binder/*`
- Workbooks Binder config in submodule: `notebooks/workshops/.binder/*`
- Ownership reference: `.gitmodules`, `notebooks/workshops/README.md`

Conformance evidence:

- Binder-facing deployment ownership points to `LuHoo/workbooks`.
- Binder launch smoke script targets external binder repo/ref via CLI.

Gaps / duplicated paths / obsolete logic:

- Binder config exists in both root and `notebooks/workshops/.binder`, and key runtime pins diverge (for example runtime snapshots and package install strategy differ), increasing drift risk around ownership of the authoritative Binder environment.

Smallest remediation:

- Declare a single authoritative Binder config location (preferably `workbooks`) and add synchronization checks for any mirrored files.

## 12) Semantic reference handling

Classification: `not yet implemented`

Implementation (files/functions):

- Available related metadata primitives:
  - `scripts/workshop-ir.R` (`traceability.source_block_key` emission)
  - `scripts/traceability-id-conventions.R`
  - `scripts/traceability-metadata.R`
- Book-level cross-reference analysis artifact: `cross_references_analysis.txt`

Conformance evidence:

- Traceability IDs and source spans exist, but there is no notebook-generation layer that resolves/maintains semantic references as a first-class architecture feature.

Gaps / duplicated paths / obsolete logic:

- README explicitly states: "No reference system ... implemented in this milestone."
- No dedicated resolver for semantic references across IR -> notebook -> LaTeX publication path.

Smallest remediation:

- Implement a minimal semantic reference resolver at IR level (stable reference IDs + resolution checks) and enforce it during notebook and LaTeX export validation.

## Summary matrix

| Principle | Classification |
|---|---|
| 1. canonical authoring sources | partially conforms |
| 2. Workshop Model / IR parsing | conforms |
| 3. R notebook generation | partially conforms |
| 4. Python notebook generation | partially conforms |
| 5. distribution notebooks without outputs | partially conforms |
| 6. controlled notebook execution | partially conforms |
| 7. executed-notebook validation | partially conforms |
| 8. R notebook-to-LaTeX rendering | conforms |
| 9. Python notebook-to-LaTeX rendering | partially conforms |
| 10. publication to workbooks and audit-data-analysis | partially conforms |
| 11. Binder-facing ownership | partially conforms |
| 12. semantic reference handling | not yet implemented |

## Highest-value minimal remediations (ordered)

1. Commit the ADR text into a stable in-repo path (for example `docs/architecture/canonical-notebook-generation.md`), and cross-link all implementation docs to that single ADR.
2. Remove non-canonical Python-to-LaTeX fallback path (`notebooks/python/workshop02_python.ipynb`) after migration.
3. Add pre-publish notebook hygiene check (enforce output-free distribution notebooks).
4. Decide and document one authoritative Binder config owner and add drift detection between root and submodule Binder files.
5. Define and implement first-class semantic reference handling in IR + export validation.
