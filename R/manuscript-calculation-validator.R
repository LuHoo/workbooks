# Validate notebook-derived manuscript calculation artifacts.

mc_required_entry_fields <- c(
  "schema_version", "id", "kind", "chapter_prefix", "source_notebook",
  "source_context", "tolerance", "language_scope", "values"
)

mc_required_value_fields <- c("id", "role", "raw", "display", "format")

mc_null_or_missing <- function(x, name) {
  is.null(x[[name]]) || length(x[[name]]) == 0L || all(is.na(x[[name]]))
}

mc_collect_error <- function(errors, message) {
  c(errors, message)
}

mc_try_validation <- function(expr) {
  tryCatch(
    {
      force(expr)
      character()
    },
    error = function(e) conditionMessage(e)
  )
}

mc_validate_registry_entry <- function(entry, repo_root = ".",
                                       metadata_path = NULL,
                                       check_files = TRUE) {
  errors <- character()
  context <- if (is.null(metadata_path)) entry$id %||% "<unknown>" else metadata_path

  for (field in mc_required_entry_fields) {
    if (mc_null_or_missing(entry, field)) {
      errors <- mc_collect_error(errors, paste0(context, ": missing required field `", field, "`."))
    }
  }
  if (length(errors)) {
    return(errors)
  }

  errors <- c(errors, mc_try_validation(mc_assert_semantic_id(entry$id, "id")))
  errors <- c(errors, mc_try_validation(mc_assert_choice(entry$kind, mc_kinds, "kind")))
  errors <- c(errors, mc_try_validation(mc_assert_choice(entry$language_scope, mc_language_scopes, "language_scope")))
  errors <- c(errors, mc_try_validation(mc_assert_numeric_scalar(entry$tolerance, "tolerance")))

  if (!identical(as.integer(entry$schema_version), as.integer(mc_registry_schema_version))) {
    errors <- mc_collect_error(errors, paste0(context, ": unsupported schema_version `", entry$schema_version, "`."))
  }
  if (!identical(entry$chapter_prefix, mc_prefix_from_id(entry$id))) {
    errors <- mc_collect_error(errors, paste0(context, ": chapter_prefix does not match entry id."))
  }

  for (field in c("source_notebook", "source_context")) {
    errors <- c(errors, mc_try_validation(mc_assert_scalar_string(entry[[field]], field)))
  }
  if (!is.null(entry$source_dataset)) {
    errors <- c(errors, mc_try_validation(mc_assert_scalar_string(entry$source_dataset, "source_dataset")))
  }
  if (!is.null(entry$target_snippet)) {
    errors <- c(errors, mc_try_validation(mc_assert_scalar_string(entry$target_snippet, "target_snippet")))
  }

  source_path <- file.path(repo_root, entry$source_notebook)
  if (isTRUE(check_files) && !file.exists(source_path)) {
    errors <- mc_collect_error(errors, paste0(context, ": source_notebook does not exist: ", entry$source_notebook))
  }

  values <- entry$values
  if (!is.list(values) || !length(values)) {
    errors <- mc_collect_error(errors, paste0(context, ": values must be a non-empty list."))
    return(errors)
  }

  value_ids <- character()
  value_roles <- character()
  for (i in seq_along(values)) {
    value <- values[[i]]
    value_context <- paste0(context, ": values[", i, "]")
    for (field in mc_required_value_fields) {
      if (mc_null_or_missing(value, field)) {
        errors <- mc_collect_error(errors, paste0(value_context, " missing required field `", field, "`."))
      }
    }
    if (length(setdiff(mc_required_value_fields, names(value)))) {
      next
    }
    errors <- c(errors, mc_try_validation(mc_assert_semantic_id(value$id, "value id")))
    errors <- c(errors, mc_try_validation(mc_assert_numeric_scalar(value$raw, "raw")))
    errors <- c(errors, mc_try_validation(mc_assert_scalar_string(value$role, "role")))
    errors <- c(errors, mc_try_validation(mc_assert_scalar_string(value$display, "display")))
    errors <- c(errors, mc_try_validation(mc_assert_scalar_string(value$format, "format")))
    errors <- c(errors, mc_try_validation(mc_format_value(value$raw, value$format)))

    if (!grepl("^[a-z][a-z0-9_]*$", value$role, perl = TRUE)) {
      errors <- mc_collect_error(errors, paste0(value_context, ": role must be lowercase snake_case."))
    }
    if (!identical(mc_prefix_from_id(value$id), entry$chapter_prefix)) {
      errors <- mc_collect_error(errors, paste0(value_context, ": value prefix does not match entry prefix."))
    }
    if (!is.null(value$tolerance)) {
      errors <- c(errors, mc_try_validation(mc_assert_numeric_scalar(value$tolerance, "value tolerance")))
    }
    if (!is.null(value$language_scope)) {
      errors <- c(errors, mc_try_validation(mc_assert_choice(value$language_scope, mc_language_scopes, "value language_scope")))
    }
    value_ids <- c(value_ids, value$id)
    value_roles <- c(value_roles, value$role)
  }

  duplicate_ids <- unique(value_ids[duplicated(value_ids)])
  if (length(duplicate_ids)) {
    errors <- mc_collect_error(errors, paste0(context, ": duplicate value ID(s): ", paste(duplicate_ids, collapse = ", ")))
  }
  duplicate_roles <- unique(value_roles[duplicated(value_roles)])
  if (length(duplicate_roles)) {
    errors <- mc_collect_error(errors, paste0(context, ": duplicate value role(s): ", paste(duplicate_roles, collapse = ", ")))
  }

  if (!is.null(entry$target_snippet)) {
    snippet_path <- file.path(repo_root, entry$target_snippet)
    if (isTRUE(check_files) && !file.exists(snippet_path)) {
      errors <- mc_collect_error(errors, paste0(context, ": target_snippet does not exist: ", entry$target_snippet))
    } else if (isTRUE(check_files)) {
      snippet <- readLines(snippet_path, warn = FALSE)
      required_lines <- c(
        paste0("% Registry ID: ", entry$id),
        paste0("% Source notebook: ", entry$source_notebook)
      )
      for (line in required_lines) {
        if (!line %in% snippet) {
          errors <- mc_collect_error(errors, paste0(context, ": snippet missing provenance line: ", line))
        }
      }
      if (identical(entry$kind, "worked_calculation")) {
        snippet_text <- paste(snippet, collapse = "\n")
        missing_displays <- vapply(values, function(value) !grepl(value$display, snippet_text, fixed = TRUE), logical(1L))
        if (any(missing_displays)) {
          errors <- mc_collect_error(
            errors,
            paste0(context, ": snippet missing display value(s): ",
                   paste(vapply(values[missing_displays], function(value) value$id, character(1L)), collapse = ", "))
          )
        }
      }
    }
  }

  errors
}

