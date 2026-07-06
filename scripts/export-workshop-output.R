#!/usr/bin/env Rscript

source("scripts/workshop-export-config.R", chdir = FALSE)

# Static-analysis hint: function is provided by sourced config script.
resolve_workshop_export_config <- get("resolve_workshop_export_config", mode = "function")

ensure_dependencies <- function() {
  if (!requireNamespace("knitr", quietly = TRUE)) {
    stop("The knitr package is required to export workshop output.")
  }
}

parse_cli_args <- function(args) {
  out <- list(input = NULL, output = NULL)
  i <- 1L
  while (i <= length(args)) {
    arg <- args[[i]]
    if (identical(arg, "--input")) {
      i <- i + 1L
      if (i > length(args)) stop("Missing value after --input")
      out$input <- args[[i]]
    } else if (identical(arg, "--output")) {
      i <- i + 1L
      if (i > length(args)) stop("Missing value after --output")
      out$output <- args[[i]]
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
    "  Rscript scripts/export-workshop-output.R --input <support.Rmd> --output <output.tex>\n\n",
    "Example:\n",
    "  Rscript scripts/export-workshop-output.R \\\n",
    "    --input notebooks/support/probability-distributions/support.Rmd \\\n",
    "    --output generated/workshop-output/exercise-1-1-1.tex\n",
    sep = ""
  )
}

normalize_marker <- function(line) {
  trimws(line)
}

# Stage 1: Read source.
read_source_lines <- function(input_path) {
  if (!file.exists(input_path)) stop("Input file does not exist: ", input_path)
  readLines(input_path, warn = FALSE)
}

# Stage 2: Parse workshop structure + Stage 3: Process support-only blocks.
strip_support_only <- function(lines, source_file) {
  keep <- logical(length(lines))
  support_only <- FALSE
  for (i in seq_along(lines)) {
    line <- normalize_marker(lines[[i]])
    if (identical(line, "<!-- SUPPORT-ONLY:START -->")) {
      if (support_only) stop("Nested support-only block in ", source_file, " at line ", i)
      support_only <- TRUE
      next
    }
    if (identical(line, "<!-- SUPPORT-ONLY:END -->")) {
      if (!support_only) stop("Unmatched support-only end marker in ", source_file, " at line ", i)
      support_only <- FALSE
      next
    }
    keep[[i]] <- !support_only
  }
  if (support_only) stop("Unclosed support-only block in ", source_file)
  lines[keep]
}

validate_supported_constructs <- function(lines, source_file) {
  for (i in seq_along(lines)) {
    line <- lines[[i]]
    if (grepl("^```\\{[^r]", line)) {
      stop(
        "Unsupported code fence in ", source_file,
        " at line ", i,
        ": only R chunks are supported in workshop export."
      )
    }
  }
}

find_heading_line <- function(lines, exercise) {
  pattern <- paste0("^##+ Exercise ", gsub("\\.", "\\\\.", exercise), "(\\.| |$)")
  heading <- grep(pattern, lines)
  if (length(heading) != 1L) {
    stop("Could not find unique Exercise ", exercise)
  }
  heading[[1L]]
}

extract_exercise_segments <- function(lines, exercise, expected_chunk_count, source_file) {
  heading <- find_heading_line(lines, exercise)
  next_heading <- grep("^##+ Exercise ", lines)
  next_heading <- next_heading[next_heading > heading]
  end <- if (length(next_heading)) next_heading[[1L]] - 1L else length(lines)
  exercise_lines <- lines[(heading + 1L):end]

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

  if (in_chunk) {
    stop("Unclosed R chunk in Exercise ", exercise, " of ", source_file)
  }
  if (length(chunks) != expected_chunk_count) {
    stop(
      "Expected ", expected_chunk_count,
      " complete R chunks in Exercise ", exercise,
      " but found ", length(chunks),
      " in ", source_file
    )
  }
  prose[[length(chunks) + 1L]] <- pending_prose
  list(chunks = chunks, prose = prose)
}

# Stage 4: Transform R code and output.
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

render_r_chunk_to_latex <- function(chunk_lines, envir) {
  old_hooks <- knitr::knit_hooks$get(c("source", "output"))
  on.exit(knitr::knit_hooks$set(source = old_hooks$source, output = old_hooks$output), add = TRUE)
  knitr::knit_hooks$set(
    source = verbatim_hook("ada_blue"),
    output = verbatim_hook("ada_light_blue")
  )

  options(width = 65)
  body <- knitr::knit(text = chunk_lines, quiet = TRUE, envir = envir)
  sub("\\n+$", "", body)
}

# Stage 5: Transform Markdown/LaTeX.
escape_latex <- function(text) {
  text <- gsub("\\\\%", "%", text)
  text <- gsub("%", paste0(intToUtf8(92L), "%"), text, fixed = TRUE)
  text <- gsub("&", "\\\\&", text, fixed = TRUE)
  text <- gsub("_", "\\\\_", text, fixed = TRUE)
  gsub("#", "\\\\#", text, fixed = TRUE)
}

evaluate_inline_r <- function(text, inline_env, source_file) {
  inline_r <- gregexpr("`r [^`]+`", text, perl = TRUE)[[1L]]
  while (!identical(inline_r[[1L]], -1L)) {
    token_length <- attr(inline_r, "match.length")[[1L]]
    token <- substr(text, inline_r[[1L]], inline_r[[1L]] + token_length - 1L)
    expression <- substr(token, 4L, nchar(token) - 1L)
    value <- tryCatch(
      paste(eval(parse(text = expression), envir = inline_env), collapse = " "),
      error = function(e) {
        stop(
          "Failed to evaluate inline R expression '", expression,
          "' in ", source_file, ": ", conditionMessage(e)
        )
      }
    )
    text <- sub("`r [^`]+`", value, text, perl = TRUE)
    inline_r <- gregexpr("`r [^`]+`", text, perl = TRUE)[[1L]]
  }
  text
}

convert_inline <- function(text, inline_env, source_file) {
  text <- evaluate_inline_r(text, inline_env, source_file)
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

markdown_to_latex <- function(lines, inline_env, source_file) {
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
      converted[[i]] <- if (nzchar(trimmed)) lines[[i]] else ""
      if (!in_display_math && !nzchar(trimmed)) paragraph_start <- TRUE
    } else {
      converted[[i]] <- paste0(
        if (paragraph_start) "\\noindent " else "",
        convert_inline(lines[[i]], inline_env, source_file)
      )
      paragraph_start <- FALSE
    }
  }
  converted
}

