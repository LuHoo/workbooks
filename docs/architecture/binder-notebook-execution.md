# Binder and Notebook Execution Validation

This document describes the Binder environment and CI execution pipeline for
R workshops and generated Python notebooks.

## Goals

- support R workshop notebooks and generated Python notebooks in one environment;
- validate notebook execution in CI with actionable diagnostics;
- block publication when execution validation fails.

## Existing Binder Root Cause

The legacy companion site repository (`LuHoo/audit-data-analysis`) does not
contain Binder runtime configuration files. Its notebook page links Binder to a
separate repository (`LuHoo/workbooks`).

The `LuHoo/workbooks` Binder configuration is R-focused (`.binder/runtime.txt`
and `.binder/install.R`) and does not define Python notebook execution
dependencies (`rpy2`, `nbclient`, generated notebook pipeline).

## Dual-Language Recommendation

A single Binder environment is feasible and recommended.

Why:

- `rpy2` requires Python and R in one runtime;
- one image avoids drift between language tracks;
- CI can validate the same dependency graph used by Binder.

Tradeoff:

- larger image and slower cold starts compared with single-language images.

## Binder Configuration

Binder files are located under `.binder/`:

- `runtime.txt`: pins R snapshot family.
- `install.R`: installs required CRAN packages and pinned GitHub packages.
- `requirements.txt`: pins Python and notebook execution dependencies.
- `apt.txt`: system libraries required for R package builds.
- `postBuild`: sanity checks for critical runtime imports.

## Dependency Management

### R dependencies

Installed by `.binder/install.R` and mirrored in CI install steps:

- workshop/render dependencies (`knitr`, `rmarkdown`, plotting/statistics libs);
- bridge/runtime dependencies (`IRkernel`, `jsonlite`, `remotes`, `devtools`);
- pinned GitHub packages:
  - `LuHoo/FSaudit@5a36801a712d9d736bb2c5a3992e7b8b644c7418`
  - `LuHoo/aicpa@4a49d0357544eb22ed3314005af2f82b3cf0f53a`

### Python dependencies

Pinned in `.binder/requirements.txt`:

- notebook tooling (`jupyter`, `jupyterlab`, `nbclient`, `nbformat`, `ipykernel`)
- data/scientific stack (`numpy`, `pandas`, `scipy`)
- plotting stack for Python workshop rendering (`matplotlib`, `seaborn`)
- interoperability layer (`rpy2==3.6.7`)

To preserve CI/Binder reproducibility while improving local developer ergonomics,
SciPy uses Python-version-aware constraints:

- Python `< 3.14`: pinned to the validated baseline (`scipy==1.15.3`)
- Python `>= 3.14`: compatible forward range (`scipy>=1.16.0,<2`)

CI/Binder remains authoritative on Python 3.10.

## CI Execution Architecture

Workflow: `.github/workflows/notebook-execution-validation.yml`

Pipeline:

1. install pinned R and Python dependencies;
2. generate Python notebooks from canonical support sources;
3. execute representative R workshop notebooks;
4. execute generated Python notebooks with `nbclient`;
5. upload execution artifacts.

Runner scripts:

- `scripts/ci/execute-r-workshop-smoke.R`
- `scripts/ci/execute-generated-python-notebooks.py`

## Diagnostics

On Python notebook execution failure, diagnostics include:

- notebook path;
- failing cell number (1-based);
- failing cell source snippet;
- stack trace;
- runtime details (Python, R, `rpy2`, `FSaudit`);
- remediation guidance.

Artifacts are written to `generated/notebook-execution-artifacts/` and uploaded
in CI.

## Dedicated Binder Readiness Validation

Workflow: `.github/workflows/binder-readiness.yml`

This workflow is intentionally independent from export/publication workflows and
targets Binder readiness directly.

Phasing:

1. PR-time: `repo2docker` build smoke check for this repository.
2. Post-merge/nightly: mybinder launch smoke check with longer timeout.

Launch smoke behavior:

- polls Binder build/launch event stream on `mybinder.org`;
- fails if Binder does not reach `ready` state before timeout;
- probes configured `urlpath` (default `lab`) and fails on non-success status;
- writes detailed logs for artifact upload.

Default launch target is `LuHoo/workbooks` because Binder usage is linked from
`LuHoo/audit-data-analysis` to that repository.

Artifacts:

- `generated/traceability/binder-repo2docker-smoke.log`
- `generated/traceability/binder-launch-smoke.log`

## Publication Gating

`export-workshops.yml` includes `notebook-execution-validation` as a required
upstream job for publication/export. If notebook execution fails, publication is
blocked.

During export publication, generated Python notebooks are copied from
`generated/python-notebooks/**/chapter-<n>.ipynb` to the Binder-facing
`notebooks/workshops` repository root using the naming convention
`Workshop <n> (Python).ipynb`.

## Contributor Guidance

Run the validation flow locally:

```bash
Rscript scripts/export-python-notebooks.R --output-dir generated/python-notebooks
Rscript scripts/ci/execute-r-workshop-smoke.R
python3 scripts/ci/execute-generated-python-notebooks.py --input-dir generated/python-notebooks --artifacts-dir generated/notebook-execution-artifacts
```

If execution fails, inspect `generated/notebook-execution-artifacts/` first.
