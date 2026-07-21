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
  fallback_output_dir = "generated/workshop-output",
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
  if (!is.null(fallback_output_dir) && nzchar(fallback_output_dir)) {
    args <- c(args, "--fallback-output-dir", fallback_output_dir)
  }

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

  export_python_workshop_tex_by_config(
    config = config,
    output_tex_path = output_tex_path,
    input_dir = input_dir,
    fallback_output_dir = fallback_output_dir,
    exporter_script = exporter_script
  )
}

generate_python_workshop_scaffold <- function(
  r_workshop_path,
  python_workshop_path,
  r_chunk_dir = "generated/workshop-output",
  python_chunk_dir = "generated/workshop-output-python"
) {
  if (!file.exists(r_workshop_path)) {
    stop("R workshop scaffold not found: ", r_workshop_path)
  }

  lines <- readLines(r_workshop_path, encoding = "UTF-8", warn = FALSE)

  pattern <- paste0("\\\\input\\{", gsub("/", "/", r_chunk_dir, fixed = TRUE), "/")
  replacement <- paste0("\\\\input{", python_chunk_dir, "/")
  lines <- gsub(pattern, replacement, lines, perl = FALSE)

  # Keep exercise headings with the next paragraph/input to avoid orphaned
  # bold titles at the bottom of a page.
  in_exercise <- FALSE
  adjusted <- character(0)
  for (line in lines) {
    trimmed <- trimws(line)
    if (identical(trimmed, "\\begin{exercise}")) {
      in_exercise <- TRUE
      adjusted <- c(adjusted, line)
      next
    }
    if (identical(trimmed, "\\end{exercise}")) {
      in_exercise <- FALSE
      adjusted <- c(adjusted, line)
      next
    }
    if (in_exercise && grepl("^\\\\textbf\\{", trimmed)) {
      adjusted <- c(
        adjusted,
        "\\Needspace{4\\baselineskip}",
        line,
        "\\nopagebreak[4]"
      )
      next
    }
    adjusted <- c(adjusted, line)
  }
  lines <- adjusted

  # Remove \label{...} entries to avoid multiply-defined label warnings
  # when both R and Python workshops are included in the same chapter.
  lines <- grep("^\\\\label\\{", lines, value = TRUE, invert = TRUE)

  header <- c(
    "% -----------------------------------------------------------------------------",
    "% This file is automatically generated from the R workshop scaffold.",
    paste0("% Source: ", r_workshop_path),
    "% Do not edit manually -- edit the R workshop scaffold instead.",
    "% -----------------------------------------------------------------------------",
    ""
  )

  writeLines(c(header, lines), python_workshop_path, useBytes = FALSE)
  message("Generated ", python_workshop_path, " from ", r_workshop_path)
  invisible(python_workshop_path)
}

sync_python_workshop_section_from_chapter <- function(
  chapter_tex_path,
  r_chunk_dir = "generated/workshop-output",
  python_chunk_dir = "generated/workshop-output-python"
) {
  if (!file.exists(chapter_tex_path)) {
    stop("Chapter file not found: ", chapter_tex_path)
  }

  lines <- readLines(chapter_tex_path, encoding = "UTF-8", warn = FALSE)

  r_start <- grep("^\\\\section\\{Workshop R\\}", lines)
  r_end <- grep("^% section workshop_ \\(end\\)$", lines)
  py_start <- grep("^\\\\section\\{Workshop Python\\}", lines)
  py_end <- grep("^% section workshop_python \\(end\\)$", lines)

  if (length(r_start) != 1L || length(r_end) != 1L) {
    stop("Could not uniquely identify Workshop R section boundaries in ", chapter_tex_path)
  }
  if (length(py_start) != 1L || length(py_end) != 1L) {
    stop("Could not uniquely identify Workshop Python section boundaries in ", chapter_tex_path)
  }
  if (r_start >= r_end) {
    stop("Invalid Workshop R section boundaries in ", chapter_tex_path)
  }
  if (py_start >= py_end) {
    stop("Invalid Workshop Python section boundaries in ", chapter_tex_path)
  }

  template <- lines[r_start:r_end]

  template <- gsub("\\\\section\\{Workshop R\\}", "\\\\section{Workshop Python}", template, fixed = FALSE)
  template <- gsub("^\\\\label\\{sec:workshop_([0-9]+)(?:_[Rr])?\\}$", "\\\\label{sec:workshop_\\1_python}", template, perl = TRUE)

  pattern <- paste0("\\\\input\\{", gsub("/", "/", r_chunk_dir, fixed = TRUE), "/")
  replacement <- paste0("\\\\input{", python_chunk_dir, "/")
  template <- gsub(pattern, replacement, template, perl = FALSE)

  template <- template[!grepl("^\\s*\\\\label\\{ex:", template)]

  in_exercise <- FALSE
  adjusted <- character(0)
  for (line in template) {
    trimmed <- trimws(line)
    if (identical(trimmed, "\\begin{exercise}")) {
      in_exercise <- TRUE
      adjusted <- c(adjusted, line)
      next
    }
    if (identical(trimmed, "\\end{exercise}")) {
      in_exercise <- FALSE
      adjusted <- c(adjusted, line)
      next
    }
    if (in_exercise && grepl("^\\\\textbf\\{", trimmed)) {
      adjusted <- c(
        adjusted,
        "\\Needspace{4\\baselineskip}",
        line,
        "\\nopagebreak[4]"
      )
      next
    }
    adjusted <- c(adjusted, line)
  }
  template <- adjusted

  template <- sub("^% section workshop_ \\(end\\)$", "% section workshop_python (end)", template)

  output <- c(lines[seq_len(py_start - 1L)], template)
  if (py_end < length(lines)) {
    output <- c(output, lines[(py_end + 1L):length(lines)])
  }

  writeLines(output, chapter_tex_path, useBytes = FALSE)
  message("Updated Python workshop section in ", chapter_tex_path)
  invisible(chapter_tex_path)
}
