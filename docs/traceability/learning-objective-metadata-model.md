# Learning Objective Traceability Metadata Model

This document defines the metadata model for the learning-objective (LO) traceability system.
It covers sub-issue 1 of epic `86-epic-implement-learning-objective-traceability-system`.

## Goals

- Create stable identifiers for learning objectives, workshop exercises, and review questions.
- Support many-to-many mappings between objectives and activities.
- Keep internal IDs out of student-facing book/notebook content.
- Enable deterministic automated reporting and validation in the exporter.

## Design Principles

- IDs are stable and never repurposed.
- Metadata is author-editable and diff-friendly.
- Relationships are explicit (no inferred links from prose text).
- Validation must fail loudly for unresolved references.
- Published outputs show objective text (and optional Bloom level), not internal IDs.

## Core Entities

### 1) Learning objective

Required fields:

- `id`: stable unique LO ID.
- `chapter`: chapter number as integer.
- `scope`: `chapter` or `section`.
- `text`: reader-facing objective text.
- `bloom`: Bloom taxonomy level.
- `status`: `active` or `retired`.

Optional fields:

- `section`: section number string when `scope = section` (for example `5.3`).
- `notes`: internal author note.

### 2) Workshop exercise

Required fields:

- `id`: stable exercise ID.
- `workshop_id`: workshop key from `scripts/workshop-export-config.R`.
- `exercise`: exercise reference (for example `5.12`).
- `chunk`: chunk number integer (for generated chunk granularity).

Optional fields:

- `source_file`: source notebook path.

### 3) Review question

Required fields:

- `id`: stable review-question ID.
- `chapter`: chapter number as integer.
- `ordinal`: question number within chapter.

Optional fields:

- `source_file`: source TeX file path.
- `anchor`: optional internal anchor/label.

## Relationship Model

The model uses explicit mapping tables.

- `lo_to_workshop`: each row maps one LO to one workshop exercise ID.
- `lo_to_review`: each row maps one LO to one review question ID.

Many-to-many behavior is achieved through multiple rows.

## Identifier Conventions

### Learning objective IDs

Format:

- Chapter-level: `LO-C<chapter>-NN`
- Section-level: `LO-C<chapter>S<section>-NN`

Examples:

- `LO-C3-01`
- `LO-C5S5.3-02`

Rules:

- `NN` is a 2-digit sequence within scope.
- ID remains fixed even if objective wording is refined.
- Retired objectives keep their IDs with `status: retired`.

### Workshop exercise IDs

Format:

- `WX-<workshop_id>-<exercise>-<chunk>`

Example:

- `WX-regression-analysis-5.12-1`

Rules:

- `workshop_id` must match the existing workshop config ID.
- `exercise` and `chunk` must match generated naming semantics.

### Review question IDs

Format:

- `RQ-C<chapter>-NNN`

Example:

- `RQ-C6-004`

Rules:

- `NNN` is 3-digit sequence within chapter.
- Reordering question text should not force ID changes.

## Canonical Metadata Files

Proposed canonical files under `metadata/traceability/`:

- `learning_objectives.yml`
- `workshop_exercises.yml`
- `review_questions.yml`
- `lo_to_workshop.yml`
- `lo_to_review.yml`

All files are append-friendly lists of records.

## YAML Record Examples

```yaml
# learning_objectives.yml
- id: LO-C5-01
  chapter: 5
  scope: chapter
  text: Apply regression diagnostics to assess model validity in audit analyses.
  bloom: analyze
  status: active

- id: LO-C5S5.3-01
  chapter: 5
  scope: section
  section: "5.3"
  text: Interpret coefficient estimates and confidence intervals in context.
  bloom: understand
  status: active
```

```yaml
# workshop_exercises.yml
- id: WX-regression-analysis-5.12-1
  workshop_id: regression-analysis
  exercise: "5.12"
  chunk: 1
  source_file: notebooks/support/regression-analysis/support.Rmd
```

```yaml
# review_questions.yml
- id: RQ-C5-001
  chapter: 5
  ordinal: 1
  source_file: review_questions.tex
```

```yaml
# lo_to_workshop.yml
- lo_id: LO-C5-01
  workshop_id: WX-regression-analysis-5.12-1

- lo_id: LO-C5S5.3-01
  workshop_id: WX-regression-analysis-5.12-1
```

```yaml
# lo_to_review.yml
- lo_id: LO-C5-01
  review_question_id: RQ-C5-001
```

## Validation Rules (for exporter integration)

Hard errors:

- duplicate IDs in any entity file.
- mapping references missing `lo_id`, `workshop_id`, or `review_question_id`.
- invalid ID format for any entity.
- `scope: section` without `section` value.

QA exceptions (report, optionally fatal by flag):

- LO with no workshop mapping.
- LO with no review mapping.
- workshop exercise with no LO mapping.
- review question with no LO mapping.
- Bloom level defined but never represented in coverage output.

## Bloom Vocabulary

Allowed values:

- `remember`
- `understand`
- `apply`
- `analyze`
- `evaluate`
- `create`

## Reader-Facing Publication Policy

- Internal IDs (`LO-*`, `WX-*`, `RQ-*`) are excluded from reader-facing LaTeX and notebooks.
- Reader-facing material may display objective text and optional Bloom level labels.
- Traceability tables are internal QA artifacts unless explicitly exported for instructor use.

## Compatibility Notes

- Workshop IDs intentionally align with `scripts/workshop-export-config.R` (`id` field).
- Workshop exercise references align with generated chunk semantics `exercise-<chapter>-<exercise>-<chunk>.tex`.
- Review-question extraction can initially be chapter+ordinal based, then upgraded to label anchors later without breaking `RQ-*` IDs.

## Definition of Done for Sub-Issue 1

- Metadata entities and required fields are defined.
- Identifier conventions are fixed.
- Mapping model is defined and many-to-many capable.
- Validation rules are clearly specified.
- Reader-facing non-exposure policy is documented.
