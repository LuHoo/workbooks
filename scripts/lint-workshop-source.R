#!/usr/bin/env Rscript

# Lint/styling workflow for workshop support notebooks.
#
# Safety model:
# - Only R chunk bodies are transformed.
# - Markdown prose, LaTeX blocks, tables, and verbatim material are untouched.
# - SUPPORT-ONLY blocks are passed through unchanged.
#
# Usage examples:
#   Rscript scripts/lint-workshop-source.R --all --check
#   Rscript scripts/lint-workshop-source.R --all --fix
#   Rscript scripts/lint-workshop-source.R --input notebooks/support/goodness-of-fit/support.Rmd --check

parse_cli_args <- function(args) {
  out <- list(inputs = character(), all = FALSE, mode = "check", help = FALSE)

  i <- 1L
  while (i <= length(args)) {
    arg <- args[[i]]
    if (identical(arg, "--input")) {
      i <- i + 1L
      if (i > length(args)) stop("Missing value after --input")
      out$inputs <- c(out$inputs, args[[i]])
    } else if (identical(arg, "--all")) {
      out$all <- TRUE
    } else if (identical(arg, "--check")) {
      out$mode <- "check"
    } else if (identical(arg, "--fix")) {
      out$mode <- "fix"
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
    "  Rscript scripts/lint-workshop-source.R [--all] [--input <support.Rmd>] (--check|--fix)\n\n",
    "Options:\n",
    "  --all      Lint all notebooks/support/**/support.Rmd files.\n",
    "  --input    Lint a specific support.Rmd file (repeatable).\n",
    "  --check    Check-only mode (default). Exits non-zero if changes are needed.\n",
    "  --fix      Apply safe fixes in place.\n",
    "  --help     Show this help.\n",
    sep = ""
  )
}

ensure_dependencies <- function() {
  if (!requireNamespace("styler", quietly = TRUE)) {
    stop("The styler package is required. Install with install.packages('styler').")
  }
}

project_style <- function(...) {
  styler::tidyverse_style(indent_by = 2L, strict = TRUE)
}

normalize_marker <- function(line) {
  trimws(line)
}

safe_trim_trailing_ws <- function(lines) {
  sub("[ \t]+$", "", lines)
}

style_chunk_body <- function(chunk_lines, file_path) {
  trimmed <- safe_trim_trailing_ws(chunk_lines)

  # Preserve empty chunks and comments-only chunks safely.
  if (!length(trimmed)) return(trimmed)

  styled <- tryCatch(
    styler::style_text(trimmed, style = project_style),
    error = function(e) {
      stop(
        "Failed to style R chunk in ", file_path,
        ": ", conditionMessage(e)
      )
    }
  )

  as.character(styled)
}

lint_support_file <- function(file_path, mode = c("check", "fix")) {
  mode <- match.arg(mode)

  if (!file.exists(file_path)) {
    stop("File does not exist: ", file_path)
  }

  original <- readLines(file_path, warn = FALSE)
  out <- character()

  in_support_only <- FALSE
  in_chunk <- FALSE
  chunk_lines <- character()

  for (line in original) {
    marker <- normalize_marker(line)

    if (identical(marker, "<!-- SUPPORT-ONLY:START -->")) {
      if (in_support_only) {
        stop("Nested SUPPORT-ONLY block in ", file_path)
      }
      in_support_only <- TRUE
      out <- c(out, line)
      next
    }

    if (identical(marker, "<!-- SUPPORT-ONLY:END -->")) {
      if (!in_support_only) {
        stop("Unmatched SUPPORT-ONLY end marker in ", file_path)
      }
      in_support_only <- FALSE
      out <- c(out, line)
      next
    }

    if (in_support_only) {
      out <- c(out, line)
      next
    }

    if (!in_chunk && grepl("^```\\{r(?:[ ,}])", line)) {
      in_chunk <- TRUE
      chunk_lines <- character()
      out <- c(out, line)
      next
    }

    if (in_chunk && identical(line, "```")) {
      styled <- style_chunk_body(chunk_lines, file_path)
      out <- c(out, styled, line)
      in_chunk <- FALSE
      chunk_lines <- character()
      next
    }

    if (in_chunk) {
      chunk_lines <- c(chunk_lines, line)
    } else {
      out <- c(out, line)
    }
  }

  if (in_support_only) stop("Unclosed SUPPORT-ONLY block in ", file_path)
  if (in_chunk) stop("Unclosed R chunk in ", file_path)

  changed <- !identical(original, out)

  if (changed && identical(mode, "fix")) {
    writeLines(out, file_path, useBytes = TRUE)
  }

  changed
}

collect_targets <- function(args) {
  targets <- character()

  if (isTRUE(args$all)) {
    all_targets <- list.files(
      path = "notebooks/support",
      pattern = "support\\.Rmd$",
      recursive = TRUE,
      full.names = TRUE
    )
    targets <- c(targets, all_targets)
  }

  if (length(args$inputs)) {
    targets <- c(targets, args$inputs)
  }

  targets <- unique(targets)
  if (!length(targets)) {
    stop("No targets provided. Use --all and/or --input <support.Rmd>.")
  }

  targets
}

main <- function() {
  args <- parse_cli_args(commandArgs(trailingOnly = TRUE))

  if (isTRUE(args$help)) {
    print_help()
    return(invisible(NULL))
  }

  ensure_dependencies()
  targets <- collect_targets(args)

  changed <- character()
  for (target in targets) {
    did_change <- lint_support_file(target, mode = args$mode)
    if (did_change) changed <- c(changed, target)
  }

  if (identical(args$mode, "check")) {
    if (length(changed)) {
      message("Lint check failed. Files requiring changes:")
      for (f in changed) message(" - ", f)
      quit(status = 1L)
    }
    message("Lint check passed. No changes required.")
    return(invisible(NULL))
  }

  if (length(changed)) {
    message("Applied safe lint fixes:")
    for (f in changed) message(" - ", f)
  } else {
    message("No lint fixes were required.")
  }
}

if (sys.nframe() == 0L) {
  main()
}
