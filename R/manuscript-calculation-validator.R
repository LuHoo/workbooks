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

mc_effective_language_scope <- function(value, entry) {
  value$language_scope %||% entry$language_scope %||% "shared"
}

mc_value_tolerance <- function(value, entry) {
  value$tolerance %||% entry$tolerance %||% 1e-8
}

mc_shared_values_by_id <- function(entries) {
  rows <- list()
  for (entry in entries) {
    for (value in entry$values) {
      if (identical(mc_effective_language_scope(value, entry), "shared")) {
        rows[[length(rows) + 1L]] <- list(
          entry_id = entry$id,
          value_id = value$id,
          raw = value$raw,
          tolerance = mc_value_tolerance(value, entry),
          source_notebook = entry$source_notebook
        )
      }
    }
  }
  stats::setNames(rows, vapply(rows, function(row) row$value_id, character(1L)))
}

mc_compare_shared_language_values <- function(r_entries, python_entries, default_tolerance = 1e-8, relative_tolerance = 1e-15) {
  errors <- character()
  comparisons <- list()
  r_values <- mc_shared_values_by_id(r_entries)
  python_values <- mc_shared_values_by_id(python_entries)

  duplicate_r <- unique(names(r_values)[duplicated(names(r_values))])
  duplicate_python <- unique(names(python_values)[duplicated(names(python_values))])
  if (length(duplicate_r)) {
    errors <- c(errors, paste0("Duplicate shared R value ID(s): ", paste(duplicate_r, collapse = ", ")))
  }
  if (length(duplicate_python)) {
    errors <- c(errors, paste0("Duplicate shared Python value ID(s): ", paste(duplicate_python, collapse = ", ")))
  }

  shared_ids <- union(names(r_values), names(python_values))
  for (value_id in shared_ids) {
    r_value <- r_values[[value_id]]
    python_value <- python_values[[value_id]]
    if (is.null(r_value)) {
      errors <- c(errors, paste0("Missing shared R value for Python value ID: ", value_id))
      next
    }
    if (is.null(python_value)) {
      errors <- c(errors, paste0("Missing shared Python value for R value ID: ", value_id))
      next
    }

    configured_tolerance <- min(r_value$tolerance %||% default_tolerance, python_value$tolerance %||% default_tolerance)
    r_numeric <- as.numeric(r_value$raw)
    python_numeric <- as.numeric(python_value$raw)
    difference <- abs(r_numeric - python_numeric)
    scale_reference <- max(abs(r_numeric), abs(python_numeric), 1)
    tolerance <- max(configured_tolerance, relative_tolerance * scale_reference)
    status <- if (is.na(difference) || difference > tolerance) "failed" else "passed"
    comparisons[[length(comparisons) + 1L]] <- list(
      id = value_id,
      r_entry = r_value$entry_id,
      python_entry = python_value$entry_id,
      r_source_notebook = r_value$source_notebook,
      python_source_notebook = python_value$source_notebook,
      r_raw = r_value$raw,
      python_raw = python_value$raw,
      difference = difference,
      tolerance = tolerance,
      status = status
    )
    if (identical(status, "failed")) {
      errors <- c(
        errors,
        paste0(
          "Shared R/Python value mismatch for ", value_id,
          ": R=", r_value$raw,
          ", Python=", python_value$raw,
          ", difference=", difference,
          ", tolerance=", tolerance
        )
      )
    }
  }

  list(errors = errors, comparisons = comparisons)
}

mc_validation_report <- function(entries, inputs, errors, language_comparisons = list()) {
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
    language_comparisons = language_comparisons,
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
  if (length(report$language_comparisons)) {
    lines <- c(lines, "", "## R/Python Shared Value Comparisons", "")
    lines <- c(lines, "| ID | R raw | Python raw | Difference | Tolerance | Status |", "| --- | ---: | ---: | ---: | ---: | --- |")
    for (item in report$language_comparisons) {
      lines <- c(lines, paste0(
        "| ", item$id,
        " | ", item$r_raw,
        " | ", item$python_raw,
        " | ", item$difference,
        " | ", item$tolerance,
        " | ", item$status,
        " |"
      ))
    }
  }
  writeLines(lines, path, useBytes = TRUE)
}
