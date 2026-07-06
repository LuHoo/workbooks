#!/usr/bin/env Rscript

source("scripts/export-workshop-output.R", chdir = FALSE)

source_file <- "notebooks/support/auxiliary-variables-and-stratification/support.Rmd"
output_dir <- "generated/workshop-output"
expected_chunks <- c(
  "3.1" = 1L,
  "3.2" = 7L,
  "3.3" = 4L,
  "3.4" = 3L,
  "3.5" = 3L,
  "3.6" = 4L,
  "3.7" = 7L,
  "3.8" = 2L,
  "3.9" = 7L
)

for (exercise in names(expected_chunks)) {
  exercise_slug <- gsub("\\.", "-", exercise)
  for (i in seq_len(expected_chunks[[exercise]])) {
    output_file <- file.path(output_dir, sprintf("exercise-%s-%d.tex", exercise_slug, i))
    export_single_chunk(source_file, output_file)
  }
}
