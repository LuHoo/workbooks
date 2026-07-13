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
source("scripts/workshop-model.R", chdir = FALSE)
source("scripts/workshop-renderer-latex.R", chdir = FALSE)
source("scripts/workshop-renderer.R", chdir = FALSE)

notebooks <- get_notebook_manifest()

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

expect_contains <- function(values, expected, message) {
  if (!expected %in% values) {
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

extract_python_override_lines <- function(lines) {
  in_python_override <- FALSE
  collected <- character()

  for (line in lines) {
    trimmed <- trimws(line)
    if (grepl("^<!--\\s*ADA:BEGIN\\b", trimmed)) {
      in_python_override <- grepl("\\blang=python\\b", trimmed)
      next
    }
    if (grepl("^<!--\\s*ADA:END\\s*-->$", trimmed)) {
      in_python_override <- FALSE
      next
    }
    if (!in_python_override) {
      next
    }

    if (identical(trimmed, "```{r}") || identical(trimmed, "```")) {
      next
    }

    if (nzchar(trimmed)) {
      collected <- c(collected, trimmed)
    }
  }

  unique(collected)
}

extract_python_signature_lines <- function(lines) {
  override_lines <- extract_python_override_lines(lines)
  Filter(
    function(line) {
      grepl(
        "ada_set_context\\(|\\batt_sample\\(|\\bhypergeom\\.|\\bnorm\\.|\\bt\\.|\\bf\\.|\\.[A-Za-z_][A-Za-z0-9_]*\\(|\\.[A-Za-z_][A-Za-z0-9_]*$",
        line
      )
    },
    override_lines
  )
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

  expect_error_pattern(
    parse_support_notebook_to_ir("tests/workshop-ir/fixtures/malformed-directive-unclosed-begin.Rmd"),
    "IR-PARSE.*unclosed ADA directive region",
    "Unclosed ADA directive should fail with actionable parse error"
  )

  expect_error_pattern(
    parse_support_notebook_to_ir("tests/workshop-ir/fixtures/malformed-directive-nested-begin.Rmd"),
    "IR-PARSE.*nested ADA directive region",
    "Nested ADA directives should fail with actionable parse error"
  )

  expect_error_pattern(
    parse_support_notebook_to_ir("tests/workshop-ir/fixtures/malformed-directive-dangling-requires.Rmd"),
    "IR-PARSE.*capability annotation is not attached to a following code block",
    "Dangling ADA:REQUIRES should fail with actionable parse error"
  )
}

run_validation_tests <- function() {
  diagnostics <- validate_support_notebook_ir(
    input_path = "tests/workshop-ir/fixtures/minimal-valid-support.Rmd",
    strict = TRUE
  )
  expect_identical(length(diagnostics), 0L, "Valid fixture should have no validation diagnostics")
}

run_directive_parser_tests <- function() {
  ir <- parse_support_notebook_to_ir(
    input_path = "tests/workshop-ir/fixtures/directive-valid-support.Rmd",
    workshop_id = "fixture-workshop"
  )

  expect_contains(ir$directives$observed, "ADA:BEGIN", "Directive fixture should observe ADA:BEGIN")
  expect_contains(ir$directives$observed, "ADA:END", "Directive fixture should observe ADA:END")
  expect_contains(ir$directives$observed, "ADA:REQUIRES", "Directive fixture should observe ADA:REQUIRES")
  expect_identical(length(ir$directives$instances), 5L, "Directive fixture should emit directive instances")

  blocks <- ir$exercises[[1L]]$blocks
  expect_identical(blocks[[3L]]$authoring_context$mode, "override", "Narrative override block should have override mode")
  expect_identical(blocks[[3L]]$authoring_context$lang_scope, "python", "Narrative override block should be python scoped")
  expect_identical(
    blocks[[3L]]$authoring_context$override_target_block_id,
    blocks[[1L]]$block_id,
    "Narrative override should target prior shared narrative block"
  )
  expect_identical(
    blocks[[4L]]$authoring_context$override_target_block_id,
    blocks[[2L]]$block_id,
    "Code override should target prior shared code block"
  )
  expect_identical(
    blocks[[5L]]$authoring_context$requires,
    "fsaudit",
    "ADA:REQUIRES should be attached to following code block"
  )
}

run_directive_validation_tests <- function() {
  diagnostics <- validate_support_notebook_ir(
    input_path = "tests/workshop-ir/fixtures/directive-valid-support.Rmd",
    strict = TRUE
  )
  expect_identical(length(diagnostics), 0L, "Directive fixture should have no validation diagnostics")

  ir_dup <- parse_support_notebook_to_ir("tests/workshop-ir/fixtures/directive-valid-support.Rmd")
  ir_dup$exercises[[1L]]$blocks[[4L]]$authoring_context$override_target_block_id <-
    ir_dup$exercises[[1L]]$blocks[[3L]]$authoring_context$override_target_block_id
  dup_diags <- validate_workshop_ir(ir_dup, source_path = "directive-valid-support.Rmd", strict = FALSE)
  dup_codes <- vapply(dup_diags, function(diag) diag$code, character(1L))
  expect_contains(dup_codes, "E241", "Duplicate override target/language should produce E241")

  ir_only_shared <- parse_support_notebook_to_ir("tests/workshop-ir/fixtures/directive-valid-support.Rmd")
  ir_only_shared$exercises[[1L]]$blocks[[5L]]$authoring_context$mode <- "only"
  ir_only_shared$exercises[[1L]]$blocks[[5L]]$authoring_context$lang_scope <- "shared"
  only_shared_diags <- validate_workshop_ir(ir_only_shared, source_path = "directive-valid-support.Rmd", strict = FALSE)
  only_shared_codes <- vapply(only_shared_diags, function(diag) diag$code, character(1L))
  expect_contains(only_shared_codes, "E242", "mode=only with shared lang_scope should produce E242")

  ir_bad_cap <- parse_support_notebook_to_ir("tests/workshop-ir/fixtures/directive-valid-support.Rmd")
  ir_bad_cap$exercises[[1L]]$blocks[[5L]]$authoring_context$requires <- c("badcap")
  bad_cap_diags <- validate_workshop_ir(ir_bad_cap, source_path = "directive-valid-support.Rmd", strict = FALSE)
  bad_cap_codes <- vapply(bad_cap_diags, function(diag) diag$code, character(1L))
  expect_contains(bad_cap_codes, "E244", "Unsupported capability should produce E244")
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

run_default_parser_cutover_test <- function() {
  parsed <- parse_export_cli_args(character())
  expect_identical(parsed$parser_engine, "ir", "CLI parser_engine default must be ir")

  cfg_default <- eval(formals(export_workshop_by_config)$parser_engine)
  expect_identical(cfg_default, "ir", "export_workshop_by_config default parser_engine must be ir")

  cfg_id_default <- eval(formals(export_workshop_by_config_id)$parser_engine)
  expect_identical(cfg_id_default, "ir", "export_workshop_by_config_id default parser_engine must be ir")
}

run_full_export_set_equivalence_test <- function() {
  default_dir <- tempfile("default-workshop-output-")
  ir_dir <- tempfile("ir-workshop-output-")
  dir.create(default_dir, recursive = TRUE, showWarnings = FALSE)
  dir.create(ir_dir, recursive = TRUE, showWarnings = FALSE)

  runner_script <- tempfile("workshop-export-set-", fileext = ".R")
  writeLines(c(
    "args <- commandArgs(trailingOnly = TRUE)",
    "out_dir <- args[[1L]]",
    "engine <- args[[2L]]",
    "source('scripts/export-workshop-output.R', chdir = FALSE)",
    "configs <- get_workshop_export_configs()",
    "for (config in configs) {",
    "  if (identical(engine, 'default')) {",
    "    export_workshop_by_config(config = config, output_dir = out_dir, enable_traceability = FALSE)",
    "  } else {",
    "    export_workshop_by_config(config = config, output_dir = out_dir, parser_engine = engine, enable_traceability = FALSE)",
    "  }",
    "}"
  ), runner_script)

  default_run <- system2("Rscript", c(runner_script, default_dir, "default"), stdout = TRUE, stderr = TRUE)
  default_status <- attr(default_run, "status")
  if (!is.null(default_status) && default_status != 0L) {
    stop("Default export-set run failed: ", paste(default_run, collapse = "\n"))
  }

  ir_run <- system2("Rscript", c(runner_script, ir_dir, "ir"), stdout = TRUE, stderr = TRUE)
  ir_status <- attr(ir_run, "status")
  if (!is.null(ir_status) && ir_status != 0L) {
    stop("Explicit IR export-set run failed: ", paste(ir_run, collapse = "\n"))
  }

  legacy_files <- sort(list.files(default_dir, pattern = "\\.tex$", recursive = TRUE, full.names = FALSE))
  ir_files <- sort(list.files(ir_dir, pattern = "\\.tex$", recursive = TRUE, full.names = FALSE))
  expect_identical(ir_files, legacy_files, "Default and explicit IR export sets must produce identical file lists")

  for (rel_path in legacy_files) {
    legacy_lines <- readLines(file.path(default_dir, rel_path), warn = FALSE)
    ir_lines <- readLines(file.path(ir_dir, rel_path), warn = FALSE)
    expect_identical(ir_lines, legacy_lines, paste0("Default-vs-IR output drift detected for ", rel_path))
  }
}

run_workshop_model_boundary_test <- function() {
  config <- resolve_workshop_export_config_by_id("probability-distributions")
  model <- build_workshop_model(input_path = config$source, config = config, strict = TRUE)

  expect_identical(class(model), "workshop_model", "Expected workshop_model class")
  expect_identical(model$schema_version, WORKSHOP_IR_SCHEMA_VERSION, "Workshop model schema version mismatch")
  expect_true(length(model$exercises) > 0L, "Workshop model should include exercises")

  first_exercise <- model$exercises[[1L]]
  expect_true(!is.null(first_exercise$blocks), "Workshop model exercise should include blocks")
}

run_renderer_boundary_test <- function() {
  config <- resolve_workshop_export_config_by_id("probability-distributions")
  model <- build_workshop_model(input_path = config$source, config = config, strict = TRUE)
  all_segments <- build_all_segments_from_ir(ir = model$ir, config = config, source_file = config$source)

  renderer <- create_workshop_renderer("latex")
  rendered_lines <- render_workshop_chunk(
    renderer = renderer,
    all_segments = all_segments,
    config = config,
    target_exercise = "1.1",
    target_chunk_index = 1L
  )

  tmp_rendered <- tempfile("rendered-latex-", fileext = ".tex")
  writeLines(rendered_lines, tmp_rendered, useBytes = TRUE)
  rendered_lines <- readLines(tmp_rendered, warn = FALSE)

  tmp_expected <- tempfile("expected-latex-", fileext = "-exercise-1-1-1.tex")
  expected_target <- file.path(dirname(tmp_expected), "exercise-1-1-1.tex")
  export_out <- system2(
    "Rscript",
    c(
      "scripts/export-workshop-output.R",
      "--input", config$source,
      "--output", expected_target,
      "--parser-engine", "ir"
    ),
    stdout = TRUE,
    stderr = TRUE
  )
  export_status <- attr(export_out, "status")
  if (!is.null(export_status) && export_status != 0L) {
    stop("Renderer boundary expectation export failed: ", paste(export_out, collapse = "\n"))
  }

  expected_lines <- readLines(expected_target, warn = FALSE)
  expect_identical(rendered_lines, expected_lines, "Renderer boundary output must match exporter output")
}

run_workshop_publication_filter_test <- function() {
  output_dir <- tempfile("workshop-publication-")
  dir.create(output_dir, recursive = TRUE, showWarnings = FALSE)

  export_out <- system2(
    "Rscript",
    c(
      "scripts/export-workshops.R",
      "--output-dir", output_dir,
      "--slug", "auxiliary-variables-and-stratification",
      "--slug", "hypothesis-testing"
    ),
    stdout = TRUE,
    stderr = TRUE
  )
  export_status <- attr(export_out, "status")
  if (!is.null(export_status) && export_status != 0L) {
    stop("Workshop publication export failed: ", paste(export_out, collapse = "\n"))
  }

  target_slugs <- c("auxiliary-variables-and-stratification", "hypothesis-testing")
  target_notebooks <- Filter(function(notebook) notebook$slug %in% target_slugs, notebooks)

  for (notebook in target_notebooks) {
    generated_path <- file.path(output_dir, basename(notebook$output))
    expect_true(file.exists(generated_path), paste0("Expected generated output: ", generated_path))

    generated_lines <- readLines(generated_path, warn = FALSE)
    expect_true(
      !any(grepl("ADA:BEGIN lang=python", generated_lines, fixed = TRUE)),
      paste0("Published Rmd leaked ADA:BEGIN lang=python in ", generated_path)
    )
    expect_true(
      !any(grepl("ADA:END", generated_lines, fixed = TRUE)),
      paste0("Published Rmd leaked ADA:END in ", generated_path)
    )
    expect_true(
      any(grepl("^```\\{r", generated_lines)),
      paste0("Expected executable R chunks in generated workshop ", generated_path)
    )

    source_lines <- readLines(notebook$source, warn = FALSE)
    python_override_lines <- extract_python_signature_lines(source_lines)
    leaked_lines <- Filter(
      function(py_line) any(grepl(py_line, generated_lines, fixed = TRUE)),
      python_override_lines
    )
    expect_identical(
      length(leaked_lines),
      0L,
      paste0(
        "Published Rmd leaked python override statements in ", generated_path,
        ": ", paste(leaked_lines, collapse = " | ")
      )
    )
  }
}

run_python_export_override_smoke_test <- function() {
  output_dir <- tempfile("python-notebooks-")
  dir.create(output_dir, recursive = TRUE, showWarnings = FALSE)

  render_out <- system2(
    "Rscript",
    c(
      "scripts/export-python-notebooks.R",
      "--config-id", "hypothesis-testing",
      "--output-dir", output_dir
    ),
    stdout = TRUE,
    stderr = TRUE
  )
  render_status <- attr(render_out, "status")
  if (!is.null(render_status) && render_status != 0L) {
    stop("Python notebook export failed: ", paste(render_out, collapse = "\n"))
  }

  notebook_path <- file.path(output_dir, "hypothesis-testing", "chapter-4.ipynb")
  expect_true(file.exists(notebook_path), paste0("Expected generated notebook: ", notebook_path))

  notebook_text <- paste(readLines(notebook_path, warn = FALSE), collapse = "\n")
  expect_true(
    grepl("att_sample\\(", notebook_text),
    "Generated Python notebook lost expected python override call att_sample(...)"
  )
  expect_true(
    grepl("ada_set_context", notebook_text),
    "Generated Python notebook lost expected python override context bootstrap"
  )
}

main <- function() {
  if (!requireNamespace("jsonlite", quietly = TRUE)) {
    stop("jsonlite is required for workshop IR tests")
  }

  run_golden_test()
  run_malformed_tests()
  run_validation_tests()
  run_directive_parser_tests()
  run_directive_validation_tests()
  run_round_trip_consistency_test()
  run_default_parser_cutover_test()
  run_exporter_compatibility_test()
  run_full_export_set_equivalence_test()
  run_workshop_model_boundary_test()
  run_renderer_boundary_test()
  run_workshop_publication_filter_test()
  run_python_export_override_smoke_test()

  cat("All workshop IR tests passed.\n")
}

main()
