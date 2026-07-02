#!/usr/bin/env Rscript

source("scripts/notebook-manifest.R", chdir = FALSE)

strip_support_only <- function(lines, source_file) {
  keep <- logical(length(lines))
  support_only <- FALSE
  for (i in seq_along(lines)) {
    if (identical(lines[[i]], "<!-- SUPPORT-ONLY:START -->")) {
      if (support_only) stop("Nested support-only block in ", source_file)
      support_only <- TRUE
      next
    }
    if (identical(lines[[i]], "<!-- SUPPORT-ONLY:END -->")) {
      if (!support_only) stop("Unmatched support-only end marker in ", source_file)
      support_only <- FALSE
      next
    }
    keep[[i]] <- !support_only
  }
  if (support_only) stop("Unclosed support-only block in ", source_file)
  lines[keep]
}

export_notebook <- function(notebook) {
  lines <- strip_support_only(readLines(notebook$source, warn = FALSE), notebook$source)
  yaml_delimiters <- which(lines == "---")
  if (length(yaml_delimiters) < 2L || yaml_delimiters[[1]] != 1L) stop("Expected a YAML header in ", notebook$source)
  body <- lines[-seq_len(yaml_delimiters[[2]])]
  while (length(body) > 0L && identical(tail(body, 1L), "")) body <- head(body, -1L)
  header <- c("---", sprintf('title: "Workshop Chapter %d: %s"', notebook$chapter, notebook$title),
              'author: "Lucas Hoogduin"', 'date: "`r Sys.Date()`"', "output:",
              "  html_document:", "    df_print: paged", "---", "",
              sprintf("<!-- GENERATED FILE: edit %s in the private ada repository. -->", notebook$source), "")
  dir.create(dirname(notebook$output), recursive = TRUE, showWarnings = FALSE)
  writeLines(c(header, body), notebook$output, useBytes = TRUE)
  message("Generated ", notebook$output, " from ", notebook$source)
}

invisible(lapply(notebooks, export_notebook))
