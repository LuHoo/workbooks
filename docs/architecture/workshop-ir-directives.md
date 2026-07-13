# Workshop IR Language-Aware Directives

Canonical overview: `docs/architecture/notebook-generation-and-publication.md`

This specification defines language-aware authoring directives for `support.Rmd`
files and their representation in workshop IR.

## Status

- Version: v1.1
- Parser target: `workshop-ir/1.1.0`

## Goals

- Author shared source content once.
- Allow Python-specific narrative/code without notebook forks.
- Keep parsing deterministic and line-traceable.
- Preserve backward compatibility for notebooks without directives.

## Supported directives

1. Region begin

`<!-- ADA:BEGIN lang=<language-id> mode=<only|override> [kind=<narrative|code|any>] -->`

2. Region end

`<!-- ADA:END -->`

3. Capability annotation

`<!-- ADA:REQUIRES capability=fsaudit -->`

## Grammar

Directive lines must match full-line HTML comments:

- Begin: `^<!--\s*ADA:BEGIN\s+...\s*-->$`
- End: `^<!--\s*ADA:END\s*-->$`
- Requires: `^<!--\s*ADA:REQUIRES\s+...\s*-->$`

Attributes are key-value pairs separated by spaces.

## Attribute rules

`ADA:BEGIN`

- required: `lang`, `mode`
- optional: `kind` (default: `any`)
- `lang`: currently `python` (extensible)
- `mode`: `only` or `override`
- `kind`: `narrative`, `code`, or `any`

`ADA:REQUIRES`

- required: `capability`
- `capability`: currently `fsaudit`

## Scope rules

- Directives are valid only outside code fences.
- `ADA:BEGIN` starts a region and `ADA:END` closes it.
- Region applies to blocks parsed between begin and end markers.
- `ADA:REQUIRES` applies to the next parsed code block.

## Nesting and placement

- Nested `ADA:BEGIN` regions are invalid.
- `ADA:END` without active region is invalid.
- Unclosed `ADA:BEGIN` at EOF is invalid.
- `ADA:REQUIRES` inside an active directive region is invalid.

## Conflict resolution

`mode=override` targets the nearest preceding shared block in the same exercise
with matching kind.

Invalid conflicts:

- no eligible target for override
- duplicate override for same `(target block, language)`
- language override kind mismatch

## IR representation

Directive behavior is represented explicitly in IR:

- top-level `directives.instances[]`
- block-level `authoring_context`

`authoring_context` includes:

- `lang_scope`: `shared` or language id
- `mode`: `base`, `only`, `override`
- `kind`: `narrative`, `code`, `any`
- `override_target_block_id` (optional)
- `requires` (optional list)

## Determinism contract

Given unchanged source and parser version:

- directive instance ordering is stable
- block metadata and override links are stable
- diagnostics order is stable
