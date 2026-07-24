#!/usr/bin/env Rscript

source("scripts/workshop-export-config.R", chdir = FALSE)

chapter_tex_files <- c(
  "probability-distributions" = "probability-distributions.tex",
  "population-estimation" = "estimation.tex",
  "auxiliary-variables-and-stratification" = "auxiliary.tex",
  "hypothesis-testing" = "hypothesis-testing.tex",
  "regression-analysis" = "regression-analysis.tex",
  "goodness-of-fit" = "goodness-of-fit.tex"
)

r_chunk_dir <- "generated/workshop-output"
python_chunk_dir <- "generated/workshop-output-python"
failures <- character()

expected_chunk_stems <- function(config) {
  unlist(
    mapply(
      function(exercise, count) {
        sprintf(
          "exercise-%s-%s",
          gsub("\\.", "-", exercise),
          seq_len(as.integer(count))
        )
      },
      names(config$expected_chunks),
      as.integer(config$expected_chunks),
      SIMPLIFY = FALSE,
      USE.NAMES = FALSE
    ),
    use.names = FALSE
  )
}

read_tex <- function(path) {
  paste(readLines(path, warn = FALSE), collapse = "\n")
}

tex_files_with_generated_chunks <- character()

for (config in get_workshop_export_configs()) {
  tex_path <- unname(chapter_tex_files[[config$id]])
  if (is.na(tex_path) || !file.exists(tex_path)) {
    failures <- c(failures, sprintf("%s: missing chapter TeX file", config$id))
    next
  }

  chunk_stems <- expected_chunk_stems(config)
  r_chunk_files <- file.path(r_chunk_dir, paste0(chunk_stems, ".tex"))
  python_chunk_files <- file.path(python_chunk_dir, paste0(chunk_stems, ".tex"))
  existing_r_chunk_stems <- chunk_stems[file.exists(r_chunk_files)]

  if (!length(existing_r_chunk_stems)) {
    next
  }

  tex_files_with_generated_chunks <- c(tex_files_with_generated_chunks, tex_path)

  tex <- read_tex(tex_path)
  expected_r_inputs <- sprintf(
    "\\input{%s/%s}",
    r_chunk_dir,
    existing_r_chunk_stems
  )
  missing_r_inputs <- expected_r_inputs[!vapply(
    expected_r_inputs,
    grepl,
    logical(1),
    x = tex,
    fixed = TRUE
  )]

  if (length(missing_r_inputs)) {
    failures <- c(
      failures,
      sprintf(
        "%s: missing R chunk inputs in %s:\n  %s",
        config$id,
        tex_path,
        paste(missing_r_inputs, collapse = "\n  ")
      )
    )
  }

  missing_python_chunks <- python_chunk_files[
    chunk_stems %in% existing_r_chunk_stems & !file.exists(python_chunk_files)
  ]
  if (length(missing_python_chunks)) {
    failures <- c(
      failures,
      sprintf(
        "%s: missing generated Python chunk file(s) for existing R chunk(s):\n  %s",
        config$id,
        paste(missing_python_chunks, collapse = "\n  ")
      )
    )
  }

  expected_inputs <- sprintf(
    "\\input{%s/%s}",
    python_chunk_dir,
    existing_r_chunk_stems
  )
  missing_inputs <- expected_inputs[!vapply(
    expected_inputs,
    grepl,
    logical(1),
    x = tex,
    fixed = TRUE
  )]

  if (length(missing_inputs)) {
    failures <- c(
      failures,
      sprintf(
        "%s: missing Python chunk inputs in %s:\n  %s",
        config$id,
        tex_path,
        paste(missing_inputs, collapse = "\n  ")
      )
    )
  }
}

for (tex_path in unique(tex_files_with_generated_chunks)) {
  tex <- readLines(tex_path, warn = FALSE)
  stale_lines <- grep("\\\\input\\{workshop[0-9]+_Python\\}", tex, value = TRUE)
  if (length(stale_lines)) {
    failures <- c(
      failures,
      sprintf(
        "%s: stale monolithic Python workshop input(s):\n  %s",
        tex_path,
        paste(trimws(stale_lines), collapse = "\n  ")
      )
    )
  }
}

if (length(failures)) {
  stop(
    paste(
      c("Generated Python workshop include check failed:", failures),
      collapse = "\n\n"
    ),
    call. = FALSE
  )
}

all_tex_files <- list.files(pattern = "\\.tex$", recursive = FALSE)
generated_input_pattern <- "\\\\input\\{(generated/workshop-output(?:-python)?/[^}]+)\\}"

for (tex_path in all_tex_files) {
  tex <- readLines(tex_path, warn = FALSE)
  matches <- regmatches(tex, gregexpr(generated_input_pattern, tex, perl = TRUE))
  inputs <- unlist(matches, use.names = FALSE)

  if (!length(inputs)) {
    next
  }

  input_paths <- sub(generated_input_pattern, "\\1", inputs, perl = TRUE)
  input_paths <- ifelse(grepl("\\.tex$", input_paths), input_paths, paste0(input_paths, ".tex"))
  missing_paths <- unique(input_paths[!file.exists(input_paths)])

  if (length(missing_paths)) {
    failures <- c(
      failures,
      sprintf(
        "%s: generated workshop input(s) point to missing file(s):\n  %s",
        tex_path,
        paste(missing_paths, collapse = "\n  ")
      )
    )
  }
}

if (length(failures)) {
  stop(
    paste(
      c("Generated workshop include check failed:", failures),
      collapse = "\n\n"
    ),
    call. = FALSE
  )
}

message("Generated workshop includes are up to date.")
