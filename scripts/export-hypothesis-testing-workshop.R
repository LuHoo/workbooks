#!/usr/bin/env Rscript

source("scripts/export-workshop-output.R", chdir = FALSE)

source_file <- "notebooks/support/hypothesis-testing/support.Rmd"
output_dir <- "generated/workshop-output"
expected_chunks <- c(
  "4.1" = 3L,
  "4.2" = 1L,
  "4.3" = 1L,
  "4.4" = 1L,
  "4.5" = 3L,
  "4.6" = 3L,
  "4.7" = 3L,
  "4.8" = 7L,
  "4.9" = 1L,
  "4.10" = 2L
)

for (exercise in names(expected_chunks)) {
  exercise_slug <- gsub("\\.", "-", exercise)
  for (i in seq_len(expected_chunks[[exercise]])) {
    output_file <- file.path(output_dir, sprintf("exercise-%s-%d.tex", exercise_slug, i))
    export_single_chunk(source_file, output_file)
  }
}
