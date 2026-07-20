# Notebook Generation and Publication Architecture

Date: 2026-07-13

This document is the canonical architecture overview for notebook generation,
validation, publication, and Binder-facing runtime integration in the ADA
ecosystem.

It documents the implementation that exists in this repository now, including
transitional paths that remain after issue #90.

For deep implementation details, use the linked specialized documents.

## Scope and Evidence Sources

Implementation evidence was validated against:

- canonical authoring and export scripts in `scripts/`
- CI workflows in `.github/workflows/`
- Binder configuration under `.binder/` and `notebooks/workshops/.binder/`
- repository boundaries (`.gitmodules`)
- specialized architecture docs under `docs/architecture/`
- root usage docs in `README.md` and `notebooks/README.md`

## 1. Repository Responsibilities

| Repository | Canonical source or published artifacts | Direct editing policy | Generation / publication / execution role | Binder relationship |
|---|---|---|---|---|
| `LuHoo/ada` (this repository) | Canonical authoring inputs (`notebooks/support/**/support.Rmd`), export configuration, IR/parser/renderer logic, validation scripts | Canonical inputs and scripts: yes. Generated artifacts: should be regenerated, not hand-fixed | Generates Rmd, Python notebooks, LaTeX fragments, validation reports; publishes to `workbooks` via submodule workflow | Contains Binder config and Binder readiness tooling; hosted launch smoke targets `LuHoo/workbooks` |
| `LuHoo/workbooks` (submodule `notebooks/workshops`) | Published student-facing notebook artifacts (Rmd and renamed Python `.ipynb`) | Generated notebook artifacts should not be manually edited | Receives publication copies from ADA export workflow; acts as Binder-facing notebook content repo | Primary Binder launch target (`mybinder.org` URLs, launch smoke default target) |
| `LuHoo/audit-data-analysis` (companion site, external to this checkout) | Companion website/docs layer (as referenced by binder architecture docs) | Not governed by this repo's generation scripts | Does not perform notebook generation in this repository; links users to Binder target repository | Referenced as linking Binder usage to `LuHoo/workbooks`; no Binder runtime files are maintained here per current architecture docs |

Current-state note:

- Although this repository is named `ada`, `README.md` title still uses
  `audit-data-analysis`. Operationally, generation and publication automation in
  this checkout is authoritative for notebook production.

## 2. Canonical Source Model

Canonical source model is split across content, config, and metadata:

- Canonical authored workshop content:
  - `notebooks/support/**/support.Rmd`
- Workshop export configuration:
  - `metadata/workshop-registry.R` (authoritative)
  - `scripts/workshop-export-config.R` (loader/adapter)
- Derived compatibility manifest for older callers:
  - `scripts/notebook-manifest.R`
- Traceability metadata:
  - `metadata/traceability/*.yml`

Language-aware and support directives are authored in `support.Rmd` and parsed
by the IR parser:

- `<!-- SUPPORT-ONLY:START -->` / `<!-- SUPPORT-ONLY:END -->`
- `<!-- ADA:BEGIN ... -->` / `<!-- ADA:END -->`
- `<!-- ADA:REQUIRES capability=... -->`

Ownership boundary:

- Source ownership: workshop pedagogical content and directive intent in
  `support.Rmd`.
- Configuration ownership: workshop/chapter registry, expected chunk structure,
  and publication naming/path conventions in scripts.

Current-state note:

- `metadata/workshop-registry.R` is the only hand-authored workshop registry.
- `scripts/notebook-manifest.R` is a derived compatibility layer produced from that registry at load time.

## 3. Parsing and Neutral Representation

Implemented parse path:

`support.Rmd` -> `scripts/workshop-ir.R` -> Workshop IR JSON/model

Core components:

- Parser: `scripts/workshop-ir.R`
- Schema: `scripts/workshop-ir-schema-v1.json` (`workshop-ir/1.1.0`)
- Validator: `scripts/workshop-ir-validate.R`
- Model wrapper: `scripts/workshop-model.R`

IR contains:

- deterministic exercise/block ordering and stable IDs (`exercise_id`, `block_id`)
- source spans and traceability keys
- language-aware authoring context (`base`, `only`, `override`)
- directive instance records and requirements (`fsaudit` capability)

Semantic interpretation boundary:

- Parsing and structural interpretation are intended to occur once in IR/model.
- Current implementation still includes a transitional direct parser path for
  R notebook publication and legacy LaTeX parsing mode (see section 4).

## 4. Rendering Paths

### 4.1 Book-facing LaTeX

Implemented path:

`support.Rmd` -> (legacy parser or IR adapter) -> LaTeX renderer -> `exercise-*.tex` -> ADA book include

Scripts:

- Entry: `scripts/export-workshop-output.R`
- Renderer boundary: `scripts/workshop-renderer.R`
- LaTeX backend: `scripts/workshop-renderer-latex.R`
- IR adapter path: `scripts/workshop-ir-adapter.R`

Current-state note:

- Parser engine defaults to `ir`.
- Explicit `--parser-engine legacy` remains available as rollback mode while
  transition policy is active.
- Current lifecycle stage is `Stage 1 — Preferred IR Default`.
- Deprecation governance and review checkpoints are defined in
  `docs/architecture/legacy-parser-deprecation-policy.md`.

### 4.2 Student-facing R notebooks

Implemented path:

`support.Rmd` -> support/language filtering -> `notebooks/workshops/*.Rmd`

Script:

- `scripts/export-workshops.R`

Current-state note:

- This path does not consume IR/model today; it reparses source with direct
  marker logic (`strip_support_only`, `strip_language_overrides`).

### 4.3 Student-facing Python notebooks

Implemented path:

`support.Rmd` -> IR parse + validate -> Python renderer -> `generated/python-notebooks/**/chapter-<n>.ipynb` -> publication mapping -> `notebooks/workshops/Workshop <n> (Python).ipynb`

Scripts:

- Orchestrator: `scripts/export-python-notebooks.R`
- Renderer: `scripts/workshop-ir-python-renderer.py`
- Publication mapping/copy: `scripts/publish-python-notebooks.R`

Metadata/provenance behavior:

- notebook metadata contains `metadata.ada_renderer` with renderer version,
  target language, schema version, workshop/chapter IDs, and source file.
- cell metadata contains per-cell traceability (`exercise_ref`, `block_id`,
  source span/key).

Execution behavior:

- generated distribution notebooks are output-free
  (`execution_count = null`, `outputs = []`).
- execution happens later in validation/runtime stages, not during generation.

## 5. Generation Versus Publication

Architectural separation in current implementation:

- Generation:
  - `scripts/export-workshops.R`
  - `scripts/export-python-notebooks.R`
  - `scripts/export-workshop-output.R`
- Validation:
  - `scripts/ci/check-generated-python-notebooks.py`
  - `scripts/ci/assert-r-python-equivalence.py`
  - `scripts/ci/validate-parity-and-traceability.R`
  - `scripts/ci/execute-r-workshop-smoke.R`
  - `scripts/ci/execute-generated-python-notebooks.py`
- Publication:
  - `scripts/publish-python-notebooks.R`
  - `.github/workflows/export-workshops.yml` export job
- Deployment/runtime:
  - Binder configuration in `.binder/`
  - Binder-facing publication repository `LuHoo/workbooks`
  - hosted checks in `.github/workflows/binder-readiness.yml`

Current-state note:

- Publication currently performs mapping/copy and stale cleanup; it does not
  execute notebooks.
- Publication permissions are workflow-level `contents: write` in
  `export-workshops.yml` (hardening tracked separately).

## 6. Validation Layers

### Layer 1: Source and structural validation

- Tools:
  - `scripts/workshop-ir-validate.R`
  - parser constraints in `scripts/workshop-ir.R`
- Proves:
  - source structure, directive validity, schema/model consistency,
    config compatibility.
- Does not prove:
  - execution success, Binder launchability, publication synchronization.
- Local availability: yes.
- Required when: changing support notebooks, directives, parser/schema behavior.

### Layer 2: Deterministic generation validation

