#!/usr/bin/env Rscript

source("scripts/workshop-ir.R", chdir = FALSE)
source("scripts/workshop-export-config.R", chdir = FALSE)

WORKSHOP_IR_ACCEPTED_SCHEMA_VERSIONS <- c("workshop-ir/1.0.0", "workshop-ir/1.1.0")
WORKSHOP_IR_SUPPORTED_DIRECTIVE_NAMES <- c(
  "SUPPORT-ONLY:START",
  "SUPPORT-ONLY:END",
  "ADA:BEGIN",
  "ADA:END",
  "ADA:REQUIRES"
)
WORKSHOP_IR_SUPPORTED_LANG_SCOPES <- c("shared", "python")
WORKSHOP_IR_SUPPORTED_CAPABILITIES <- c("fsaudit")

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
    authoring_context <- block$authoring_context
    lang_scope <- if (is.list(authoring_context) && !is.null(authoring_context$lang_scope)) {
      authoring_context$lang_scope
    } else {
      "shared"
    }

    identical(block$block_type, "code") &&
      !isTRUE(block$support_only) &&
      identical(lang_scope, "shared")
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

collect_ir_block_index <- function(ir) {
  index <- list()

  for (block in ir$chapter_blocks) {
    index[[block$block_id]] <- block
  }

  for (exercise in ir$exercises) {
    for (block in exercise$blocks) {
      index[[block$block_id]] <- block
    }
  }

  index
}

collect_ir_known_entity_ids <- function(ir) {
  ids <- list(
    chapter = character(),
    exercise = character(),
    block = character()
  )

  ids$chapter <- ir$chapter$chapter_id
  ids$exercise <- vapply(ir$exercises, function(exercise) exercise$exercise_id, character(1L))
  ids$block <- c(
    vapply(ir$chapter_blocks, function(block) block$block_id, character(1L)),
    unlist(lapply(ir$exercises, function(exercise) vapply(exercise$blocks, function(block) block$block_id, character(1L))), use.names = FALSE)
  )

  ids
}

