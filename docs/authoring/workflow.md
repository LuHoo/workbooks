# Notebook Validation Workflow

This workflow enforces notebook-validation hygiene and avoids the recurring CI loops we recently hit.

## Scripts

- Narrow validation chain:
  - `scripts/ci/local-notebook-narrow-chain.sh`
- Moving-parts synchronization:
  - `scripts/ci/sync-notebook-moving-parts.sh`

## When To Run Each Script

### 1) Run the narrow chain before every push that can affect notebook validation

Run this before pushing if your change touches any of these areas:

- `notebooks/support/**/support.Rmd`
- `scripts/workshop-ir-python-renderer.py`
- `scripts/ci/validate-manuscript-calculations.R`
- `R/manuscript-calculation-validator.R`
- `.binder/install.R`
- `.github/workflows/notebook-execution-validation.yml`
- `.github/workflows/export-workshops.yml`
- `.github/workflows/workshop-ir-tests.yml`
- `notebooks/workshops` submodule pointer in the parent repo

Command:

```bash
bash scripts/ci/local-notebook-narrow-chain.sh
```

Optional timeout override for notebook execution:

```bash
NOTEBOOK_EXEC_TIMEOUT=900 bash scripts/ci/local-notebook-narrow-chain.sh
```

### 2) Run the sync script when publication parity can drift

Run this after any canonical notebook/source change, and immediately when CI fails on generated notebook artifact policy.

Command:

```bash
bash scripts/ci/sync-notebook-moving-parts.sh
```

After it passes, commit in this order:

1. In `notebooks/workshops` (submodule): commit and push updated workshop notebook artifacts.
2. In parent repo: commit and push the updated submodule pointer.

### 3) Re-run the narrow chain after sync and before final push

Command:

```bash
bash scripts/ci/local-notebook-narrow-chain.sh
```

If both scripts pass, push your branch and run/observe the GitHub workflow.

## Recommended Daily Pattern

1. Develop changes.
2. `bash scripts/ci/local-notebook-narrow-chain.sh`
3. If artifact-policy fails: `bash scripts/ci/sync-notebook-moving-parts.sh`
4. Commit submodule + parent pointer.
5. `bash scripts/ci/local-notebook-narrow-chain.sh` again.
6. Push and trigger/monitor Notebook Execution Validation.

## Why This Works

This sequence keeps the three moving parts in lockstep:

1. Canonical generated notebooks (`generated/python-notebooks`)
2. Published notebooks (`notebooks/workshops`)
3. Policy and execution gates (CI and local validators)

That is the shortest repeatable loop that prevents stale publication artifacts and late-stage CI surprises.
