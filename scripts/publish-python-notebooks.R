#!/usr/bin/env Rscript

source("scripts/workshop-export-config.R", chdir = FALSE)

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

extract_chapter_number <- function(config) {
  refs <- names(config$expected_chunks)
  if (length(refs) == 0L) {
    stop("Config has no expected chunk references: ", config$id)
  }

  chapter_part <- strsplit(refs[[1]], "\\.", fixed = FALSE)[[1]][[1]]
  chapter_number <- suppressWarnings(as.integer(chapter_part))
  if (is.na(chapter_number)) {
    stop("Could not extract chapter number from expected chunk id: ", refs[[1]])
  }

  chapter_number
}

publish_python_notebooks <- function(input_dir, output_dir) {
  configs <- get_workshop_export_configs()
  dir.create(output_dir, recursive = TRUE, showWarnings = FALSE)

  expected_files <- character(0L)

  for (config in configs) {
    chapter_number <- extract_chapter_number(config)
    input_path <- file.path(input_dir, config$id, paste0("chapter-", chapter_number, ".ipynb"))
    output_name <- sprintf("Workshop %d (Python).ipynb", chapter_number)
    output_path <- file.path(output_dir, output_name)

    if (!file.exists(input_path)) {
      stop("Missing generated notebook for config '", config$id, "': ", input_path)
    }

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