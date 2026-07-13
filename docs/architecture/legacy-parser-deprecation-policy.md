# Legacy Parser Deprecation Policy and Transition Plan

Canonical context:

- `docs/architecture/workshop-ir-migration-and-rollback.md`
- `docs/architecture/notebook-generation-and-publication.md`
- `docs/architecture/recovery-and-regeneration.md`

Issue tracking:

- Issue #137: define deprecation criteria and transition governance for the legacy parser path.

## Scope and non-goals

This policy governs lifecycle decisions for the legacy parser mode exposed through
`scripts/export-workshop-output.R` (`--parser-engine legacy`).

In scope:

- deprecation criteria;
- review checkpoints and decision triggers;
- rollback/recovery expectations during transition.

Out of scope:

- immediate parser removal;
- parser redesign;
- IR schema redesign;
- feature work unrelated to deprecation governance.

## Why the legacy parser remains available

The legacy parser remains available as an explicit rollback mechanism while the IR
path is the canonical default. It exists to preserve operational recovery options
for parser regressions, release stabilization, and incident response.

The legacy path is not the strategic target architecture.

## Lifecycle states

1. `Rollback-capable transition` (current)
   - IR parser is default.
   - Legacy parser is available only through explicit selection.
   - Legacy path is maintained for recovery/rollback use.
2. `Retirement-candidate review`
   - Entered only after all advancement criteria are met.
   - Decision is governance-only (no automatic removal action).
3. `Post-decision transition`
   - Result of a maintainer decision at a checkpoint.
   - May remain in transition if criteria are no longer stable.

This policy intentionally does not set a hard removal date.

## Decision checkpoints and triggers

Policy review must occur at least at the following checkpoints:

1. Release readiness checkpoints where parser/export behavior changed.
2. Architecture recommendation refreshes (for example updates to `recommendation-issues-todo.md`).
3. Post-incident parser regressions that required fallback analysis.

Checkpoint outcomes:

- advance to retirement-candidate review;
- hold current state;
- extend transition period with rationale.

## Advancement criteria (all required)

Before retirement can be considered, all of the following must hold at checkpoint time:

1. IR remains the default parser engine in exporter workflows.
2. No unresolved parser regressions are known where normal generation/publishing depends on legacy fallback.
3. Existing validation and compatibility controls are green for the current baseline:
   - `Rscript tests/workshop-ir/run-tests.R`
   - `bash scripts/ci/verify-deterministic-notebook-generation.sh`
   - traceability/parity validation used by architecture runbooks
4. Recovery procedures are demonstrably operable with IR-first workflows, with legacy fallback used as contingency rather than routine mode.
5. Architecture and recovery docs remain internally consistent about parser status and rollback expectations.

## Hold/extension criteria

Advancement must be delayed when any of the following is true:

1. Active parser defects require legacy mode as the only safe path.
2. Compatibility/parity checks fail and root cause is unresolved.
3. Recovery incidents show recurring dependence on legacy mode.
4. Documentation drift creates conflicting parser lifecycle expectations.

## Rollback and maintenance expectations during transition

While in transition:

1. Legacy parser remains callable via explicit `--parser-engine legacy`.
2. Rollback compatibility remains covered by existing parser test suites.
3. Maintenance expectation for legacy mode is stability-oriented:
   - keep correctness and recovery viability;
   - avoid new feature expansion specific to legacy mode.
4. Fallback remains appropriate for:
   - incident containment;
   - release-blocking parser regressions;
   - controlled baseline comparison during investigations.

Evidence supporting continued transition should be traceable in issue/PR records
and release readiness notes when fallback is used.

## Documentation alignment requirements

The following documents must stay aligned with this policy:

- `docs/architecture/workshop-ir-migration-and-rollback.md`
- `docs/architecture/notebook-generation-and-publication.md`
- `docs/architecture/recovery-and-regeneration.md`
- `docs/architecture/canonical-notebook-generation-conformance.md`

At minimum, they must consistently state:

- IR is default;
- legacy is explicit rollback mode;
- deprecation is checkpoint-based and criteria-driven;
- no immediate removal commitment is made.