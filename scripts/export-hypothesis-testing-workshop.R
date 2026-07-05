#!/usr/bin/env Rscript

source_file <- "notebooks/support/hypothesis-testing/support.Rmd"
output_dir <- "generated/workshop-output"
expected_chunks <- c(
  "4.1" = 3L,
  "4.2" = 1L,
  "4.3" = 1L,
  "4.4" = 1L,
  "4.5" = 3L,
  "4.6" = 3L,
  "4.7" = 3L,
  "4.8" = 7L,
  "4.9" = 1L,
  "4.10" = 2L
)

if (!requireNamespace("knitr", quietly = TRUE)) {
  stop("The knitr package is required to export the hypothesis-testing workshop.")
}

strip_support_only <- function(lines) {
  keep <- logical(length(lines))
  support_only <- FALSE
  for (i in seq_along(lines)) {
    if (identical(lines[[i]], "<!-- SUPPORT-ONLY:START -->")) {
      if (support_only) stop("Nested support-only block in ", source_file)
      support_only <- TRUE
    } else if (identical(lines[[i]], "<!-- SUPPORT-ONLY:END -->")) {
      if (!support_only) stop("Unmatched support-only end marker in ", source_file)
      support_only <- FALSE
    } else {
      keep[[i]] <- !support_only
    }
  }
  if (support_only) stop("Unclosed support-only block in ", source_file)
  lines[keep]
}

publishable <- strip_support_only(readLines(source_file, warn = FALSE))

extract_segments <- function(exercise) {
  exercise_pattern <- paste(strsplit(exercise, ".", fixed = TRUE)[[1L]], collapse = "\\.")
  heading <- grep(paste0("^### Exercise ", exercise_pattern, "\\.?(?: |$)"), publishable)
  next_heading <- grep("^### Exercise ", publishable)
  next_heading <- next_heading[next_heading > heading]

  if (length(heading) != 1L) {
    stop("Could not find Exercise ", exercise, " in ", source_file)
  }

  end <- if (length(next_heading)) next_heading[[1L]] - 1L else length(publishable)
  exercise_lines <- publishable[(heading + 1L):end]
  in_chunk <- FALSE
  chunk <- character()
  chunks <- list()
  prose <- list()
  pending_prose <- character()

  for (line in exercise_lines) {
    if (grepl("^```\\{r(?:[ ,}])", line)) {
      in_chunk <- TRUE
      prose[[length(chunks) + 1L]] <- pending_prose
      pending_prose <- character()
      chunk <- paste0(
        "```{r, echo=TRUE, results='markup', comment='', ",
        "fig.keep='none', message=FALSE, warning=FALSE, error=FALSE}"
      )
    } else if (in_chunk && identical(line, "```")) {
      in_chunk <- FALSE
      chunk[grepl("^options\\(width\\s*=", chunk)] <- "options(width = 65)"
      chunks[[length(chunks) + 1L]] <- c(chunk, line)
      chunk <- character()
    } else if (in_chunk) {
      chunk <- c(chunk, line)
    } else {
      pending_prose <- c(pending_prose, line)
    }
  }

  if (in_chunk || length(chunks) != expected_chunks[[exercise]]) {
    stop("Expected ", expected_chunks[[exercise]], " complete R chunks in Exercise ", exercise, ".")
  }
  prose[[length(chunks) + 1L]] <- pending_prose
  list(chunks = chunks, prose = prose)
}

escape_latex <- function(text) {
  text <- gsub("%", "\\%", text, fixed = TRUE)
  text <- gsub("&", "\\&", text, fixed = TRUE)
  text <- gsub("_", "\\_", text, fixed = TRUE)
  gsub("#", "\\#", text, fixed = TRUE)
}

