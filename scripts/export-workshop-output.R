#!/usr/bin/env Rscript

source("scripts/workshop-export-config.R", chdir = FALSE)
source("scripts/workshop-ir-adapter.R", chdir = FALSE)
source("scripts/workshop-model.R", chdir = FALSE)
source("scripts/workshop-renderer-latex.R", chdir = FALSE)
source("scripts/workshop-renderer.R", chdir = FALSE)
source("scripts/traceability-metadata.R", chdir = FALSE)

# Static-analysis hint: function is provided by sourced config script.
resolve_workshop_export_config <- get("resolve_workshop_export_config", mode = "function")
resolve_workshop_export_config_by_id <- get("resolve_workshop_export_config_by_id", mode = "function")
load_traceability_metadata <- get("load_traceability_metadata", mode = "function")
build_workshop_traceability_id <- get("build_workshop_traceability_id", mode = "function")

ensure_dependencies <- function() {
  if (!requireNamespace("knitr", quietly = TRUE)) {
    stop("The knitr package is required to export workshop output.")
  }
}

parse_cli_args <- function(args) {
  out <- list(
    input = NULL,
    output = NULL,
    parser_engine = "ir",
    traceability_dir = "metadata/traceability",
    enable_traceability = TRUE,
    traceability_strict = FALSE
  )
  i <- 1L
  while (i <= length(args)) {
    arg <- args[[i]]
    if (identical(arg, "--input")) {
      i <- i + 1L
      if (i > length(args)) stop("Missing value after --input")
      out$input <- args[[i]]
    } else if (identical(arg, "--output")) {
      i <- i + 1L
      if (i > length(args)) stop("Missing value after --output")
      out$output <- args[[i]]
    } else if (identical(arg, "--parser-engine")) {
      i <- i + 1L
      if (i > length(args)) stop("Missing value after --parser-engine")
      out$parser_engine <- args[[i]]
    } else if (identical(arg, "--traceability-dir")) {
      i <- i + 1L
      if (i > length(args)) stop("Missing value after --traceability-dir")
      out$traceability_dir <- args[[i]]
    } else if (identical(arg, "--no-traceability")) {
      out$enable_traceability <- FALSE
    } else if (identical(arg, "--traceability-strict")) {
      out$traceability_strict <- TRUE
    } else if (identical(arg, "--help") || identical(arg, "-h")) {
      out$help <- TRUE
    } else {
      stop("Unsupported option: ", arg)
    }
    i <- i + 1L
  }
  out
}

parse_export_cli_args <- parse_cli_args

print_help <- function() {
  cat(
    "Usage:\n",
    "  Rscript scripts/export-workshop-output.R --input <support.Rmd> --output <output.tex> [options]\n\n",
    "Options:\n",
    "  --parser-engine <legacy|ir>   Parser backend (default: ir).\n\n",
    "  --traceability-dir <path>   Path to traceability metadata directory (default: metadata/traceability)\n",
    "  --traceability-strict       Fail if metadata directory exists but required files are missing\n",
    "  --no-traceability           Skip traceability metadata loading\n\n",
    "Example:\n",
    "  Rscript scripts/export-workshop-output.R \\\n",
    "    --input notebooks/support/probability-distributions/support.Rmd \\\n",
    "    --output generated/workshop-output/exercise-1-1-1.tex\n",
    sep = ""
  )
}

normalize_marker <- function(line) {
  trimws(line)
}

# Stage 1: Read source.
read_source_lines <- function(input_path) {
  if (!file.exists(input_path)) stop("Input file does not exist: ", input_path)
  readLines(input_path, warn = FALSE)
}

# Stage 2: Parse workshop structure + Stage 3: Process support-only blocks.
strip_support_only <- function(lines, source_file) {
  keep <- logical(length(lines))
  support_only <- FALSE
  for (i in seq_along(lines)) {
    line <- normalize_marker(lines[[i]])
    if (identical(line, "<!-- SUPPORT-ONLY:START -->")) {
      if (support_only) stop("Nested support-only block in ", source_file, " at line ", i)
      support_only <- TRUE
      next
    }
    if (identical(line, "<!-- SUPPORT-ONLY:END -->")) {
      if (!support_only) stop("Unmatched support-only end marker in ", source_file, " at line ", i)
      support_only <- FALSE
      next
    }
    keep[[i]] <- !support_only
  }
  if (support_only) stop("Unclosed support-only block in ", source_file)
  lines[keep]
}

