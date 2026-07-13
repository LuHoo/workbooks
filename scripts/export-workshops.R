#!/usr/bin/env Rscript

source("scripts/notebook-manifest.R", chdir = FALSE)

normalize_line <- function(line) {
  trimws(line)
}

parse_directive_lang <- function(line, source_file, line_number) {
  attr_text <- sub("^<!--\\s*ADA:BEGIN\\s*", "", line)
  attr_text <- sub("\\s*-->$", "", attr_text)
  attr_text <- trimws(attr_text)
  if (!nzchar(attr_text)) {
    stop("ADA:BEGIN is missing required attributes in ", source_file, " at line ", line_number)
  }

  parts <- strsplit(attr_text, "[[:space:]]+")[[1L]]
  for (part in parts) {
    if (!grepl("=", part, fixed = TRUE)) {
      next
    }
    kv <- strsplit(part, "=", fixed = TRUE)[[1L]]
    if (length(kv) == 2L && identical(kv[[1L]], "lang")) {
      return(kv[[2L]])
    }
  }

  stop("ADA:BEGIN is missing lang=<language> in ", source_file, " at line ", line_number)
}

strip_support_only <- function(lines, source_file) {
  keep <- logical(length(lines))
  support_only <- FALSE
  for (i in seq_along(lines)) {
    line <- normalize_line(lines[[i]])
    if (identical(line, "<!-- SUPPORT-ONLY:START -->")) {
      if (support_only) stop("Nested support-only block in ", source_file)
      support_only <- TRUE
      next
    }
    if (identical(line, "<!-- SUPPORT-ONLY:END -->")) {
      if (!support_only) stop("Unmatched support-only end marker in ", source_file)
      support_only <- FALSE
      next
    }
    keep[[i]] <- !support_only
  }
  if (support_only) stop("Unclosed support-only block in ", source_file)
  lines[keep]
}

strip_language_overrides <- function(lines, source_file, target_language = "r") {
  keep <- logical(length(lines))
  in_directive_region <- FALSE
  directive_lang <- NULL

  for (i in seq_along(lines)) {
    line <- normalize_line(lines[[i]])

    if (grepl("^<!--\\s*ADA:BEGIN\\b", line)) {
      if (in_directive_region) {
        stop("Nested ADA directive region in ", source_file, " at line ", i)
      }
      directive_lang <- parse_directive_lang(line, source_file, i)
      in_directive_region <- TRUE
      next
    }

    if (grepl("^<!--\\s*ADA:END\\s*-->$", line)) {
      if (!in_directive_region) {
        stop("Unmatched ADA:END marker in ", source_file, " at line ", i)
      }
      in_directive_region <- FALSE
      directive_lang <- NULL
      next
    }

    if (grepl("^<!--\\s*ADA:REQUIRES\\b", line)) {
      next
    }

    if (in_directive_region) {
      keep[[i]] <- identical(directive_lang, target_language)
    } else {
      keep[[i]] <- TRUE
    }
  }

  if (in_directive_region) {
    stop("Unclosed ADA directive region in ", source_file)
  }

  lines[keep]
}

build_output_path <- function(notebook, output_dir = NULL) {
  if (is.null(output_dir)) {
    return(notebook$output)
  }
  file.path(output_dir, basename(notebook$output))
}

resolve_notebooks <- function(slugs = NULL) {
  if (is.null(slugs) || !length(slugs)) {
    return(notebooks)
  }

  selected <- Filter(function(notebook) notebook$slug %in% slugs, notebooks)
  if (length(selected) != length(slugs)) {
    known <- vapply(notebooks, function(notebook) notebook$slug, character(1L))
    missing <- setdiff(slugs, known)
    stop(
      "Unknown workshop slug(s): ", paste(missing, collapse = ", "),
      ". Supported values: ", paste(known, collapse = ", ")
    )
  }

  selected
}

parse_cli_args <- function(args) {
  out <- list(
    output_dir = NULL,
    slugs = character(),
    help = FALSE
  )

  i <- 1L
  while (i <= length(args)) {
    arg <- args[[i]]
    if (identical(arg, "--output-dir")) {
      i <- i + 1L
      if (i > length(args)) stop("Missing value after --output-dir")
      out$output_dir <- args[[i]]
    } else if (identical(arg, "--slug")) {
      i <- i + 1L
      if (i > length(args)) stop("Missing value after --slug")
      out$slugs <- c(out$slugs, args[[i]])
    } else if (identical(arg, "--help") || identical(arg, "-h")) {
      out$help <- TRUE
    } else {
      stop("Unsupported option: ", arg)
    }
    i <- i + 1L
  }

  out
}

print_help <- function() {
  cat(
    "Usage:\n",
    "  Rscript scripts/export-workshops.R [options]\n\n",
    "Options:\n",
    "  --output-dir <path>   Directory for generated workshop Rmd files.\n",
    "  --slug <slug>         Export only selected workshop slug (repeatable).\n",
    "  --help                Show this help.\n",
    sep = ""
  )
}

export_notebook <- function(notebook, output_dir = NULL) {
  lines <- readLines(notebook$source, warn = FALSE)
  lines <- strip_support_only(lines, notebook$source)
  lines <- strip_language_overrides(lines, notebook$source, target_language = "r")

  yaml_delimiters <- which(lines == "---")
  if (length(yaml_delimiters) < 2L || yaml_delimiters[[1]] != 1L) stop("Expected a YAML header in ", notebook$source)
  body <- lines[-seq_len(yaml_delimiters[[2]])]
  while (length(body) > 0L && identical(tail(body, 1L), "")) body <- head(body, -1L)
  header <- c("---", sprintf('title: "Workshop Chapter %d: %s"', notebook$chapter, notebook$title),
              'author: "Lucas Hoogduin"', 'date: "`r Sys.Date()`"', "output:",
              "  html_document:", "    df_print: paged", "---", "",
              sprintf("<!-- GENERATED FILE: edit %s in the private ada repository. -->", notebook$source), "")
  output_path <- build_output_path(notebook, output_dir)
  dir.create(dirname(output_path), recursive = TRUE, showWarnings = FALSE)
  writeLines(c(header, body), output_path, useBytes = TRUE)
  message("Generated ", output_path, " from ", notebook$source)
}

export_workshops <- function(output_dir = NULL, slugs = NULL) {
  selected <- resolve_notebooks(slugs = slugs)
  invisible(lapply(selected, function(notebook) export_notebook(notebook, output_dir = output_dir)))
}

main <- function() {
  args <- parse_cli_args(commandArgs(trailingOnly = TRUE))
  if (isTRUE(args$help)) {
    print_help()
    return(invisible(NULL))
  }

  export_workshops(output_dir = args$output_dir, slugs = args$slugs)
}

if (sys.nframe() == 0L) {
  main()
}