- Current implementation:
  - deterministic behavior is encoded in parser/renderer design and tests
    (stable ordering/IDs, canonical JSON serialization), but there is no
    dedicated repository-wide deterministic dual-run verifier script in this
    branch.
- Proves:
  - component-level deterministic intent and repeatability checks where tests
    exist.
- Does not prove:
  - full end-to-end reproducibility across all generated artifacts in one gate.
- Local availability: partial.
- Required when: making parser/renderer/output-contract changes.

### Layer 3: Local execution and parity validation

- Tools:
  - `scripts/ci/run-local-validation.py`
  - `scripts/ci/local-notebook-validation-gate.sh`
  - `scripts/ci/check-generated-python-notebooks.py`
  - `scripts/ci/assert-r-python-equivalence.py`
  - `scripts/ci/validate-parity-and-traceability.R`
  - `scripts/ci/execute-r-workshop-smoke.R`
  - `scripts/ci/execute-generated-python-notebooks.py`
- Proves:
  - deterministic generation validation, strict notebook hygiene checks,
    parity checks, deterministic sampled R execution, runtime viability for
    generated notebooks, and publication-readiness against published artifacts.
- Does not prove:
  - hosted Binder service availability, publication repo drift on remote, or
    full R workshop execution coverage.
- Local availability: yes.
- Required when: before publication/export and before hosted checks.

Canonical local validation report:

- entrypoint: `scripts/ci/run-local-validation.py`
- machine-readable report: `generated/validation/local-validation-report.json`
- stage order: generation validation -> notebook hygiene -> parity -> notebook execution -> publication-readiness

R workshop execution coverage policy:

- Policy name: `deterministic-sampling-v2`
- Policy name: `deterministic-sampling-v2`
- Enforced by: `scripts/ci/execute-r-workshop-smoke.R`
- Invoked by:
  - `.github/workflows/notebook-execution-validation.yml`
  - `.github/workflows/export-workshops.yml`
  - `scripts/ci/local-notebook-validation-gate.sh`
- Deterministic selection set:
  - `notebooks/workshops/Hypothesis testing workshop.Rmd`
  - `notebooks/workshops/Regression analysis workshop.Rmd`
- Guarantee provided:
  - execution gate validates runtime health and integration for this representative, fixed subset;
    failure in any selected notebook fails the execution gate.
- Not guaranteed:
  - successful execution of every generated/published R workshop notebook.

### Layer 4: Hosted publication and Binder validation

- Tools/workflows:
  - `.github/workflows/notebook-execution-validation.yml`
  - `.github/workflows/export-workshops.yml`
  - `.github/workflows/binder-readiness.yml`
- Proves:
  - CI runtime reproducibility, publication gating in hosted environment,
    Binder build/launch readiness on mybinder targets.
- Does not prove:
  - correctness of unpublished local-only experiments.
- Local availability: no (hosted workflows required).
- Required when: merging/publishing changes that affect generated notebooks,
  runtime dependencies, or Binder behavior.

## 7. Artifact Ownership and Edit Policy

| Artifact class | Owner repository | Canonical or generated | Direct edit policy |
|---|---|---|---|
| `notebooks/support/**/support.Rmd` | `LuHoo/ada` | canonical | allowed |
| Workshop IR JSON/model | `LuHoo/ada` | generated | do not edit; regenerate |
| `generated/workshop-output/exercise-*.tex` | `LuHoo/ada` | generated | do not edit; regenerate |
| `notebooks/workshops/*.Rmd` (published student Rmd) | published in `LuHoo/workbooks` via submodule | generated | do not edit generated content directly |
| `generated/python-notebooks/**/chapter-*.ipynb` | `LuHoo/ada` | generated | do not edit; regenerate |
| `notebooks/workshops/Workshop <n> (Python).ipynb` | `LuHoo/workbooks` publication target | generated | do not edit generated content directly |

Generated Python notebook artifact edit-policy enforcement:

- Validator: `scripts/ci/check-generated-python-notebooks.py`
- Policy mode: `--checks hygiene --published-dir notebooks/workshops`
- Enforcement rule: every published Python notebook must match the canonical
  generated notebook mapping for its chapter.
