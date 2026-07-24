# Content Authoring Workflow

This guide explains where to add book and workshop content, how the support
notebooks relate to published workshops, and which automated actions keep the
generated outputs in sync.

## Source Files

### Book Chapters

Write book prose in the chapter `.tex` files at the repository root, for
example:

- `probability-distributions.tex`
- `estimation.tex`
- `auxiliary.tex`
- `hypothesis-testing.tex`
- `regression-analysis.tex`
- `goodness-of-fit.tex`

The master file `ada_volume1.tex` inputs these chapters and the backmatter. Do
not put ordinary chapter prose in generated workshop chunk files.

### Workshop Source

Write workshop source content in:

```text
notebooks/support/<workshop-slug>/support.Rmd
```

These `support.Rmd` files are the canonical source for workshop exercises. They
feed several generated artifacts:

- public R workshop notebooks under `notebooks/workshops/`;
- generated Python notebooks under `generated/python-notebooks/`;
- generated R LaTeX chunks under `generated/workshop-output/`;
- generated Python LaTeX chunks under `generated/workshop-output-python/`.

Generated files should not be edited by hand. If output is wrong, edit the
matching `support.Rmd` or exporter script, then regenerate.

## Support vs Workshop

### Support

The support notebook is the full authoring source. Use it for:

- shared exercise prose;
- R code that defines the canonical workshop calculation;
- Python-specific alternatives using ADA directives;
- helper setup needed by generated outputs;
- author-only or internal material wrapped in support-only markers.

Support-only blocks are written as:

```markdown
<!-- SUPPORT-ONLY:START -->
Internal author/support material.
<!-- SUPPORT-ONLY:END -->
```

Those blocks stay in the support source but are removed from published workshop
outputs.

### Workshop

The workshop output is what readers use. It is generated from support files and
should contain only the student-facing material for the R or Python track.

Examples:

1. Shared text for both tracks

Use ordinary Markdown when the same material should appear in both the R and
Python workshops:

````markdown
The sample mean estimates the population mean.

```{r}
mean(sample_values)
```
````

2. Python-only text

Use `mode=only` when material should appear only in the Python workshop:

````markdown
The R workshop continues here as usual.

<!-- ADA:BEGIN lang=python mode=only kind=narrative -->
In Python, the same calculation uses a pandas `Series`.
<!-- ADA:END -->
````

3. Python-override material

Use `mode=override` when the Python workshop should replace the preceding R
wording or code with Python-specific material:

````markdown
Calculate the sample mean in R.

```{r}
mean(sample_values)
```

<!-- ADA:BEGIN lang=python mode=override kind=code -->
```{r}
sample_values.mean()
```
<!-- ADA:END -->
````

See `docs/authoring/language-aware-directives.md` for directive details.

## Adding Or Changing Workshop Content

1. Edit the relevant `notebooks/support/<slug>/support.Rmd`.
2. If you add, remove, or split exercises/chunks, update
   `scripts/workshop-export-config.R`.
3. Regenerate the affected generated outputs.
4. Check that the chapter `.tex` file inputs the generated chunks.
5. Run the local checks before opening or merging a PR.

For a full local regeneration:

```bash
Rscript scripts/export-workshops.R
Rscript scripts/export-python-notebooks.R --output-dir generated/python-notebooks
Rscript scripts/publish-python-notebooks.R --input-dir generated/python-notebooks --output-dir notebooks/workshops
```

For chapter-specific wrapper scripts, use the matching `scripts/export-*-workshop.R`
file when one exists. These wrappers should generate per-exercise R and Python
chunks only; they must not write monolithic chapter-level workshop `.tex` files.

## Embedding Workshop Output In LaTeX

Prefer generated chunk inputs in the chapter `.tex` file:

```tex
\input{generated/workshop-output/exercise-5-36-1}
\input{generated/workshop-output-python/exercise-5-36-1}
```

Avoid monolithic workshop files such as `workshopNN_R.tex`,
`workshopNN_Python.tex`, or generated `workshop-*_Python.tex` files. The local
validation gate runs `scripts/ci/check-no-python-workshop-monoliths.R` to keep
chapter wrappers on the per-exercise chunk path.

## Local Checks

Use the combined local gate when working on notebook or workshop generation:

```bash
bash scripts/ci/local-notebook-validation-gate.sh
```

Useful focused checks:

```bash
Rscript scripts/ci/check-generated-python-workshop-includes.R
.venv/bin/python scripts/ci/assert-r-python-equivalence.py --chapters 1,2,3,4,5,6
Rscript scripts/workshop-ir-validate.R --input notebooks/support/probability-distributions/support.Rmd --config-id probability-distributions --pretty
Rscript scripts/lint-workshop-source.R --all --check
```

The equivalence command has two layers:

- structural coverage: generated R/Python exercise chunks exist and are embedded;
- numeric checks: selected R/Python metrics match within a small tolerance.

## GitHub Automation

### Export Workshop Notebooks

Workflow:

```text
.github/workflows/export-workshops.yml
```

Triggered by pushes to `main` that touch support notebooks or exporter scripts,
and by manual `workflow_dispatch`.

It:

- runs renderer and notebook checks;
- generates R workshops and Python notebooks;
- validates notebook hygiene and generated-artifact policy;
- publishes generated notebooks to the workbooks submodule/repository path when
  needed.

### Notebook Execution Validation

Workflow:

```text
.github/workflows/notebook-execution-validation.yml
```

Triggered by pushes and pull requests that touch support notebooks, workshop
notebooks, CI scripts, renderer code, traceability metadata, Binder files, or
the workflow itself. It can also be run manually.

It:

- generates Python notebooks;
- validates parity and traceability gates;
- checks generated notebook hygiene;
- runs R/Python equivalence checks;
- executes generated Python notebooks and uploads execution artifacts on
  failure or completion.

### Workshop IR Tests

Workflow:

```text
.github/workflows/workshop-ir-tests.yml
```

Triggered by pushes and pull requests that touch IR/parser/renderer files,
selected support notebooks, tests, or related architecture docs. It can also be
run manually.

It runs the workshop IR and Python renderer test harness.

### Binder Readiness

Workflow:

```text
.github/workflows/binder-readiness.yml
```

Triggered by relevant Binder/documentation changes, scheduled checks, and manual
dispatch.

It validates that published notebooks can be launched in the intended Binder
environment.

## Practical Rule Of Thumb

- Edit `.tex` files for book prose.
- Edit `support.Rmd` files for workshop exercises.
- Use support-only markers for author/internal material.
- Use ADA directives for Python-only or Python-override material.
- Regenerate outputs instead of editing generated files.
- Run the local gate, or at least the focused checks, before merging.
