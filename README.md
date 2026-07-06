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
