#!/usr/bin/env Rscript

source("R/manuscript-calculation-registry.R", chdir = FALSE)
source("R/manuscript-calculation-renderer.R", chdir = FALSE)

assert_true <- function(value, message) {
  if (!isTRUE(value)) {
    stop(message, call. = FALSE)
  }
}

expect_error <- function(expr, pattern) {
  err <- tryCatch(
    {
      force(expr)
      NULL
    },
    error = function(e) e
  )
  if (is.null(err)) {
    stop("Expected an error matching: ", pattern, call. = FALSE)
  }
  if (!grepl(pattern, conditionMessage(err), fixed = TRUE)) {
    stop(
      "Error did not match expected pattern.\nExpected: ", pattern,
      "\nActual: ", conditionMessage(err),
      call. = FALSE
    )
  }
}

value <- mc_value("aux.mpu.total_audit_value", raw = 864212.48, format = "number:2")
assert_true(identical(value$role, "total_audit_value"), "default role should derive from ID")
assert_true(identical(value$display, "864,212.48"), "number:2 display mismatch")

percent_value <- mc_value("hyp.alpha.rate", raw = 0.05, format = "percentage:1")
assert_true(identical(percent_value$display, "5.0\\%"), "percentage display mismatch")

group <- mc_group(
  id = "aux.mpu.estimator",
  kind = "worked_calculation",
  source_notebook = "notebooks/support/auxiliary-variables-and-stratification/support.Rmd",
  source_context = "unit test",
  values = list(value),
  target_snippet = "generated/worked-calculations/aux-mpu-estimator.tex"
)
assert_true(identical(group$schema_version, 1L), "schema version mismatch")
assert_true(identical(group$chapter_prefix, "aux"), "chapter prefix mismatch")
assert_true(identical(group$language_scope, "shared"), "default language scope mismatch")

expect_error(
  mc_value("bad.id", raw = 1, format = "integer"),
  "semantic manuscript calculation ID"
)

expect_error(
  mc_group(
    id = "aux.mpu.estimator",
    kind = "worked_calculation",
    source_notebook = "notebooks/support/auxiliary-variables-and-stratification/support.Rmd",
    source_context = "unit test",
    values = list(mc_value("reg.mpu.value", raw = 1, format = "integer"))
  ),
  "Value IDs must use group prefix"
)

rendered <- mc_render_template(
  c("Mean: {{mean_audit_value}}", "Total: {{aux.mpu.total_audit_value}}"),
  list(
    mc_value("aux.mpu.mean_audit_value", raw = 2160.5312, format = "number:2"),
    mc_value("aux.mpu.total_audit_value", raw = 864212.48, format = "number:2")
  )
)
assert_true(identical(rendered[[1]], "Mean: 2,160.53"), "role template rendering mismatch")
assert_true(identical(rendered[[2]], "Total: 864,212.48"), "ID template rendering mismatch")

expect_error(
  mc_render_template("Missing {{sample_size}}", list(value)),
  "Missing registered value"
)

message("Manuscript registry R helper tests passed.")
