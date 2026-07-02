#!/usr/bin/env Rscript

source_file <- "notebooks/regression-analysis/regression-analysis.Rmd"
output_file <- "notebooks/workshops/Regression analysis workshop.Rmd"

lines <- readLines(source_file, warn = FALSE)

start_marker <- "<!-- SUPPORT-ONLY:START -->"
end_marker <- "<!-- SUPPORT-ONLY:END -->"
keep <- logical(length(lines))
support_only <- FALSE

for (i in seq_along(lines)) {
  if (identical(lines[[i]], start_marker)) {
    support_only <- TRUE
    next
  }
  if (identical(lines[[i]], end_marker)) {
    support_only <- FALSE
    next
  }
  keep[[i]] <- !support_only
}

if (support_only) {
  stop("Unclosed support-only block in ", source_file)
}

lines <- lines[keep]

yaml_delimiters <- which(lines == "---")
if (length(yaml_delimiters) < 2L || yaml_delimiters[[1]] != 1L) {
  stop("Expected a YAML header in ", source_file)
}

body <- lines[-seq_len(yaml_delimiters[[2]])]
while (length(body) > 0L && identical(tail(body, 1L), "")) {
  body <- head(body, -1L)
}
header <- c(
  "---",
  "title: \"Workshop Chapter 5: Regression analysis\"",
  "author: \"Lucas Hoogduin\"",
  "date: \"`r Sys.Date()`\"",
  "output:",
  "  html_document:",
  "    df_print: paged",
  "---",
  "",
  "<!-- GENERATED FILE: edit notebooks/regression-analysis/regression-analysis.Rmd in the private ada repository. -->",
  ""
)

dir.create(dirname(output_file), recursive = TRUE, showWarnings = FALSE)
writeLines(c(header, body), output_file, useBytes = TRUE)

message("Generated ", output_file, " from ", source_file)