prepare_chunk_environment <- function(all_segments, config, target_exercise, target_chunk_index) {
  env <- .GlobalEnv

  for (exercise in names(config$expected_chunks)) {
    segments <- all_segments[[exercise]]
    if (is.null(segments)) {
      stop("Missing parsed segments for configured exercise ", exercise)
    }
    chunk_count <- length(segments$chunks)
    max_chunk <- chunk_count
    if (identical(exercise, target_exercise)) {
      max_chunk <- target_chunk_index - 1L
    }

    if (max_chunk >= 1L) {
      for (i in seq_len(max_chunk)) {
        knitr::knit(text = segments$chunks[[i]], quiet = TRUE, envir = env)
      }
    }

    if (identical(exercise, target_exercise)) {
      break
    }
  }

  env
}

# Stage 6: Apply spacing and formatting rules.
compose_tex_document <- function(source_file, prose_before, body, prose_after) {
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
  generated
}

# Stage 7: Validate generated output.
validate_generated_output <- function(lines) {
  if (!length(lines)) stop("Generated output is empty.")
  if (!any(grepl("^\\\\begin\\{Verbatim\\}", lines))) {
    stop("Generated output does not contain a Verbatim block.")
  }
}

# Stage 8: Write the final .tex file.
write_output <- function(lines, output_path) {
  dir.create(dirname(output_path), recursive = TRUE, showWarnings = FALSE)
  writeLines(lines, output_path, useBytes = TRUE)
}

parse_output_target <- function(output_path) {
  file_name <- basename(output_path)
  pattern <- "^exercise-([0-9]+-[0-9]+)-([0-9]+)\\.tex$"
  if (!grepl(pattern, file_name)) {
    stop(
      "Unsupported output filename '", file_name,
      "'. Expected exercise-<chapter>-<exercise>-<chunk>.tex"
    )
  }
  parts <- regmatches(file_name, regexec(pattern, file_name))[[1L]]
  exercise <- gsub("-", ".", parts[[2L]])
  chunk_index <- as.integer(parts[[3L]])
  list(exercise = exercise, chunk_index = chunk_index)
}

export_single_chunk <- function(input_path, output_path) {
  ensure_dependencies()

  config <- resolve_workshop_export_config(input_path)
  if (is.null(config)) {
    stop(
      "Unsupported workshop source: ", input_path,
      ". Add its configuration to scripts/workshop-export-config.R."
    )
  }

  target <- parse_output_target(output_path)
  expected_chunk_count <- config$expected_chunks[[target$exercise]]
  if (is.null(expected_chunk_count)) {
    stop(
      "Exercise ", target$exercise,
      " is not configured for source ", config$source,
      ". Supported exercises: ", paste(names(config$expected_chunks), collapse = ", ")
    )
  }

  source_lines <- read_source_lines(config$source)
  validate_supported_constructs(source_lines, config$source)
  publishable <- strip_support_only(source_lines, config$source)

  all_segments <- list()
  for (exercise in names(config$expected_chunks)) {
    all_segments[[exercise]] <- extract_exercise_segments(
      publishable,
      exercise,
      config$expected_chunks[[exercise]],
      config$source
    )
  }
  segments <- all_segments[[target$exercise]]

  if (target$chunk_index < 1L || target$chunk_index > length(segments$chunks)) {
    stop(
      "Chunk index ", target$chunk_index,
      " out of bounds for exercise ", target$exercise,
      " (has ", length(segments$chunks), " chunk(s))."
    )
  }

  chunk_env <- prepare_chunk_environment(
    all_segments,
    config,
    target$exercise,
    target$chunk_index
  )
  body <- render_r_chunk_to_latex(segments$chunks[[target$chunk_index]], chunk_env)
  prose_before <- if (target$chunk_index == 1L) {
    markdown_to_latex(segments$prose[[target$chunk_index]], chunk_env, config$source)
  } else {
    character()
  }
  prose_after <- markdown_to_latex(segments$prose[[target$chunk_index + 1L]], chunk_env, config$source)

  generated <- compose_tex_document(config$source, prose_before, body, prose_after)
  validate_generated_output(generated)
  write_output(generated, output_path)
  message("Generated ", output_path)
}

main <- function() {
  args <- parse_cli_args(commandArgs(trailingOnly = TRUE))
  if (isTRUE(args$help)) {
    print_help()
    return(invisible(NULL))
  }
  if (is.null(args$input) || is.null(args$output)) {
    stop("Both --input and --output are required. Use --help for usage.")
  }
  export_single_chunk(args$input, args$output)
}

if (sys.nframe() == 0L) {
  main()
}
