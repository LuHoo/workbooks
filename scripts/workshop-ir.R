#!/usr/bin/env Rscript

WORKSHOP_IR_SCHEMA_VERSION <- "workshop-ir/1.1.0"
WORKSHOP_IR_ALLOWED_LANGUAGES <- c("python")
WORKSHOP_IR_ALLOWED_MODES <- c("only", "override")
WORKSHOP_IR_ALLOWED_KINDS <- c("narrative", "code", "any")
WORKSHOP_IR_ALLOWED_CAPABILITIES <- c("fsaudit")

normalize_line <- function(line) {
  trimws(line)
}

parse_cli_args <- function(args) {
  out <- list(
    input = NULL,
    output = NULL,
    workshop_id = NULL,
    chapter_number = NULL,
    chapter_title = NULL,
    pretty = FALSE,
    help = FALSE
  )

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
    } else if (identical(arg, "--workshop-id")) {
      i <- i + 1L
      if (i > length(args)) stop("Missing value after --workshop-id")
      out$workshop_id <- args[[i]]
    } else if (identical(arg, "--chapter-number")) {
      i <- i + 1L
      if (i > length(args)) stop("Missing value after --chapter-number")
      out$chapter_number <- as.integer(args[[i]])
    } else if (identical(arg, "--chapter-title")) {
      i <- i + 1L
      if (i > length(args)) stop("Missing value after --chapter-title")
      out$chapter_title <- args[[i]]
    } else if (identical(arg, "--pretty")) {
      out$pretty <- TRUE
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
    "  Rscript scripts/workshop-ir.R --input <support.Rmd> [options]\n\n",
    "Options:\n",
    "  --output <path>           Write IR JSON to file (default: stdout).\n",
    "  --workshop-id <id>        Override workshop id (default: infer from input path).\n",
    "  --chapter-number <n>      Override chapter number (default: infer from first exercise).\n",
    "  --chapter-title <title>   Override chapter title (default: infer from YAML title).\n",
    "  --pretty                  Pretty-print JSON.\n",
    "  --help                    Show this help.\n",
    sep = ""
  )
}

make_parse_error <- function(file_path, line, block, message, remediation) {
  stop(
    paste0(
      "[IR-PARSE] file=", file_path,
      " line=", line,
      " block=", block,
      " message=", message,
      " remediation=", remediation
    )
  )
}

parse_directive_attrs <- function(attr_text) {
  attrs <- list()
  trimmed <- trimws(attr_text)
  if (!nzchar(trimmed)) {
    return(attrs)
  }

  parts <- strsplit(trimmed, "[[:space:]]+")[[1L]]
  for (part in parts) {
    if (!grepl("=", part, fixed = TRUE)) {
      stop("Malformed directive attribute token: ", part)
    }
    kv <- strsplit(part, "=", fixed = TRUE)[[1L]]
    if (length(kv) != 2L || !nzchar(kv[[1L]]) || !nzchar(kv[[2L]])) {
      stop("Malformed directive attribute token: ", part)
    }
    attrs[[kv[[1L]]]] <- kv[[2L]]
  }

  attrs
}

make_directive_instance <- function(id, name, attributes, line, status = "applied") {
  list(
    directive_id = sprintf("DI-%03d", id),
    name = name,
    attributes = attributes,
    source_span = list(start_line = line, end_line = line),
    status = status
  )
}

extract_yaml_title <- function(lines) {
  if (length(lines) < 3L || !identical(normalize_line(lines[[1L]]), "---")) {
    return(NULL)
  }

  end <- NA_integer_
  for (i in 2:length(lines)) {
    if (identical(normalize_line(lines[[i]]), "---")) {
      end <- i
      break
    }
  }
  if (is.na(end)) return(NULL)

  for (i in 2:(end - 1L)) {
    if (grepl("^title\\s*:", lines[[i]])) {
      title <- sub("^title\\s*:\\s*", "", lines[[i]])
      title <- trimws(title)
      title <- sub('^"', "", title)
      title <- sub('"$', "", title)
      return(title)
    }
  }

  NULL
}

