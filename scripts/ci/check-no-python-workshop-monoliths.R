#!/usr/bin/env Rscript

wrapper_files <- list.files(
  "scripts",
  pattern = "^export-.*-workshop\\.R$",
  full.names = TRUE
)

allowed_files <- normalizePath(
  c("scripts/export-python-workshop-output.R"),
  winslash = "/",
  mustWork = FALSE
)

failures <- character()
for (path in wrapper_files) {
  norm_path <- normalizePath(path, winslash = "/", mustWork = FALSE)
  if (norm_path %in% allowed_files) {
    next
  }

  lines <- readLines(path, warn = FALSE)
  matches <- grep("--output.*workshop-output-python/workshop|workshop[0-9]+_Python\\.tex", lines)
  if (length(matches)) {
    failures <- c(
      failures,
      sprintf(
        "%s still appears to generate a monolithic Python workshop TeX file:\n  %s",
        path,
        paste(sprintf("%d: %s", matches, trimws(lines[matches])), collapse = "\n  ")
      )
    )
  }
}

if (length(failures)) {
  stop(
    paste(
      c("Monolithic Python workshop generation is not allowed in chapter wrappers:", failures),
      collapse = "\n\n"
    ),
    call. = FALSE
  )
}

message("No chapter wrapper generates monolithic Python workshop TeX files.")