convert_inline <- function(text) {
  pattern <- "`[^`]*`|\\$[^$]*\\$|\\*[^*]+\\*"
  matches <- gregexpr(pattern, text, perl = TRUE)[[1L]]
  if (identical(matches[[1L]], -1L)) return(escape_latex(text))

  lengths <- attr(matches, "match.length")
  result <- character()
  cursor <- 1L
  for (i in seq_along(matches)) {
    start <- matches[[i]]
    if (start > cursor) result <- c(result, escape_latex(substr(text, cursor, start - 1L)))
    token <- substr(text, start, start + lengths[[i]] - 1L)
    if (startsWith(token, "`")) {
      result <- c(result, paste0("\\ttblue{", escape_latex(substr(token, 2L, nchar(token) - 1L)), "}"))
    } else if (startsWith(token, "$")) {
      result <- c(result, token)
    } else {
      result <- c(result, paste0("\\emph{", escape_latex(substr(token, 2L, nchar(token) - 1L)), "}"))
    }
    cursor <- start + lengths[[i]]
  }
  if (cursor <= nchar(text)) result <- c(result, escape_latex(substr(text, cursor, nchar(text))))
  paste0(result, collapse = "")
}

markdown_to_latex <- function(lines) {
  in_display_math <- FALSE
  paragraph_start <- TRUE
  converted <- character(length(lines))
  for (i in seq_along(lines)) {
    trimmed <- trimws(lines[[i]])
    if (identical(trimmed, "$$") || identical(trimmed, "\\[") || identical(trimmed, "\\]")) {
      converted[[i]] <- lines[[i]]
      in_display_math <- !in_display_math
      if (!in_display_math) paragraph_start <- TRUE
    } else if (in_display_math || !nzchar(trimmed)) {
      converted[[i]] <- lines[[i]]
      if (!in_display_math && !nzchar(trimmed)) paragraph_start <- TRUE
    } else {
      converted[[i]] <- paste0(if (paragraph_start) "\\noindent " else "", convert_inline(lines[[i]]))
      paragraph_start <- FALSE
    }
  }
  converted
}

verbatim_hook <- function(color) {
  function(x, options) {
    text <- paste(x, collapse = "\n")
    text <- gsub("[[:blank:]]+(?=\\n|$)", "", text, perl = TRUE)
    if (!length(x) || !nzchar(text)) return("")
    paste0(
      "\\begin{Verbatim}[breaklines=true,formatcom=\\color{", color, "}]\n",
      text,
      if (grepl("\\n$", text)) "" else "\n",
      "\\end{Verbatim}\n"
    )
  }
}

old_hooks <- knitr::knit_hooks$get(c("source", "output"))
on.exit(knitr::knit_hooks$set(source = old_hooks$source, output = old_hooks$output), add = TRUE)
knitr::knit_hooks$set(
  source = verbatim_hook("ada_blue"),
  output = verbatim_hook("ada_light_blue")
)

dir.create(output_dir, recursive = TRUE, showWarnings = FALSE)

for (exercise in names(expected_chunks)) {
  segments <- extract_segments(exercise)
  chunks <- segments$chunks
  for (i in seq_along(chunks)) {
    options(width = 65)
    exercise_slug <- gsub("\\.", "-", exercise)
    output_file <- file.path(output_dir, sprintf("exercise-%s-%d.tex", exercise_slug, i))
    body <- sub("\\n+$", "", knitr::knit(text = chunks[[i]], quiet = TRUE))
    prose_before <- if (i == 1L) markdown_to_latex(segments$prose[[i]]) else character()
    prose_after <- markdown_to_latex(segments$prose[[i + 1L]])
    header <- c(
      "% -----------------------------------------------------------------------------",
      "% This file is automatically generated.",
      "% Do not edit manually.",
      paste0("% Source: ", source_file),
      "% -----------------------------------------------------------------------------",
      ""
    )
    compact_wrapper <- c(
      "\\par\\addvspace{\\topsep}",
      "\\begingroup",
      "\\fvset{listparameters={%",
      "  \\setlength{\\topsep}{0pt}%",
      "  \\setlength{\\partopsep}{0pt}%",
      "  \\setlength{\\parsep}{0pt}%",
      "  \\setlength{\\itemsep}{0pt}%",
      "}}",
      body,
      "\\endgroup",
      "\\par\\addvspace{\\topsep}"
    )
    generated <- c(header, prose_before, compact_wrapper, prose_after)
    while (length(generated) && !nzchar(generated[[length(generated)]])) {
      generated <- head(generated, -1L)
    }
    writeLines(generated, output_file, useBytes = TRUE)
    message("Generated ", output_file)
  }
}