mc_read_registry_metadata <- function(generated_dir = "generated/worked-calculations") {
  if (!requireNamespace("jsonlite", quietly = TRUE)) {
    stop("The jsonlite package is required to validate manuscript calculations.", call. = FALSE)
  }
  paths <- list.files(generated_dir, pattern = "\\.json$", full.names = TRUE)
  paths <- paths[!grepl("validation-report\\.json$", basename(paths))]
  lapply(paths, function(path) {
    entry <- jsonlite::fromJSON(path, simplifyVector = FALSE)
    attr(entry, "metadata_path") <- path
    entry
  })
}

mc_extract_worked_calculation_inputs <- function(tex_files) {
  inputs <- data.frame(file = character(), target = character(), stringsAsFactors = FALSE)
  pattern <- "\\\\input\\{(generated/worked-calculations/[^}]+)\\}"
  for (tex_file in tex_files) {
    lines <- readLines(tex_file, warn = FALSE)
    matches <- gregexpr(pattern, lines, perl = TRUE)
    found <- regmatches(lines, matches)
    for (line_matches in found[lengths(found) > 0L]) {
      targets <- sub("^\\\\input\\{", "", sub("\\}$", "", line_matches))
      targets <- ifelse(grepl("\\.tex$", targets), targets, paste0(targets, ".tex"))
      inputs <- rbind(inputs, data.frame(file = tex_file, target = targets, stringsAsFactors = FALSE))
    }
  }
  inputs
}

mc_validate_manuscript_inputs <- function(entries, repo_root = ".", manuscript_dir = ".") {
  errors <- character()
  tex_files <- list.files(file.path(repo_root, manuscript_dir), pattern = "\\.tex$", full.names = TRUE, recursive = FALSE)
  inputs <- mc_extract_worked_calculation_inputs(tex_files)
  registered_targets <- vapply(entries, function(entry) entry$target_snippet %||% NA_character_, character(1L))
  registered_targets <- registered_targets[!is.na(registered_targets)]

  if (!nrow(inputs)) {
    return(list(errors = errors, inputs = inputs))
  }

  for (i in seq_len(nrow(inputs))) {
    target <- inputs$target[[i]]
    if (!file.exists(file.path(repo_root, target))) {
      errors <- mc_collect_error(errors, paste0(inputs$file[[i]], ": input points to missing worked calculation snippet: ", target))
    }
    if (!target %in% registered_targets) {
      errors <- mc_collect_error(errors, paste0(inputs$file[[i]], ": input is not registered in metadata: ", target))
    }
  }

  list(errors = errors, inputs = inputs)
}

mc_validation_report <- function(entries, inputs, errors) {
  entry_rows <- lapply(entries, function(entry) {
    list(
      id = entry$id %||% NA_character_,
      source_notebook = entry$source_notebook %||% NA_character_,
      target_snippet = entry$target_snippet %||% NA_character_,
      status = if (any(grepl(paste0("(^|: )", entry$id), errors, fixed = FALSE))) "failed" else "passed"
    )
  })
  list(
    schema_version = mc_registry_schema_version,
    status = if (length(errors)) "failed" else "passed",
    checked_count = length(entries),
    checked = entry_rows,
    manuscript_inputs = if (nrow(inputs)) split(inputs, seq_len(nrow(inputs))) else list(),
    errors = as.list(errors)
  )
}

mc_write_validation_markdown <- function(path, report) {
  lines <- c(
    "# Manuscript Calculation Validation Report",
    "",
    paste0("- Status: ", report$status),
    paste0("- Checked calculations: ", report$checked_count),
    "",
    "## Checked Calculations",
    ""
  )
  if (length(report$checked)) {
    lines <- c(lines, "| ID | Source notebook | Target snippet | Status |", "| --- | --- | --- | --- |")
    for (entry in report$checked) {
      lines <- c(lines, paste0("| ", entry$id, " | ", entry$source_notebook, " | ", entry$target_snippet, " | ", entry$status, " |"))
    }
  } else {
    lines <- c(lines, "_No registered calculations found._")
  }
  if (length(report$errors)) {
    lines <- c(lines, "", "## Errors", "", paste0("- ", unlist(report$errors, use.names = FALSE)))
  }
  writeLines(lines, path, useBytes = TRUE)
}
