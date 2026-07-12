# Workshop IR Migration and Rollback Strategy

This document defines how to operate the workshop IR path now that IR is the
canonical default exporter backend.

## Current default behavior

The canonical exporter defaults to the IR parser engine.

- Command behavior uses IR unless an explicit parser override is provided.
- Wrapper scripts call IR explicitly for architectural clarity.

## Adapter-first migration approach

Migration is staged through an adapter that converts IR back into the legacy
segment shape consumed by rendering logic.

Flow during migration:

1. Parse `support.Rmd` into IR (`scripts/workshop-ir.R`).
2. Validate IR and config compatibility (`scripts/workshop-ir-validate.R`).
3. Adapt IR to legacy segments (`scripts/workshop-ir-adapter.R`).
4. Render with existing downstream export stages.

This allows parser evolution without changing renderer behavior.

## Cutover completion

Cutover is complete:

- IR is default for CLI and exporter APIs.
- Full export-set equivalence (legacy vs IR) is regression-tested.
- Legacy remains available only through explicit parser selection.

## Rollback plan

Immediate rollback requires no code revert:

- Pass `--parser-engine legacy` explicitly.

If optional integrations were added to automation, rollback means:

- set pipeline settings to explicit `legacy` parser engine;
- rerun compatibility test suite to confirm baseline.

## Operational guardrails

- Keep parser errors actionable and file/line-specific.
- Run `tests/workshop-ir/run-tests.R` to validate IR default behavior and legacy rollback compatibility.
- Preserve output contract for generated workshop chunks.
- Treat parser-engine changes as operational toggles, not renderer changes.

## Exit criteria for broad IR adoption

- No exporter output diffs in defined compatibility suite.
- Validation checks pass on targeted support notebooks.
- Malformed inputs produce deterministic, actionable diagnostics.
- Team can safely toggle between engines without code changes.
