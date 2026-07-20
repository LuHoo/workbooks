# Binder and Notebook Execution Validation

Canonical overview: `docs/architecture/notebook-generation-and-publication.md`

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

Current ownership contract:

- authoritative Binder config source in the ADA toolchain is `LuHoo/ada:.binder/*`;
- Binder-facing workbooks files under `notebooks/workshops/.binder/*` are a
  required mirror for the publication target repository;
- drift between the authoritative ADA config and the workbooks mirror is a
  validation failure, not a silent policy exception.

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

Mirror rule:

- ADA root `.binder/*` is the authoritative edit surface for Binder runtime
  configuration used by local Binder smoke checks and CI preflight.
- `notebooks/workshops/.binder/*` must remain byte-for-byte synchronized with
  the authoritative ADA files.
- Drift is checked by `scripts/ci/check-binder-config-drift.sh`.

Policy constraint:

- Runtime package installation is not allowed in Binder notebook startup paths.
- Dependencies must be resolved at image build time only.

## Dependency Management

### R dependencies

Installed by `.binder/install.R` and mirrored in CI install steps:

- runtime workshop/render dependencies:
  - `IRkernel`, `jsonlite`, `knitr`, `rmarkdown`
  - plotting/statistics stack required by current workshops:
    `ggplot2`, `car`, `pbkrtest`, `lme4`, `nloptr`, `gridExtra`, `tidyr`,
    `corrplot`, `lmtest`, `latex2exp`, `scales`
- justified build-time exception:
  - `remotes` is retained only because `.binder/install.R` installs pinned
    GitHub runtime packages during image build
- CRAN imports preinstalled from the snapshot for pinned GitHub runtime packages:
  - `lazyeval`, `stratification`, `tibble`
- pinned GitHub packages:
  - `LuHoo/FSaudit@5a36801a712d9d736bb2c5a3992e7b8b644c7418`
  - `LuHoo/aicpa@4a49d0357544eb22ed3314005af2f82b3cf0f53a`

Audit result:

- `devtools` was removed from the Binder install graph because it is
  maintainer-oriented tooling and is not required by the student runtime or the
  Binder build path.
- `readr` was removed from the explicit Binder install list because current
  runtime surfaces in this repository do not use it directly.

Build-time verification:

- `.binder/install.R` now verifies required package availability after installation using `requireNamespace(...)` checks.
- Build fails if required packages are missing; no success message is emitted before verification.

Snapshot/package-source policy:

- prefer the pinned Posit Package Manager Linux Jammy snapshot for CRAN package
  installs so Binder can consume binary-friendly package channels where
  available;
- preinstall CRAN imports for pinned GitHub runtime packages from that snapshot
  before calling `remotes::install_github(...)`;
- reserve GitHub installs for packages that are intentionally pinned outside the
  snapshot (`FSaudit`, `aicpa`);
- use `apt.txt` for system libraries and toolchain requirements only, not as a
  parallel source of versioned R package policy.

### System dependencies (`.binder/apt.txt`)

Installed by repo2docker before R/Python package installation.

Current Binder system packages:

- `libcurl4-openssl-dev`, `libssl-dev`, `libxml2-dev`, `libgit2-dev`
  - needed by common R network/XML/git dependency chains.
- `cmake`
  - required by `nloptr` source builds (`CMake was not found on the PATH` when absent).
- `libnlopt-dev`, `gfortran`, `libblas-dev`, `liblapack-dev`
  - required by the `car -> pbkrtest -> lme4 -> nloptr` chain on Linux Binder builds.
- `libharfbuzz-dev`, `libfribidi-dev`
  - required by `textshaping`/`systemfonts` source builds (`hb-ft.h` and related shaping headers).

Snapshot/reproducibility update:

- Binder R package installation now uses a pinned Posit Package Manager snapshot (`2024-10-15`) for Linux Jammy in `.binder/install.R`.
- This removes live-CRAN drift, improves reproducibility, and increases binary package availability versus unconstrained repository resolution.
- Current optimization step: the `FSaudit` CRAN imports (`lazyeval`,
  `stratification`, `tibble`) are installed from the pinned snapshot before the
  GitHub package itself, reducing dynamic dependency resolution during
  `install_github()`.
- Measurable install-graph effect in current implementation: the Binder build no
  longer asks `install_github()` to resolve those three CRAN imports dynamically
  from the GitHub package install path.

Maintenance guidance:

- keep OS-level Binder deps in `.binder/apt.txt` as the single source of truth;
- do not replace the snapshot-backed CRAN package policy with Ubuntu `r-cran-*`
  packages unless reproducibility and version-alignment tradeoffs are explicitly
  reviewed;
- avoid introducing a parallel Dockerfile-based package install path unless Binder architecture changes;
- when adding an R/Python package that compiles native code, first document and add required OS headers/tools in `.binder/apt.txt`, then mirror rationale here.

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
3. execute deterministic sampled R workshop notebooks (policy `deterministic-sampling-v2`);
4. execute generated Python notebooks with `nbclient`;
5. upload execution artifacts.

Runner scripts:

- `scripts/ci/execute-r-workshop-smoke.R`
- `scripts/ci/execute-generated-python-notebooks.py`

R workshop execution coverage policy:

- Policy name: `deterministic-sampling-v2`
- Executed notebooks:
  - `notebooks/workshops/Hypothesis testing workshop.Rmd`
  - `notebooks/workshops/Regression analysis workshop.Rmd`
- Why these notebooks:
  - together cover inferential/runtime integration and the heaviest modeling path in the current workshop set.
- Guarantee provided:
  - if either selected notebook fails to knit, CI/local execution gate fails.
- Not guaranteed:
  - full execution coverage for all generated/published R workshop notebooks.

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

Ownership enforcement:

- both jobs validate Binder mirror drift before build or launch checks run;
- a drift failure means `.binder/*` and `notebooks/workshops/.binder/*` no
  longer match and must be resynchronized before publication or Binder
  validation proceeds.

Launch smoke behavior:

- polls Binder build/launch event stream on `mybinder.org`;
- sends `Accept: text/event-stream` on `/build` requests (required by current BinderHub deployments);
- fails if Binder does not reach `ready` state before timeout;
- probes configured `urlpath` (default `lab`) and fails on non-success status;
- writes detailed logs for artifact upload.

Default launch target is `LuHoo/workbooks` because Binder usage is linked from
`LuHoo/audit-data-analysis` to that repository.

Artifacts:

- `generated/traceability/binder-repo2docker-smoke.log`
- `generated/traceability/binder-launch-smoke.log`

`postBuild` includes lightweight dependency assertions for critical system tools/headers (including `cmake`, harfbuzz, and fribidi) so missing Binder apt dependencies fail fast with actionable messages.

`postBuild` also validates that key R packages (`FSaudit`, `aicpa`, `car`, `pbkrtest`, `lme4`, `nloptr`) are available immediately at runtime.

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
Rscript scripts/ci/execute-r-workshop-smoke.R --policy deterministic-sampling-v2
python3 scripts/ci/execute-generated-python-notebooks.py --input-dir generated/python-notebooks --artifacts-dir generated/notebook-execution-artifacts
```

If execution fails, inspect `generated/notebook-execution-artifacts/` first.
