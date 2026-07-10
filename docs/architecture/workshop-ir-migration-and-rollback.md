# Workshop IR Migration and Rollback Strategy

This document defines how to adopt the workshop IR path safely while preserving
current exporter behavior by default.

## Current default behavior

The canonical exporter defaults to the legacy parser engine.

- Command behavior remains unchanged unless `--parser-engine ir` is explicitly
  provided.
- Existing wrapper scripts continue to use legacy behavior by default.

## Adapter-first migration approach

Migration is staged through an adapter that converts IR back into the legacy
segment shape consumed by rendering logic.

Flow during migration:

1. Parse `support.Rmd` into IR (`scripts/workshop-ir.R`).
2. Validate IR and config compatibility (`scripts/workshop-ir-validate.R`).
3. Adapt IR to legacy segments (`scripts/workshop-ir-adapter.R`).
4. Render with existing downstream export stages.

This allows parser evolution without changing renderer behavior.

## Recommended rollout phases

1. Foundation

- Land schema, parser, validation, and adapter with legacy default.
- Keep all production commands on legacy parser.

2. Shadow verification

- Run side-by-side checks in CI or local scripts:
  - legacy parser output
  - IR parser output
- Enforce no-diff expectations for selected representative chunks.

3. Controlled opt-in

- Enable `--parser-engine ir` for selected workflows/chapters.
- Expand coverage as confidence grows.

4. Default switch (future issue)

- Switch default parser only after sustained compatibility evidence.
- Keep legacy path available for rollback until deprecation decision.

## Rollback plan

Immediate rollback requires no code revert:

- Stop passing `--parser-engine ir`.
- Use default legacy parser behavior.

If optional integrations were added to automation, rollback means:

- revert pipeline settings to `legacy` parser engine;
- rerun compatibility test suite to confirm baseline.

## Operational guardrails

- Keep parser errors actionable and file/line-specific.
- Run `tests/workshop-ir/run-tests.R` before enabling IR path broadly.
- Preserve output contract for generated workshop chunks.
- Treat parser-engine changes as operational toggles, not renderer changes.

## Exit criteria for broad IR adoption

- No exporter output diffs in defined compatibility suite.
- Validation checks pass on targeted support notebooks.
- Malformed inputs produce deterministic, actionable diagnostics.
- Team can safely toggle between engines without code changes.
