# Generation, Publication, and Permissions Architecture Audit

Date: 2026-07-13  
Method: static repository inspection only (no workflow execution, no Binder execution, no code/workflow changes)

Audit basis:

- ADR principles supplied by project owner in-chat (Canonical Notebook Generation and Publication Architecture)
- Implementation and docs currently in repository

## 1 Repository trust boundaries

### Boundary summary

This workspace contains one primary repository (`ada`) and one checked-out submodule (`notebooks/workshops`) pointing to `LuHoo/workbooks`.

`audit-data-analysis` appears to be this repository identity (root `README.md` title), while `workbooks` is the Binder-facing publication target.

### Repository boundary table

| Repository / boundary | Purpose | Canonical source? | Generated artifacts? | Published artifacts? | Expected manual edits? | Binder relationship |
|---|---|---|---|---|---|---|
| `ada` (this repo) | Authoring, IR parsing, rendering, validation, export orchestration, book build inputs | Yes (`notebooks/support/**/support.Rmd`, config, traceability metadata) | Yes (`generated/**`, `generated/python-notebooks/**`, `generated/workshop-output/**`, reports) | Indirect (publishes to `workbooks` submodule) | Yes for canonical sources/docs/scripts; no for generated outputs | Contains root `.binder/*` (validation/runtime context) and Binder readiness scripts |
| `workbooks` (submodule at `notebooks/workshops`) | Student-facing distribution notebooks (R and Python), Binder launch target | No (declared generated from private/canonical source) | Yes (generated into submodule by export workflow) | Yes (pushed to `LuHoo/workbooks:main`) | No for generated notebooks (README explicitly says do not edit directly) | Primary Binder target (`mybinder.org/v2/gh/LuHoo/workbooks/...`) |
| `audit-data-analysis` (name in root README) | Project/repo identity for ADA codebase and book workflow | Yes (same as `ada` canonical layer) | Yes | Not a separate publication target in scripts | Yes (canonical assets) | Binder links in docs point to `workbooks`, not separate binder config ownership |

Findings:

- Trust boundary between canonical authoring (`ada`) and student distribution (`workbooks`) is explicit and mostly clean.
- Binder config ownership is now cleanly modeled as authoritative ADA root `.binder/*` plus a required mirrored copy in `notebooks/workshops/.binder/*` for the Binder-facing publication target.

## 2 Artifact ownership

| Artifact | Canonical or generated | Authoritative producer | Publication target | Manual editing allowed | Conformance |
|---|---|---|---|---|---|
| `notebooks/support/**/support.Rmd` | Canonical | Human authoring | Inputs to generators (not published directly) | Yes | conforms |
| Workshop registry (`metadata/workshop-registry.R`) | Canonical | Human authoring | Internal | Yes | conforms |
| Traceability metadata (`metadata/traceability/**`) | Canonical | Human authoring | Internal validation/reporting | Yes | conforms |
| Semantic reference metadata | Intended canonical | Not implemented as dedicated layer | N/A | N/A | not implemented |
| Workshop IR JSON (ephemeral from `scripts/workshop-ir.R`) | Generated | `parse_support_notebook_to_ir()` | Internal handoff to renderers | No | conforms |
| Workshop model object (`scripts/workshop-model.R`) | Generated | `build_workshop_model()` | Internal handoff | No | conforms |
| Distribution R workshop notebooks (`notebooks/workshops/*.Rmd`) | Generated | `scripts/export-workshops.R` | `workbooks` submodule | No (policy says no direct edits) | partially conforms |
| Distribution Python notebooks (`generated/python-notebooks/**/chapter-*.ipynb`) | Generated | `scripts/export-python-notebooks.R` + `scripts/workshop-ir-python-renderer.py` | Staging for publication | No | conforms |
| Published Python notebooks (`notebooks/workshops/Workshop N (Python).ipynb`) | Generated | `scripts/publish-python-notebooks.R` copy/sync | `workbooks` submodule | No | partially conforms |
| Executed Python notebooks (`generated/notebook-execution-artifacts/executed/*.ipynb`) | Temporary generated | `scripts/ci/execute-generated-python-notebooks.py` | CI artifacts only | No | conforms |
| Executed R smoke outputs (`generated/notebook-execution-artifacts/r-smoke/*.md`) | Temporary generated | `scripts/ci/execute-r-workshop-smoke.R` | CI artifacts only | No | partially conforms |
| Generated workshop LaTeX chunks (`generated/workshop-output/exercise-*.tex`) | Generated | `scripts/export-workshop-output.R` -> LaTeX renderer | Book input | No | conforms |
| Python notebook-to-TeX (`workshop02_Python.tex`) | Generated | `scripts/export-python-workshop.py` via wrapper | Book input | No | partially conforms |
| Book-only LaTeX chapter files (`chap*.tex`, etc.) | Canonical | Human authoring | Book build | Yes | conforms |
| Final PDF/book outputs | Build artifact | TeX toolchain/task | Distribution output | No | conforms |

