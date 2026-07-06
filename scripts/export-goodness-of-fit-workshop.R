#!/usr/bin/env Rscript

source("scripts/export-workshop-output.R", chdir = FALSE)

# Chapter 6 chunks rely on regression-model objects built in chapter 5.
# Source the chapter 5 wrapper in-process to preserve object state.
source("scripts/export-regression-analysis-workshop.R", chdir = FALSE)

source_file <- "notebooks/support/goodness-of-fit/support.Rmd"
output_dir <- "generated/workshop-output"
expected_chunks <- c(
  "6.1" = 1L,
  "6.2" = 18L
)

for (exercise in names(expected_chunks)) {
  exercise_slug <- gsub("\\.", "-", exercise)
  for (i in seq_len(expected_chunks[[exercise]])) {
    output_file <- file.path(output_dir, sprintf("exercise-%s-%d.tex", exercise_slug, i))
    export_single_chunk(source_file, output_file)
  }
}