validate_supported_constructs <- function(lines, source_file) {
  for (i in seq_along(lines)) {
    line <- lines[[i]]
    if (grepl("^```\\{[^r]", line)) {
      stop(
        "Unsupported code fence in ", source_file,
        " at line ", i,
        ": only R chunks are supported in workshop export."
      )
    }
  }
}

find_heading_line <- function(lines, exercise) {
  pattern <- paste0("^##+ Exercise ", gsub("\\.", "\\\\.", exercise), "(\\.| |$)")
  heading <- grep(pattern, lines)
  if (length(heading) != 1L) {
    stop("Could not find unique Exercise ", exercise)
  }
  heading[[1L]]
}

extract_exercise_segments <- function(lines, exercise, expected_chunk_count, source_file) {
  heading <- find_heading_line(lines, exercise)
  next_heading <- grep("^##+ Exercise ", lines)
  next_heading <- next_heading[next_heading > heading]
  end <- if (length(next_heading)) next_heading[[1L]] - 1L else length(lines)
  exercise_lines <- lines[(heading + 1L):end]

  in_chunk <- FALSE
  chunk <- character()
  chunks <- list()
  prose <- list()
  pending_prose <- character()

  for (line in exercise_lines) {
    if (grepl("^```\\{r(?:[ ,}])", line)) {
      in_chunk <- TRUE
      prose[[length(chunks) + 1L]] <- pending_prose
      pending_prose <- character()
      chunk <- paste0(
        "```{r, echo=TRUE, results='markup', comment='', ",
        "fig.keep='none', message=FALSE, warning=FALSE, error=FALSE}"
      )
    } else if (in_chunk && identical(line, "```")) {
      in_chunk <- FALSE
      chunk[grepl("^options\\(width\\s*=", chunk)] <- "options(width = 65)"
      chunks[[length(chunks) + 1L]] <- c(chunk, line)
      chunk <- character()
    } else if (in_chunk) {
      chunk <- c(chunk, line)
    } else {
      pending_prose <- c(pending_prose, line)
    }
  }

  if (in_chunk) {
    stop("Unclosed R chunk in Exercise ", exercise, " of ", source_file)
  }
  if (length(chunks) != expected_chunk_count) {
    stop(
      "Expected ", expected_chunk_count,
      " complete R chunks in Exercise ", exercise,
      " but found ", length(chunks),
      " in ", source_file
    )
  }
  prose[[length(chunks) + 1L]] <- pending_prose
  list(chunks = chunks, prose = prose)
}

# Stage 8: Write the final .tex file.
write_output <- function(lines, output_path) {
  dir.create(dirname(output_path), recursive = TRUE, showWarnings = FALSE)
  writeLines(lines, output_path, useBytes = TRUE)
}

parse_output_target <- function(output_path) {
  file_name <- basename(output_path)
  pattern <- "^exercise-([0-9]+-[0-9]+)-([0-9]+)\\.tex$"
  if (!grepl(pattern, file_name)) {
    stop(
      "Unsupported output filename '", file_name,
      "'. Expected exercise-<chapter>-<exercise>-<chunk>.tex"
    )
  }
  parts <- regmatches(file_name, regexec(pattern, file_name))[[1L]]
  exercise <- gsub("-", ".", parts[[2L]])
  chunk_index <- as.integer(parts[[3L]])
  list(exercise = exercise, chunk_index = chunk_index)
}

