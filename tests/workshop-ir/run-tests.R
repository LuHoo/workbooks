#!/usr/bin/env Rscript

args <- commandArgs(trailingOnly = FALSE)
file_arg <- grep("^--file=", args, value = TRUE)
script_path <- sub("^--file=", "", file_arg[[1L]])
script_dir <- dirname(normalizePath(script_path, winslash = "/", mustWork = TRUE))
repo_root <- normalizePath(file.path(script_dir, "..", ".."), winslash = "/", mustWork = TRUE)
setwd(repo_root)

source("scripts/workshop-ir.R", chdir = FALSE)
source("scripts/workshop-ir-validate.R", chdir = FALSE)
source("scripts/export-workshop-output.R", chdir = FALSE)
source("scripts/workshop-ir-adapter.R", chdir = FALSE)

expect_true <- function(condition, message) {
  if (!isTRUE(condition)) {
    stop(message)
  }
}

expect_identical <- function(actual, expected, message) {
  if (!identical(actual, expected)) {
    stop(message)
  }
}

expect_error_pattern <- function(expr, pattern, message) {
  err <- NULL
  tryCatch(
    expr,
    error = function(e) {
      err <<- conditionMessage(e)
    }
  )
  if (is.null(err)) {
    stop(paste0(message, " (expected error but none was raised)"))
  }
  if (!grepl(pattern, err)) {
    stop(paste0(message, " (error was: ", err, ")"))
  }
}

summarize_ir_for_golden <- function(ir) {
  list(
    schema_version = ir$schema_version,
    chapter = ir$chapter,
    directives = ir$directives,
    chapter_blocks = lapply(ir$chapter_blocks, function(block) {
      list(
        block_type = block$block_type,
        support_only = block$support_only,
        source_span = block$source_span
      )
    }),
    exercises = lapply(ir$exercises, function(exercise) {
      list(
        exercise_ref = exercise$exercise_ref,
        ordinal = exercise$ordinal,
        source_span = exercise$source_span,
        blocks = lapply(exercise$blocks, function(block) {
          list(
            block_type = block$block_type,
            support_only = block$support_only,
            source_span = block$source_span,
            content = block$content
          )
        })
      )
    })
  )
}

run_golden_test <- function() {
  fixture <- "tests/workshop-ir/fixtures/minimal-valid-support.Rmd"
  golden_path <- "tests/workshop-ir/fixtures/golden-minimal-summary.json"

  ir <- parse_support_notebook_to_ir(
    input_path = fixture,
    workshop_id = "fixture-workshop"
  )
  summary <- summarize_ir_for_golden(ir)

  actual_json <- jsonlite::toJSON(summary, auto_unbox = TRUE, pretty = TRUE)
  golden_json <- paste(readLines(golden_path, warn = FALSE), collapse = "\n")

  if (!identical(jsonlite::minify(actual_json), jsonlite::minify(golden_json))) {
    actual_path <- tempfile("workshop-ir-golden-actual-", fileext = ".json")
    writeLines(actual_json, actual_path)
    stop(
      "Golden summary mismatch. Compare expected ", golden_path,
      " with actual ", actual_path
    )
  }
}

run_malformed_tests <- function() {
  expect_error_pattern(
    parse_support_notebook_to_ir("tests/workshop-ir/fixtures/malformed-unmatched-support-end.Rmd"),
    "IR-PARSE.*SUPPORT-ONLY:END",
    "Unmatched SUPPORT-ONLY end should fail with actionable parse error"
  )

  expect_error_pattern(
    parse_support_notebook_to_ir("tests/workshop-ir/fixtures/malformed-unclosed-fence.Rmd"),
    "IR-PARSE.*unclosed code fence",
    "Unclosed code fence should fail with actionable parse error"
  )

  expect_error_pattern(
    parse_support_notebook_to_ir("tests/workshop-ir/fixtures/malformed-duplicate-exercise.Rmd"),
    "IR-PARSE.*duplicate exercise reference",
    "Duplicate exercise refs should fail with actionable parse error"
  )
}

run_validation_tests <- function() {
  diagnostics <- validate_support_notebook_ir(
    input_path = "tests/workshop-ir/fixtures/minimal-valid-support.Rmd",
    strict = TRUE
  )
  expect_identical(length(diagnostics), 0L, "Valid fixture should have no validation diagnostics")
}

run_round_trip_consistency_test <- function() {
  config <- resolve_workshop_export_config_by_id("probability-distributions")
  source_file <- config$source

  source_lines <- read_source_lines(source_file)
  validate_supported_constructs(source_lines, source_file)
  publishable <- strip_support_only(source_lines, source_file)

  legacy_segments <- extract_exercise_segments(
    publishable,
    "1.1",
    config$expected_chunks[["1.1"]],
    source_file
  )

  ir_segments <- load_ir_segments(input_path = source_file, config = config)[["1.1"]]

  expect_identical(ir_segments, legacy_segments, "IR adapter segments must match legacy segments for exercise 1.1")
}

run_exporter_compatibility_test <- function() {
  source_file <- "notebooks/support/probability-distributions/support.Rmd"
  tmp_legacy <- tempfile("legacy-", fileext = "-exercise-1-1-1.tex")
  tmp_ir <- tempfile("ir-", fileext = "-exercise-1-1-1.tex")

  legacy_target <- file.path(dirname(tmp_legacy), "exercise-1-1-1.tex")
  ir_target <- file.path(dirname(tmp_ir), "exercise-1-1-1.tex")

  legacy_out <- system2(
    "Rscript",
    c("scripts/export-workshop-output.R", "--input", source_file, "--output", legacy_target, "--parser-engine", "legacy"),
    stdout = TRUE,
    stderr = TRUE
  )
  legacy_status <- attr(legacy_out, "status")
  if (!is.null(legacy_status) && legacy_status != 0L) {
    stop("Legacy exporter run failed: ", paste(legacy_out, collapse = "\n"))
  }

  ir_out <- system2(
    "Rscript",
    c("scripts/export-workshop-output.R", "--input", source_file, "--output", ir_target, "--parser-engine", "ir"),
    stdout = TRUE,
    stderr = TRUE
  )
  ir_status <- attr(ir_out, "status")
  if (!is.null(ir_status) && ir_status != 0L) {
    stop("IR exporter run failed: ", paste(ir_out, collapse = "\n"))
  }

  legacy_tex <- readLines(legacy_target, warn = FALSE)
  ir_tex <- readLines(ir_target, warn = FALSE)
  expect_identical(ir_tex, legacy_tex, "IR parser engine output must equal legacy output")
}

main <- function() {
  if (!requireNamespace("jsonlite", quietly = TRUE)) {
    stop("jsonlite is required for workshop IR tests")
  }

  run_golden_test()
  run_malformed_tests()
  run_validation_tests()
  run_round_trip_consistency_test()
  run_exporter_compatibility_test()

  cat("All workshop IR tests passed.\n")
}

main()
