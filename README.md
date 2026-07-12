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

## Workshop IR (v1.1)

A canonical, versioned Intermediate Representation (IR) can be generated from
`support.Rmd` notebooks.

Schema and docs:

- `scripts/workshop-ir-schema-v1.json`
- `docs/architecture/workshop-ir-schema-v1.md`
- `docs/architecture/workshop-ir-directives.md`
- `docs/authoring/language-aware-directives.md`

Directive support in v1.1:

- parser-level support for `ADA:BEGIN`, `ADA:END`, and `ADA:REQUIRES`;
- deterministic per-block `authoring_context` metadata;
- emitted directive event records in `directives.instances`.

Generate IR JSON:

- `Rscript scripts/workshop-ir.R --input notebooks/support/probability-distributions/support.Rmd --pretty`

## Workshop IR Validation

Validate parsed IR structure and compatibility with workshop export configuration:

- `Rscript scripts/workshop-ir-validate.R --input notebooks/support/probability-distributions/support.Rmd --config-id probability-distributions --pretty`

Validation spec:

- `docs/architecture/workshop-ir-validation.md`

## Optional IR Parser Integration

The canonical exporter supports an optional parser backend switch. Default behavior
is unchanged.

- Default (legacy parser):
	- `Rscript scripts/export-workshop-output.R --input <support.Rmd> --output <exercise-*.tex>`
- IR parser path:
	- `Rscript scripts/export-workshop-output.R --input <support.Rmd> --output <exercise-*.tex> --parser-engine ir`

Allowed values for `--parser-engine`:

- `legacy` (default)
- `ir`

Migration and rollback guidance:

- `docs/architecture/workshop-ir-migration-and-rollback.md`

Rollback is immediate by switching parser selection back to legacy (or omitting
`--parser-engine`, which defaults to legacy).

## Workshop IR Test Harness

Run the IR-focused regression test suite:

- `Rscript tests/workshop-ir/run-tests.R`

The suite covers:

- golden summary checks for deterministic extraction;
- malformed source diagnostics;
- IR validation checks;
- round-trip segment consistency (legacy parser vs IR adapter);
- exporter output compatibility (`--parser-engine legacy` vs `--parser-engine ir`).

## Python Notebook Renderer (IR-Based)

Generate deterministic Python `.ipynb` outputs from canonical workshop IR:

- batch generation from configured workshop sources:
	- `Rscript scripts/export-python-notebooks.R`
- single configured workshop id:
	- `Rscript scripts/export-python-notebooks.R --config-id probability-distributions`
- direct renderer invocation with pre-generated IR JSON:
	- `python3 scripts/workshop-ir-python-renderer.py --input-ir <ir.json> --output-notebook <chapter.ipynb> --target-language python`

Renderer guarantees:

- consumes canonical IR only;
- preserves exercise ordering and numbering from IR;
- applies Python overrides from directive-aware IR metadata;
- emits deterministic notebook JSON for unchanged input.

Architecture and mapping details:

- `docs/architecture/workshop-ir-python-renderer.md`
- `docs/architecture/fsaudit-rpy2-bridge.md`
- `docs/architecture/workshop-model-renderer-separation.md`

Renderer tests:

- `python3 tests/python-renderer/run-tests.py`

Bridge/runtime tests:

- `python -m unittest tests/python-renderer/test_fsaudit_bridge.py`

The FSAudit-backed Python notebooks for chapters 3 and 4 rely on the reusable
`ada_fsaudit_bridge` module at the repository root. Setup, reproducibility,
public API, and troubleshooting guidance are documented in
`docs/architecture/fsaudit-rpy2-bridge.md`.

Recommended validated notebook runtime:

- Python 3.10
- R 4.3.1
- FSaudit 0.3.4+
- rpy2 3.6.7

## Binder and Notebook Execution Validation

Binder and CI execution architecture for dual-language workshop support is
documented in:

- `docs/architecture/binder-notebook-execution.md`

Binder configuration lives in `.binder/` and is designed to support both:

- R workshop notebooks (`notebooks/workshops/*.Rmd`)
- generated Python notebooks (`generated/python-notebooks/**/*.ipynb`)

Binder system packages are managed in `.binder/apt.txt`.

For native R package build paths, maintain these required OS dependencies there:

- `cmake` (required by `nloptr` source builds)
- `libharfbuzz-dev` and `libfribidi-dev` (required by `textshaping`/`systemfonts` headers)

See `docs/architecture/binder-notebook-execution.md` for full dependency flow and maintainer guidance.

CI execution workflow:

