#!/usr/bin/env Rscript

source("scripts/workshop-ir.R", chdir = FALSE)
source("scripts/workshop-export-config.R", chdir = FALSE)

resolve_workshop_export_config <- get("resolve_workshop_export_config", mode = "function")
resolve_workshop_export_config_by_id <- get("resolve_workshop_export_config_by_id", mode = "function")

new_ir_diagnostic <- function(category, code, file, line, block, message, remediation, severity = "error") {
  list(
    severity = severity,
    category = category,
    code = code,
    file = file,
    line = as.integer(line),
    block = block,
    message = message,
    remediation = remediation
  )
}

format_ir_diagnostic <- function(diag) {
  paste0(
    "[", toupper(diag$severity), "] ", diag$category, " ", diag$code,
    " file=", diag$file,
    " line=", diag$line,
    " block=", diag$block,
    " message=", diag$message,
    " remediation=", diag$remediation
  )
}

append_diag <- function(diags, diag) {
  c(diags, list(diag))
}

get_exercise_code_count <- function(exercise) {
  sum(vapply(exercise$blocks, function(block) {
    identical(block$block_type, "code") && !isTRUE(block$support_only)
  }, logical(1L)))
}

validate_required_string <- function(value, field_name, file_path, line = 1L, block = "root") {
  if (!is.character(value) || length(value) != 1L || !nzchar(value)) {
    return(new_ir_diagnostic(
      category = "IR-MODEL",
      code = "E100",
      file = file_path,
      line = line,
      block = block,
      message = paste0("missing or invalid required string field '", field_name, "'"),
      remediation = "ensure parser output includes a non-empty string for this field"
    ))
  }
  NULL
}

