#!/usr/bin/env Rscript

source("scripts/export-workshop-output.R", chdir = FALSE)

source_file <- "notebooks/support/probability-distributions/support.Rmd"
output_dir <- "generated/workshop-output"
expected_chunks <- c(
  "1.1" = 3L,
  "1.2" = 1L,
  "1.3" = 2L,
  "1.4" = 2L,
  "1.5" = 1L,
  "1.6" = 2L,
  "1.7" = 2L
)

for (exercise in names(expected_chunks)) {
  exercise_slug <- gsub("\\.", "-", exercise)
  for (i in seq_len(expected_chunks[[exercise]])) {
    output_file <- file.path(output_dir, sprintf("exercise-%s-%d.tex", exercise_slug, i))
    export_single_chunk(source_file, output_file)
  }
}