Key ownership findings:

- Most artifacts have one dominant producer.
- R distribution notebooks have a separate direct line-based generator (`export-workshops.R`) rather than a full IR-renderer path.
- Python LaTeX generation currently has a legacy fallback input (`notebooks/python/workshop02_python.ipynb`) in wrapper script, violating strict single-producer intent.

## 3 Generation pipeline

### Current generation path (observed)

1. Canonical source authoring in `notebooks/support/**/support.Rmd`.
2. Parser path to IR via `scripts/workshop-ir.R` (`parse_support_notebook_to_ir`).
3. IR validation via `scripts/workshop-ir-validate.R` (`validate_workshop_ir`).
4. Python distribution generation:
   - `scripts/export-python-notebooks.R` builds IR and invokes
   - `scripts/workshop-ir-python-renderer.py`.
5. R LaTeX chunk generation:
   - `scripts/export-workshop-output.R` default `--parser-engine ir`.
   - IR adapted through `scripts/workshop-ir-adapter.R`.
   - Rendered via `scripts/workshop-renderer-latex.R`.
6. Publication staging:
   - Python notebooks copied to submodule by `scripts/publish-python-notebooks.R`.
   - R distribution Rmd generated directly by `scripts/export-workshops.R`.

### Parsers, renderers, generators, execution, validation

- Parsers:
  - Primary: `scripts/workshop-ir.R`
  - Additional line parser behavior in `scripts/export-workshops.R` (support-only and language-region stripping)
- Renderers:
  - R/LaTeX: `scripts/workshop-renderer-latex.R`
  - Python notebook: `scripts/workshop-ir-python-renderer.py`
- Notebook generators:
  - R distribution: `scripts/export-workshops.R`
  - Python distribution: `scripts/export-python-notebooks.R`
- Execution steps:
  - Python execution: `scripts/ci/execute-generated-python-notebooks.py`
  - R smoke execution: `scripts/ci/execute-r-workshop-smoke.R`
- Validation steps:
  - IR validation: `scripts/workshop-ir-validate.R`
  - Python raw construct guardrail: `scripts/ci/check-generated-python-notebooks.py`
  - Parity/traceability: `scripts/ci/validate-parity-and-traceability.R`
  - R/Python equivalence: `scripts/ci/assert-r-python-equivalence.py`

### Duplicated generation paths

1. `export-workshop-output.R` includes explicit legacy parser rollback (`--parser-engine legacy`) in addition to IR path.
2. `export-workshops.R` performs direct source parsing/rewriting for R distribution instead of consuming IR model.
3. `export-probability-distributions-workshop.R` includes a legacy Python input fallback (`notebooks/python/workshop02_python.ipynb`) for TeX export.

Assessment: generation architecture is mostly aligned with parse-once/render-many intent, but not fully consolidated.

## 4 Publication pipeline

### Notebook publication

Primary steps:

- Source: `generated/python-notebooks/<config>/chapter-<n>.ipynb`
- Destination: `notebooks/workshops/Workshop <n> (Python).ipynb`
- Script: `scripts/publish-python-notebooks.R`
- Operation: file copy + stale file cleanup by naming pattern

Observed transformations in publication step:

- Path renaming: yes (`chapter-<n>.ipynb` -> `Workshop <n> (Python).ipynb`)
- Content rewriting: no
- Semantic transformation: no
- Metadata changes: no

### Workbooks synchronization

Workflow `export-workshops.yml` export job:

