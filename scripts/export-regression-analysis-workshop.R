#!/usr/bin/env Rscript

source("scripts/export-workshop-output.R", chdir = FALSE)

source_file <- "notebooks/support/regression-analysis/support.Rmd"
output_dir <- "generated/workshop-output"
expected_chunks <- c(
  "5.1" = 1L,
  "5.2" = 1L,
  "5.3" = 8L,
  "5.4" = 1L,
  "5.5" = 1L,
  "5.6" = 2L,
  "5.7" = 4L,
  "5.8" = 1L,
  "5.9" = 3L,
  "5.10" = 1L,
  "5.11" = 1L,
  "5.12" = 1L,
  "5.13" = 3L,
  "5.14" = 1L,
  "5.15" = 2L,
  "5.16" = 1L,
  "5.17" = 2L,
  "5.18" = 2L,
  "5.19" = 5L,
  "5.20" = 3L,
  "5.21" = 1L,
  "5.22" = 2L,
  "5.23" = 3L,
  "5.24" = 2L,
  "5.25" = 2L,
  "5.26" = 4L,
  "5.27" = 1L,
  "5.28" = 1L,
  "5.29" = 1L,
  "5.30" = 1L,
  "5.31" = 4L,
  "5.32" = 1L,
  "5.33" = 2L,
  "5.34" = 1L,
  "5.35" = 2L
)

for (exercise in names(expected_chunks)) {
  exercise_slug <- gsub("\\.", "-", exercise)
  for (i in seq_len(expected_chunks[[exercise]])) {
    output_file <- file.path(output_dir, sprintf("exercise-%s-%d.tex", exercise_slug, i))
    export_single_chunk(source_file, output_file)
  }
}
