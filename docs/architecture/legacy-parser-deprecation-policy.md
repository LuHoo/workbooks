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

## Lifecycle stages

The legacy parser lifecycle is governed by explicit stages and review checkpoints, not by a fixed removal date.

### Stage 0 — Supported legacy mode

- Legacy parser is fully supported.
- IR adoption or compatibility confidence is still being established.
- Rollback may be routine while migration confidence is immature.

### Stage 1 — Preferred IR default (current)

- IR parser is the recommended and default path.
- Legacy parser remains available only through explicit selection.
- Legacy mode is supported for rollback, incident containment, and controlled baseline comparison.
- Legacy-specific maintenance is limited to correctness, compatibility, and recovery viability.

### Stage 2 — Retirement-candidate review

- Entered only after advancement evidence is satisfied.
- Review is governance-only; no automatic removal action is implied.
- Rollback viability must still be demonstrable at review time.

### Stage 3 — Removal approval

- Reached only after a formal decision that retirement evidence remains satisfied.
- Actual parser removal remains a separate future change and is out of scope for this policy.

This policy intentionally does not set a hard removal date.

## Decision checkpoints, ownership, and triggers

Policy review must occur at least at the following checkpoints:

1. Release-readiness checkpoints where parser/export behavior changed.
2. Architecture recommendation refreshes and conformance updates.
3. Post-incident parser regressions that required fallback analysis.
4. Any proposal to reduce or remove rollback support.

Decision owners:

- repository maintainers responsible for exporter/runtime governance;
- reviewers approving architecture and recovery guidance for notebook generation.

Checkpoint outcomes:

- advance to retirement-candidate review;
- hold current state;
- extend transition period with rationale.

## Advancement evidence (all required for Stage 2 review)

Before retirement can be considered, all of the following must hold at checkpoint time:

1. IR remains the default parser engine in exporter workflows.
2. No unresolved parser regressions are known where normal generation/publishing depends on legacy fallback.
3. Existing validation and compatibility controls are green for the current baseline:
   - `Rscript tests/workshop-ir/run-tests.R`
   - `bash scripts/ci/verify-deterministic-notebook-generation.sh`
   - the canonical local validation entrypoint (`scripts/ci/run-local-validation.py`) or the equivalent documented validation ladder
4. At least three consecutive parser-affecting review checkpoints have completed without requiring legacy fallback for release-blocking recovery.
5. No unresolved legacy-vs-IR output divergence is tracked in open incidents, release blockers, or recommendation issues.
6. Recovery procedures are demonstrably operable with IR-first workflows, with legacy fallback used as contingency rather than routine mode.
7. Architecture and recovery docs remain internally consistent about parser status and rollback expectations.

Advancement evidence must be recorded in the associated issue, PR, release-readiness note, or architecture review summary.

## Stage 2 review questions

When Stage 2 is entered, reviewers must explicitly answer all of the following:

1. Has legacy mode become contingency-only rather than operationally routine?
2. Are parser/export regressions discoverable through current validation controls before publication risk becomes user-facing?
3. Does the team still need legacy mode for common investigation workflows, or only for rare disaster recovery?
4. Is rollback support still operationally realistic, not merely documented?

If any answer is negative or unclear, the lifecycle must remain at `Stage 1 — Preferred IR Default`.

## Hold and extension criteria

Advancement must be delayed when any of the following is true:

1. Active parser defects require legacy mode as the only safe path.
2. Compatibility/parity checks fail and root cause is unresolved.
3. Recovery incidents show recurring dependence on legacy mode.
4. Documentation drift creates conflicting parser lifecycle expectations.
5. Validation evidence is incomplete, stale, or not attributable to the current baseline.

Extension is the default outcome whenever advancement evidence is incomplete.

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
5. Rollback users are expected to regenerate affected outputs and rerun the documented validation ladder after switching parser engines.
6. Legacy fallback usage must be recorded with the triggering defect, affected scope, and exit criteria for returning to IR-first operation.

Evidence supporting continued transition should be traceable in issue/PR records
and release readiness notes when fallback is used.

## Removal prerequisites

Actual legacy-parser removal is permissible only when all of the following are true:

1. A separate removal issue exists and references the evidence gathered under this policy.
2. Stage 2 review concluded that retirement criteria were satisfied and recorded.
3. Maintainers explicitly approve removal in a dedicated PR.
4. Recovery documentation is updated to remove legacy fallback instructions only as part of that future removal change.

This policy never authorizes automatic removal based on elapsed time alone.

## Documentation alignment requirements

The following documents must stay aligned with this policy:

- `docs/architecture/workshop-ir-migration-and-rollback.md`
- `docs/architecture/notebook-generation-and-publication.md`
- `docs/architecture/recovery-and-regeneration.md`
- `docs/architecture/canonical-notebook-generation-conformance.md`

At minimum, they must consistently state:

- IR is default;
- legacy is explicit rollback mode;
- the current lifecycle stage;
- deprecation is checkpoint-based and criteria-driven;
- actual removal requires a future explicit issue/PR;
- no immediate removal commitment is made.