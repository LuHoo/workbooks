#!/usr/bin/env Rscript

source("scripts/export-workshops.R", chdir = FALSE)

args <- commandArgs(trailingOnly = TRUE)
mode <- if (length(args)) args[[1]] else "workshops"
if (!mode %in% c("workshops", "canonical", "all")) {
  stop("Use workshops, canonical, or all")
}

if (mode %in% c("workshops", "all")) {
  export_workshops()
}

for (notebook in get_notebook_manifest()) {
  if (mode %in% c("canonical", "all")) {
    rmarkdown::render(notebook$source, output_format = "html_document")
  }
  if (mode %in% c("workshops", "all")) {
    rmarkdown::render(notebook$output, output_format = "html_document")
  }
}
