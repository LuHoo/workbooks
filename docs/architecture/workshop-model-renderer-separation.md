# Workshop Model and Renderer Separation

Canonical overview: `docs/architecture/notebook-generation-and-publication.md`

This document describes the architectural separation introduced for workshop export so that parsing and semantic interpretation are reusable across renderers.

## Current Architecture

Before this separation, the export entrypoint in `scripts/export-workshop-output.R` hosted both:

- source parsing logic (`support.Rmd` to exercise/chunk segments), and
- LaTeX rendering concerns (R execution, inline evaluation, LaTeX composition).

That shape made renderer reuse harder because parser and renderer concerns were co-located.

## New Architecture

The exporter now follows a staged architecture:

1. `support.Rmd` is parsed into a neutral Workshop Model.
2. The model is adapted to renderer-ready segments.
3. A renderer is selected via a renderer boundary (`create_workshop_renderer`).
4. The renderer produces format output.

Current implementation uses:

- model layer: `scripts/workshop-model.R`
- parser: `scripts/workshop-ir.R`
- model validation: `scripts/workshop-ir-validate.R`
- renderer boundary: `scripts/workshop-renderer.R`
- LaTeX backend: `scripts/workshop-renderer-latex.R`

## Workshop Model

The Workshop Model is a renderer-neutral representation backed by the IR schema (`workshop-ir/1.1.0`) and includes:

- source metadata and chapter metadata;
- ordered chapter blocks and exercise blocks;
- narrative/code block content;
- support-only markers;
- authoring context and directives;
- traceability-relevant source spans.

The model remains serialization-friendly and testable because it is plain structured data.

## Parsing Layer

Responsibilities:

- read and parse `support.Rmd`;
- build a neutral workshop model;
- validate model consistency and configuration compatibility;
- emit actionable parser diagnostics.

Non-responsibilities:

- no LaTeX formatting;
- no renderer-specific output generation;
- no notebook-specific output generation.

## Rendering Layer

Responsibilities:

- consume parsed model/segments only;
- perform renderer-specific execution and formatting;
- produce output artifacts.

For LaTeX specifically:

- R/knitr execution lifecycle is owned by the LaTeX backend;
- inline evaluation and markdown-to-LaTeX transformations are renderer concerns;
- output composition and validation are renderer concerns.

## Renderer Extension Points

Renderer extension points are explicit:

- `create_workshop_renderer(format)` selects backend implementation.
- `render_workshop_chunk(renderer, ...)` dispatches rendering.
- backends implement `render_chunk` and can own execution/runtime details.

A future renderer can be added by implementing a backend and registering it in `scripts/workshop-renderer.R` without changing parser internals.

## Path to Issue #87

This separation establishes the prerequisite for multi-target output architecture: parsing into a stable model once, then rendering through pluggable backends.

Legacy rollback note:

- The renderer/model separation does not itself authorize immediate retirement of `--parser-engine legacy`.
- Parser lifecycle and rollback removal are governed separately by `docs/architecture/legacy-parser-deprecation-policy.md`.

The path to future format support is:

- keep parser/model authoritative;
- add new renderers that consume the same model;
- avoid duplicate source parsing logic in each output format.

This preserves existing LaTeX output behavior while enabling future renderer work to proceed independently.
