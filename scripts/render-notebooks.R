#!/usr/bin/env Rscript

source("scripts/export-workshops.R", chdir = FALSE)

prepare_canonical_source <- function(notebook) {
  source_path <- normalizePath(notebook$source, winslash = "/", mustWork = TRUE)
  source_dir <- dirname(source_path)
  source_name <- basename(source_path)

  lines <- readLines(source_path, warn = FALSE)
  lines <- strip_language_overrides(lines, source_path, target_language = "r")

  temp_path <- tempfile(
    pattern = paste0(tools::file_path_sans_ext(source_name), "-canonical-"),
    tmpdir = source_dir,
    fileext = ".Rmd"
  )
  writeLines(lines, temp_path, useBytes = TRUE)
  temp_path
}

render_canonical_notebook <- function(notebook) {
  render_path <- prepare_canonical_source(notebook)
  on.exit(unlink(render_path), add = TRUE)

  output_name <- paste0(tools::file_path_sans_ext(basename(notebook$source)), ".html")
  rmarkdown::render(
    render_path,
    output_format = "html_document",
    output_file = output_name,
    output_dir = dirname(notebook$source)
  )
}

render_notebooks <- function(mode = "workshops") {
  if (!mode %in% c("workshops", "canonical", "all")) {
    stop("Use workshops, canonical, or all")
  }

  if (mode %in% c("workshops", "all")) {
    export_workshops()
  }

  for (notebook in get_notebook_manifest()) {
    if (mode %in% c("canonical", "all")) {
      render_canonical_notebook(notebook)
    }
    if (mode %in% c("workshops", "all")) {
      rmarkdown::render(notebook$output, output_format = "html_document")
    }
  }

  invisible(NULL)
}

main <- function(args = commandArgs(trailingOnly = TRUE)) {
  mode <- if (length(args)) args[[1]] else "workshops"
  render_notebooks(mode)
}

if (sys.nframe() == 0L) {
  main()
}
