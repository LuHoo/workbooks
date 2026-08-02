#!/usr/bin/env Rscript

parse_args <- function(args) {
  out <- list(
    output_dir = "generated/worked-calculations",
    check = FALSE,
    help = FALSE
  )

  i <- 1L
  while (i <= length(args)) {
    arg <- args[[i]]
    if (identical(arg, "--output-dir")) {
      i <- i + 1L
      if (i > length(args)) stop("Missing value after --output-dir")
      out$output_dir <- args[[i]]
    } else if (identical(arg, "--check")) {
      out$check <- TRUE
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
    "  Rscript scripts/generate-worked-calculations.R [options]\n\n",
    "Options:\n",
    "  --output-dir <path>  Directory for generated snippets and metadata (default: generated/worked-calculations)\n",
    "  --check              Fail if committed generated files are stale\n",
    sep = ""
  )
}

source("R/manuscript-calculation-registry.R", chdir = FALSE)
source("R/manuscript-calculation-renderer.R", chdir = FALSE)

ensure_dependencies <- function() {
  if (!requireNamespace("FSaudit", quietly = TRUE)) {
    stop("The FSaudit package is required to generate worked calculations.")
  }
}

format_raw <- function(x, tolerance = NULL) {
  mc_assert_numeric_scalar(x, "x")

  digits <- 16L
  if (!is.null(tolerance) && is.finite(tolerance) && tolerance > 0) {
    digits <- max(0L, ceiling(-log10(tolerance)))
    x <- round(x, digits = digits)
    return(formatC(x, format = "f", digits = digits, decimal.mark = "."))
  }

  formatC(x, format = "fg", digits = digits, flag = "#")
}

json_escape <- function(x) {
  x <- gsub("\\\\", "\\\\\\\\", x)
  x <- gsub("\"", "\\\\\"", x)
  x <- gsub("\n", "\\\\n", x)
  x
}

json_string <- function(x) {
  paste0("\"", json_escape(x), "\"")
}

json_value_object <- function(item, default_tolerance = NULL) {
  raw_tolerance <- item$tolerance %||% default_tolerance
  lines <- c(
    "    {",
    paste0("      \"id\": ", json_string(item$id), ","),
    paste0("      \"role\": ", json_string(item$role), ","),
    paste0("      \"raw\": ", format_raw(item$raw, raw_tolerance), ","),
    paste0("      \"display\": ", json_string(item$display), ","),
    paste0("      \"format\": ", json_string(item$format))
  )
  if (!is.null(item$tolerance)) {
    lines[length(lines)] <- paste0(lines[length(lines)], ",")
    lines <- c(lines, paste0("      \"tolerance\": ", format_raw(item$tolerance, item$tolerance)))
  }
  if (!is.null(item$language_scope)) {
    lines[length(lines)] <- paste0(lines[length(lines)], ",")
    lines <- c(lines, paste0("      \"language_scope\": ", json_string(item$language_scope)))
  }
  c(lines, "    }")
}

write_json_metadata <- function(path, metadata) {
  value_blocks <- lapply(metadata$values, json_value_object, default_tolerance = metadata$tolerance)
  value_lines <- character()
  for (i in seq_along(value_blocks)) {
    block <- value_blocks[[i]]
    if (i < length(value_blocks)) {
      block[length(block)] <- paste0(block[length(block)], ",")
    }
    value_lines <- c(value_lines, block)
  }

  lines <- c(
    "{",
    paste0("  \"schema_version\": ", metadata$schema_version, ","),
    paste0("  \"id\": ", json_string(metadata$id), ","),
    paste0("  \"kind\": ", json_string(metadata$kind), ","),
    paste0("  \"chapter_prefix\": ", json_string(metadata$chapter_prefix), ","),
    paste0("  \"source_notebook\": ", json_string(metadata$source_notebook), ","),
    paste0("  \"source_context\": ", json_string(metadata$source_context), ","),
    paste0("  \"source_dataset\": ", json_string(metadata$source_dataset), ","),
    paste0("  \"target_snippet\": ", json_string(metadata$target_snippet), ","),
    paste0("  \"tolerance\": ", format_raw(metadata$tolerance, metadata$tolerance), ","),
    paste0("  \"language_scope\": ", json_string(metadata$language_scope), ","),
    "  \"equation_labels\": [",
    paste0(
      "    ",
      paste(vapply(metadata$equation_labels, json_string, character(1L)), collapse = ", ")
    ),
    "  ],",
    "  \"values\": [",
    value_lines,
    "  ]",
    "}"
  )
  writeLines(lines, path, useBytes = TRUE)
}

compute_aux_mpu_estimator <- function() {
  ensure_dependencies()

  inventory_data <- FSaudit::inventoryData
  suppressWarnings(RNGkind(sample.kind = "Rounding"))
  sample_obj <- FSaudit::cvs_obj(
    n = 400,
    bv = inventory_data$bv,
    id = inventory_data$item,
    seed = 12345
  )
  sample_obj <- FSaudit::select(sample_obj)
  audit_values <- inventory_data[
    match(sample_obj$sample$item, inventory_data$item),
    "av"
  ]
  sample_obj <- FSaudit::evaluate(sample_obj, av = audit_values)

  sample <- data.frame(
    bv = sample_obj$sample$bv,
    av = sample_obj$av
  )

  n <- sample_obj$n
  N <- nrow(inventory_data)
  sum_y <- sum(sample$av)
  mean_y <- mean(sample$av)
  sum_y2 <- sum(sample$av^2)
  var_y <- var(sample$av)
  mpu_estimate <- N * mean_y

  values <- list(
    mc_value("aux.mpu.population_size", role = "population_size", raw = N, format = "integer"),
    mc_value("aux.mpu.sample_size", role = "sample_size", raw = n, format = "integer"),
    mc_value("aux.mpu.total_audit_value", role = "total_audit_value", raw = sum_y, format = "number:2"),
    mc_value("aux.mpu.mean_audit_value", role = "mean_audit_value", raw = mean_y, format = "number:2"),
    mc_value("aux.mpu.sum_squared_audit_values", role = "sum_squared_audit_values", raw = sum_y2, format = "integer", tolerance = 1e-6),
    mc_value("aux.mpu.audit_value_variance", role = "audit_value_variance", raw = var_y, format = "integer"),
    mc_value("aux.mpu.estimated_population_value", role = "estimated_population_value", raw = mpu_estimate, format = "integer")
  )

  metadata <- mc_group(
    id = "aux.mpu.estimator",
    kind = "worked_calculation",
    source_notebook = "notebooks/support/auxiliary-variables-and-stratification/support.Rmd",
    source_context = "Exercise 3.2 and Exercise 3.3; inventory sample selected with seed 12345",
    source_dataset = "FSaudit::inventoryData",
    target_snippet = "generated/worked-calculations/aux-mpu-estimator.tex",
    tolerance = 1e-8,
    language_scope = "shared",
    equation_labels = c("eq:estimate_total", "eq:sample_var_shortcut"),
    values = values
  )

  template <- c(
    "The total \\hlblue{audit value}\\index{audit value} of the {{sample_size}} sampled items $\\sum y =$ {{total_audit_value}}, resulting in the mean audit value",
    "",
    "\\begin{equation*}",
    "\\overline{y} = \\frac{\\sum{y_i}}{n} = \\frac{{{total_audit_value}}}{{{sample_size}}} = {{mean_audit_value}}",
    "\\end{equation*}",
    "",
    "We then use Equation \\ref{eq:estimate_total}",
    "\\begin{equation*}",
    "  \\hat{Y}_{MPU} = N\\frac{\\sum y_i}{n} = {{population_size}} \\cdot {{mean_audit_value}} = {{estimated_population_value}}",
    "\\end{equation*}",
    "to estimate the population value.",
    "The variance of the audit values is calculated with Equation \\ref{eq:sample_var_shortcut}",
    "",
    "\\begin{align*}",
    "s_y^2 &= \\frac{\\sum{y^2} - (\\sum{y})^2 / n}{n - 1} \\\\",
    "&= \\frac{{{sum_squared_audit_values}} - {{total_audit_value}}^2 / {{sample_size}}}{{{sample_size}} - 1} = {{audit_value_variance}}",
    "\\end{align*}"
  )

  list(
    tex = mc_render_snippet(metadata, template),
    metadata = metadata
  )
}

write_pilot_outputs <- function(output_dir) {
  result <- compute_aux_mpu_estimator()
  dir.create(output_dir, recursive = TRUE, showWarnings = FALSE)

  tex_path <- file.path(output_dir, "aux-mpu-estimator.tex")
  json_path <- file.path(output_dir, "aux-mpu-estimator.json")
  writeLines(result$tex, tex_path, useBytes = TRUE)
  write_json_metadata(json_path, result$metadata)

  c(tex_path, json_path)
}

files_identical <- function(path_a, path_b) {
  isTRUE(identical(readBin(path_a, "raw", n = file.info(path_a)$size),
                   readBin(path_b, "raw", n = file.info(path_b)$size)))
}

json_metadata_equivalent <- function(expected_path, actual_path) {
  if (!requireNamespace("jsonlite", quietly = TRUE)) {
    stop("jsonlite is required to compare generated JSON metadata.")
  }

  expected <- jsonlite::fromJSON(expected_path, simplifyVector = FALSE)
  actual <- jsonlite::fromJSON(actual_path, simplifyVector = FALSE)

  scalar_fields <- c(
    "schema_version",
    "id",
    "kind",
    "chapter_prefix",
    "source_notebook",
    "source_context",
    "source_dataset",
    "target_snippet",
    "language_scope"
  )

  for (field in scalar_fields) {
    if (!identical(expected[[field]], actual[[field]])) {
      return(FALSE)
    }
  }

  if (!identical(expected$equation_labels, actual$equation_labels)) {
    return(FALSE)
  }

  if (length(expected$values) != length(actual$values)) {
    return(FALSE)
  }

  default_tolerance <- suppressWarnings(as.numeric(expected$tolerance %||% 0))
  if (!is.finite(default_tolerance)) {
    default_tolerance <- 0
  }

  value_tolerance <- function(item) {
    tol <- suppressWarnings(as.numeric(item$tolerance %||% default_tolerance))
    if (!is.finite(tol)) {
      return(default_tolerance)
    }
    tol
  }

  equal_numeric <- function(a, b, tol) {
    if (is.na(a) || is.na(b)) {
      return(is.na(a) && is.na(b))
    }
    abs(a - b) <= tol
  }

  for (i in seq_along(expected$values)) {
    e <- expected$values[[i]]
    a <- actual$values[[i]]
    if (!identical(e$id, a$id) || !identical(e$role, a$role) || !identical(e$format, a$format)) {
      return(FALSE)
    }

    e_scope <- e$language_scope %||% NULL
    a_scope <- a$language_scope %||% NULL
    if (!identical(e_scope, a_scope)) {
      return(FALSE)
    }

    e_raw <- suppressWarnings(as.numeric(e$raw))
    a_raw <- suppressWarnings(as.numeric(a$raw))
    tol <- max(value_tolerance(e), value_tolerance(a))
    if (!equal_numeric(e_raw, a_raw, tol)) {
      return(FALSE)
    }
  }

  TRUE
}

check_outputs <- function(output_dir) {
  temp_dir <- tempfile("worked-calculations-")
  dir.create(temp_dir, recursive = TRUE)
  on.exit(unlink(temp_dir, recursive = TRUE), add = TRUE)

  expected <- write_pilot_outputs(temp_dir)
  target <- file.path(output_dir, basename(expected))
  failures <- character()

  for (i in seq_along(expected)) {
    if (!file.exists(target[[i]])) {
      failures <- c(failures, paste0("Missing generated file: ", target[[i]]))
      next
    }
    same <- if (grepl("\\.json$", expected[[i]], ignore.case = TRUE)) {
      json_metadata_equivalent(expected[[i]], target[[i]])
    } else {
      files_identical(expected[[i]], target[[i]])
    }
    if (!same) {
      failures <- c(failures, paste0("Stale generated file: ", target[[i]]))
    }
  }

  if (length(failures)) {
    stop(
      paste(
        c(
          "Worked calculation check failed. Regenerate with:",
          "  Rscript scripts/generate-worked-calculations.R",
          failures
        ),
        collapse = "\n"
      ),
      call. = FALSE
    )
  }
}

args <- parse_args(commandArgs(trailingOnly = TRUE))
if (isTRUE(args$help)) {
  print_help()
  quit(status = 0L)
}

if (isTRUE(args$check)) {
  check_outputs(args$output_dir)
  message("Generated worked calculations are up to date.")
} else {
  paths <- write_pilot_outputs(args$output_dir)
  message("Wrote generated worked calculations:\n  ", paste(paths, collapse = "\n  "))
}
