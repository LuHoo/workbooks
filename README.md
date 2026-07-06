# audit-data-analysis
Audit Data Analysis

## Workshop Exporter CLI

Workshop exercise `.tex` chunks are generated through a single command-line entry point:

`Rscript scripts/export-workshop-output.R --input <support.Rmd> --output <exercise-*.tex>`

Example:

`Rscript scripts/export-workshop-output.R --input notebooks/support/probability-distributions/support.Rmd --output generated/workshop-output/exercise-1-1-1.tex`

### Supported input/output

- Input: canonical workshop source notebook under `notebooks/support/.../support.Rmd`.
- Output: one generated chunk file under `generated/workshop-output/` named `exercise-<chapter>-<exercise>-<chunk>.tex`.

### Export pipeline stages

1. Read source.
2. Parse workshop structure.
3. Process support-only blocks.
4. Transform R code and output.
5. Transform Markdown/LaTeX.
6. Apply spacing and formatting rules.
7. Validate generated output.
8. Write final `.tex` file.

### Notes

- Workshop-specific settings are isolated in `scripts/workshop-export-config.R`.
- The exporter fails loudly for unsupported constructs and malformed marker blocks.
- Chapter scripts remain as thin compatibility wrappers that delegate to the
	canonical exporter via configuration:
	- `scripts/export-probability-distributions-workshop.R`
	- `scripts/export-auxiliary-variables-and-stratification-workshop.R`
	- `scripts/export-hypothesis-testing-workshop.R`
	- `scripts/export-regression-analysis-workshop.R`
	- `scripts/export-goodness-of-fit-workshop.R`

### Convenience wrappers

To export all chunks for a chapter/workshop, run the relevant wrapper script.

Examples:

- `Rscript scripts/export-probability-distributions-workshop.R`
- `Rscript scripts/export-auxiliary-variables-and-stratification-workshop.R`
- `Rscript scripts/export-hypothesis-testing-workshop.R`
- `Rscript scripts/export-regression-analysis-workshop.R`
- `Rscript scripts/export-goodness-of-fit-workshop.R`

Note: The goodness-of-fit wrapper preloads the regression workshop in-process,
because chapter 6 exercises depend on objects produced by chapter 5 code.

## Exporter Architecture Freeze

The workshop exporter architecture is frozen as supported project infrastructure.
`scripts/export-workshop-output.R` is the canonical implementation for workshop
chunk generation.

### Why this structure

The architecture is organized around a strict separation between:

- stable export behavior (implemented once in the canonical exporter), and
- workshop/chapter variability (isolated in `scripts/workshop-export-config.R`).

This layout reduces duplicate logic, keeps behavior consistent across chapters,
and provides a controlled path for future enhancements without redesigning core
flow.

### Processing stages and responsibilities

- Stage 1 (`read_source_lines`): read the source notebook.
- Stage 2 (`extract_exercise_segments`): parse exercise headings and chunk
	boundaries.
- Stage 3 (`strip_support_only`): remove support-only content delimited by
	`<!-- SUPPORT-ONLY:START -->` / `<!-- SUPPORT-ONLY:END -->`.
- Stage 4 (`render_r_chunk_to_latex`): execute and render R input/output with
	LaTeX verbatim hooks.
- Stage 5 (`markdown_to_latex`, `convert_inline`, `escape_latex`): convert prose
	and inline constructs into LaTeX-safe output.
- Stage 6 (`compose_tex_document`): apply spacing/layout conventions and header
	metadata.
- Stage 7 (`validate_generated_output`): enforce basic structural sanity checks.
- Stage 8 (`write_output`): write final generated `.tex` chunk.

### Supported constructs

- R code fences only (` ```{r ...}``).
- Markdown prose with inline:
	- code spans using backticks,
	- emphasis markers (`*...*`),
	- inline math (`$...$`),
	- inline R (` `r ...` `).
- Display math fence passthrough for `$$`, `\[`, and `\]` blocks.
- Support-only block markers as described above.

Unsupported or malformed structures fail with explicit errors.

### Output contract

- Output target must be named
	`exercise-<chapter>-<exercise>-<chunk>.tex`.
- Generated files include an auto-generated header with source provenance.
- Chunk output is emitted with stable `Verbatim` wrappers and project color hooks.

### Extension points (approved path)

- Add new workshop/chapter mappings in `scripts/workshop-export-config.R`.
- Use `export_workshop_by_config_id(...)` for wrapper-level batch export.
- Add new validations in Stage 7 if they do not alter current output semantics.
- Add CLI options only when they preserve default behavior.

### Assumptions and limitations

- `knitr` is required.
- The parser expects unique `Exercise <chapter>.<exercise>` headings.
- Output filename schema is mandatory.
- No reference system or source linting is implemented in this milestone.

### Stability declaration

No architectural redesign is expected before follow-up issues (references,
controlled linting, and style cleanup). Future work should extend this exporter
through the documented stages and configuration interfaces.