infer_workshop_id <- function(input_path) {
  parts <- strsplit(gsub("\\\\", "/", input_path), "/", fixed = TRUE)[[1L]]
  support_pos <- which(parts == "support")
  if (!length(support_pos)) {
    return("unknown-workshop")
  }
  idx <- support_pos[[length(support_pos)]] + 1L
  if (idx > length(parts)) {
    return("unknown-workshop")
  }
  parts[[idx]]
}

parse_chunk_language <- function(chunk_header) {
  first <- strsplit(chunk_header, ",", fixed = TRUE)[[1L]][[1L]]
  token <- strsplit(trimws(first), "[[:space:]]+")[[1L]][[1L]]
  token
}

format_source_mtime_utc <- function(path) {
  info <- file.info(path)
  if (is.na(info$mtime)) {
    return("1970-01-01T00:00:00Z")
  }
  format(as.POSIXct(info$mtime, tz = "UTC"), "%Y-%m-%dT%H:%M:%SZ", tz = "UTC")
}

new_narrative_block <- function(start_line, support_only, active_directive = NULL) {
  mode <- "base"
  lang_scope <- "shared"
  kind <- "any"
  if (!is.null(active_directive)) {
    mode <- active_directive$mode
    lang_scope <- active_directive$lang
    kind <- active_directive$kind
  }

  list(
    block_type = "narrative",
    start_line = start_line,
    end_line = start_line,
    support_only = support_only,
    narrative_lines = character(),
    authoring_mode = mode,
    authoring_lang_scope = lang_scope,
    authoring_kind = kind,
    override_target_sequence = NULL,
    requires = character()
  )
}

append_narrative_line <- function(block, line, line_number) {
  block$narrative_lines <- c(block$narrative_lines, line)
  block$end_line <- line_number
  block
}

finalize_narrative_block <- function(block) {
  if (length(block$narrative_lines) == 0L) return(NULL)
  block
}

make_code_block <- function(
  start_line,
  end_line,
  fence_open,
  fence_close,
  chunk_header,
  code_lines,
  support_only,
  active_directive = NULL,
  requires = character()
) {
  mode <- "base"
  lang_scope <- "shared"
  kind <- "any"
  if (!is.null(active_directive)) {
    mode <- active_directive$mode
    lang_scope <- active_directive$lang
    kind <- active_directive$kind
  }

  list(
    block_type = "code",
    start_line = start_line,
    end_line = end_line,
    fence_open_line = fence_open,
    fence_close_line = fence_close,
    support_only = support_only,
    chunk_header = chunk_header,
    language = parse_chunk_language(chunk_header),
    code_lines = code_lines,
    authoring_mode = mode,
    authoring_lang_scope = lang_scope,
    authoring_kind = kind,
    override_target_sequence = NULL,
    requires = requires
  )
}

exercise_heading_match <- function(line) {
  regexec("^##+\\s+Exercise\\s+([0-9]+\\.[0-9]+)(?:\\.|\\s|$)(.*)$", line, perl = TRUE)
}

as_block_output <- function(
  block,
  source_file,
  block_id,
  sequence,
  exercise_ref = NULL,
  chunk_index = NULL,
  override_target_block_id = NULL
) {
  trace <- list(
    source_file = source_file,
    source_block_key = paste0(source_file, ":", block$start_line, "-", block$end_line, ":", block$block_type)
  )

  if (!is.null(exercise_ref) && !is.null(chunk_index) && identical(block$block_type, "code")) {
    trace$workshop_identity_hint <- list(
      exercise = exercise_ref,
      chunk_index_within_exercise = chunk_index
    )
  }

  out <- list(
    block_id = block_id,
    block_type = block$block_type,
    sequence = sequence,
    support_only = isTRUE(block$support_only),
    source_span = list(
      start_line = block$start_line,
      end_line = block$end_line
    ),
    content = list(),
    traceability = trace,
    authoring_context = list(
      lang_scope = block$authoring_lang_scope,
      mode = block$authoring_mode,
      kind = block$authoring_kind,
      requires = block$requires
    )
  )

  if (!is.null(override_target_block_id)) {
    out$authoring_context$override_target_block_id <- override_target_block_id
  }

  if (identical(block$block_type, "narrative")) {
    out$content$narrative_lines <- block$narrative_lines
  } else {
    out$source_span$fence_open_line <- block$fence_open_line
    out$source_span$fence_close_line <- block$fence_close_line
    out$content$chunk_header <- block$chunk_header
    out$content$code_lines <- block$code_lines
    out$content$language <- block$language
  }

  out
}