- Violation behavior: fail with remediation guidance to modify canonical source,
  regenerate, and republish; direct/manual edits to published generated notebooks
  are rejected.

CI integration for policy enforcement:

- Pull request/runtime validation: `.github/workflows/notebook-execution-validation.yml`
- Publication workflow validation: `.github/workflows/export-workshops.yml`
- Local mirrored gate: `scripts/ci/local-notebook-validation-gate.sh`
  (compatibility wrapper for `scripts/ci/run-local-validation.py`)
| Binder runtime config under `.binder/` | `LuHoo/ada` (current tooling owner) | canonical runtime config | allowed with validation |
| Binder runtime config under `notebooks/workshops/.binder/` | `LuHoo/workbooks` | canonical in that repo | allowed in that repo; keep ownership/drift explicit |

Policy:

Fix the earliest authoritative source or transformation responsible for the
error, then regenerate and republish.

## 8. Provenance and Determinism

Current implementation records provenance through:

- IR schema version (`schema_version`) and source metadata
- stable block/exercise identifiers in IR
- renderer metadata in generated Python notebooks (`metadata.ada_renderer`)
- per-cell traceability metadata (`metadata.traceability`)

Determinism controls implemented:

- deterministic parser ordering and sequence checks
- stable cell IDs from deterministic seeds in renderer
- canonical notebook serialization (`sort_keys=True`, fixed indentation)
- output-free distribution notebooks

Current implementation gaps and caveats:

- IR field `generated_at_utc` is derived from source file mtime, so this field
  can vary if file timestamps change.

Reproducibility verification methods currently available:

- rerun `scripts/export-python-notebooks.R` on unchanged source and compare
  generated outputs;
- run `tests/workshop-ir/run-tests.R` and `tests/python-renderer/run-tests.py`;
- run `scripts/ci/run-local-validation.py` before publication.

## 9. Failure and Recovery Paths (High-level)

- Unexpected generated differences:
  - inspect canonical source and parser/renderer version boundaries first;
  - rerun IR validation and renderer tests.
- Publication drift:
  - regenerate artifacts in ADA, republish through mapping script/workflow,
    verify submodule pointer and target files.
- Notebook execution failures:
  - inspect execution artifacts and runtime diagnostics;
  - fix runtime/dependency/source issue at earliest authoritative layer.
- R/Python parity issues:
  - run parity scripts and traceability gates; resolve in source or renderer,
    not by patching generated notebooks.
- Stale Binder artifacts:
  - rerun publication flow, then hosted Binder readiness checks.
- Renderer rollback:
  - for LaTeX generation, switch back to legacy parser mode where needed,
    record fallback rationale, and re-evaluate retirement criteria at the next
    deprecation checkpoint;
  - for Python renderer regressions, fix renderer or revert renderer change and
    regenerate.

- Legacy parser lifecycle governance:
  - `docs/architecture/legacy-parser-deprecation-policy.md`

Specialized references:

- `docs/architecture/workshop-ir-migration-and-rollback.md`
- `docs/architecture/binder-notebook-execution.md`
- `docs/architecture/parity-traceability-gates.md`

## 10. Extension Guidance

For future changes, align with these architecture rules:

- New workshop or chapter:
  - add canonical source under `notebooks/support/<slug>/support.Rmd`
  - register in export configuration and manifests
  - extend validation and publication mappings.
- New renderer:
  - consume Workshop Model / IR only;
  - do not add a second parser for `support.Rmd`.
- New language override:
  - express through directive model and IR;
  - validate in parser/validator before renderer consumption.
- New publication target:
  - keep generation and validation unchanged;
  - add explicit publication mapping and ownership policy.
- New validation layer:
  - define exactly what it proves and what it does not prove;
  - keep layer outputs machine-readable where possible.
- Runtime dependency changes:
  - update `.binder/*`, CI install steps, and architecture docs together;
  - validate with local gate and hosted Binder checks.

Explicit rule:

A new renderer should consume the Workshop Model / IR and should not introduce
another parser for `support.Rmd`.