validate_workshop_ir <- function(ir, source_path = NULL, config = NULL, strict = TRUE) {
  if (is.null(source_path)) {
    source_path <- if (!is.null(ir$source$file_path)) ir$source$file_path else "<unknown>"
  }

  diagnostics <- list()

  if (!identical(ir$schema_version, WORKSHOP_IR_SCHEMA_VERSION)) {
    diagnostics <- append_diag(diagnostics, new_ir_diagnostic(
      category = "IR-MODEL",
      code = "E101",
      file = source_path,
      line = 1L,
      block = "schema_version",
      message = paste0("unsupported schema version '", ir$schema_version, "'"),
      remediation = paste0("use schema version ", WORKSHOP_IR_SCHEMA_VERSION)
    ))
  }

  required_top <- c("source", "chapter", "directives", "chapter_blocks", "exercises")
  for (field_name in required_top) {
    if (is.null(ir[[field_name]])) {
      diagnostics <- append_diag(diagnostics, new_ir_diagnostic(
        category = "IR-MODEL",
        code = "E102",
        file = source_path,
        line = 1L,
        block = "root",
        message = paste0("missing required top-level field '", field_name, "'"),
        remediation = "ensure parser emits all required top-level fields"
      ))
    }
  }

  missing <- validate_required_string(ir$source$file_path, "source.file_path", source_path)
  if (!is.null(missing)) diagnostics <- append_diag(diagnostics, missing)

  missing <- validate_required_string(ir$chapter$chapter_id, "chapter.chapter_id", source_path)
  if (!is.null(missing)) diagnostics <- append_diag(diagnostics, missing)

  missing <- validate_required_string(ir$chapter$workshop_id, "chapter.workshop_id", source_path)
  if (!is.null(missing)) diagnostics <- append_diag(diagnostics, missing)

  if (is.null(ir$source$line_count) || ir$source$line_count < 1L) {
    diagnostics <- append_diag(diagnostics, new_ir_diagnostic(
      category = "IR-MODEL",
      code = "E103",
      file = source_path,
      line = 1L,
      block = "source.line_count",
      message = "invalid source line_count",
      remediation = "ensure parser records a positive line_count"
    ))
  }

  supported <- ir$directives$supported
  observed <- ir$directives$observed
  if (!is.null(observed) && !is.null(supported)) {
    unknown <- setdiff(observed, supported)
    if (length(unknown) > 0L) {
      diagnostics <- append_diag(diagnostics, new_ir_diagnostic(
        category = "IR-DIRECTIVE",
        code = "E200",
        file = source_path,
        line = 1L,
        block = "directives.observed",
        message = paste0("unsupported directives observed: ", paste(unknown, collapse = ", ")),
        remediation = "remove unknown directives or extend supported directive set"
      ))
    }
  }

  exercise_refs <- character()
  expected_ordinal <- 1L

  for (exercise in ir$exercises) {
    if (!identical(exercise$ordinal, expected_ordinal)) {
      diagnostics <- append_diag(diagnostics, new_ir_diagnostic(
        category = "IR-MODEL",
        code = "E104",
        file = source_path,
        line = exercise$source_span$heading_line,
        block = paste0("exercise:", exercise$exercise_ref),
        message = paste0("non-contiguous exercise ordinal (expected ", expected_ordinal, ", got ", exercise$ordinal, ")"),
        remediation = "ensure exercises are emitted in source order with contiguous ordinals"
      ))
    }
    expected_ordinal <- expected_ordinal + 1L

    if (exercise$exercise_ref %in% exercise_refs) {
      diagnostics <- append_diag(diagnostics, new_ir_diagnostic(
        category = "IR-MODEL",
        code = "E105",
        file = source_path,
        line = exercise$source_span$heading_line,
        block = paste0("exercise:", exercise$exercise_ref),
        message = "duplicate exercise_ref in IR",
        remediation = "ensure each exercise heading appears once and maps to one IR exercise entry"
      ))
    }
    exercise_refs <- c(exercise_refs, exercise$exercise_ref)

    if (exercise$source_span$start_line > exercise$source_span$end_line) {
      diagnostics <- append_diag(diagnostics, new_ir_diagnostic(
        category = "IR-MODEL",
        code = "E106",
        file = source_path,
        line = exercise$source_span$heading_line,
        block = paste0("exercise:", exercise$exercise_ref),
        message = "invalid exercise source span (start_line > end_line)",
        remediation = "ensure parser records valid source span boundaries"
      ))
    }

    expected_seq <- 1L
    for (block in exercise$blocks) {
      if (!identical(block$sequence, expected_seq)) {
        diagnostics <- append_diag(diagnostics, new_ir_diagnostic(
          category = "IR-MODEL",
          code = "E107",
          file = source_path,
          line = block$source_span$start_line,
          block = block$block_id,
          message = paste0("non-contiguous block sequence (expected ", expected_seq, ", got ", block$sequence, ")"),
          remediation = "ensure block sequence is contiguous within each exercise"
        ))
      }
      expected_seq <- expected_seq + 1L

      if (block$source_span$start_line > block$source_span$end_line) {
        diagnostics <- append_diag(diagnostics, new_ir_diagnostic(
          category = "IR-MODEL",
          code = "E108",
          file = source_path,
          line = block$source_span$start_line,
          block = block$block_id,
          message = "invalid block source span (start_line > end_line)",
          remediation = "ensure parser emits valid block line boundaries"
        ))
      }

      if (identical(block$block_type, "code")) {
        if (!identical(block$content$language, "r")) {
          diagnostics <- append_diag(diagnostics, new_ir_diagnostic(
            category = "IR-MODEL",
            code = "E109",
            file = source_path,
            line = block$source_span$fence_open_line,
            block = block$block_id,
            message = paste0("unsupported code language '", block$content$language, "' in v1"),
            remediation = "use only R code fences or extend schema version for additional languages"
          ))
        }
        if (is.null(block$content$code_lines)) {
          diagnostics <- append_diag(diagnostics, new_ir_diagnostic(
            category = "IR-MODEL",
            code = "E110",
            file = source_path,
            line = block$source_span$fence_open_line,
            block = block$block_id,
            message = "code block missing code_lines",
            remediation = "ensure parser emits code_lines for every code block"
          ))
        }
      }
    }
  }

  if (!is.null(config) && !is.null(config$expected_chunks)) {
    missing_exercises <- setdiff(names(config$expected_chunks), exercise_refs)
    if (length(missing_exercises) > 0L) {
      diagnostics <- append_diag(diagnostics, new_ir_diagnostic(
        category = "IR-COMPAT",
        code = "E300",
        file = source_path,
        line = 1L,
        block = "exercise-index",
        message = paste0("IR missing configured exercises: ", paste(missing_exercises, collapse = ", ")),
        remediation = "ensure support notebook contains configured exercise headings"
      ))
    }

    for (exercise in ir$exercises) {
      expected <- config$expected_chunks[[exercise$exercise_ref]]
      if (!is.null(expected)) {
        actual <- get_exercise_code_count(exercise)
        if (!identical(as.integer(expected), as.integer(actual))) {
          diagnostics <- append_diag(diagnostics, new_ir_diagnostic(
            category = "IR-COMPAT",
            code = "E301",
            file = source_path,
            line = exercise$source_span$heading_line,
            block = paste0("exercise:", exercise$exercise_ref),
            message = paste0("chunk count mismatch (expected ", expected, ", got ", actual, ")"),
            remediation = "reconcile support notebook chunks with workshop-export-config.R"
          ))
        }
      }
    }
  }

  errors <- Filter(function(diag) identical(diag$severity, "error"), diagnostics)
  if (isTRUE(strict) && length(errors) > 0L) {
    stop(paste(vapply(errors, format_ir_diagnostic, character(1L)), collapse = "\n"))
  }

  diagnostics
}

