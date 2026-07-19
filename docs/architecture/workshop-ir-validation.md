# Workshop IR Validation Model

Canonical overview: `docs/architecture/notebook-generation-and-publication.md`

This document specifies validation behavior for workshop-ir/1.0.0 and
workshop-ir/1.1.0.
Implementation entry point: scripts/workshop-ir-validate.R

## Validation goals

- Catch malformed source structure early.
- Guarantee IR consistency before renderer consumption.
- Provide actionable diagnostics with file and line precision.
- Validate compatibility with workshop export config where applicable.

## Diagnostic shape

Each diagnostic includes:

- severity
- category
- code
- file
- line
- block
- message
- remediation

Severity values:

- error

Category values:

- IR-PARSE: source parsing failures (thrown by parser)
- IR-DIRECTIVE: unsupported or malformed directives
- IR-MODEL: schema and structural consistency errors
- IR-COMPAT: compatibility failures relative to exporter config

## Structural validation rules

- schema_version must be one of accepted versions (`workshop-ir/1.0.0`, `workshop-ir/1.1.0`).
- required top-level fields must be present.
- source.line_count must be positive.
- exercise ordinals must be contiguous and start at 1.
- exercise_ref values must be unique per notebook.
- source spans must satisfy start_line <= end_line.
- block sequences must be contiguous per exercise.
- code blocks in v1 must declare language r and include code_lines.

## Directive validation rules

- observed directives must be a subset of supported directives.
- parser-level marker balancing is enforced during extraction and surfaces as IR-PARSE errors.

## Compatibility validation rules

When a workshop config is available:

- all configured exercises must exist in IR output.
- code block counts per exercise must match expected_chunks.

## Example diagnostics

IR-DIRECTIVE unknown directive:

[ERROR] IR-DIRECTIVE E200 file=notebooks/support/regression-analysis/support.Rmd line=1 block=directives.observed message=unsupported directives observed: PYTHON-OVERRIDE remediation=remove unknown directives or extend supported directive set

IR-COMPAT chunk mismatch:

[ERROR] IR-COMPAT E301 file=notebooks/support/goodness-of-fit/support.Rmd line=45 block=exercise:6.2 message=chunk count mismatch (expected 18, got 17) remediation=reconcile support notebook chunks with metadata/workshop-registry.R

## CLI usage

Validate one notebook and fail on errors:

Rscript scripts/workshop-ir-validate.R --input notebooks/support/probability-distributions/support.Rmd

Validate with explicit config id:

Rscript scripts/workshop-ir-validate.R --input notebooks/support/probability-distributions/support.Rmd --config-id probability-distributions

Print diagnostics without failing:

Rscript scripts/workshop-ir-validate.R --input notebooks/support/probability-distributions/support.Rmd --no-strict --pretty
