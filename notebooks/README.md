# Notebook sources

Each Volume 1 chapter has one authored R notebook at
`support/<semantic-chapter>/support.Rmd`. These canonical notebooks contain both the workshop exercises and
the private support calculations used while maintaining the book. Chapter
numbers live in `scripts/notebook-manifest.R`; filenames do not change when a
volume is reorganized.

Material enclosed by the exact marker lines

```text
<!-- SUPPORT-ONLY:START -->
<!-- SUPPORT-ONLY:END -->
```

is retained in the private support notebook and omitted from the generated
public workshop. Run `Rscript scripts/render-notebooks.R` to regenerate and render all
public Binder workbooks in the `notebooks/workshops` submodule. Pass `canonical`
to render the private sources, or `all` to render both variants. To export workshop
exercise chunks without rendering, run `Rscript scripts/export-workshops.R`.
The canonical chunk exporter entry point is:

`Rscript scripts/export-workshop-output.R --input <support.Rmd> --output <exercise-*.tex>`

This command uses the Workshop IR parser path by default. To force legacy as a
rollback path, pass `--parser-engine legacy`.

For example:

`Rscript scripts/export-workshop-output.R --input notebooks/support/probability-distributions/support.Rmd --output generated/workshop-output/exercise-1-1-1.tex`

Legacy workshop-specific scripts call this CLI for backward compatibility.
Supported wrapper scripts are:

- `Rscript scripts/export-probability-distributions-workshop.R`
- `Rscript scripts/export-hypothesis-testing-workshop.R`
- `Rscript scripts/export-regression-analysis-workshop.R`
- `Rscript scripts/export-goodness-of-fit-workshop.R`

Never edit generated public R workbooks
directly.

`support/analytical-procedures/support.Rmd` is a private-only Volume 2 figure
notebook. It is canonical but has no Binder export.

Git history replaces version suffixes such as `_v01`, `_v02`, `bis`, and
`DELETE`; canonical notebook filenames remain stable.
