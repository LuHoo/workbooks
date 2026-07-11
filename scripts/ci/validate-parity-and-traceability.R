#!/usr/bin/env Rscript

source("scripts/workshop-export-config.R", chdir = FALSE)
source("scripts/workshop-ir.R", chdir = FALSE)
source("scripts/traceability-metadata.R", chdir = FALSE)

SCRIPT_VERSION <- "0.1.0"

parse_args <- function(args) {
  out <- list(
    notebooks_dir = "generated/python-notebooks",
    metadata_dir = "metadata/traceability",
    chapters = "1,2,3,4,5,6",
    output_json = NULL
  )

  i <- 1L
  while (i <= length(args)) {
    arg <- args[[i]]
    if (identical(arg, "--notebooks-dir")) {
      i <- i + 1L
      out$notebooks_dir <- args[[i]]
    } else if (identical(arg, "--metadata-dir")) {
      i <- i + 1L
      out$metadata_dir <- args[[i]]
    } else if (identical(arg, "--chapters")) {
      i <- i + 1L
      out$chapters <- args[[i]]
    } else if (identical(arg, "--output-json")) {
      i <- i + 1L
      out$output_json <- args[[i]]
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
    "  Rscript scripts/ci/validate-parity-and-traceability.R [options]\n\n",
    "Options:\n",
    "  --notebooks-dir <path>  Generated Python notebook root (default: generated/python-notebooks)\n",
    "  --metadata-dir <path>   Traceability metadata directory (default: metadata/traceability)\n",
    "  --chapters <list>       Comma-separated chapter list (default: 1,2,3,4,5,6)\n",
    "  --output-json <path>    Optional output path for machine-readable report\n",
    sep = ""
  )
}

empty_workshop_report <- function(config) {
  list(
    workshop_id = config$id,
    chapter = as.character(sub("^([0-9]+).*", "\\1", names(config$expected_chunks)[[1]])),
    checks = list(
      exercise_parity = list(status = "not-run", errors = list(), warnings = list()),
      lo_mapping_parity = list(status = "not-run", errors = list(), warnings = list()),
      fsaudit_coverage = list(status = "not-run", errors = list(), warnings = list())
    )
  )
}

build_report <- function(configs) {
  list(
    script = "scripts/ci/validate-parity-and-traceability.R",
    version = SCRIPT_VERSION,
    status = "not-run",
    generated_at = format(Sys.time(), "%Y-%m-%dT%H:%M:%SZ", tz = "UTC"),
    workshops = lapply(configs, empty_workshop_report),
    errors = list(),
    warnings = list()
  )
}

emit_summary <- function(report) {
  cat("Parity/Traceability gate scaffold initialized.\n")
  cat("Target workshops:", length(report$workshops), "\n")
}

main <- function() {
  args <- parse_args(commandArgs(trailingOnly = TRUE))
  if (isTRUE(args$help)) {
    print_help()
    return(invisible(NULL))
  }

  chapter_filter <- strsplit(args$chapters, ",", fixed = TRUE)[[1]]
  chapter_filter <- trimws(chapter_filter)

  configs <- get_workshop_export_configs()
  configs <- Filter(function(cfg) {
    startsWith(names(cfg$expected_chunks)[[1]], paste0(chapter_filter, "."))
  }, configs)

  report <- build_report(configs)
  report$status <- "ok"

  if (!is.null(args$output_json)) {
    dir.create(dirname(args$output_json), recursive = TRUE, showWarnings = FALSE)
    if (!requireNamespace("jsonlite", quietly = TRUE)) {
      stop("jsonlite is required for --output-json")
    }
    writeLines(jsonlite::toJSON(report, auto_unbox = TRUE, pretty = TRUE), args$output_json)
  }

  emit_summary(report)
}

if (sys.nframe() == 0L) {
  main()
}
