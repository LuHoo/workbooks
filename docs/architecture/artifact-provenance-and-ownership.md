# Artifact Provenance and Ownership

Date: 2026-07-13

## Scope

This document defines artifact provenance and generated-file ownership for the canonical notebook generation and publication architecture in this repository.

It covers:

- canonical authoring;
- parsing and IR generation;
- student-facing notebook generation;
- notebook publication;
- notebook execution;
- LaTeX workshop generation;
- book assembly;
- traceability reporting;
- Binder publication boundary;
- companion-site publication boundary.

This document is local/static and workflow-agnostic. It does not require GitHub Actions or Binder execution.

## Terminology

- Canonical: authoritative source-of-truth content authored by humans.
- Intermediate: generated handoff artifacts used between pipeline stages.
- Generated: reproducible artifacts intended as outputs of canonical producers.
- Published: generated artifacts copied/synchronized into a publication repository or endpoint.
- Temporary: run artifacts used for validation/diagnostics and not intended as long-lived source.
- Authoritative producer: the single script/renderer/build command that owns generation of a class of artifacts.

## Canonical Source Hierarchy

Authoritative source order:

1. Canonical educational source notebooks: `notebooks/support/**/support.Rmd`.
2. Canonical workshop export registry: `metadata/workshop-registry.R` (loaded via `scripts/workshop-export-config.R`).
3. Canonical traceability metadata: `metadata/traceability/*.yml`.
4. Canonical book manuscripts and chapter `.tex` sources at repository root.

Generated artifacts are never independent sources of truth.

## Artifact Lifecycle

1. Author canonical source (`support.Rmd`, config, metadata).
2. Parse to IR (`scripts/workshop-ir.R`) and validate (`scripts/workshop-ir-validate.R`).
3. Generate distribution notebooks:
   - Python `.ipynb`: `scripts/export-python-notebooks.R` -> `scripts/workshop-ir-python-renderer.py`.
   - R workshop `.Rmd`: `scripts/export-workshops.R`.
4. Publish Python distribution copies to binder-facing workbooks: `scripts/publish-python-notebooks.R`.
5. Execute generated notebooks for quality gates:
   - Python execution artifacts: `scripts/ci/execute-generated-python-notebooks.py`.
   - R smoke execution artifacts: `scripts/ci/execute-r-workshop-smoke.R`.
6. Generate book-facing workshop `.tex` fragments: `scripts/export-workshop-output.R`.
7. Build final book PDFs via LaTeX build commands/tasks.

## Authoritative Producer Principle

Every generated artifact class must have exactly one authoritative producer.

Rule:

- Defects must be corrected at the earliest authoritative source or transformation stage, then downstream artifacts must be regenerated.

Anti-rule:

- No manual patching of generated outputs to “fix” downstream symptoms.

## Artifact Ownership Matrix

| Artifact class | Path pattern | Status | Producer | Manual edit | Committed | Published |
|---|---|---|---|---|---|---|
| Canonical support notebooks | `notebooks/support/**/support.Rmd` | canonical | human authoring | yes | yes | indirectly (via generated outputs) |
| Workshop export registry | `metadata/workshop-registry.R` | canonical | human authoring | yes | yes | no |
| Workshop config adapter | `scripts/workshop-export-config.R` | derived adapter | `metadata/workshop-registry.R` | no | yes | no |
| Notebook manifest compatibility layer | `scripts/notebook-manifest.R` | derived compatibility | `scripts/workshop-export-config.R` | no | yes | no |
| Traceability metadata | `metadata/traceability/*.yml` | canonical | human authoring | yes | yes | no |
| Workshop IR snapshots | `generated/ir/*.json` or temp IR from `scripts/export-python-notebooks.R` | intermediate | `scripts/workshop-ir.R` | no | no (temp), optional in diagnostics | no |
| Generated Python notebooks | `generated/python-notebooks/**/chapter-*.ipynb` | generated (distribution staging) | `scripts/export-python-notebooks.R` + `scripts/workshop-ir-python-renderer.py` | no | no | yes (copied onward) |
| Published Python notebooks | `notebooks/workshops/Workshop * (Python).ipynb` | published generated copy | `scripts/publish-python-notebooks.R` | no | yes (submodule repo) | yes |
| Generated R workshop notebooks | `notebooks/workshops/*.Rmd` | generated distribution | `scripts/export-workshops.R` | no | yes (submodule repo) | yes |
| Executed Python notebooks | `generated/notebook-execution-artifacts/executed/*.ipynb` | temporary | `scripts/ci/execute-generated-python-notebooks.py` | no | no | no |
| Executed R smoke outputs | `generated/notebook-execution-artifacts/r-smoke/*.md` | temporary | `scripts/ci/execute-r-workshop-smoke.R` | no | no | no |
| Generated workshop LaTeX fragments | `generated/workshop-output/exercise-*.tex` | generated book artifact | `scripts/export-workshop-output.R` | no | yes | no |
| Generated traceability reports | `generated/traceability/*` | generated report | `scripts/generate-traceability-reports.R` and `scripts/ci/validate-parity-and-traceability.R` | no | mixed (some committed) | no |
| Generated validation reports | `generated/validation/local-validation-report.json`, `generated/validation/parity-traceability-*`, `generated/notebook-execution-artifacts/*.json` | temporary/diagnostic | CI/local validation scripts | no | no | no |
| Final PDF outputs | `*.pdf` at repo root | build artifact | LaTeX build command/task | no | no (ignored) | external distribution |
| Companion-site static pages | `index.html`, `contact.html` | canonical site content | human authoring | yes | yes | yes (site host) |

