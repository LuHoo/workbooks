# FSAudit rpy2 Bridge

Canonical overview: `docs/architecture/notebook-generation-and-publication.md`

This document describes the reusable Python interoperability layer for FSAudit-backed workshop notebooks.

## Goals

- expose stable Python APIs for FSAudit workflows used in generated notebooks;
- keep `rpy2` details out of notebook exercise cells;
- preserve deterministic execution when seeds are configured;
- return actionable diagnostics for package, environment, conversion, and runtime failures;
- support isolated testing of bridge logic and renderer integration.

## Module Layout

- `ada_fsaudit_bridge/__init__.py`
  - stable import surface for notebooks.
- `ada_fsaudit_bridge/api.py`
  - public factory functions, sampler wrappers, environment configuration, and diagnostics.
- `ada_fsaudit_bridge/session.py`
  - lazy R session bootstrap, FSaudit package loading, and low-level function calls.
- `ada_fsaudit_bridge/conversion.py`
  - reusable Python/R type conversion helpers.
- `ada_fsaudit_bridge/errors.py`
  - structured bridge exceptions with remediation hints.
- `ada_fsaudit_bridge/models.py`
  - typed context and diagnostics containers.
- `ada_fsaudit_bridge/native_stats.py`
  - native Python upper/lower bound helpers for simple scalar cases.

## Public API

### Environment and diagnostics

- `configure_environment(...)`
  - initializes the lazy R bridge and optional deterministic seeds.
- `set_notebook_context(chapter=None, exercise=None, notebook=None)`
  - attaches notebook metadata to subsequent diagnostics.
- `bridge_diagnostics()`
  - returns bridge, R, FSaudit, library-path, and context metadata.
- `reset_session()`
  - test helper for rebuilding a fresh session.

### Dataset helpers

- `load_dataset(name)`
  - loads FSaudit package datasets into a pandas DataFrame.

### Sampler factories

- `att_sample(**kwargs)`
  - creates an `AttributeSampler` wrapper around `att_obj`.
- `mus_sample(**kwargs)`
  - creates a `MonetaryUnitSampler` wrapper around `mus_obj`.
- `cvs_sample(**kwargs)`
  - creates a `ClassicalVariableSampler` wrapper around `cvs_obj`.

### Native statistical helpers

- `upper_bound(...)`
- `lower_bound(...)`

These native helpers are used for simple scalar bounds where a direct Python implementation is clearer than a full R round-trip.

## Wrapper Semantics

Sampler wrappers retain a live R object handle inside the bridge session and expose a Python-facing API:

- `.size(**kwargs)`
- `.select(**kwargs)`
- `.evaluate(**kwargs)`
- `.stratify(**kwargs)` for `ClassicalVariableSampler`
- `.summary()`
- `.field(name)`
- `.field_names()`

Common convenience properties:

- `.n`
- `.popn`
- `.popBv`
- `.sample`
- `.eval_results`

Mutating workflow methods return `self` so generated notebook code stays compact.

## Notebook Integration

The Python renderer injects a shared bootstrap cell at the top of generated notebooks whenever the selected exercise blocks require the `fsaudit` capability.

That bootstrap cell:

- imports `ada_fsaudit_bridge` as an installed Python package;
- imports the bridge API and `scipy.stats.hypergeom`;
- defines `ada_set_context(exercise_ref)` for exercise-scoped diagnostics;
- calls `configure_environment()` once.

Exercise-level Python override cells then call the bridge API directly instead of embedding `rpy2` or raw R code.

## Type Conversion Rules

### Python to R

- scalars: `int`, `float`, `str`, `bool`, `None`
- vectors: Python lists/tuples, NumPy arrays, pandas Series
- tabular data: pandas DataFrames

### R to Python

- atomic values become native Python scalars where possible;
- `data.frame` becomes pandas DataFrame;
- named lists become Python dictionaries;
- unnamed lists become Python lists;
- sampler state objects remain wrapped as live bridge objects rather than being eagerly flattened.

Missing values are normalized through `pandas`, `numpy`, and `rpy2` conversion behavior for the relevant container type.

## Error Model

The bridge avoids leaking raw `rpy2` exceptions into notebook output.

Base exception:

- `FSAuditBridgeError`

Specialized exceptions:

- `FSAuditPackageNotInstalledError`
- `FSAuditVersionMismatchError`
- `FSAuditInputError`
- `FSAuditConversionError`
- `FSAuditExecutionError`
- `FSAuditEnvironmentError`

Diagnostics include, where available:

- bridge operation;
- FSaudit function name;
- notebook/chapter/exercise context;
- underlying R or `rpy2` error text;
- remediation guidance;
- runtime metadata from `bridge_diagnostics()`.

## Reproducibility

Use `configure_environment(seed=...)` to synchronize:

- Python `random`;
- NumPy random state;
- R `set.seed(...)`.

Per-operation seeds still belong in exercise code when they are part of the book workflow, for example `select(seed=345)`.

The bridge does not inject timestamps or non-deterministic notebook metadata.

## Environment Setup

### Recommended validated notebook runtime

The pinned bridge validation target is:

- Python 3.10
- R 4.3.1
- FSaudit 0.3.4+
- rpy2 3.6.7
- pandas 2.3.3
- scipy 1.15.3

This runtime is enforced in CI through `.github/workflows/workshop-ir-tests.yml`.

Minimum requirements:

- system R installed and reachable;
- FSaudit installed in R;
- Python packages:
  - `rpy2`
  - `pandas`
  - `scipy`

Example installation inside a project environment:

```bash
python -m pip install rpy2 pandas scipy
Rscript -e "install.packages('FSaudit')"
```

If FSaudit is installed in a non-default R library, configure that path through:

- `configure_environment(r_library_paths=[...])`, or
- `ADA_FSAUDIT_R_LIBS` in the calling environment.

## Troubleshooting

### `Could not locate ada_fsaudit_bridge`

Install the bridge package in the active environment.

For local development from this repository root:

```bash
python -m pip install -e .
```

For Binder publication targets, ensure `.binder/requirements.txt` includes `-e .` and the bridge package source directory is present in the Binder repo.

### `FSaudit R package is not installed`

Install FSaudit into the active R installation or point the bridge at the correct library path.

### `rpy2 could not initialize against the active R runtime`

This indicates a Python/rpy2/R ABI mismatch or an incorrect R loader path.

Check:

- `R_HOME` points at the intended R framework or installation;
- the active Python version is supported by the installed `rpy2` build;
- the active R version is compatible with the installed `rpy2` build.

### Conversion failures

Inspect the failing bridge call and reduce inputs to pandas/NumPy/native scalar types before handing them to the bridge.

## Test Coverage

- `python3 tests/python-renderer/run-tests.py`
  - renderer determinism and bridge-bootstrap integration.
- `python -m unittest tests/python-renderer/test_fsaudit_bridge.py`
  - bridge smoke tests; skips cleanly when the local Python/R/rpy2 runtime cannot initialize.