parse_validation_cli_args <- function(args) {
  out <- list(
    input = NULL,
    config_id = NULL,
    strict = TRUE,
    pretty = FALSE,
    help = FALSE
  )

  i <- 1L
  while (i <= length(args)) {
    arg <- args[[i]]
    if (identical(arg, "--input")) {
      i <- i + 1L
      if (i > length(args)) stop("Missing value after --input")
      out$input <- args[[i]]
    } else if (identical(arg, "--config-id")) {
      i <- i + 1L
      if (i > length(args)) stop("Missing value after --config-id")
      out$config_id <- args[[i]]
    } else if (identical(arg, "--no-strict")) {
      out$strict <- FALSE
    } else if (identical(arg, "--pretty")) {
      out$pretty <- TRUE
    } else if (identical(arg, "--help") || identical(arg, "-h")) {
      out$help <- TRUE
    } else {
      stop("Unsupported option: ", arg)
    }
    i <- i + 1L
  }

  out
}

print_validation_help <- function() {
  cat(
    "Usage:\n",
    "  Rscript scripts/workshop-ir-validate.R --input <support.Rmd> [options]\n\n",
    "Options:\n",
    "  --config-id <id>   Validate compatibility against workshop config id.\n",
    "  --no-strict        Do not fail on validation errors; print diagnostics only.\n",
    "  --pretty           Pretty-print diagnostics JSON.\n",
    "  --help             Show this help.\n",
    sep = ""
  )
}

validate_support_notebook_ir <- function(input_path, config_id = NULL, strict = TRUE) {
  config <- NULL
  if (!is.null(config_id)) {
    config <- resolve_workshop_export_config_by_id(config_id)
    if (is.null(config)) {
      stop("Unknown config id: ", config_id)
    }
  } else {
    config <- resolve_workshop_export_config(input_path)
  }

  ir <- parse_support_notebook_to_ir(input_path = input_path)
  validate_workshop_ir(ir, source_path = input_path, config = config, strict = strict)
}

main <- function() {
  args <- parse_validation_cli_args(commandArgs(trailingOnly = TRUE))
  if (isTRUE(args$help)) {
    print_validation_help()
    return(invisible(NULL))
  }
  if (is.null(args$input)) {
    stop("--input is required. Use --help for usage.")
  }

  diagnostics <- validate_support_notebook_ir(
    input_path = args$input,
    config_id = args$config_id,
    strict = args$strict
  )

  if (!requireNamespace("jsonlite", quietly = TRUE)) {
    stop("The jsonlite package is required to print diagnostics JSON.")
  }

  cat(jsonlite::toJSON(diagnostics, auto_unbox = TRUE, pretty = isTRUE(args$pretty), null = "null"), "\n", sep = "")
}

if (sys.nframe() == 0L) {
  main()
}
