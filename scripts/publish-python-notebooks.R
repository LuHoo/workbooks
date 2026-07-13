#!/usr/bin/env Rscript

source("scripts/workshop-export-config.R", chdir = FALSE)

resolve_python_bin <- function() {
  python_bin <- Sys.which("python3")
  if (!nzchar(python_bin)) {
    python_bin <- Sys.which("python")
  }
  if (!nzchar(python_bin)) {
    stop("Python executable not found. Install python3 or add python to PATH.")
  }
  python_bin
}

ensure_jsonlite <- function() {
  if (!requireNamespace("jsonlite", quietly = TRUE)) {
    stop("jsonlite is required for published notebook provenance checks")
  }
}

validate_generated_notebook_provenance <- function(notebook_path) {
  notebook <- jsonlite::fromJSON(notebook_path, simplifyVector = FALSE)
  metadata <- notebook$metadata
  if (is.null(metadata) || !is.list(metadata)) {
    stop("Missing notebook metadata in generated notebook: ", notebook_path)
  }

  ada_renderer <- metadata$ada_renderer
  if (is.null(ada_renderer) || !is.list(ada_renderer)) {
    stop(
      "Missing metadata.ada_renderer in generated notebook: ", notebook_path,
      ". Regenerate with scripts/export-python-notebooks.R before publishing."
    )
  }

  required_fields <- c("chapter_number", "workshop_id", "source_file", "target_language")
  missing_fields <- required_fields[!vapply(required_fields, function(field) {
    !is.null(ada_renderer[[field]]) && nzchar(as.character(ada_renderer[[field]]))
  }, logical(1L))]

  if (length(missing_fields) > 0L) {
    stop(
      "Missing required metadata.ada_renderer fields in ", notebook_path,
      ": ", paste(missing_fields, collapse = ", ")
    )
  }

  if (!identical(as.character(ada_renderer$target_language), "python")) {
    stop(
      "Invalid metadata.ada_renderer.target_language in ", notebook_path,
      ": expected 'python'"
    )
  }

  source_file <- as.character(ada_renderer$source_file)
  if (grepl("^/", source_file)) {
    stop("Absolute source_file path is not allowed in notebook metadata: ", notebook_path)
  }
  if (grepl("/tmp/|/var/folders/", source_file)) {
    stop("Environment-specific source_file path is not allowed in notebook metadata: ", notebook_path)
  }
}

parse_args <- function(args) {
  out <- list(
    input_dir = "generated/python-notebooks",
    output_dir = "notebooks/workshops"
  )

  i <- 1L
  while (i <= length(args)) {
    arg <- args[[i]]
    if (identical(arg, "--input-dir")) {
      i <- i + 1L
      if (i > length(args)) stop("Missing value after --input-dir")
      out$input_dir <- args[[i]]
    } else if (identical(arg, "--output-dir")) {
      i <- i + 1L
      if (i > length(args)) stop("Missing value after --output-dir")
      out$output_dir <- args[[i]]
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
    "  Rscript scripts/publish-python-notebooks.R [options]\n\n",
    "Options:\n",
    "  --input-dir <path>   Source directory for generated notebooks\n",
    "                       (default: generated/python-notebooks).\n",
    "  --output-dir <path>  Destination directory for Binder-facing notebooks\n",
    "                       (default: notebooks/workshops).\n",
    "  --help               Show this help.\n",
    sep = ""
  )
}

validate_notebook_hygiene <- function(input_dir, python_bin = resolve_python_bin()) {
  guardrail_script <- file.path("scripts", "ci", "check-generated-python-notebooks.py")
  if (!file.exists(guardrail_script)) {
    stop("Missing guardrail script: ", guardrail_script)
  }

  message("Validating generated Python notebook hygiene before publication")
  status <- system2(
    python_bin,
    args = c(guardrail_script, "--input-dir", input_dir)
  )
  if (!identical(status, 0L)) {
    stop(
      "Python notebook hygiene validation failed for ", input_dir,
      ". Publication aborted before any notebook copy/sync."
    )
  }
}

publish_python_notebooks <- function(input_dir, output_dir) {
  ensure_jsonlite()
  validate_notebook_hygiene(input_dir)

  configs <- get_workshop_export_configs()
  dir.create(output_dir, recursive = TRUE, showWarnings = FALSE)

  expected_files <- character(0L)

  for (config in configs) {
    chapter_number <- config$chapter
    input_path <- file.path(input_dir, config$id, paste0("chapter-", chapter_number, ".ipynb"))
    output_name <- config$published_python_output
    output_path <- file.path(output_dir, output_name)

    if (!file.exists(input_path)) {
      stop("Missing generated notebook for config '", config$id, "': ", input_path)
    }

    validate_generated_notebook_provenance(input_path)

    if (!isTRUE(file.copy(input_path, output_path, overwrite = TRUE))) {
      stop("Failed to publish notebook: ", input_path, " -> ", output_path)
    }

    expected_files <- c(expected_files, output_name)
    message("Published ", output_path, " from ", input_path)
  }

  existing_python <- list.files(
    output_dir,
    pattern = "^Workshop [0-9]+ \\(Python\\)\\.ipynb$",
    full.names = FALSE
  )
  stale <- setdiff(existing_python, expected_files)

  if (length(stale) > 0L) {
    stale_paths <- file.path(output_dir, stale)
    if (!all(file.remove(stale_paths))) {
      stop("Failed to remove stale published Python notebooks: ", paste(stale, collapse = ", "))
    }
    message("Removed stale Python notebooks: ", paste(stale, collapse = ", "))
  }
}

main <- function() {
  args <- parse_args(commandArgs(trailingOnly = TRUE))
  if (isTRUE(args$help)) {
    print_help()
    return(invisible(NULL))
  }

  publish_python_notebooks(
    input_dir = args$input_dir,
    output_dir = args$output_dir
  )
}

if (sys.nframe() == 0L) {
  main()
}