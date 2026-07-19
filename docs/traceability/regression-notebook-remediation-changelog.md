# Regression Notebook Remediation Changelog

This document records the Chapter 5 regression notebook remediation work, the rationale for each change, and the publication implications for the student-facing R and Python notebooks.

## Scope

- Canonical source: `notebooks/support/regression-analysis/support.Rmd`
- Published R workshop: `notebooks/workshops/Regression analysis workshop.Rmd`
- Published Python workshop: `notebooks/workshops/Workshop 5 (Python).ipynb`
- Chapter integration: `chap07.tex`, `generated/workshop-output/**`, `generated/workshop-output-python/**`

## Iteration 1: Binder and dependency audit

- Confirmed that `car` was already installed in Binder and loaded in the notebook setup chunk.
- Added Binder verification for the specific `car` exports used by the notebook: `scatterplot`, `influenceIndexPlot`, and `qqPlot`.
- Documented the dependency matrix and audit conclusion in `docs/traceability/regression-binder-dependency-audit.md`.

Rationale:

- The risk was dependency opacity, not a reproduced missing-package failure.
- Binder verification needed to fail early on missing exported functions, not just on missing packages.

## Iteration 2: Exercise 5.3 cleanup

- Added a concise explanation of how the 12-value `summer` pattern maps onto 48 monthly observations through recycling.
- Made `brief()` explicit as `car::brief()` in the notebook narrative and code.
- Preserved model object names and existing output values.

Rationale:

- The notebook depended on `car::brief()` but did not state that clearly.
- The dummy-variable encoding needed a short explanation without changing the learning objective.

## Iteration 3: Exercises 5.19 to 5.26

- Exercise 5.19: kept the variance-to-TSS cross-check and explained why `var(y) * (n - 1)` equals TSS.
- Exercise 5.22: clarified that `model_forward`, `model_backward`, and `fit_both` end at the same final model; distinguished `step()` trace values from `AIC()` on fitted model objects.
- Exercise 5.24: corrected `asumption` to `assumption`.
- Exercise 5.26: refactored the AR(1) transformation into smaller conceptual steps with named intermediate objects and clearer explanatory text.

Rationale:

- The numerical logic was largely correct, but the notebook explanation was harder to follow than necessary.
- The AR(1) section needed to emphasize the manual transformation rather than introduce separate terminology by implication.

## Iteration 4: Ordering and duplication

- Reordered refined-model diagnostics to follow the chapter sequence: Shapiro-Wilk, Breusch-Pagan, Breusch-Godfrey.
- Differentiated Exercise 5.28 and Exercise 5.30:
  - Exercise 5.28 now clearly serves coefficient-level inference via the full summary.
  - Exercise 5.30 isolates the model-level `F` statistic instead of repeating the full summary.

Rationale:

- Diagnostic-test order should be consistent across prose and code.
- Exercises 5.28 and 5.30 were near-duplicates and needed pedagogical separation rather than removal.

## Iteration 5: Showcase exercises

- Relabeled Exercise 5.31 as `Showcase: Visualizing the uncertainty in the model parameters`.
- Relabeled Exercise 5.32 as `Showcase: Confidence and prediction intervals`.
- Added explicit notebook text that both are illustrations rather than US SteamCo case steps.

Rationale:

- Both exercises are synthetic demonstrations that support the chapter narrative but are not part of the case workflow.
- They remain in the student notebook because they provide conceptual scaffolding for the later forecasting exercises.

## Iteration 6: Exercise 5.35 and Exercise 5.36

- Exercise 5.35: reorganized the annual-prediction derivation into smaller, named steps and aligned the code comments with Equations 5.38 to 5.43.
- Exercise 5.36: preserved the achieved-assurance result but removed unresolved editorial commentary comparing it with previously reported percentages.
- Restored Exercise 5.36 to the student-facing R and Python notebooks by removing the `SUPPORT-ONLY` wrapper and extending the export contract.

Rationale:

- The annual-prediction derivation needed to be traceable from monthly expectations to the annual prediction interval.
- The notebook should report the computed result directly rather than leave unresolved provenance questions in student-facing text.
- Exercise 5.36 belongs in the student-facing notebooks and chapter workshop flow.

## Export and renderer updates

- Updated the canonical workshop registry (`metadata/workshop-registry.R`, loaded via `scripts/workshop-export-config.R`) to match current Chapter 5 chunk counts, including Exercises 5.19, 5.35, and 5.36.
- Updated `scripts/workshop-ir-python-renderer.py` to preserve Chapter 5 parity after notebook refactors, including:
  - Exercise 5.26 AR(1) transformation updates.
  - Exercise 5.29 diagnostic ordering.
  - Exercise 5.30 `F`-statistic extraction.
  - Exercise 5.36 annual-difference, acceptable-difference-range, non-central-`t`, and conclusion blocks.
  - Generic R-to-Python normalization for `cat(...)` and non-central `pt(..., ncp=...)` cases.

Rationale:

- Notebook edits changed chunk shapes and variable names that the Chapter 5 Python renderer had encoded explicitly.
- Export validation needed to stay synchronized with the canonical R notebook so R and Python student-facing artifacts remain aligned.

## Chapter integration

- Updated `chap07.tex` workshop exercise titles to reflect the current notebook terminology for Exercise 5.26, Exercise 5.31, and Exercise 5.32.
- Added Chapter 5 workshop includes for `exercise-5-35-3` and `exercise-5-36-1` through `exercise-5-36-6` in both the R and Python workshop sections.
- Regenerated `generated/workshop-output/**` and `generated/workshop-output-python/**` for Chapter 5.

Rationale:

- The chapter workshop section must stay aligned with the canonical notebook and the published student-facing outputs.
- Restoring Exercise 5.36 to student-facing notebooks required restoring the corresponding chapter workshop includes.

## Validation summary

- R workshop regeneration: passed.
- Focused R notebook knit for Chapter 5: passed.
- Generated Chapter 5 Python notebook execution with repo `.venv`: passed.
- Python notebook publication hygiene: passed.
- Published R and Python Chapter 5 notebook copies refreshed.

## Outstanding note

- A focused LaTeX build of `chap07.tex` surfaces an unrelated pre-existing error around line 903 in surrounding chapter math, outside the Chapter 5 workshop-remediation changes. The workshop fragment integration itself regenerated successfully.