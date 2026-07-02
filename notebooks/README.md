# Notebook sources

## Regression analysis

`regression-analysis/regression-analysis.Rmd` is the only authored source for
the Regression notebooks. It contains the full support material used while
maintaining the book.

Material enclosed by the exact marker lines

```text
<!-- SUPPORT-ONLY:START -->
<!-- SUPPORT-ONLY:END -->
```

is retained in the private support notebook and omitted from the public
workshop. Run

```sh
Rscript scripts/render-regression-notebooks.R
```

to regenerate the public Binder workbook in the `notebooks/workshops`
submodule and render both variants. Never edit the generated public Regression
workbook directly.

Git history replaces version suffixes such as `_v01`, `_v02`, `bis`, and
`DELETE`; new canonical notebook filenames should remain stable.