validate_semantic_references <- function(ir, source_path) {
  diagnostics <- list()

  if (is.null(ir$semantic_references)) {
    return(diagnostics)
  }

  sr <- ir$semantic_references
  if (is.null(sr$targets) || is.null(sr$references)) {
    diagnostics <- append_diag(diagnostics, new_ir_diagnostic(
      category = "IR-SEMANTIC",
      code = "E310",
      file = source_path,
      line = 1L,
      block = "semantic_references",
      message = "semantic_references requires both targets and references arrays",
      remediation = "ensure parser emits semantic_references.targets and semantic_references.references"
    ))
    return(diagnostics)
  }

  known_ids <- collect_ir_known_entity_ids(ir)
  block_index <- collect_ir_block_index(ir)
  valid_entity_types <- c("chapter", "exercise", "block")

  target_ids <- character()
  target_types <- character()

  for (target in sr$targets) {
    target_line <- 1L
    target_block <- if (!is.null(target$semantic_id)) target$semantic_id else "semantic-target"

    if (is.null(target$semantic_id) || !nzchar(target$semantic_id) ||
        is.null(target$entity_type) || !nzchar(target$entity_type) ||
        is.null(target$entity_id) || !nzchar(target$entity_id)) {
      diagnostics <- append_diag(diagnostics, new_ir_diagnostic(
        category = "IR-SEMANTIC",
        code = "E311",
        file = source_path,
        line = target_line,
        block = target_block,
        message = "semantic target missing required fields (semantic_id/entity_type/entity_id)",
        remediation = "ensure each semantic target declares semantic_id, entity_type, and entity_id"
      ))
      next
    }

    if (!target$entity_type %in% valid_entity_types) {
      diagnostics <- append_diag(diagnostics, new_ir_diagnostic(
        category = "IR-SEMANTIC",
        code = "E312",
        file = source_path,
        line = target_line,
        block = target$semantic_id,
        message = paste0("unsupported semantic target entity_type '", target$entity_type, "'"),
        remediation = paste0("use one of: ", paste(valid_entity_types, collapse = ", "))
      ))
      next
    }

    if (target$semantic_id %in% target_ids) {
      existing_type <- target_types[match(target$semantic_id, target_ids)]
      diagnostics <- append_diag(diagnostics, new_ir_diagnostic(
        category = "IR-SEMANTIC",
        code = "E313",
        file = source_path,
        line = target_line,
        block = target$semantic_id,
        message = paste0(
          "duplicate semantic target id '", target$semantic_id,
          "' declared for entity types '", existing_type, "' and '", target$entity_type, "'"
        ),
        remediation = "ensure semantic target IDs are unique"
      ))
      next
    }

    target_ids <- c(target_ids, target$semantic_id)
    target_types <- c(target_types, target$entity_type)

    if (!target$entity_id %in% known_ids[[target$entity_type]]) {
      diagnostics <- append_diag(diagnostics, new_ir_diagnostic(
        category = "IR-SEMANTIC",
        code = "E320",
        file = source_path,
        line = target_line,
        block = target$semantic_id,
        message = paste0(
          "semantic target entity_id '", target$entity_id,
          "' not present in IR ", target$entity_type, " objects"
        ),
        remediation = "ensure semantic targets point to existing chapter/exercise/block IDs"
      ))
    }
  }

  valid_scopes <- c("chapter", "exercise")
  for (reference in sr$references) {
    line <- if (!is.null(reference$source_line)) as.integer(reference$source_line) else 1L
    block <- if (!is.null(reference$source_block_id) && nzchar(reference$source_block_id)) {
      reference$source_block_id
    } else {
      "semantic-reference"
    }

    required_fields <- c(
      "reference_id",
      "source_scope",
      "source_container_id",
      "source_block_id",
      "source_line",
      "source_column",
      "raw_token",
      "target_id"
    )
    missing_fields <- Filter(function(name) {
      value <- reference[[name]]
      is.null(value) || (is.character(value) && length(value) == 1L && !nzchar(value))
    }, required_fields)

    if (length(missing_fields) > 0L) {
      diagnostics <- append_diag(diagnostics, new_ir_diagnostic(
        category = "IR-SEMANTIC",
        code = "E314",
        file = source_path,
        line = line,
        block = block,
        message = paste0("semantic reference missing fields: ", paste(missing_fields, collapse = ", ")),
        remediation = "ensure parser emits complete semantic reference entries"
      ))
      next
    }

    if (!reference$source_scope %in% valid_scopes) {
      diagnostics <- append_diag(diagnostics, new_ir_diagnostic(
        category = "IR-SEMANTIC",
        code = "E315",
        file = source_path,
        line = line,
        block = block,
        message = paste0("unsupported semantic reference source_scope '", reference$source_scope, "'"),
        remediation = paste0("use one of: ", paste(valid_scopes, collapse = ", "))
      ))
    }

    if (!reference$source_block_id %in% names(block_index)) {
      diagnostics <- append_diag(diagnostics, new_ir_diagnostic(
        category = "IR-SEMANTIC",
        code = "E322",
        file = source_path,
        line = line,
        block = block,
        message = paste0("semantic reference source_block_id '", reference$source_block_id, "' not present in IR"),
        remediation = "ensure semantic references point to existing IR block IDs"
      ))
    }

    if (!reference$target_id %in% target_ids) {
      diagnostics <- append_diag(diagnostics, new_ir_diagnostic(
        category = "IR-SEMANTIC",
        code = "E321",
        file = source_path,
        line = line,
        block = block,
        message = paste0("unresolved semantic target_id '", reference$target_id, "'"),
        remediation = "define a corresponding semantic target ID or fix the ADA:REF token target"
      ))
    }
  }

  diagnostics
}