## Provenance Model

Minimum consistent provenance fields for generated artifacts:

- canonical source path (`source_file` or deterministic source mapping);
- workshop/config identifier (`workshop_id`, chapter id/number);
- artifact type (`python-distribution`, `r-distribution`, `workshop-tex`, `executed-notebook`, etc.);
- producer identity (script/renderer path);
- schema/version (`schema_version`, renderer version when applicable);
- upstream artifact identity (exercise id/ref, block id, source block key where applicable);
- target language;
- lifecycle category (`distribution`, `executed`, `published`, `book-facing`).

Not required by default:

- volatile generation timestamp in distribution artifacts.
- environment-specific absolute paths.

### Provenance Matrix

| Artifact class | Source path | Producer metadata | Schema/version | Upstream identity |
|---|---|---|---|---|
| Python distribution notebook (`generated/python-notebooks/**`) | embedded `metadata.ada_renderer.source_file` | embedded `metadata.ada_renderer.version`, `target_language` | embedded IR schema + renderer version | embedded cell `metadata.traceability` fields |
| Published Python notebook copy (`notebooks/workshops/Workshop * (Python).ipynb`) | inherited from generated notebook metadata | inherited from generated notebook metadata; publish script now validates presence | inherited | inherited |
| R distribution workshop notebook (`notebooks/workshops/*.Rmd`) | generated-file header comment includes source path | header indicates generated file | no explicit schema version | deterministic mapping via `metadata/workshop-registry.R` |
| Workshop LaTeX fragments (`generated/workshop-output/exercise-*.tex`) | generated-file header includes source | generated by canonical exporter stage | implicit via exporter contract/docs | deterministic filename: exercise/chunk identity |
| Traceability reports (`generated/traceability/*`) | deterministic metadata directory + script args | report file path and generating script | CSV/Markdown report format | LO/workshop/review IDs from canonical metadata |
| Executed notebooks/reports (`generated/notebook-execution-artifacts/**`) | derived from generated notebook paths | execution report JSON records runtime and notebook path | tool-specific JSON format | notebook filename + failing cell index where relevant |

Provenance source layers:

1. Embedded in artifact:
   - Python notebooks (`metadata.ada_renderer`, cell traceability).
   - Generated R notebooks / LaTeX fragments (header comments).
2. Deterministic path conventions:
   - chapter/workshop mapping via filename and config id.
3. Sidecar manifests/reports:
   - parity/traceability reports and execution report JSON.
4. Git history:
   - commit-level provenance for canonical source changes and publication pointer updates.

## Ownership Rules

### Canonical source files

- Owner: maintainers/authors.
- Creation/overwrite: manual authoring only.
- Manual edit: allowed.
- Commit: required.
- Publish: indirectly via generators.
- Defect correction: edit canonical source/config/metadata and regenerate all downstream artifacts.

### Generated but committed files

- Owner: authoritative generator script.
- Creation/overwrite: generator only.
- Manual edit: not allowed.
- Commit: allowed only as generated outputs.
- Publish: allowed if publication target requires committed generated files.
- Defect correction: fix producer or upstream canonical source, then regenerate.

### Temporary generated files

- Owner: validation/execution script that produced them.
- Creation/overwrite: local/CI validation pipeline only.
- Manual edit: not allowed.
- Commit: not allowed.
- Publish: not allowed.
- Defect correction: rerun pipeline after upstream fix.

### Published copies in other repositories

- Owner: publication script and target repository maintainers.
- Creation/overwrite: publication sync only.
- Manual edit: not allowed in target copies.
- Commit: yes in publication repository as synchronized generated artifacts.
- Publish: yes.
- Defect correction: fix in canonical repository and republish.

