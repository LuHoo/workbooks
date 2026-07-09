# Traceability Identifier Conventions

This document defines the canonical identifier conventions for sub-issue 2.

Conventions are documented here and encoded in:

- `scripts/traceability-id-conventions.R`

## Learning Objective IDs

Supported formats:

- Chapter level: `LO-C<chapter>-NN`
- Section level: `LO-C<chapter>S<section>-NN`

Examples:

- `LO-C3-01`
- `LO-C5S5.3-02`

Rules:

- `NN` is a two-digit sequence scoped to chapter or section.
- IDs are stable and not repurposed.

## Workshop Exercise IDs

Format:

- `WX-<workshop_id>-<exercise>-<chunk>`

Examples:

- `WX-regression-analysis-5.12-1`
- `WX-goodness-of-fit-6.2-18`

Rules:

- `workshop_id` must match workshop config IDs used by exporter wrappers.
- `exercise` follows chapter.exercise notation.
- `chunk` is a positive integer within the exercise.

## Review Question IDs

Format:

- `RQ-C<chapter>-NNN`

Examples:

- `RQ-C6-001`
- `RQ-C5-014`

Rules:

- `NNN` is a three-digit sequence scoped to chapter.
- IDs remain stable if wording changes.

## Validation Behavior

`scripts/traceability-id-conventions.R` provides:

- format validators (`is_valid_*`)
- uniqueness checks (`assert_unique_ids`)
- strict assertions for each entity type (`assert_valid_*_ids`)

These checks are intended for integration into exporter/report generation and CI.

## Reader-Facing Policy

Internal IDs are for authoring, QA, and reporting only.

- Do not show `LO-*`, `WX-*`, or `RQ-*` identifiers in student-facing book text.
- Show objective text (and optionally Bloom level) where pedagogically useful.
