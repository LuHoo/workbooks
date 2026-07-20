# Canonical Local Validation Orchestration

Canonical overview: `docs/architecture/notebook-generation-and-publication.md`

## Purpose

This document defines the canonical local validation entrypoint for notebook generation, parity, execution, and publication-readiness checks.

The goal is to provide one maintainable command that:

- orchestrates existing validators in a deterministic order;
- preserves each validator as a standalone tool;
- emits one combined machine-readable report for local and CI-adjacent consumption.

## Canonical Command

Preferred invocation:

```bash
.venv/bin/python scripts/ci/run-local-validation.py
```

Compatibility wrapper:

```bash
bash scripts/ci/local-notebook-validation-gate.sh
```

The shell wrapper delegates directly to `scripts/ci/run-local-validation.py`.

## Validation Flow

The orchestration layer runs the following stages in order:

1. Generation validation
2. Notebook hygiene
3. Parity validation
4. Notebook execution
5. Publication-readiness

The sequence is fail-fast. If any stage fails, downstream stages are marked `skipped` in the combined report because their prerequisites were not satisfied.

## Stage Inventory

### 1) Generation validation

Commands:

- `bash scripts/ci/verify-deterministic-notebook-generation.sh`
- `Rscript scripts/export-python-notebooks.R --output-dir generated/python-notebooks`

Inputs:

- canonical workshop sources under `notebooks/support/**/support.Rmd`
- registry/configuration scripts
- local runtime dependencies for R and Python generators

Success criteria:

- deterministic dual-run verifier exits `0`
- canonical generated Python notebooks are regenerated successfully

Artifacts:

- `generated/python-notebooks/**/chapter-*.ipynb`
- stage log files under `generated/validation/logs/`

### 2) Notebook hygiene

Command:

- `.venv/bin/python scripts/ci/check-generated-python-notebooks.py --input-dir generated/python-notebooks`

Inputs:

- generated Python notebooks

Success criteria:

- no non-null `execution_count`
- no non-empty `outputs`
- no raw R-only constructs rejected by the strict guardrail

Artifacts:

- stage log files under `generated/validation/logs/`

### 3) Parity validation

Command:

- `Rscript scripts/ci/validate-parity-and-traceability.R --notebooks-dir generated/python-notebooks --metadata-dir metadata/traceability --output-json generated/validation/parity-traceability-report.json --output-summary generated/validation/parity-traceability-summary.txt`

Inputs:

- generated Python notebooks
- traceability metadata
- workshop registry/configuration

Success criteria:

- exercise parity passes
- LO mapping parity passes
- FSAudit-required block coverage passes

Artifacts:

- `generated/validation/parity-traceability-report.json`
- `generated/validation/parity-traceability-summary.txt`

### 4) Notebook execution

Commands:

- `.venv/bin/python scripts/ci/assert-r-python-equivalence.py --chapters 1,6`
- `.venv/bin/python scripts/ci/assert-r-python-equivalence.py --chapters 1,2,3,4,5,6`
- `Rscript scripts/ci/execute-r-workshop-smoke.R --policy deterministic-sampling-v2`
- `.venv/bin/python scripts/ci/execute-generated-python-notebooks.py --input-dir generated/python-notebooks --artifacts-dir generated/notebook-execution-artifacts --timeout 600`

Inputs:

- generated Python notebooks
- published R workshop notebooks under `notebooks/workshops/*.Rmd`
- bridge/runtime dependencies

Success criteria:

- numeric equivalence checks pass for both configured phases
- representative R workshop smoke execution passes
- generated Python notebooks execute successfully

Artifacts:

- `generated/notebook-execution-artifacts/python-notebook-execution-report.json`
- `generated/notebook-execution-artifacts/executed/*.ipynb`
- `generated/notebook-execution-artifacts/r-smoke/*.md`

### 5) Publication-readiness

Command:

- `.venv/bin/python scripts/ci/check-generated-python-notebooks.py --input-dir generated/python-notebooks --checks hygiene --published-dir notebooks/workshops`

Inputs:

- generated Python notebooks
- published Python notebooks under `notebooks/workshops/`

Success criteria:

- generated notebooks remain hygiene-clean
- published Python notebooks match the canonical generated mapping

Artifacts:

- stage log files under `generated/validation/logs/`

## Combined Report Contract

Default report path:

- `generated/validation/local-validation-report.json`

Schema shape:

```json
{
  "schema_version": "1.0.0",
  "validation_run": {
    "status": "passed|failed|skipped",
    "started_at": "...",
    "completed_at": "...",
    "duration_seconds": 0,
    "entrypoint": "scripts/ci/run-local-validation.py",
    "report_path": "generated/validation/local-validation-report.json"
  },
  "stages": [
    {
      "name": "generation_validation",
      "status": "passed|failed|skipped",
      "duration_seconds": 0,
      "exit_code": 0,
      "message": "...",
      "artifacts": {
        "generated_notebooks_dir": "generated/python-notebooks"
      },
      "substeps": [
        {
          "name": "01-deterministic-generation",
          "command": "bash scripts/ci/verify-deterministic-notebook-generation.sh",
          "status": "passed|failed|skipped",
          "exit_code": 0,
          "log_path": "generated/validation/logs/01-deterministic-generation.log"
        }
      ]
    }
  ]
}
```

Report design principles:

- stage-level status is stable and easy for CI or local tooling to consume;
- substep entries preserve the exact standalone validator commands;
- artifact paths point maintainers to the existing detailed reports emitted by child validators;
- skipped stages preserve dependency context when execution stops early.

## Why This Structure

The orchestration script deliberately does not replace existing validators.

Instead it adds:

- ordering,
- shared reporting,
- consistent log capture,
- and one canonical local command.

That keeps the current validators reusable in workflows, local debugging, and targeted troubleshooting while reducing duplication in local validation entrypoints.