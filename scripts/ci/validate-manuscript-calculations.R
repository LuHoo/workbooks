#!/usr/bin/env Rscript

parse_args <- function(args) {
  out <- list(
    generated_dir = "generated/worked-calculations",
    manuscript_dir = ".",
    output_json = NULL,
    output_summary = NULL,
    skip_freshness = FALSE,
    help = FALSE
  )

  i <- 1L
  while (i <= length(args)) {
    arg <- args[[i]]
    if (identical(arg, "--generated-dir")) {
      i <- i + 1L
      if (i > length(args)) stop("Missing value after --generated-dir")
      out$generated_dir <- args[[i]]
    } else if (identical(arg, "--manuscript-dir")) {
      i <- i + 1L
      if (i > length(args)) stop("Missing value after --manuscript-dir")
      out$manuscript_dir <- args[[i]]
    } else if (identical(arg, "--output-json")) {
      i <- i + 1L
      if (i > length(args)) stop("Missing value after --output-json")
      out$output_json <- args[[i]]
    } else if (identical(arg, "--output-summary")) {
      i <- i + 1L
      if (i > length(args)) stop("Missing value after --output-summary")
      out$output_summary <- args[[i]]
    } else if (identical(arg, "--skip-freshness")) {
      out$skip_freshness <- TRUE
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
    "  Rscript scripts/ci/validate-manuscript-calculations.R [options]\n\n",
    "Options:\n",
    "  --generated-dir <path>   Directory with generated snippets and metadata (default: generated/worked-calculations)\n",
    "  --manuscript-dir <path>  Directory containing top-level manuscript .tex files (default: .)\n",
    "  --output-json <path>     Write a machine-readable validation report\n",
    "  --output-summary <path>  Write a Markdown validation report\n",
    "  --skip-freshness         Skip regenerating snippets for stale-file detection\n",
    sep = ""
  )
}

source("R/manuscript-calculation-registry.R", chdir = FALSE)
source("R/manuscript-calculation-validator.R", chdir = FALSE)

run_freshness_check <- function(generated_dir) {
  status <- system2(
    "Rscript",
    c("scripts/generate-worked-calculations.R", "--check", "--output-dir", generated_dir),
    stdout = TRUE,
    stderr = TRUE
  )
  exit_status <- attr(status, "status") %||% 0L
  if (!identical(as.integer(exit_status), 0L)) {
    stop(paste(status, collapse = "\n"), call. = FALSE)
  }
}

write_report <- function(report, output_json = NULL, output_summary = NULL) {
  if (!is.null(output_json)) {
    if (!requireNamespace("jsonlite", quietly = TRUE)) {
      stop("The jsonlite package is required to write validation reports.", call. = FALSE)
    }
    dir.create(dirname(output_json), recursive = TRUE, showWarnings = FALSE)
    jsonlite::write_json(report, output_json, auto_unbox = TRUE, pretty = TRUE)
  }
  if (!is.null(output_summary)) {
    dir.create(dirname(output_summary), recursive = TRUE, showWarnings = FALSE)
    mc_write_validation_markdown(output_summary, report)
  }
}

args <- parse_args(commandArgs(trailingOnly = TRUE))
if (isTRUE(args$help)) {
  print_help()
  quit(status = 0L)
}

freshness_errors <- character()
if (!isTRUE(args$skip_freshness)) {
  freshness_errors <- tryCatch(
    {
      run_freshness_check(args$generated_dir)
      character()
    },
    error = function(e) conditionMessage(e)
  )
}

entries <- mc_read_registry_metadata(args$generated_dir)
errors <- freshness_errors

if (!length(entries)) {
  errors <- c(errors, paste0("No manuscript calculation metadata files found in: ", args$generated_dir))
}

for (entry in entries) {
  errors <- c(
    errors,
    mc_validate_registry_entry(
      entry,
      repo_root = ".",
      metadata_path = attr(entry, "metadata_path")
    )
  )
}

entry_ids <- vapply(entries, function(entry) entry$id %||% NA_character_, character(1L))
duplicate_entries <- unique(entry_ids[!is.na(entry_ids) & duplicated(entry_ids)])
if (length(duplicate_entries)) {
  errors <- c(errors, paste0("Duplicate registry entry ID(s): ", paste(duplicate_entries, collapse = ", ")))
}

input_check <- mc_validate_manuscript_inputs(entries, repo_root = ".", manuscript_dir = args$manuscript_dir)
errors <- c(errors, input_check$errors)

report <- mc_validation_report(entries, input_check$inputs, errors)
write_report(report, args$output_json, args$output_summary)

if (length(errors)) {
  stop(
    paste(c("Manuscript calculation validation failed:", errors), collapse = "\n"),
    call. = FALSE
  )
}

message("Manuscript calculation validation passed for ", length(entries), " registered calculation(s).")