1. Runs export scripts to regenerate R and Python distribution notebooks.
2. Commits and pushes within submodule `notebooks/workshops` to `LuHoo/workbooks:main`.
3. Commits parent repo submodule pointer update.

### Book artifact production

Observed locally:

- R/LaTeX chunk generation via `scripts/export-workshop-output.R`.
- Python notebook-to-TeX via `scripts/export-python-workshop.py` (currently wrapper-integrated for probability chapter path).
- TeX build tasks available (`Build Volume 1`, `Build Volume 2`).

Publication-step transformation findings:

- Publication copy/sync itself is mostly non-semantic.
- Semantic transformations occur in generation/rendering scripts before publication (acceptable).
- Potential boundary blur: `export-workshops.R` rewrites headers/dates and strips language regions while generating R distribution notebooks; this is generation behavior, not publication behavior.

## 5 Workflow permissions

### Workflow-by-workflow analysis

#### `.github/workflows/export-workshops.yml`

- Triggers: push to `main` on generation-related paths; manual dispatch.
- Repositories touched:
  - current repo (`ada`)
  - submodule repo (`LuHoo/workbooks`) via push
- Declared permissions: `contents: write` (workflow-level)
- Writes performed:
  - commit/push to `workbooks` submodule
  - commit/push submodule pointer in parent repo
- Reads performed: checkout, tests, generation, validation
- Required permissions (best estimate):
  - preflight + validation jobs: `contents: read`
  - export/publish job: `contents: write`

Least-privilege opportunities:

- Narrow permissions to job-level (`read` for non-publish jobs, `write` only for export job).
- Use dedicated token scope for submodule push only in publish step.

#### `.github/workflows/notebook-execution-validation.yml`

- Triggers: push/PR on notebook/ci/binder/traceability paths; manual dispatch.
- Repositories touched: current repo only.
- Declared permissions: `contents: read`.
- Writes performed: no repo writes; artifact uploads only.
- Required permissions (best estimate): `contents: read` (current is appropriate).

#### `.github/workflows/binder-readiness.yml`

- Triggers: PR/push on binder files, schedule, manual dispatch.
- Repositories touched:
  - current repo (checkout)
  - external Binder launch endpoint target `LuHoo/workbooks` (read/launch probe only)
- Declared permissions: `contents: read`.
- Writes performed: no repo writes; artifact logs upload.
- Required permissions (best estimate): `contents: read` (appropriate).

#### `.github/workflows/workshop-ir-tests.yml`

- Triggers: push/PR on IR/renderer/tests/docs paths; manual dispatch.
- Repositories touched: current repo only.
- Declared permissions: `contents: read`.
- Writes performed: none.
- Required permissions (best estimate): `contents: read` (appropriate).

### Duplicate responsibilities

- `export-workshops.yml` and `notebook-execution-validation.yml` both run significant overlap in dependency install, renderer regression tests, generation, and execution checks.
- This duplication increases CI maintenance and can drift in dependency/runtime assumptions.

## 6 Provenance

### Provenance chain target

Expected chain per architecture:

`support.Rmd` -> IR -> renderer -> distribution notebook -> execution validation -> executed notebook -> notebook->LaTeX -> book

### Observed chain status

- `support.Rmd` -> IR: present (`scripts/workshop-ir.R`)
- IR -> Python distribution notebook: present (`export-python-notebooks.R` + renderer)
- Python distribution -> publication to workbooks: present (`publish-python-notebooks.R`)
- Python distribution -> executed notebook artifact: present (`execute-generated-python-notebooks.py`)
- Executed notebook -> book renderer: partially present (generic `export-python-workshop.py` exists, but workflow integration is chapter-/wrapper-specific rather than full uniform pipeline)
- `support.Rmd` -> R distribution Rmd: present but via direct script parsing (`export-workshops.R`) not explicit IR renderer
- R executed notebook -> book pipeline: partially represented (R smoke execution and R LaTeX chunk generation both exist, but full executed-notebook-as-single-source-for-book step is not explicitly enforced end-to-end)

Broken/weak provenance links:

