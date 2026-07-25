# Helpers for registering notebook-derived manuscript calculations.

mc_registry_schema_version <- 1L

mc_chapter_prefixes <- c("pro", "est", "aux", "hyp", "reg", "gof")
mc_kinds <- c("worked_calculation", "inline_values", "table_values", "report_only")
mc_language_scopes <- c("shared", "r", "python", "exception")

mc_assert_scalar_string <- function(value, name) {
  if (!is.character(value) || length(value) != 1L || is.na(value) || !nzchar(trimws(value))) {
    stop("`", name, "` must be one non-empty character string.", call. = FALSE)
  }
  invisible(value)
}

mc_assert_numeric_scalar <- function(value, name) {
  if (!is.numeric(value) || length(value) != 1L || is.na(value)) {
    stop("`", name, "` must be one non-missing numeric value.", call. = FALSE)
  }
  invisible(value)
}

mc_prefix_from_id <- function(id) {
  sub("\\..*$", "", id)
}

mc_assert_semantic_id <- function(id, name = "id") {
  mc_assert_scalar_string(id, name)
  pattern <- "^(pro|est|aux|hyp|reg|gof)\\.[a-z0-9_]+(\\.[a-z0-9_]+)*$"
  if (!grepl(pattern, id, perl = TRUE)) {
    stop("`", name, "` must be a semantic manuscript calculation ID: ", id, call. = FALSE)
  }
  invisible(id)
}

mc_assert_choice <- function(value, choices, name) {
  mc_assert_scalar_string(value, name)
  if (!value %in% choices) {
    stop("`", name, "` must be one of: ", paste(choices, collapse = ", "), call. = FALSE)
  }
  invisible(value)
}

mc_format_number <- function(x, digits = 0) {
  formatC(
    x,
    format = "f",
    digits = digits,
    big.mark = ",",
    decimal.mark = "."
  )
}

mc_format_value <- function(raw, format) {
  mc_assert_numeric_scalar(raw, "raw")
  mc_assert_scalar_string(format, "format")

  if (identical(format, "integer")) {
    return(mc_format_number(raw, 0L))
  }

  number_match <- regexec("^number:([0-9]+)$", format, perl = TRUE)
  number_parts <- regmatches(format, number_match)[[1L]]
  if (length(number_parts) == 2L) {
    return(mc_format_number(raw, as.integer(number_parts[[2L]])))
  }

  percent_match <- regexec("^percentage:([0-9]+)$", format, perl = TRUE)
  percent_parts <- regmatches(format, percent_match)[[1L]]
  if (length(percent_parts) == 2L) {
    return(paste0(mc_format_number(raw * 100, as.integer(percent_parts[[2L]])), "\\%"))
  }

  fixed_match <- regexec("^(pvalue|statistic):([0-9]+)$", format, perl = TRUE)
  fixed_parts <- regmatches(format, fixed_match)[[1L]]
  if (length(fixed_parts) == 3L) {
    return(mc_format_number(raw, as.integer(fixed_parts[[3L]])))
  }

  stop("Unsupported manuscript calculation format: ", format, call. = FALSE)
}

mc_value <- function(id, raw, format, role = NULL, display = NULL,
                     tolerance = NULL, language_scope = NULL) {
  mc_assert_semantic_id(id)
  mc_assert_numeric_scalar(raw, "raw")
  mc_assert_scalar_string(format, "format")

  if (is.null(role)) {
    role <- sub("^.*\\.", "", id)
  }
  mc_assert_scalar_string(role, "role")
  if (!grepl("^[a-z][a-z0-9_]*$", role, perl = TRUE)) {
    stop("`role` must be lowercase snake_case: ", role, call. = FALSE)
  }

  if (is.null(display)) {
    display <- mc_format_value(raw, format)
  }
  mc_assert_scalar_string(display, "display")

  out <- list(
    id = id,
    role = role,
    raw = raw,
    display = display,
    format = format
  )

  if (!is.null(tolerance)) {
    mc_assert_numeric_scalar(tolerance, "tolerance")
    out$tolerance <- tolerance
  }
  if (!is.null(language_scope)) {
    mc_assert_choice(language_scope, mc_language_scopes, "language_scope")
    out$language_scope <- language_scope
  }

  out
}

mc_group <- function(id, kind, source_notebook, source_context, values,
                     source_dataset = NULL, target_snippet = NULL,
                     tolerance = 1e-8, language_scope = "shared",
                     equation_labels = character()) {
  mc_assert_semantic_id(id)
  mc_assert_choice(kind, mc_kinds, "kind")
  mc_assert_scalar_string(source_notebook, "source_notebook")
  mc_assert_scalar_string(source_context, "source_context")
  mc_assert_numeric_scalar(tolerance, "tolerance")
  mc_assert_choice(language_scope, mc_language_scopes, "language_scope")

  chapter_prefix <- mc_prefix_from_id(id)
  if (!chapter_prefix %in% mc_chapter_prefixes) {
    stop("Unsupported chapter prefix: ", chapter_prefix, call. = FALSE)
  }
  if (!is.list(values) || length(values) == 0L) {
    stop("`values` must be a non-empty list of registry values.", call. = FALSE)
  }

  value_ids <- vapply(values, function(item) item$id %||% NA_character_, character(1L))
  if (anyNA(value_ids) || any(!nzchar(value_ids))) {
    stop("Every registry value must have an `id`.", call. = FALSE)
  }
  if (any(duplicated(value_ids))) {
    stop("Duplicate registry value ID(s): ", paste(unique(value_ids[duplicated(value_ids)]), collapse = ", "), call. = FALSE)
  }
  bad_prefix <- value_ids[mc_prefix_from_id(value_ids) != chapter_prefix]
  if (length(bad_prefix)) {
    stop("Value IDs must use group prefix `", chapter_prefix, "`: ", paste(bad_prefix, collapse = ", "), call. = FALSE)
  }

  out <- list(
    schema_version = mc_registry_schema_version,
    id = id,
    kind = kind,
    chapter_prefix = chapter_prefix,
    source_notebook = source_notebook,
    source_context = source_context,
    tolerance = tolerance,
    language_scope = language_scope,
    values = values
  )

  if (!is.null(source_dataset)) {
    mc_assert_scalar_string(source_dataset, "source_dataset")
    out$source_dataset <- source_dataset
  }
  if (!is.null(target_snippet)) {
    mc_assert_scalar_string(target_snippet, "target_snippet")
    out$target_snippet <- target_snippet
  }
  if (length(equation_labels)) {
    out$equation_labels <- as.character(equation_labels)
  }

  out
}

`%||%` <- function(lhs, rhs) {
  if (is.null(lhs)) rhs else lhs
}