## Maintained Architecture Diagram

```mermaid
flowchart LR
  subgraph ADA[LuHoo/ada: Canonical Authoring and Generation]
    A[support.Rmd\nnotebooks/support/**]
    C[workshop-export-config.R\n+ manifest metadata]
    P[workshop-ir.R parser]
    V1[Source/IR validation\nworkshop-ir-validate.R]
    IR[Workshop IR / Model\nworkshop-ir/1.1.0]
    RGEN[R workshop publication generation\nexport-workshops.R\n(transitional direct parse)]
    PYGEN[Python generation\nexport-python-notebooks.R]
    PYREND[Python IR renderer\nworkshop-ir-python-renderer.py]
    LATEX[LaTeX chunk generation\nexport-workshop-output.R\nlegacy or IR adapter]
    VAL[Local/CI validation gates\ncheck-generated, parity, execution]
    PUBMAP[Publication mapping\npublish-python-notebooks.R]
    BOOK[ADA book build inputs\nexercise-*.tex]
    BCONF[Binder config and readiness tooling\n.binder/* + binder-readiness.yml]
  end

  subgraph WB[LuHoo/workbooks: Published Artifacts]
    WR[Published R workshops\n*.Rmd]
    WP[Published Python workshops\nWorkshop <n> (Python).ipynb]
    WBCONF[Workbooks Binder config\nnotebooks/workshops/.binder/*]
  end

  subgraph BND[Binder Runtime]
    BR[mybinder.org execution\nRStudio/JupyterLab]
  end

  A --> P --> V1 --> IR
  C --> P
  A --> RGEN --> WR
  IR --> PYGEN --> PYREND --> VAL --> PUBMAP --> WP
  A --> LATEX --> BOOK

  WR --> BR
  WP --> BR
  BCONF --> BR
  WBCONF --> BR

  classDef gen fill:#e8f3ff,stroke:#2c5aa0,color:#102a43;
  classDef val fill:#e8fbe8,stroke:#1f7a1f,color:#123b12;
  classDef pub fill:#fff5e6,stroke:#a65d03,color:#5b3200;
  class P,IR,RGEN,PYGEN,PYREND,LATEX gen;
  class V1,VAL val;
  class PUBMAP,WR,WP pub;
```

Boundary interpretation:

- Generation boundary: parsing and renderer production in ADA.
- Validation boundary: source/IR validation, parity, and execution checks before publication.
- Publication boundary: mapping/copy from generated outputs into workbooks.
- Repository ownership boundary: ADA generates; workbooks hosts published notebooks; Binder consumes published artifacts.

## Cross-links to Specialized Documents

- Workshop IR schema:
  - `docs/architecture/workshop-ir-schema-v1.md`
- Workshop IR validation:
  - `docs/architecture/workshop-ir-validation.md`
- Language-aware directives:
  - `docs/architecture/workshop-ir-directives.md`
- Model/renderer separation:
  - `docs/architecture/workshop-model-renderer-separation.md`
- Python renderer architecture:
  - `docs/architecture/workshop-ir-python-renderer.md`
- FSAudit bridge architecture:
  - `docs/architecture/fsaudit-rpy2-bridge.md`
- Binder validation architecture:
  - `docs/architecture/binder-notebook-execution.md`
- Parity and traceability gates:
  - `docs/architecture/parity-traceability-gates.md`
- IR migration and rollback:
  - `docs/architecture/workshop-ir-migration-and-rollback.md`

## Current vs Intended Architecture Summary

Current implemented:

- IR parser/validator/model exists and is production-used for Python generation.
- R workshop publication generation still uses direct source filtering path.
- LaTeX export defaults to IR parser with explicit legacy rollback mode.
- Publication is separated from generation and from execution validation.
- Binder launch smoke targets `LuHoo/workbooks` as runtime-facing repository.

Intended direction (tracked in existing issue set):

- full parse-once/render-many convergence for all generation paths;
- stronger publication guardrails and ownership clarity across Binder config locations;
- dedicated semantic reference layer and broader deterministic verification.