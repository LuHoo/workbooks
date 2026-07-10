# Workshop IR Python Notebook Renderer

This document specifies the deterministic IR-to-notebook renderer introduced for
Python workshop output generation.

## Scope

The renderer consumes canonical workshop IR and generates chapter-aligned
`.ipynb` notebooks.

Design constraints:

- consume IR only (no source reparsing in renderer core);
- preserve chapter/exercise ordering from IR;
- apply language-aware overrides for Python as specified by IR v1.1;
- produce byte-for-byte identical output for unchanged IR input.

## Entry Points

- `scripts/workshop-ir-python-renderer.py`
  - core renderer: IR JSON -> deterministic `.ipynb`.
- `scripts/export-python-notebooks.R`
  - orchestrator: parses/validates canonical IR per configured workshop source,
    then invokes the Python renderer.

## Rendering Pipeline

1. **Load IR** from JSON file.
2. **Validate IR contract** for supported schema versions and sequence integrity.
3. **Resolve exercise plan** in ordinal order.
4. **Resolve language behavior** (`target_language=python`) with directive
   precedence.
5. **Map effective blocks to notebook cells**.
6. **Attach stable metadata/provenance**.
7. **Serialize canonical notebook JSON** with stable formatting.

## Cell Mapping

### Exercise boundaries

- Each exercise starts with one markdown heading cell (`## <exercise label>`).
- Exercises are rendered strictly in `ordinal` order.

### Narrative blocks

- IR `block_type=narrative` -> markdown cell.
- Cell source is derived from `content.narrative_lines`.

### Code blocks

- IR `block_type=code` -> code cell.
- Cell source is derived from `content.code_lines`.
- `execution_count` is `null` and `outputs` is an empty list.

## Override Resolution Rules

Renderer precedence for Python target:

1. Python override (`mode=override`, `lang_scope=python`)
2. Shared base block (`mode=base`, `lang_scope=shared`)
3. Validation failure on invalid/conflicting override metadata

Additional behavior:

- Python `mode=only` blocks are included for Python output only.
- Duplicate overrides for the same target block fail validation.
- Missing override targets fail validation.

## Provenance and Metadata

Notebook-level metadata (`metadata.ada_renderer`):

- renderer version
- target language
- IR schema version
- chapter/workshop identifiers
- source file reference

Cell-level metadata (`metadata.traceability`):

- exercise id/reference
- block id
- source file and source block key
- source span

## Determinism Guarantees

The renderer enforces deterministic output by:

- fixed notebook format fields (`nbformat=4`, fixed minor version);
- deterministic cell IDs from stable IR-derived seeds;
- fixed ordering of exercises, blocks, and cells;
- canonical JSON serialization (`sort_keys=True`, fixed indentation);
- no timestamps or runtime/session metadata.

## Validation Diagnostics

Renderer diagnostics include:

- stage (`validate-ir`, `resolve-overrides`, `render-cells`)
- chapter
- block identifier (when available)
- machine-readable error code
- actionable remediation guidance

## Testing Strategy

`tests/python-renderer/run-tests.py` covers:

- chapter rendering and exercise ordering parity;
- narrative/code block mapping;
- override application;
- deterministic output across repeated runs;
- renderer validation failures for broken override references;
- golden notebook comparison.

Compatibility with existing IR/R workflows is verified by retaining and running
`tests/workshop-ir/run-tests.R`.