1. R student distribution notebook generation bypasses IR layer (`export-workshops.R` line-based stripping path).
2. Python TeX export wrapper for probability chapter has legacy fallback source (`notebooks/python/workshop02_python.ipynb`), which weakens strict provenance from canonical source.
3. No dedicated semantic-reference provenance chain implemented (reference metadata/resolution layer absent).

## 7 Architectural conformance

Classification against supplied architectural principles:

| Principle | Status | Why |
|---|---|---|
| `support.Rmd` is canonical educational source | conforms | Source docs and scripts consistently treat support notebooks as canonical authoring input |
| Workshop Model / IR is only renderer-neutral representation | partially conforms | IR is primary for Python and LaTeX chunk path, but R distribution generation still uses direct source parsing path |
| Student-facing R and Python notebooks are generated artifacts | conforms | Both are generated via scripts and docs mark them as non-manual |
| Distribution notebooks contain no outputs | partially conforms | Python renderer enforces empty outputs; publication step does not re-validate; R Rmd naturally has no execution outputs but rendered HTML exists separately |
| Executed notebooks are temporary build artifacts | partially conforms | Python executed notebooks are artifacts under generated dir; R execution is smoke output markdown and not full chapter set |
| Book generation consumes validated executed notebooks | partially conforms | Components exist but end-to-end enforcement is incomplete/uneven across R/Python |
| Publication never performs semantic transformations | conforms | Publication scripts mostly copy/rename and prune stale files; semantic transforms occur earlier during generation |
| Generated artifacts are never edited manually | partially conforms | Policy/documentation says no manual edits, but repository contains generated artifacts committed in submodule and no hard guard prevents manual edits |
| Every generated artifact has exactly one authoritative producer | partially conforms | Multiple/legacy paths exist (legacy parser mode, direct R distribution parser, probability Python TeX fallback path) |

## 8 Recommendations

Smallest architectural changes required to align implementation with stated architecture.

### High

1. Remove legacy Python TeX fallback input path in `scripts/export-probability-distributions-workshop.R` (`notebooks/python/workshop02_python.ipynb`) and require generated IR-based notebook input only.
2. Consolidate R student notebook generation onto IR/model-renderer path (or codify current direct parser path as the explicit single producer and deprecate alternatives).
3. Restrict `export-workshops.yml` permissions at job scope: `contents: read` for preflight/validation jobs, `contents: write` only for export/publish job.

### Medium

1. Add a pre-publication notebook hygiene validation step in publication flow to enforce no outputs and null execution counts for all published Python notebooks.
2. Reduce CI duplication by centralizing shared validation logic between `notebook-execution-validation.yml` and `export-workshops.yml`.
3. Establish explicit provenance checks that fail when publication input is not generated from canonical support sources (e.g., metadata assertions before publish).

### Low

1. Keep the authoritative ADA Binder config and mirrored workbooks Binder files synchronized via the drift check and publication workflow.
2. Add policy checks (pre-commit/CI) to detect manual edits on generated artifacts in `notebooks/workshops/*` when they are not produced by generation scripts.
3. Add explicit docs mapping each generated artifact to its single authoritative producer script.

## File evidence index (non-exhaustive)

- Workflows: `.github/workflows/export-workshops.yml`, `.github/workflows/notebook-execution-validation.yml`, `.github/workflows/binder-readiness.yml`, `.github/workflows/workshop-ir-tests.yml`
- Submodule boundary: `.gitmodules`
- Canonical + architecture docs: `README.md`, `notebooks/README.md`, `docs/architecture/*.md`
- Generation scripts: `scripts/workshop-ir.R`, `scripts/workshop-ir-validate.R`, `scripts/workshop-model.R`, `scripts/workshop-ir-python-renderer.py`, `scripts/export-python-notebooks.R`, `scripts/export-workshop-output.R`, `scripts/export-workshops.R`
- Publication scripts: `scripts/publish-python-notebooks.R`
- Execution/validation scripts: `scripts/ci/execute-generated-python-notebooks.py`, `scripts/ci/execute-r-workshop-smoke.R`, `scripts/ci/check-generated-python-notebooks.py`, `scripts/ci/validate-parity-and-traceability.R`, `scripts/ci/assert-r-python-equivalence.py`
- Legacy/fallback path evidence: `scripts/export-probability-distributions-workshop.R`, `notebooks/python/workshop02_python.ipynb`