parse_support_notebook_to_ir <- function(
  input_path,
  workshop_id = NULL,
  chapter_number = NULL,
  chapter_title = NULL
) {
  if (!file.exists(input_path)) {
    stop("Input file does not exist: ", input_path)
  }

  lines <- readLines(input_path, warn = FALSE)
  if (!length(lines)) {
    stop("Input file is empty: ", input_path)
  }

  workshop_id <- if (is.null(workshop_id)) infer_workshop_id(input_path) else workshop_id
  yaml_title <- extract_yaml_title(lines)

  observed_directives <- character()
  directive_instances <- list()
  directive_counter <- 0L
  exercises <- list()
  chapter_blocks <- list()

  in_support_only <- FALSE
  in_code <- FALSE
  code_start_line <- NA_integer_
  code_header <- NULL
  code_lines <- character()
  code_support_only <- FALSE
  code_directive <- NULL

  current_exercise_index <- 0L
  current_narrative <- NULL
  exercise_refs <- character()
  active_directive <- NULL
  pending_requires <- character()

  add_directive_instance <- function(name, attributes, line, status = "applied") {
    directive_counter <<- directive_counter + 1L
    directive_instances[[length(directive_instances) + 1L]] <<- make_directive_instance(
      id = directive_counter,
      name = name,
      attributes = attributes,
      line = line,
      status = status
    )
  }

  resolve_override_target_sequence <- function(raw_blocks, current_block_type, lang_scope, kind) {
    if (!identical(lang_scope, "python")) {
      return(NULL)
    }
    for (j in rev(seq_along(raw_blocks))) {
      candidate <- raw_blocks[[j]]
      if (!identical(candidate$authoring_mode, "base")) {
        next
      }
      if (!identical(candidate$authoring_lang_scope, "shared")) {
        next
      }
      if (!identical(candidate$block_type, current_block_type)) {
        next
      }
      if (!identical(kind, "any") && !identical(kind, current_block_type)) {
        next
      }
      return(j)
    }
    NULL
  }

  close_current_narrative <- function(line_number) {
    if (is.null(current_narrative)) return(NULL)
    finished <- finalize_narrative_block(current_narrative)
    current_narrative <<- NULL
    if (is.null(finished)) return(NULL)

    if (identical(finished$authoring_mode, "override")) {
      if (current_exercise_index == 0L) {
        make_parse_error(
          input_path,
          finished$start_line,
          "ADA:BEGIN",
          "override directive outside exercise scope",
          "place override regions inside an exercise section"
        )
      }

      existing_blocks <- exercises[[current_exercise_index]]$raw_blocks
      finished$override_target_sequence <- resolve_override_target_sequence(
        raw_blocks = existing_blocks,
        current_block_type = "narrative",
        lang_scope = finished$authoring_lang_scope,
        kind = finished$authoring_kind
      )
      if (is.null(finished$override_target_sequence)) {
        make_parse_error(
          input_path,
          finished$start_line,
          "ADA:BEGIN",
          "override directive has no eligible target block",
          "add a shared narrative block before this override in the same exercise"
        )
      }
    }

    if (current_exercise_index == 0L) {
      chapter_blocks[[length(chapter_blocks) + 1L]] <<- finished
    } else {
      exercises[[current_exercise_index]]$raw_blocks[[length(exercises[[current_exercise_index]]$raw_blocks) + 1L]] <<- finished
    }
    invisible(NULL)
  }

  ensure_narrative <- function(line_number) {
    if (is.null(current_narrative)) {
      current_narrative <<- new_narrative_block(line_number, in_support_only, active_directive)
    } else if (!identical(current_narrative$support_only, in_support_only)) {
      close_current_narrative(line_number)
      current_narrative <<- new_narrative_block(line_number, in_support_only, active_directive)
    }
  }

  for (i in seq_along(lines)) {
    line <- lines[[i]]
    trimmed <- normalize_line(line)

    if (!in_code && grepl("^<!--\\s*ADA:", trimmed)) {
      if (grepl("^<!--\\s*ADA:BEGIN\\b", trimmed)) {
        if (!is.null(active_directive)) {
          make_parse_error(
            input_path,
            i,
            "ADA:BEGIN",
            "nested ADA directive region",
            "close current directive region with ADA:END before opening a new one"
          )
        }

        attr_text <- sub("^<!--\\s*ADA:BEGIN\\s*", "", trimmed)
        attr_text <- sub("\\s*-->$", "", attr_text)
        attrs <- tryCatch(
          parse_directive_attrs(attr_text),
          error = function(e) {
            make_parse_error(
              input_path,
              i,
              "ADA:BEGIN",
              conditionMessage(e),
              "use key=value pairs, e.g. lang=python mode=override kind=narrative"
            )
          }
        )

        if (is.null(attrs$lang) || is.null(attrs$mode)) {
          make_parse_error(
            input_path,
            i,
            "ADA:BEGIN",
            "missing required attributes",
            "provide lang=<language-id> and mode=<only|override>"
          )
        }
        kind <- if (!is.null(attrs$kind)) attrs$kind else "any"

        if (!attrs$lang %in% WORKSHOP_IR_ALLOWED_LANGUAGES) {
          make_parse_error(
            input_path,
            i,
            "ADA:BEGIN",
            paste0("unsupported language id '", attrs$lang, "'"),
            paste0("use one of: ", paste(WORKSHOP_IR_ALLOWED_LANGUAGES, collapse = ", "))
          )
        }
        if (!attrs$mode %in% WORKSHOP_IR_ALLOWED_MODES) {
          make_parse_error(
            input_path,
            i,
            "ADA:BEGIN",
            paste0("unsupported mode '", attrs$mode, "'"),
            paste0("use one of: ", paste(WORKSHOP_IR_ALLOWED_MODES, collapse = ", "))
          )
        }
        if (!kind %in% WORKSHOP_IR_ALLOWED_KINDS) {
          make_parse_error(
            input_path,
            i,
            "ADA:BEGIN",
            paste0("unsupported kind '", kind, "'"),
            paste0("use one of: ", paste(WORKSHOP_IR_ALLOWED_KINDS, collapse = ", "))
          )
        }

        close_current_narrative(i)
        active_directive <- list(lang = attrs$lang, mode = attrs$mode, kind = kind)
        add_directive_instance("ADA:BEGIN", c(attrs, list(kind = kind)), i)
        observed_directives <- unique(c(observed_directives, "ADA:BEGIN"))
        next
      }

      if (grepl("^<!--\\s*ADA:END\\s*-->$", trimmed)) {
        if (is.null(active_directive)) {
          make_parse_error(
            input_path,
            i,
            "ADA:END",
            "unmatched ADA:END",
            "add matching ADA:BEGIN before this line or remove stray ADA:END"
          )
        }
        close_current_narrative(i)
        add_directive_instance("ADA:END", list(), i)
        observed_directives <- unique(c(observed_directives, "ADA:END"))
        active_directive <- NULL
        next
      }

      if (grepl("^<!--\\s*ADA:REQUIRES\\b", trimmed)) {
        if (!is.null(active_directive)) {
          make_parse_error(
            input_path,
            i,
            "ADA:REQUIRES",
            "ADA:REQUIRES is not allowed inside ADA:BEGIN/ADA:END region",
            "move ADA:REQUIRES directly above the target code block"
          )
        }
        attr_text <- sub("^<!--\\s*ADA:REQUIRES\\s*", "", trimmed)
        attr_text <- sub("\\s*-->$", "", attr_text)
        attrs <- tryCatch(
          parse_directive_attrs(attr_text),
          error = function(e) {
            make_parse_error(
              input_path,
              i,
              "ADA:REQUIRES",
              conditionMessage(e),
              "use key=value pairs, e.g. capability=fsaudit"
            )
          }
        )
        if (is.null(attrs$capability)) {
          make_parse_error(
            input_path,
            i,
            "ADA:REQUIRES",
            "missing required attribute 'capability'",
            "provide capability=fsaudit"
          )
        }
        if (!attrs$capability %in% WORKSHOP_IR_ALLOWED_CAPABILITIES) {
          make_parse_error(
            input_path,
            i,
            "ADA:REQUIRES",
            paste0("unsupported capability '", attrs$capability, "'"),
            paste0("use one of: ", paste(WORKSHOP_IR_ALLOWED_CAPABILITIES, collapse = ", "))
          )
        }
        close_current_narrative(i)
        pending_requires <- c(pending_requires, attrs$capability)
        add_directive_instance("ADA:REQUIRES", attrs, i)
        observed_directives <- unique(c(observed_directives, "ADA:REQUIRES"))
        next
      }

      make_parse_error(
        input_path,
        i,
        "ADA:*",
        "unknown ADA directive",
        "use ADA:BEGIN, ADA:END, or ADA:REQUIRES"
      )
    }

    if (!in_code && identical(trimmed, "<!-- SUPPORT-ONLY:START -->")) {
      observed_directives <- unique(c(observed_directives, "SUPPORT-ONLY:START"))
      if (in_support_only) {
        make_parse_error(
          input_path,
          i,
          "SUPPORT-ONLY:START",
          "nested support-only block",
          "remove nested start marker or add matching end marker before this line"
        )
      }
      close_current_narrative(i)
      in_support_only <- TRUE
      next
    }

    if (!in_code && identical(trimmed, "<!-- SUPPORT-ONLY:END -->")) {
      observed_directives <- unique(c(observed_directives, "SUPPORT-ONLY:END"))
      if (!in_support_only) {
        make_parse_error(
          input_path,
          i,
          "SUPPORT-ONLY:END",
          "unmatched support-only end marker",
          "add matching SUPPORT-ONLY:START before this line or remove stray end marker"
        )
      }
      close_current_narrative(i)
      in_support_only <- FALSE
      next
    }

    if (!in_code) {
      open_match <- regexec("^```\\{([^}]*)\\}\\s*$", line, perl = TRUE)
      open_parts <- regmatches(line, open_match)[[1L]]
      if (length(open_parts) > 0L) {
        close_current_narrative(i)
        in_code <- TRUE
        code_start_line <- i
        code_header <- open_parts[[2L]]
        code_lines <- character()
        code_support_only <- in_support_only
        code_directive <- active_directive
        next
      }

      heading_parts <- regmatches(line, exercise_heading_match(line))[[1L]]
      if (length(heading_parts) > 0L) {
        close_current_narrative(i)

        if (current_exercise_index > 0L) {
          exercises[[current_exercise_index]]$end_line <- i - 1L
        }

        exercise_ref <- heading_parts[[2L]]
        heading_suffix <- trimws(heading_parts[[3L]])
        label <- trimws(sub("^#+\\s+", "", line))

        if (exercise_ref %in% exercise_refs) {
          make_parse_error(
            input_path,
            i,
            paste0("Exercise ", exercise_ref),
            "duplicate exercise reference",
            "ensure each exercise heading appears once per file"
          )
        }

        exercise_refs <- c(exercise_refs, exercise_ref)
        current_exercise_index <- current_exercise_index + 1L
        exercises[[current_exercise_index]] <- list(
          exercise_ref = exercise_ref,
          heading_suffix = heading_suffix,
          label = label,
          heading_line = i,
          start_line = i,
          end_line = length(lines),
          raw_blocks = list()
        )

        next
      }

      ensure_narrative(i)
      current_narrative <- append_narrative_line(current_narrative, line, i)
      next
    }

    if (identical(line, "```")) {
      in_code <- FALSE
      code_end_line <- i
      code_language <- parse_chunk_language(code_header)
      if (!identical(code_language, "r")) {
        make_parse_error(
          input_path,
          code_start_line,
          paste0("code-fence:", code_language),
          "unsupported code fence language in v1",
          "use R chunk fences only (```{r ...}) for workshop IR v1 extraction"
        )
      }
      code_block <- make_code_block(
        start_line = code_start_line,
        end_line = code_end_line,
        fence_open = code_start_line,
        fence_close = code_end_line,
        chunk_header = code_header,
        code_lines = code_lines,
        support_only = code_support_only,
        active_directive = code_directive,
        requires = pending_requires
      )

      if (length(pending_requires) > 0L) {
        pending_requires <- character()
      }

      if (identical(code_block$authoring_mode, "override")) {
        if (current_exercise_index == 0L) {
          make_parse_error(
            input_path,
            code_start_line,
            "ADA:BEGIN",
            "override directive outside exercise scope",
            "place override regions inside an exercise section"
          )
        }
        existing_blocks <- exercises[[current_exercise_index]]$raw_blocks
        code_block$override_target_sequence <- resolve_override_target_sequence(
          raw_blocks = existing_blocks,
          current_block_type = "code",
          lang_scope = code_block$authoring_lang_scope,
          kind = code_block$authoring_kind
        )
        if (is.null(code_block$override_target_sequence)) {
          make_parse_error(
            input_path,
            code_start_line,
            "ADA:BEGIN",
            "override directive has no eligible target block",
            "add a shared code block before this override in the same exercise"
          )
        }
      }

      if (current_exercise_index == 0L) {
        chapter_blocks[[length(chapter_blocks) + 1L]] <- code_block
      } else {
        exercises[[current_exercise_index]]$raw_blocks[[length(exercises[[current_exercise_index]]$raw_blocks) + 1L]] <- code_block
      }

      code_start_line <- NA_integer_
      code_header <- NULL
      code_lines <- character()
      code_support_only <- FALSE
      code_directive <- NULL
      next
    }

    code_lines <- c(code_lines, line)
  }

  close_current_narrative(length(lines))

  if (in_code) {
    make_parse_error(
      input_path,
      code_start_line,
      "code-fence",
      "unclosed code fence",
      "close the chunk with triple backticks before end of file"
    )
  }

  if (in_support_only) {
    make_parse_error(
      input_path,
      length(lines),
      "SUPPORT-ONLY",
      "unclosed support-only block",
      "add SUPPORT-ONLY:END marker"
    )
  }

  if (!is.null(active_directive)) {
    make_parse_error(
      input_path,
      length(lines),
      "ADA:BEGIN",
      "unclosed ADA directive region",
      "close region with ADA:END"
    )
  }

  if (length(pending_requires) > 0L) {
    make_parse_error(
      input_path,
      length(lines),
      "ADA:REQUIRES",
      "capability annotation is not attached to a following code block",
      "move ADA:REQUIRES directly above a code block"
    )
  }

  if (length(exercises) == 0L) {
    make_parse_error(
      input_path,
      1L,
      "exercise headings",
      "no exercises detected",
      "add headings matching pattern: ## Exercise <chapter>.<exercise>"
    )
  }

  if (is.null(chapter_number)) {
    first_ex <- exercises[[1L]]$exercise_ref
    chapter_number <- as.integer(strsplit(first_ex, "\\.", perl = TRUE)[[1L]][[1L]])
  }

  if (is.na(chapter_number) || chapter_number < 1L) {
    stop("Chapter number must be a positive integer.")
  }

  if (is.null(chapter_title)) {
    chapter_title <- if (!is.null(yaml_title)) yaml_title else paste("Workshop Chapter", chapter_number)
  }

  chapter_sequence <- 1L
  for (i in seq_along(chapter_blocks)) {
    block <- chapter_blocks[[i]]
    chapter_blocks[[i]] <- as_block_output(
      block = block,
      source_file = input_path,
      block_id = sprintf("BL-CH-%03d", chapter_sequence),
      sequence = chapter_sequence
    )
    chapter_sequence <- chapter_sequence + 1L
  }

  exercise_outputs <- vector("list", length(exercises))
  for (ex_i in seq_along(exercises)) {
    ex <- exercises[[ex_i]]
    code_index <- 0L
    ex_blocks <- vector("list", length(ex$raw_blocks))
    ex_block_ids <- character(length(ex$raw_blocks))
    for (block_i in seq_along(ex$raw_blocks)) {
      ex_block_ids[[block_i]] <- sprintf("BL-EX-%s-%03d", ex$exercise_ref, block_i)
    }
    for (block_i in seq_along(ex$raw_blocks)) {
      raw_block <- ex$raw_blocks[[block_i]]
      chunk_idx <- NULL
      if (identical(raw_block$block_type, "code")) {
        code_index <- code_index + 1L
        chunk_idx <- code_index
      }
      override_target_block_id <- NULL
      if (!is.null(raw_block$override_target_sequence)) {
        override_target_block_id <- ex_block_ids[[raw_block$override_target_sequence]]
      }

      ex_blocks[[block_i]] <- as_block_output(
        block = raw_block,
        source_file = input_path,
        block_id = ex_block_ids[[block_i]],
        sequence = block_i,
        exercise_ref = ex$exercise_ref,
        chunk_index = chunk_idx,
        override_target_block_id = override_target_block_id
      )
    }

    exercise_outputs[[ex_i]] <- list(
      exercise_id = paste0("EX-", ex$exercise_ref),
      exercise_ref = ex$exercise_ref,
      ordinal = ex_i,
      label = ex$label,
      source_span = list(
        start_line = ex$start_line,
        end_line = ex$end_line,
        heading_line = ex$heading_line
      ),
      blocks = ex_blocks
    )
  }

  list(
    schema_version = WORKSHOP_IR_SCHEMA_VERSION,
    generated_at_utc = format_source_mtime_utc(input_path),
    source = list(
      file_path = input_path,
      line_count = length(lines)
    ),
    chapter = list(
      chapter_id = paste0("CH-", workshop_id),
      workshop_id = workshop_id,
      chapter_number = chapter_number,
      title = chapter_title
    ),
    directives = list(
      supported = c(
        "SUPPORT-ONLY:START",
        "SUPPORT-ONLY:END",
        "ADA:BEGIN",
        "ADA:END",
        "ADA:REQUIRES"
      ),
      observed = observed_directives,
      instances = directive_instances
    ),
    chapter_blocks = chapter_blocks,
    exercises = exercise_outputs
  )
}

write_workshop_ir_json <- function(ir, output_path = NULL, pretty = FALSE) {
  if (!requireNamespace("jsonlite", quietly = TRUE)) {
    stop("The jsonlite package is required to emit IR JSON.")
  }

  json <- jsonlite::toJSON(ir, auto_unbox = TRUE, pretty = isTRUE(pretty), null = "null")
  if (is.null(output_path)) {
    cat(json, "\n", sep = "")
    return(invisible(json))
  }

  dir.create(dirname(output_path), recursive = TRUE, showWarnings = FALSE)
  writeLines(json, output_path, useBytes = TRUE)
  invisible(output_path)
}

main <- function() {
  args <- parse_cli_args(commandArgs(trailingOnly = TRUE))

  if (isTRUE(args$help)) {
    print_help()
    return(invisible(NULL))
  }

  if (is.null(args$input)) {
    stop("--input is required. Use --help for usage.")
  }

  ir <- parse_support_notebook_to_ir(
    input_path = args$input,
    workshop_id = args$workshop_id,
    chapter_number = args$chapter_number,
    chapter_title = args$chapter_title
  )

  write_workshop_ir_json(ir, output_path = args$output, pretty = args$pretty)
}

if (sys.nframe() == 0L) {
  main()
}
