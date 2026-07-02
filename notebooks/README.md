# Notebook sources

Each Volume 1 chapter has one authored R notebook under its semantic chapter
directory. These canonical notebooks contain both the workshop exercises and
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
to render the private sources, or `all` to render both variants. To export without rendering, run
`Rscript scripts/export-workshops.R`. Never edit generated public R workbooks
directly.

`analytical-procedures/figure-support.Rmd` is a private-only Volume 2 figure
notebook. It is canonical but has no Binder export.

Git history replaces version suffixes such as `_v01`, `_v02`, `bis`, and
`DELETE`; canonical notebook filenames remain stable.
