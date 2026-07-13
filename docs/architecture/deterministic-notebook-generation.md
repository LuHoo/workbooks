# Deterministic Notebook Generation (Local Verification)

## Scope

This document defines and records the local-only verification procedure for deterministic generation of canonical ADA workshop artifacts.

The check validates deterministic behavior for:

- Workshop IR JSON snapshots.
- Generated Python notebooks (`.ipynb`) from IR.
- Published Python notebook copies (distribution naming/path mapping).
- Generated R workshop notebooks (`.Rmd`).
- Generated workshop LaTeX exercise fragments (`exercise-*.tex`).

The procedure intentionally excludes GitHub Actions and Binder execution.

## Canonical Local Checker

Single command:

```bash
bash scripts/ci/verify-deterministic-notebook-generation.sh
```

Script location:

- `scripts/ci/verify-deterministic-notebook-generation.sh`

## Determinism Contract

The verifier enforces the following contract by executing two isolated runs and comparing outputs.

### 1) Fresh, Isolated Generation Roots

Two clean output roots are used on every invocation:

- `/tmp/ada-generation-run-a`
- `/tmp/ada-generation-run-b`

No generated artifacts are reused between runs.

### 2) Canonical Generation Paths

Each run invokes the same canonical generators:

- IR snapshots from support notebooks via `scripts/workshop-ir.R` and workshop export configs.
- Python notebooks via `scripts/export-python-notebooks.R`.
- Published Python notebooks via `scripts/publish-python-notebooks.R`.
- R workshop notebooks via `scripts/export-workshops.R`.
- LaTeX chunks via `scripts/export-workshop-output.R` with `parser_engine = "ir"` and strict traceability.

### 3) Byte-Level Artifact Equivalence

After both runs complete:

- Full file inventories are listed and compared exactly.
- SHA-256 manifests are computed over all generated files and compared exactly.

Any path or hash mismatch fails verification.

### 4) Notebook Semantic Invariants

For every generated `.ipynb`, the checker validates:

- Canonical JSON equality between runs (`sort_keys=True`, stable indentation/newline).
- Same cell type sequence across runs.
- Stable cell id format `cell-[0-9a-f]{16}`.
- Unique cell ids per notebook.
- Distribution code cells have `execution_count: null` and `outputs: []`.
- `metadata.ada_renderer.source_file` does not contain absolute or environment-specific temp paths.

### 5) Guardrails on Generated Content

Additional checks ensure no environment leakage and no directive leakage:

- Generated R notebooks must not contain support-only/ADA directive markers.
- Published Python notebooks must not contain `/tmp/` or `/var/folders/` path fragments.
- Generated LaTeX outputs must not contain `/tmp/` or `/var/folders/` path fragments.

## Local Verification Result

Latest recorded local execution in this repository context:

- Command: `bash scripts/ci/verify-deterministic-notebook-generation.sh`
- Result: pass (`exit code 0`)
- Final status lines:
  - `Comparing file inventories`
  - `Comparing SHA-256 hashes`
  - `Notebook semantic checks passed`
  - `Deterministic generation verified`

## Operational Notes

- The checker defaults to deleting temp roots after success/failure.
- Use `--keep-temp` to retain run outputs for debugging.
- Optional overrides:
  - `--run-a <path>`
  - `--run-b <path>`

## Why This Is Sufficient

The procedure combines:

- identical generator entry points,
- isolated re-generation,
- inventory equality,
- cryptographic hash equality,
- notebook-level semantic invariants,
- and explicit leakage/marker guardrails.

Together, these checks provide local, reproducible evidence that unchanged inputs yield deterministic generated notebook artifacts.