### Generated documentation and validation reports

- Owner: generating report script.
- Manual edit: not allowed.
- Commit: case-by-case; committed only if intentionally tracked project report.
- Publish: optional.
- Defect correction: fix source metadata/validation logic and regenerate.

### Final build outputs

- Owner: build command/toolchain.
- Manual edit: not allowed.
- Commit: not allowed.
- Publish: external release/distribution only.
- Defect correction: fix TeX/canonical source or generation pipeline, rebuild.

## Manual-Edit Policy

- Canonical sources: manual edits are allowed and expected.
- Generated artifacts: manual edits are prohibited.
- Published generated copies: manual edits are prohibited.
- Temporary artifacts: manual edits are prohibited.

## Commit Policy

- Commit canonical source/config/metadata changes.
- Commit generated artifacts only when repository policy requires them as distribution/book inputs.
- Do not commit temporary execution artifacts.

## Publication Policy

- Publication is copy/sync of generated artifacts, not an independent authoring stage.
- Publication scripts must not perform semantic transformations.
- Publication must fail if required provenance metadata is absent from generated artifacts.

## Correction and Regeneration Workflow

1. Identify the earliest stage that introduced the defect.
2. Correct that stage only (canonical source or authoritative producer).
3. Regenerate all downstream artifacts.
4. Re-run local validation gates.
5. Publish synchronized artifacts if required.

## Repository-to-Repository Responsibility Matrix

| Repository | Canonical source | Generated artifacts | Published artifacts | Direct edits |
|---|---|---|---|---|
| `ada` (this repository) | yes | yes | indirectly (via submodule sync) | canonical files only |
| `workbooks` (submodule `notebooks/workshops`) | no | receives generated outputs | yes (binder/student-facing) | no direct edits to generated notebook artifacts |

## Conformance Snapshot (Current State)

- Clear single producer:
  - Python distribution notebooks.
  - Python publication copy step.
  - Workshop LaTeX fragments.
  - Traceability report generation.
  - Executed Python artifacts.
- Multiple producers or transitional paths:
  - R distribution notebooks currently use direct parser path rather than IR-renderer path.
  - Probability wrapper contains legacy Python notebook fallback for `.tex` export.
- Producer unclear/not documented:
  - semantic reference metadata layer is not implemented as a dedicated artifact class.

## Minimal Guardrails Implemented

1. Publish-time provenance validation
   - `scripts/publish-python-notebooks.R` now validates required `metadata.ada_renderer` fields and rejects absolute/temp source paths before publication copy.
2. Temporary artifact commit guardrail
   - `.gitignore` now ignores `generated/notebook-execution-artifacts/`.
3. Generated artifact edit-policy guardrail
   - `scripts/ci/check-generated-python-notebooks.py --checks hygiene --published-dir notebooks/workshops` validates that published Python notebooks match canonical generated outputs.
   - Validation fails when published notebook artifacts are manually edited or out-of-sync with generated mapping.
   - Remediation is explicit: update canonical source, regenerate, republish, and commit regenerated artifacts.
4. Policy documentation
   - this document defines ownership, provenance minimums, and correction flow.

## Optional Machine-Readable Manifest Decision

Decision: not implemented now.

Rationale:

- ownership-critical mapping now lives in canonical registry `metadata/workshop-registry.R`, with `scripts/workshop-export-config.R` and `scripts/notebook-manifest.R` retained only as derived adapter/compatibility layers;
- adding a new YAML ownership manifest now would duplicate source mappings without a live consumer;
- deterministic and maintainable behavior is currently achieved via existing scripts plus this architecture policy.

Future trigger to add `metadata/artifact-ownership.yml`:

- if a linter/validator is introduced that programmatically enforces producer ownership and edit policy from one machine-readable source.

## Maintenance Guidance

- Update this document whenever new artifact classes or publication targets are introduced.
- Keep ownership aligned with actual write paths in scripts, not inferred names.
- If a second script can write an existing artifact class, explicitly classify that as transitional and document deprecation plan.
- Keep provenance deterministic: avoid volatile timestamps and absolute local paths in distribution artifacts.

## Notes on Input Document Path

Requested input `docs/canonical-notebook-generation.md` is not present in this repository at the time of writing.

Equivalent architecture context was derived from:

- `README.md`;
- `docs/architecture/canonical-notebook-generation-conformance.md`;
- `docs/architecture/generation-publication-permissions-audit.md`;
- `docs/architecture/deterministic-notebook-generation.md`.