validate_workshop_ir <- function(ir, source_path = NULL, config = NULL, strict = TRUE) {
  if (is.null(source_path)) {
    source_path <- if (!is.null(ir$source$file_path)) ir$source$file_path else "<unknown>"
  }

  diagnostics <- list()

  if (!ir$schema_version %in% WORKSHOP_IR_ACCEPTED_SCHEMA_VERSIONS) {
    diagnostics <- append_diag(diagnostics, new_ir_diagnostic(
      category = "IR-MODEL",
      code = "E101",
      file = source_path,
      line = 1L,
      block = "schema_version",
      message = paste0("unsupported schema version '", ir$schema_version, "'"),
      remediation = paste0("use one of: ", paste(WORKSHOP_IR_ACCEPTED_SCHEMA_VERSIONS, collapse = ", "))
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

  missing <- validate_required_string(ir$chapter$semantic_id, "chapter.semantic_id", source_path)
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

  if (!is.null(ir$directives$instances)) {
    for (instance in ir$directives$instances) {
      if (!instance$name %in% WORKSHOP_IR_SUPPORTED_DIRECTIVE_NAMES) {
        diagnostics <- append_diag(diagnostics, new_ir_diagnostic(
          category = "IR-DIRECTIVE",
          code = "E201",
          file = source_path,
          line = instance$source_span$start_line,
          block = instance$name,
          message = paste0("unsupported directive instance '", instance$name, "' in IR"),
          remediation = "ensure parser emits only supported directives"
        ))
      }
    }
  }

  exercise_refs <- character()
  expected_ordinal <- 1L

  for (exercise in ir$exercises) {
    override_keys <- character()
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

    missing <- validate_required_string(
      exercise$semantic_id,
      paste0("exercise.semantic_id (", exercise$exercise_ref, ")"),
      source_path,
      line = exercise$source_span$heading_line,
      block = paste0("exercise:", exercise$exercise_ref)
    )
    if (!is.null(missing)) diagnostics <- append_diag(diagnostics, missing)

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

      missing <- validate_required_string(
        block$semantic_id,
        paste0("block.semantic_id (", block$block_id, ")"),
        source_path,
        line = block$source_span$start_line,
        block = block$block_id
      )
      if (!is.null(missing)) diagnostics <- append_diag(diagnostics, missing)

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

      if (!is.null(block$authoring_context)) {
        ctx <- block$authoring_context

        if (!ctx$lang_scope %in% WORKSHOP_IR_SUPPORTED_LANG_SCOPES) {
          diagnostics <- append_diag(diagnostics, new_ir_diagnostic(
            category = "IR-DIRECTIVE",
            code = "E230",
            file = source_path,
            line = block$source_span$start_line,
            block = block$block_id,
            message = paste0("unsupported language scope '", ctx$lang_scope, "'"),
            remediation = paste0("use one of: ", paste(WORKSHOP_IR_SUPPORTED_LANG_SCOPES, collapse = ", "))
          ))
        }

        if (identical(ctx$mode, "override")) {
          if (is.null(ctx$override_target_block_id) || !nzchar(ctx$override_target_block_id)) {
            diagnostics <- append_diag(diagnostics, new_ir_diagnostic(
              category = "IR-DIRECTIVE",
              code = "E240",
              file = source_path,
              line = block$source_span$start_line,
              block = block$block_id,
              message = "override block missing override_target_block_id",
              remediation = "ensure override directives resolve a valid prior shared block"
            ))
          } else {
            key <- paste(ctx$override_target_block_id, ctx$lang_scope, sep = "::")
            if (key %in% override_keys) {
              diagnostics <- append_diag(diagnostics, new_ir_diagnostic(
                category = "IR-DIRECTIVE",
                code = "E241",
                file = source_path,
                line = block$source_span$start_line,
                block = block$block_id,
                message = "duplicate override for same target block and language",
                remediation = "keep only one override per target block/language"
              ))
            }
            override_keys <- c(override_keys, key)
          }
        }

        if (identical(ctx$mode, "only") && identical(ctx$lang_scope, "shared")) {
          diagnostics <- append_diag(diagnostics, new_ir_diagnostic(
            category = "IR-DIRECTIVE",
            code = "E242",
            file = source_path,
            line = block$source_span$start_line,
            block = block$block_id,
            message = "mode=only with lang_scope=shared is invalid",
            remediation = "use a non-shared language scope for mode=only"
          ))
        }

        if (!is.null(ctx$requires) && length(ctx$requires) > 0L) {
          if (!identical(block$block_type, "code")) {
            diagnostics <- append_diag(diagnostics, new_ir_diagnostic(
              category = "IR-DIRECTIVE",
              code = "E243",
              file = source_path,
              line = block$source_span$start_line,
              block = block$block_id,
              message = "capability requirements are only valid on code blocks",
              remediation = "move ADA:REQUIRES to directly above a code block"
            ))
          }
          unknown_caps <- setdiff(ctx$requires, WORKSHOP_IR_SUPPORTED_CAPABILITIES)
          if (length(unknown_caps) > 0L) {
            diagnostics <- append_diag(diagnostics, new_ir_diagnostic(
              category = "IR-DIRECTIVE",
              code = "E244",
              file = source_path,
              line = block$source_span$start_line,
              block = block$block_id,
              message = paste0("unsupported capability requirements: ", paste(unknown_caps, collapse = ", ")),
              remediation = paste0("use one of: ", paste(WORKSHOP_IR_SUPPORTED_CAPABILITIES, collapse = ", "))
            ))
          }
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
      expected <- NULL
      if (exercise$exercise_ref %in% names(config$expected_chunks)) {
        expected <- config$expected_chunks[[exercise$exercise_ref]]
      }
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
            remediation = "reconcile support notebook chunks with metadata/workshop-registry.R"
          ))
        }
      }
    }
  }

  diagnostics <- c(diagnostics, validate_semantic_references(ir = ir, source_path = source_path))

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
