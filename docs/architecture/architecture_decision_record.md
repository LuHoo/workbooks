# Architecture Decision Record: Canonical Notebook Generation and Publication Architecture

**Status:** Proposed
**Related issues:** #108, #89, #90, Reference System (future issue)

---

# Purpose

This document defines the high-level architecture for workshop authoring, notebook generation, book generation, and publication within the ADA project.

Its purpose is to establish the architectural principles that guide future implementation. More detailed technical documentation may evolve over time, but should remain consistent with the decisions recorded here.

---

# Design philosophy

The ADA project is built around a single fundamental principle:

> **Every educational concept should be authored exactly once.**

Everything else is generated from that canonical source.

This minimizes duplication, prevents divergence between educational artefacts, and ensures that improvements automatically propagate throughout the ecosystem.

---

# Single source of truth

The canonical workshop definition consists of:

* `support.Rmd`
* workshop configuration
* traceability metadata
* semantic reference metadata

Within this architecture, `support.Rmd` is the primary educational source.

It contains:

* instructional narrative;
* exercises;
* shared explanations;
* language-specific explanations;
* R code;
* Python code or overrides;
* support-only material;
* semantic references.

No generated artefact may become an independent source of truth.

Whenever an error is discovered, it should be corrected at the earliest authoritative layer.

---

# Overall architecture

```text
                     Canonical Authoring

                 notebooks/support/.../support.Rmd
                               │
                               ▼
                      Workshop Model / IR
                               │
              ┌────────────────┴────────────────┐
              ▼                                 ▼
      R notebook renderer              Python notebook renderer
              │                                 │
              ▼                                 ▼
     distribution.Rmd                 distribution.ipynb
     (without outputs)                (without outputs)
              │                                 │
              ├──────── publication ────────────┤
              │                                 │
              ▼                                 ▼
                     Binder / Student notebooks


                        Book Build Pipeline

     distribution.Rmd                 distribution.ipynb
              │                                 │
              ▼                                 ▼
      controlled execution             controlled execution
              │                                 │
              ▼                                 ▼
     validated executed notebook      validated executed notebook
              │                                 │
              ▼                                 ▼
      notebook → LaTeX renderer       notebook → LaTeX renderer
              │                                 │
              └──────────────┬──────────────────┘
                             ▼
                          ADA Book
```

---

# Workshop Model / IR

The Workshop Model (IR) is the renderer-neutral representation of the workshop.

It contains semantic information only.

It deliberately does **not** contain renderer-specific formatting.

Every renderer consumes the same Workshop Model.

No renderer should implement its own parser for `support.Rmd`.

---

# Student notebooks

Two student-facing notebook formats are generated.

## R notebook

The R notebook contains:

* shared instructional material;
* R-specific instructional material;
* executable R code;
* no support-only material;
* no Python-only content.

## Python notebook

The Python notebook contains:

* shared instructional material;
* Python-specific instructional material;
* executable Python code;
* no support-only material;
* no R-only content.

Both notebooks are educationally equivalent.

They may differ in implementation details, but should present the same learning experience.

---

# Distribution notebooks

The notebooks published to Binder are distribution artefacts.

Characteristics:

* executable by students;
* contain no outputs;
* contain no execution counts;
* deterministic;
* generated automatically.

They are never edited manually.

---

# Executed notebooks

Before book generation, the distribution notebooks are executed in a controlled environment.

This produces a temporary build artefact:

* validated executed notebook.

Characteristics:

* contains outputs;
* contains execution results;
* is used only during the build;
* is never manually edited;
* is not distributed to students.

Execution is intentionally separated from presentation.

---

# Book generation

The ADA book is generated from validated executed notebooks.

The notebook-to-LaTeX renderer:

* reads notebook cells;
* converts markdown;
* converts code;
* converts outputs;
* preserves ordering;
* applies book typography.

It does **not** execute code.

This guarantees that the book presents exactly the notebook that has been validated.

---

# Instructional text

Three categories of instructional text exist.

## Shared instructional text

Appears in:

* R notebook;
* Python notebook;
* corresponding workshop sections in the book.

## Language-specific instructional text

Appears only in the relevant language.

Examples:

* R-specific explanations;
* Python-specific explanations.

These are generated using language-aware directives.

## Book-only text

Book narrative that connects workshop sections to the surrounding chapter.

Examples:

* introductions;
* transitions;
* chapter summaries;
* references to earlier sections.

Book-only narrative remains outside the notebook generation pipeline.

---

# Reference architecture

References are semantic rather than presentation-specific.

Examples:

* figures;
* tables;
* sections;
* exercises.

The canonical source contains stable identifiers.

Renderers transform these identifiers into target-specific references.

Examples:

* notebook-friendly text;
* `\ref{}`;
* `\pageref{}`;
* `\autoref{}`.

Page numbers are never stored in canonical source material.

---

# Validation pipeline

Validation occurs in distinct stages.

## Generation validation

Verifies:

* structural correctness;
* deterministic generation;
* parser consistency.

## Notebook validation

Verifies:

* notebook integrity;
* executable structure;
* language-specific correctness.

## Execution validation

Verifies:

* successful execution;
* generated outputs;
* runtime correctness;
* parity where applicable.

## Book validation

Verifies:

* successful notebook-to-LaTeX conversion;
* reference integrity;
* generated workshop inclusion.

---

# Canonical versus generated artefacts

| Artefact                          | Status                    | Manual editing |
| --------------------------------- | ------------------------- | -------------- |
| support.Rmd                       | Canonical                 | Yes            |
| Workshop configuration            | Canonical                 | Yes            |
| Traceability metadata             | Canonical                 | Yes            |
| Reference metadata                | Canonical                 | Yes            |
| Workshop Model / IR               | Generated                 | No             |
| Distribution R notebook           | Generated                 | No             |
| Distribution Python notebook      | Generated                 | No             |
| Executed notebooks                | Temporary build artefacts | No             |
| Generated LaTeX workshop sections | Generated                 | No             |
| Book-only LaTeX                   | Canonical                 | Yes            |
| Final PDF                         | Build artefact            | No             |

---

# Error correction principle

Whenever an error is discovered:

1. determine the earliest authoritative source responsible;
2. correct the canonical source;
3. regenerate downstream artefacts;
4. revalidate;
5. republish if necessary.

Generated artefacts must never be manually corrected.

---

# Architectural principles

1. Author educational content once.
2. Generate everything else.
3. Parse once.
4. Render many.
5. Execute before presentation.
6. Separate execution from rendering.
7. Separate generation from publication.
8. Separate publication from deployment.
9. Preserve provenance throughout the pipeline.
10. Fix errors at the earliest authoritative layer.

---

# Future work

This document records architectural intent.

Implementation details are documented separately, including:

* Workshop IR
* Renderer architecture
* Binder runtime
* Publication workflows
* Reference system
* Validation workflows

These implementation documents should remain consistent with the principles established here.
