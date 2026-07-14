# Regression Notebook Binder Dependency Audit

This note records the Iteration 1 Binder and dependency audit for the Chapter 5 regression workshop notebook.

## Scope

- Canonical notebook source: `notebooks/support/regression-analysis/support.Rmd`
- Published R workshop copy: `notebooks/workshops/Regression analysis workshop.Rmd`
- Binder runtime config reviewed: `.binder/install.R`, `.binder/postBuild`

## Root cause analysis

- The Chapter 5 notebook does depend on `car` for Exercise 5.3, Exercise 5.9, Exercise 5.12, and later diagnostics such as `qqPlot()`.
- Current Binder configuration already installs `car` and the notebook setup chunk already attaches `car` with `library(car)`.
- Local smoke execution of the published workshop succeeds, so the current evidence does not support a missing-package root cause for `car`.
- The actual risk is dependency opacity: key notebook functions are called without namespace qualification and Binder verification previously checked only package availability, not the specific `car` exports used by the notebook.
- Two setup packages are currently loaded but not referenced in the canonical regression notebook source: `tidyr` and `latex2exp`.

## `car` investigation

Exercises reviewed:

- Exercise 5.1 setup chunk
- Exercise 5.3 enhanced scatter plot
- Exercise 5.9 interaction scatter plot
- Exercise 5.12 influence index plot

Findings:

- `car` is installed in Binder via `.binder/install.R`.
- `car` is loaded in the notebook setup chunk via `library(car)`.
- Local validated version: `car` 3.1-2.
- No version-specific failure was reproduced for `scatterplot()` or `influenceIndexPlot()`.
- `scatterplot()` and `influenceIndexPlot()` are called without namespace qualification and therefore rely on the setup chunk attaching `car` successfully.

## Dependency matrix

| Package | Functions or objects used in the regression notebook | Where used | Installed in Binder | Loaded automatically |
| --- | --- | --- | --- | --- |
| `ggplot2` | `ggplot`, `aes`, `geom_histogram`, `geom_line`, `geom_point`, `geom_smooth`, `scale_x_continuous`, `scale_y_continuous`, `sec_axis`, `theme`, `element_blank`, `element_text`, `labs` | Exercises 5.3, 5.9, 5.11, 5.34, 5.35 | yes | yes |
| `aicpa` | `USSteamCo` | Exercises 5.2 onward | yes | yes |
| `car` | `scatterplot`, `influenceIndexPlot`, `qqPlot` | Exercises 5.3, 5.9, 5.12, 5.14, 5.24 | yes | yes |
| `gridExtra` | `grid.arrange`, `arrangeGrob` | Exercises 5.3, 5.10, 5.11 | yes | yes |
| `tidyr` | no direct calls found in current source | setup chunk only | yes | yes |
| `corrplot` | `corrplot` | Exercise 5.6 | yes | yes |
| `lmtest` | `bptest`, `bgtest` | Exercises 5.24, 5.26, 5.28 | yes | yes |
| `latex2exp` | no direct calls found in current source | setup chunk only | yes | yes |
| `scales` | `label_comma`, `rescale` via `scales::...` and attached namespace | Exercises 5.3, 5.9, 5.11, 5.35 | yes | yes |
| `grid` | `unit`, `grid.newpage`, `grid.draw` | Exercises 5.3, 5.11 | base/recommended | yes |

## Recommended fix

- Keep the Binder package set unchanged for this iteration.
- Harden Binder verification so it checks the specific `car` exports used by the notebook, not only that the package is installed.
- Defer exercise-level notebook rewrites to later iterations unless a concrete Binder failure is reproduced.

## Minimal implementation in this iteration

- Add an explicit Binder `postBuild` check for `car::scatterplot()`, `car::influenceIndexPlot()`, and `car::qqPlot()`.
- Record the dependency matrix and audit conclusion in this document.

## Validation performed

- Local R workshop smoke: `Rscript scripts/ci/execute-r-workshop-smoke.R --policy deterministic-sampling-v2`.
- Package/function check: confirmed `car`, `aicpa`, `ggplot2`, `gridExtra`, `tidyr`, `corrplot`, `lmtest`, `latex2exp`, and `scales` are available locally; confirmed `car` exports `scatterplot`, `influenceIndexPlot`, and `qqPlot`.

## Remaining risks

- Hosted fresh Binder validation of branch-only changes is still pending because the published Binder target is the separate `LuHoo/workbooks` repository.
- The setup chunk still carries two apparently unused package attachments, which increases Binder install surface until a later cleanup pass confirms they are safe to remove.
- Unqualified `car` calls remain in the notebook for now; this is intentional in Iteration 1 to avoid exercise rewrites before the dependency baseline is reviewed.