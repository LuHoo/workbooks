# Parity and Traceability Quality Gates

## Purpose

Issue #100 introduces CI-enforced parity and traceability gates that complement existing runtime notebook execution checks.

The gates focus on structural consistency rather than numeric outputs:

- exercise parity between source support notebooks and generated Python notebooks
- learning-objective (LO) mapping parity and chapter consistency
- coverage of FSAudit-required IR blocks in generated outputs

## Inputs

- workshop source notebooks (`notebooks/support/**/support.Rmd`)
- generated Python notebooks (`generated/python-notebooks/**/chapter-*.ipynb`)
- traceability metadata (`metadata/traceability/*.yml`)

## Report Contract

The validation script writes a machine-readable JSON report with:

- top-level status (`ok` / `failed`)
- targeted chapters/workshops
- per-workshop checks
- aggregated error and warning lists
- timestamp and script version metadata

The script also emits a compact human-readable CI summary to stdout/stderr.

## Failure Policy

The gate exits with non-zero status when any of these are true:

- exercise count/order/identifier drift is detected
- duplicate or missing exercises are detected
- LO mappings are missing or chapter-inconsistent
- FSAudit-required blocks are missing from generated notebook traceability

## CI Integration

The gate is integrated into the notebook validation workflow after notebook generation and before execution checks.

This ordering ensures:

- structural drift fails fast
- expensive execution jobs only run when parity/traceability preconditions are satisfied
