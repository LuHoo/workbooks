#!/usr/bin/env Rscript

source("scripts/export-regression-workshop.R", chdir = FALSE)

rmarkdown::render(
  "notebooks/regression-analysis/regression-analysis.Rmd",
  output_format = "html_document",
  quiet = FALSE
)

rmarkdown::render(
  "notebooks/workshops/Regression analysis workshop.Rmd",
  output_format = "html_document",
  quiet = FALSE
)
