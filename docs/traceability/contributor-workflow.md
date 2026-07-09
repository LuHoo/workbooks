# Traceability Contributor Workflow

This guide defines the contributor workflow for maintaining learning-objective
traceability metadata and validating coverage.

It completes sub-issue 9 of epic
`86-epic-implement-learning-objective-traceability-system`.

## Goals

- keep learning-objective mappings current when exercises/questions change;
- make QA checks reproducible for every contributor;
- keep internal IDs out of student-facing outputs.

## Required Inputs

Traceability metadata lives in `metadata/traceability/`:

- `learning_objectives.yml`
- `workshop_exercises.yml`
- `review_questions.yml`
- `lo_to_workshop.yml`
- `lo_to_review.yml`

Reference specifications:

- metadata model: `docs/traceability/learning-objective-metadata-model.md`
- identifier formats: `docs/traceability/identifier-conventions.md`

## Standard Update Flow

1. Update learning objectives

- add/update LO records in `learning_objectives.yml`;
- keep IDs stable;
- when wording changes, keep the same ID;
- use `status: retired` instead of reusing old IDs.

2. Update workshop entities

- add/update workshop chunk records in `workshop_exercises.yml`;
- IDs must follow `WX-<workshop_id>-<exercise>-<chunk>`;
- ensure `workshop_id` matches exporter config IDs.

3. Update review entities

- add/update review-question records in `review_questions.yml`;
- IDs must follow `RQ-C<chapter>-NNN`.

4. Update mappings

- edit `lo_to_workshop.yml` for LO -> workshop links;
- edit `lo_to_review.yml` for LO -> review-question links;
- many-to-many mappings are represented by multiple rows.

5. Regenerate QA reports

```bash
Rscript scripts/generate-traceability-reports.R
```

6. Review outputs in `generated/traceability/`

- `learning-objective-coverage.md`
- `learning-objective-coverage.csv`
- `learning-objective-bloom-summary.csv`
- `workshop-exercise-to-lo.csv`
- `review-question-to-lo.csv`
- `lo-to-workshop-links.csv`
- `lo-to-review-links.csv`
- `traceability-exceptions.csv`

## Quality Gate Checklist

Before merging metadata changes, verify:

- every LO has at least one workshop or review link;
- every workshop exercise has at least one LO link;
- every review question has at least one LO link;
- `traceability-exceptions.csv` contains only accepted exceptions;
- no malformed IDs are present;
- no duplicate IDs are present.

## Handling Exceptions

If `traceability-exceptions.csv` contains rows:

1. resolve `unmapped` workshop or review entities by adding mappings;
2. resolve `workshop-only` or `review-only` LO rows by adding missing links;
3. if an exception is intentional, document rationale in the PR description.

## Authoring Rules

- keep YAML indentation with spaces (no tabs);
- keep records append-friendly and diff-friendly;
- avoid changing IDs solely for prose edits;
- do not expose `LO-*`, `WX-*`, or `RQ-*` IDs in reader-facing text.

## Recommended PR Pattern

1. commit source changes first (metadata, scripts, docs);
2. include generated reports only when explicitly requested;
3. summarize coverage deltas in the PR:

- newly mapped LOs;
- newly mapped workshop/review entities;
- remaining exceptions (if any).