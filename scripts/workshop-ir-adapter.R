source("scripts/workshop-ir-validate.R", chdir = FALSE)

normalize_ir_code_chunk <- function(code_lines) {
  chunk <- c(
    "```{r, echo=TRUE, results='markup', comment='', fig.keep='none', message=FALSE, warning=FALSE, error=FALSE}",
    code_lines,
    "```"
  )
  chunk[grepl("^options\\(width\\s*=", chunk)] <- "options(width = 65)"
  chunk
}

build_exercise_segments_from_ir <- function(ir, exercise_ref, expected_chunk_count, source_file) {
  matches <- Filter(function(ex) identical(ex$exercise_ref, exercise_ref), ir$exercises)
  if (length(matches) != 1L) {
    stop("Could not find unique Exercise ", exercise_ref, " in IR for ", source_file)
  }

  exercise <- matches[[1L]]
  chunks <- list()
  prose <- list()
  pending_prose <- character()

  for (block in exercise$blocks) {
    if (isTRUE(block$support_only)) {
      next
    }

    if (identical(block$block_type, "narrative")) {
      pending_prose <- c(pending_prose, block$content$narrative_lines)
    } else if (identical(block$block_type, "code")) {
      prose[[length(chunks) + 1L]] <- pending_prose
      pending_prose <- character()
      chunks[[length(chunks) + 1L]] <- normalize_ir_code_chunk(block$content$code_lines)
    } else {
      stop(
        "Unsupported IR block type '", block$block_type,
        "' in exercise ", exercise_ref, " for ", source_file
      )
    }
  }

  if (length(chunks) != expected_chunk_count) {
    stop(
      "Expected ", expected_chunk_count,
      " complete R chunks in Exercise ", exercise_ref,
      " but found ", length(chunks),
      " in ", source_file,
      " (IR adapter path)"
    )
  }

  prose[[length(chunks) + 1L]] <- pending_prose
  list(chunks = chunks, prose = prose)
}

build_all_segments_from_ir <- function(ir, config, source_file) {
  all_segments <- list()
  for (exercise in names(config$expected_chunks)) {
    all_segments[[exercise]] <- build_exercise_segments_from_ir(
      ir = ir,
      exercise_ref = exercise,
      expected_chunk_count = config$expected_chunks[[exercise]],
      source_file = source_file
    )
  }
  all_segments
}

load_ir_segments <- function(input_path, config) {
  ir <- parse_support_notebook_to_ir(input_path = input_path)
  validate_workshop_ir(
    ir = ir,
    source_path = input_path,
    config = config,
    strict = TRUE
  )
  build_all_segments_from_ir(ir = ir, config = config, source_file = input_path)
}