- `.github/workflows/notebook-execution-validation.yml`

Local-first validation quickstart:

- Combined local gate first:
  - `bash scripts/ci/local-notebook-validation-gate.sh`
- For standalone Python validation commands, prefer the project venv interpreter:
  - `.venv/bin/python scripts/ci/check-generated-python-notebooks.py --input-dir generated/python-notebooks`
  - `.venv/bin/python scripts/ci/assert-r-python-equivalence.py --chapters 1,2,3,4,5,6`
  - `.venv/bin/python scripts/ci/execute-generated-python-notebooks.py --input-dir generated/python-notebooks --artifacts-dir generated/notebook-execution-artifacts`

Hosted Binder run policy:

- Run full hosted Binder validation only after local-first checks are green.
- Trigger full hosted Binder checks deliberately via manual workflow dispatch (`workflow_dispatch`) instead of on every development push.

Publication gating:

- `.github/workflows/export-workshops.yml` now requires notebook execution
	validation to pass before export/publication can proceed.

### Traceability Metadata Ingestion

The exporter can now read learning-objective traceability metadata from
`metadata/traceability/`.

Current behavior in this milestone:

- metadata loading and ID validation are performed when metadata files are
	present;
- exporter output remains unchanged (report generation is implemented in
	follow-up issues);
- ingestion can be configured via CLI flags.

CLI flags:

- `--traceability-dir <path>` to override metadata location;
- `--traceability-strict` to fail when the metadata directory exists but
	required files are missing;
- `--no-traceability` to skip metadata loading.

## Learning Objective Coverage Reports

Generate learning-objective coverage reports from traceability metadata:

`Rscript scripts/generate-traceability-reports.R`

Optional flags:

- `--metadata-dir <path>` to override metadata source directory;
- `--output-dir <path>` to override report output directory.

Generated outputs (default directory `generated/traceability/`):

- `learning-objective-coverage.csv`
- `learning-objective-bloom-summary.csv`
- `workshop-exercise-to-lo.csv`
- `review-question-to-lo.csv`
- `lo-to-workshop-links.csv`
- `lo-to-review-links.csv`
- `traceability-exceptions.csv`
- `learning-objective-coverage.md`

Contributor workflow documentation:

- `docs/traceability/contributor-workflow.md`

### Assumptions and limitations

- `knitr` is required.
- The parser expects unique `Exercise <chapter>.<exercise>` headings.
- Output filename schema is mandatory.
- No reference system or source linting is implemented in this milestone.

### Stability declaration

No architectural redesign is expected before follow-up issues (references,
controlled linting, and style cleanup). Future work should extend this exporter
through the documented stages and configuration interfaces.

## Controlled Workshop Linting

Workshop source linting is handled by a dedicated script, separate from export:

`Rscript scripts/lint-workshop-source.R`

### Purpose

- provide a safe, repeatable source-formatting workflow for `support.Rmd` files;
- resolve recurring style issues in R chunk code without changing rendered
	workshop prose or LaTeX-sensitive structures.

### Modes

- Check-only mode (non-zero exit when changes would be needed):
	- `Rscript scripts/lint-workshop-source.R --all --check`
- Auto-fix mode (in-place safe fixes):
	- `Rscript scripts/lint-workshop-source.R --all --fix`
- Targeted file mode:
	- `Rscript scripts/lint-workshop-source.R --input notebooks/support/goodness-of-fit/support.Rmd --check`

### Safety boundaries

The linter only modifies R chunk bodies (```` ```{r ...}```` blocks) outside
support-only sections. It does not modify:

- Markdown prose;
- LaTeX environments;
- tables;
- verbatim material;
- support-only blocks (`<!-- SUPPORT-ONLY:START -->` / `<!-- SUPPORT-ONLY:END -->`).

### Applied transformations

- remove trailing whitespace where safe (R chunk bodies only);
- style R chunk bodies with project `styler` configuration;
- enforce consistent spacing around infix operators via `styler` output.

### Relationship to exporter

- Exporter responsibility: convert workshop source to generated LaTeX.
- Linter responsibility: check/fix safe workshop-source formatting.

The exporter remains canonical and does not require linting to run. Linter
invocation by the exporter can be considered in future issues once lint behavior
is proven stable.

### Diagnostics policy

Editor `lintr` diagnostics are intentionally limited to reduce noise on legacy
workshop sources. In particular, `object_name_linter` is not enforced for this
project.

The authoritative style workflow for workshop support files is
`scripts/lint-workshop-source.R` in `--check`/`--fix` mode, not broad editor
style diagnostics.
