#!/usr/bin/env Rscript

source("scripts/workshop-export-config.R", chdir = FALSE)

resolve_python_workshop_notebook <- function(config, input_dir = "generated/python-notebooks") {
  file.path(input_dir, config$id, paste0("chapter-", config$chapter, ".ipynb"))
}

encode_expected_chunks <- function(expected_chunks) {
  parts <- mapply(
    function(exercise, chunk_count) {
      paste0(exercise, ":", as.integer(chunk_count))
    },
    names(expected_chunks),
    as.integer(expected_chunks),
    SIMPLIFY = TRUE,
    USE.NAMES = FALSE
  )
  paste(parts, collapse = ",")
}

resolve_python_bin <- function() {
  python_bin <- Sys.which("python3")
  if (!nzchar(python_bin)) {
    python_bin <- Sys.which("python")
  }
  if (!nzchar(python_bin)) {
    stop("Python executable not found. Install python3 or add python to PATH.")
  }
  python_bin
}

export_python_workshop_chunks_by_config <- function(
  config,
  input_dir = "generated/python-notebooks",
  output_dir = "generated/workshop-output-python",
  fallback_output_dir = "generated/workshop-output",
  exporter_script = "scripts/export-python-workshop.py"
) {
  if (is.null(config) || is.null(config$id) || is.null(config$expected_chunks)) {
    stop("Invalid workshop export configuration supplied.")
  }

  notebook_path <- resolve_python_workshop_notebook(config, input_dir = input_dir)
  if (!file.exists(notebook_path)) {
    stop(
      "Missing generated Python notebook for config ", config$id,
      ": expected ", notebook_path,
      ". Run scripts/export-python-notebooks.R first."
    )
  }

  expected_chunks <- encode_expected_chunks(config$expected_chunks)
  python_bin <- resolve_python_bin()

  args <- c(
    exporter_script,
    "--input", notebook_path,
    "--chunk-output-dir", output_dir,
    "--expected-chunks", expected_chunks,
    "--expect-generated-metadata"
  )
  if (!is.null(fallback_output_dir) && nzchar(fallback_output_dir)) {
    args <- c(args, "--fallback-output-dir", fallback_output_dir)
  }

  status <- system2(python_bin, args)
  if (!identical(status, 0L)) {
    stop("Failed to export Python workshop chunks for config ", config$id)
  }

  invisible(TRUE)
}

export_python_workshop_tex_by_config <- function(
  config,
  output_tex_path,
  input_dir = "generated/python-notebooks",
  exporter_script = "scripts/export-python-workshop.py"
) {
  if (is.null(config) || is.null(config$id)) {
    stop("Invalid workshop export configuration supplied.")
  }

  notebook_path <- resolve_python_workshop_notebook(config, input_dir = input_dir)
  if (!file.exists(notebook_path)) {
    stop(
      "Missing generated Python notebook for config ", config$id,
      ": expected ", notebook_path,
      ". Run scripts/export-python-notebooks.R first."
    )
  }

  python_bin <- resolve_python_bin()
  args <- c(
    exporter_script,
    "--input", notebook_path,
    "--output", output_tex_path,
    "--expect-generated-metadata"
  )

  status <- system2(python_bin, args)
  if (!identical(status, 0L)) {
    stop("Failed to export Python workshop TeX for config ", config$id)
  }

  invisible(TRUE)
}

export_python_workshop_chunks_by_config_id <- function(
  config_id,
  input_dir = "generated/python-notebooks",
  output_dir = "generated/workshop-output-python",
  fallback_output_dir = "generated/workshop-output",
  exporter_script = "scripts/export-python-workshop.py"
) {
  config <- resolve_workshop_export_config_by_id(config_id)
  if (is.null(config)) {
    stop(
      "Unsupported workshop config id: ", config_id,
      ". Add it to metadata/workshop-registry.R."
    )
  }

  export_python_workshop_chunks_by_config(
    config = config,
    input_dir = input_dir,
    output_dir = output_dir,
    fallback_output_dir = fallback_output_dir,
    exporter_script = exporter_script
  )
}

export_python_workshop_tex_by_config_id <- function(
  config_id,
  output_tex_path,
  input_dir = "generated/python-notebooks",
  exporter_script = "scripts/export-python-workshop.py"
) {
  config <- resolve_workshop_export_config_by_id(config_id)
  if (is.null(config)) {
    stop(
      "Unsupported workshop config id: ", config_id,
      ". Add it to metadata/workshop-registry.R."
    )
  }

  export_python_workshop_tex_by_config(
    config = config,
    output_tex_path = output_tex_path,
    input_dir = input_dir,
    exporter_script = exporter_script
  )
}
