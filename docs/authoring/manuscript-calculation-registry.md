# Manuscript Calculation Registry

This document defines the registry contract for notebook-derived manuscript
calculations. The purpose is to make chapter Support notebooks the source of
truth for reader-facing calculations while keeping manuscript prose responsible
for explanation, interpretation, and placement.

The machine-readable schema is encoded in
`scripts/manuscript-calculation-registry-schema-v1.json`.

## Registry Unit

A registry entry describes one calculation group. A group may render one
generated LaTeX snippet, provide several inline values, or support a report-only
check. Each group has stable metadata:

- `schema_version`: currently `1`.
- `id`: stable semantic ID for the calculation group.
- `kind`: `worked_calculation`, `inline_values`, `table_values`, or
  `report_only`.
- `chapter_prefix`: one of `pro`, `est`, `aux`, `hyp`, `reg`, or `gof`.
- `source_notebook`: canonical Support notebook path.
- `source_context`: human-readable source block, exercise, or calculation
  context.
- `source_dataset`: source dataset or package object, when relevant.
- `target_snippet`: generated LaTeX snippet path, when a snippet is rendered.
- `language_scope`: `shared`, `r`, `python`, or `exception`.
- `tolerance`: raw numeric comparison tolerance.
- `equation_labels`: related manuscript equation labels.
- `values`: registered raw/display values used by the group.

## Identifier Policy

Calculation IDs are semantic and stable. They should not contain exercise
numbers unless no stable semantic name exists.

Chapter prefixes:

- `pro`: probability distributions
- `est`: population estimation
- `aux`: auxiliary variables and stratification
- `hyp`: hypothesis testing
- `reg`: regression analysis
- `gof`: goodness of fit

Examples:

- `aux.mpu.estimator`
- `aux.mpu.total_audit_value`
- `hyp.significance.one_error_probability`
- `reg.adr.achieved_assurance`

## Value Contract

Each value stores:

- `id`: stable semantic value ID.
- `role`: the value's role inside the calculation group.
- `raw`: numeric source-of-truth value.
- `display`: rendered string used in the manuscript.
- `format`: formatting rule used to produce `display`.
- `tolerance`: optional value-specific tolerance overriding the group default.
- `language_scope`: optional value-specific language scope.

Raw values are compared numerically. Display values are compared only for
freshness of generated artifacts.

## Formatting Rules

Default formats:

- `integer`: thousands separators, no decimals.
- `number:2`: thousands separators, two decimals.
- `number:<digits>`: thousands separators and fixed decimal places.
- `percentage:1`: one decimal percentage.
- `pvalue:3`: three decimal places, with later support for very small values.
- `statistic:2` or `statistic:3`: test statistics with fixed decimals.

Money-like values use number formats and must not receive a currency symbol.
This is an international edition, so do not prefix monetary values with `$`.

## What To Register

Register values when they are important reader-facing calculations:

- sample sizes, population sizes, totals, means, and proportions;
- estimates, bounds, standard errors, variances, and critical values;
- p-values, test statistics, assurance percentages, and power calculations;
- worked-example intermediate values shown in equations;
- table values derived from Support notebook computations.

Do not register ordinary static or conceptual values unless they are
calculation outputs:

- purely illustrative constants;
- theoretical symbols and equation references;
- static page or section references;
- repeated mentions where one canonical occurrence is already generated or
  checked;
- model/test structures that are owned by #214.

Every unregistered manual number found during migration should be classified as
static, theoretical, illustrative, duplicated from a registered occurrence, or
covered by another workflow.

## Validation Expectations

Validation should fail when:

- a generated snippet is stale;
- a manuscript input points to a missing generated snippet;
- a registered value lacks raw value, display value, format, or source metadata;
- duplicate IDs appear;
- a shared R/Python raw value differs by more than `1e-8`, unless explicitly
  marked as an exception.

The MPU pilot metadata in `generated/worked-calculations/aux-mpu-estimator.json`
is the first concrete registry entry.