export_single_chunk <- function(
  input_path,
  output_path,
  traceability = NULL,
  traceability_dir = "metadata/traceability",
  enable_traceability = TRUE,
  traceability_strict = FALSE
) {
  ensure_dependencies()

  config <- resolve_workshop_export_config(input_path)
  if (is.null(config)) {
    stop(
      "Unsupported workshop source: ", input_path,
      ". Add its configuration to scripts/workshop-export-config.R."
    )
  }

  target <- parse_output_target(output_path)

  if (isTRUE(enable_traceability)) {
    if (is.null(traceability)) {
      traceability <- load_traceability_metadata(
        metadata_dir = traceability_dir,
        strict = traceability_strict
      )
    }

    if (isTRUE(traceability$enabled)) {
      # Sub-issue 3: verify exporter can resolve and ingest traceability metadata.
      # Coverage and exception reporting are implemented in follow-up sub-issues.
      invisible(build_workshop_traceability_id(config$id, target$exercise, target$chunk_index))
    }
  }

  expected_chunk_count <- config$expected_chunks[[target$exercise]]
  if (is.null(expected_chunk_count)) {
    stop(
      "Exercise ", target$exercise,
      " is not configured for source ", config$source,
      ". Supported exercises: ", paste(names(config$expected_chunks), collapse = ", ")
    )
  }

  parser_engine <- "ir"
  if (!is.null(getOption("ada.workshop.parser.engine"))) {
    parser_engine <- getOption("ada.workshop.parser.engine")
  }
  if (!parser_engine %in% c("legacy", "ir")) {
    stop("Unsupported parser engine: ", parser_engine, ". Use legacy or ir.")
  }

  all_segments <- if (identical(parser_engine, "ir")) {
    model <- build_workshop_model(input_path = config$source, config = config)
    build_all_segments_from_ir(ir = model$ir, config = config, source_file = config$source)
  } else {
    source_lines <- read_source_lines(config$source)
    validate_supported_constructs(source_lines, config$source)
    publishable <- strip_support_only(source_lines, config$source)

    segments <- list()
    for (exercise in names(config$expected_chunks)) {
      segments[[exercise]] <- extract_exercise_segments(
        publishable,
        exercise,
        config$expected_chunks[[exercise]],
        config$source
      )
    }
    segments
  }
  renderer <- create_workshop_renderer("latex")
  generated <- render_workshop_chunk(
    renderer = renderer,
    all_segments = all_segments,
    config = config,
    target_exercise = target$exercise,
    target_chunk_index = target$chunk_index
  )
  write_output(generated, output_path)
  message("Generated ", output_path)
}

build_output_path <- function(output_dir, exercise, chunk_index) {
  exercise_slug <- gsub("\\.", "-", exercise)
  file.path(output_dir, sprintf("exercise-%s-%d.tex", exercise_slug, chunk_index))
}

export_workshop_by_config <- function(
  config,
  output_dir = "generated/workshop-output",
  parser_engine = "ir",
  traceability_dir = "metadata/traceability",
  enable_traceability = TRUE,
  traceability_strict = FALSE
) {
  if (is.null(config) || is.null(config$source) || is.null(config$expected_chunks)) {
    stop("Invalid workshop export configuration supplied.")
  }

  if (!parser_engine %in% c("legacy", "ir")) {
    stop("Unsupported parser engine: ", parser_engine, ". Use legacy or ir.")
  }

  old_engine <- getOption("ada.workshop.parser.engine")
  options(ada.workshop.parser.engine = parser_engine)
  on.exit(options(ada.workshop.parser.engine = old_engine), add = TRUE)

  traceability <- NULL
  if (isTRUE(enable_traceability)) {
    traceability <- load_traceability_metadata(
      metadata_dir = traceability_dir,
      strict = traceability_strict
    )
  }
  for (exercise in names(config$expected_chunks)) {
    for (i in seq_len(config$expected_chunks[[exercise]])) {
      export_single_chunk(
        config$source,
        build_output_path(output_dir, exercise, i),
        traceability = traceability,
        traceability_dir = traceability_dir,
        enable_traceability = enable_traceability,
        traceability_strict = traceability_strict
      )
    }
  }
}

export_workshop_by_config_id <- function(
  config_id,
  output_dir = "generated/workshop-output",
  parser_engine = "ir",
  traceability_dir = "metadata/traceability",
  enable_traceability = TRUE,
  traceability_strict = FALSE
) {
  config <- resolve_workshop_export_config_by_id(config_id)
  if (is.null(config)) {
    stop(
      "Unsupported workshop config id: ", config_id,
      ". Add it to scripts/workshop-export-config.R."
    )
  }
  export_workshop_by_config(
    config,
    output_dir = output_dir,
    parser_engine = parser_engine,
    traceability_dir = traceability_dir,
    enable_traceability = enable_traceability,
    traceability_strict = traceability_strict
  )
}

main <- function() {
  args <- parse_cli_args(commandArgs(trailingOnly = TRUE))
  if (isTRUE(args$help)) {
    print_help()
    return(invisible(NULL))
  }
  if (is.null(args$input) || is.null(args$output)) {
    stop("Both --input and --output are required. Use --help for usage.")
  }
  old_engine <- getOption("ada.workshop.parser.engine")
  options(ada.workshop.parser.engine = args$parser_engine)
  on.exit(options(ada.workshop.parser.engine = old_engine), add = TRUE)

  export_single_chunk(
    args$input,
    args$output,
    traceability_dir = args$traceability_dir,
    enable_traceability = args$enable_traceability,
    traceability_strict = args$traceability_strict
  )
}

if (sys.nframe() == 0L) {
  main()
}
