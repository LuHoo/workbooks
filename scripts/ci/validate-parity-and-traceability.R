#!/usr/bin/env Rscript

source("scripts/workshop-export-config.R", chdir = FALSE)
source("scripts/workshop-ir.R", chdir = FALSE)
source("scripts/traceability-metadata.R", chdir = FALSE)

SCRIPT_VERSION <- "0.1.0"

ensure_jsonlite <- function() {
  if (!requireNamespace("jsonlite", quietly = TRUE)) {
    stop("jsonlite is required for parity/traceability validation")
  }
}

parse_args <- function(args) {
  out <- list(
    notebooks_dir = "generated/python-notebooks",
    metadata_dir = "metadata/traceability",
    chapters = "1,2,3,4,5,6",
    output_json = NULL
  )

  i <- 1L
  while (i <= length(args)) {
    arg <- args[[i]]
    if (identical(arg, "--notebooks-dir")) {
      i <- i + 1L
      out$notebooks_dir <- args[[i]]
    } else if (identical(arg, "--metadata-dir")) {
      i <- i + 1L
      out$metadata_dir <- args[[i]]
    } else if (identical(arg, "--chapters")) {
      i <- i + 1L
      out$chapters <- args[[i]]
    } else if (identical(arg, "--output-json")) {
      i <- i + 1L
      out$output_json <- args[[i]]
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
    "  Rscript scripts/ci/validate-parity-and-traceability.R [options]\n\n",
    "Options:\n",
    "  --notebooks-dir <path>  Generated Python notebook root (default: generated/python-notebooks)\n",
    "  --metadata-dir <path>   Traceability metadata directory (default: metadata/traceability)\n",
    "  --chapters <list>       Comma-separated chapter list (default: 1,2,3,4,5,6)\n",
    "  --output-json <path>    Optional output path for machine-readable report\n",
    sep = ""
  )
}

empty_workshop_report <- function(config) {
  list(
    workshop_id = config$id,
    chapter = as.character(sub("^([0-9]+).*", "\\1", names(config$expected_chunks)[[1]])),
    checks = list(
      exercise_parity = list(status = "not-run", errors = list(), warnings = list()),
      lo_mapping_parity = list(status = "not-run", errors = list(), warnings = list()),
      fsaudit_coverage = list(status = "not-run", errors = list(), warnings = list())
    )
  )
}

build_report <- function(configs) {
  list(
    script = "scripts/ci/validate-parity-and-traceability.R",
    version = SCRIPT_VERSION,
    status = "not-run",
    generated_at = format(Sys.time(), "%Y-%m-%dT%H:%M:%SZ", tz = "UTC"),
    workshops = lapply(configs, empty_workshop_report),
    errors = list(),
    warnings = list()
  )
}

workshop_metadata_index <- function(metadata, workshop_id) {
  wx_rows <- Filter(function(item) identical(as.character(item$workshop_id), workshop_id), metadata$workshop_exercises)
  wx_by_id <- setNames(wx_rows, vapply(wx_rows, function(item) as.character(item$id), character(1L)))

  lo_by_id <- setNames(metadata$learning_objectives, vapply(metadata$learning_objectives, function(item) as.character(item$id), character(1L)))

  links_by_wx <- list()
  for (link in metadata$lo_to_workshop) {
    wx_id <- as.character(link$workshop_id)
    lo_id <- as.character(link$lo_id)
    links_by_wx[[wx_id]] <- unique(c(links_by_wx[[wx_id]], lo_id))
  }

  list(wx_by_id = wx_by_id, lo_by_id = lo_by_id, links_by_wx = links_by_wx)
}

run_lo_mapping_parity <- function(config, metadata) {
  check <- list(status = "ok", errors = list(), warnings = list())
  chapter <- as.character(sub("\\..*$", "", names(config$expected_chunks)[[1L]]))

  idx <- workshop_metadata_index(metadata, config$id)

  if (length(idx$wx_by_id) == 0L) {
    check$status <- "skipped"
    check$warnings <- c(
      check$warnings,
      list("No workshop_exercises metadata available for this workshop; LO parity not evaluated")
    )
    return(check)
  }

  for (exercise_ref in names(config$expected_chunks)) {
    exercise_wx <- Filter(function(item) identical(as.character(item$exercise), exercise_ref), idx$wx_by_id)

    if (length(exercise_wx) == 0L) {
      check <- add_check_error(check, paste0("No workshop_exercises metadata for exercise ", exercise_ref))
      next
    }

    exercise_lo <- unique(unlist(lapply(exercise_wx, function(item) {
      wx_id <- as.character(item$id)
      idx$links_by_wx[[wx_id]]
    }), use.names = FALSE))

    if (length(exercise_lo) == 0L) {
      check <- add_check_error(check, paste0("No LO mappings for exercise ", exercise_ref))
      next
    }

    for (lo_id in exercise_lo) {
      lo <- idx$lo_by_id[[lo_id]]
      if (is.null(lo)) {
        check <- add_check_error(check, paste0("Mapped LO not found in metadata: ", lo_id, " (exercise ", exercise_ref, ")"))
        next
      }

      lo_chapter <- as.character(lo$chapter)
      if (!identical(lo_chapter, chapter)) {
        check <- add_check_error(
          check,
          paste0(
            "LO chapter mismatch for exercise ", exercise_ref,
            ": LO ", lo_id, " is chapter ", lo_chapter,
            " but workshop chapter is ", chapter
          )
        )
      }
    }
  }

  if (length(check$errors) > 0L) {
    check$status <- "failed"
  }

  check
}

get_authoring_context <- function(block) {
  ctx <- block$authoring_context
  if (is.null(ctx) || !is.list(ctx)) {
    return(list(lang_scope = "shared", mode = "base", requires = character(), override_target_block_id = NULL))
  }
  requires <- ctx$requires
  if (is.null(requires)) {
    requires <- character()
  }
  list(
    lang_scope = if (!is.null(ctx$lang_scope)) as.character(ctx$lang_scope) else "shared",
    mode = if (!is.null(ctx$mode)) as.character(ctx$mode) else "base",
    requires = as.character(requires),
    override_target_block_id = if (!is.null(ctx$override_target_block_id)) as.character(ctx$override_target_block_id) else NULL
  )
}

block_requires <- function(block, capability) {
  ctx <- get_authoring_context(block)
  capability %in% ctx$requires
}

resolve_blocks_for_python <- function(exercise) {
  blocks <- exercise$blocks
  effective <- list()
  shared_base_index <- list()

  for (block in blocks) {
    if (isTRUE(block$support_only)) {
      next
    }

    ctx <- get_authoring_context(block)
    mode <- ctx$mode
    lang_scope <- ctx$lang_scope
    block_id <- as.character(block$block_id)

    if (identical(mode, "base")) {
      if (!identical(lang_scope, "shared")) {
        next
      }
      shared_base_index[[block_id]] <- length(effective) + 1L
      effective[[length(effective) + 1L]] <- block
      next
    }

    if (identical(mode, "only")) {
      if (identical(lang_scope, "python")) {
        effective[[length(effective) + 1L]] <- block
      }
      next
    }

    if (identical(mode, "override")) {
      if (!identical(lang_scope, "python")) {
        next
      }
      target_id <- ctx$override_target_block_id
      if (is.null(target_id) || is.null(shared_base_index[[target_id]])) {
        next
      }
      pos <- shared_base_index[[target_id]]
      target_ctx <- get_authoring_context(effective[[pos]])
      merged <- block
      merged_ctx <- get_authoring_context(merged)
      if (length(merged_ctx$requires) == 0L && length(target_ctx$requires) > 0L) {
        merged$authoring_context$requires <- target_ctx$requires
      }
      effective[[pos]] <- merged
      next
    }
  }

  effective
}

extract_notebook_traceability_block_ids <- function(notebook_path) {
  notebook <- jsonlite::fromJSON(notebook_path, simplifyVector = FALSE)
  ids <- character()
  for (cell in notebook$cells) {
    if (!identical(cell$cell_type, "code")) {
      next
    }
    tr <- cell$metadata$traceability
    if (is.null(tr) || is.null(tr$block_id)) {
      next
    }
    ids <- c(ids, as.character(tr$block_id))
  }
  unique(ids)
}

run_fsaudit_coverage <- function(config, notebooks_dir) {
  check <- list(status = "ok", errors = list(), warnings = list())
  chapter <- as.character(sub("\\..*$", "", names(config$expected_chunks)[[1L]]))
  notebook_path <- file.path(notebooks_dir, config$id, paste0("chapter-", chapter, ".ipynb"))

  if (!file.exists(notebook_path)) {
    check <- add_check_error(check, paste0("Generated notebook not found: ", notebook_path))
    check$status <- "failed"
    return(check)
  }

  ir <- parse_support_notebook_to_ir(input_path = config$source)
  required_ids <- character()
  for (exercise in ir$exercises) {
    effective <- resolve_blocks_for_python(exercise)
    for (block in effective) {
      if (!identical(as.character(block$block_type), "code")) {
        next
      }
      if (!block_requires(block, "fsaudit")) {
        next
      }
      required_ids <- c(required_ids, as.character(block$block_id))
    }
  }
  required_ids <- unique(required_ids)

  if (length(required_ids) == 0L) {
    check$status <- "skipped"
    check$warnings <- c(check$warnings, list("No FSAudit-required blocks for this workshop"))
    return(check)
  }

  present_ids <- extract_notebook_traceability_block_ids(notebook_path)
  missing_ids <- setdiff(required_ids, present_ids)

  if (length(missing_ids) > 0L) {
    check <- add_check_error(
      check,
      paste0("Missing FSAudit-required block IDs in generated notebook: ", paste(missing_ids, collapse = ", "))
    )
    check$status <- "failed"
  }

  check
}

extract_source_exercise_refs <- function(source_path) {
  ir <- parse_support_notebook_to_ir(input_path = source_path)
  vapply(ir$exercises, function(ex) as.character(ex$exercise_ref), character(1L))
}

extract_notebook_exercise_refs <- function(notebook_path) {
  if (!file.exists(notebook_path)) {
    return(character())
  }

  notebook <- jsonlite::fromJSON(notebook_path, simplifyVector = FALSE)
  refs <- character()

  for (cell in notebook$cells) {
    if (!identical(cell$cell_type, "markdown")) {
      next
    }
    lines <- unlist(cell$source)
    for (line in lines) {
      match <- regexec("^##\\s*Exercise\\s+([0-9]+\\.[0-9]+)", line, perl = TRUE)
      hit <- regmatches(line, match)[[1L]]
      if (length(hit) == 2L) {
        refs <- c(refs, hit[[2L]])
      }
    }
  }

  refs
}

add_check_error <- function(check, message) {
  check$errors <- c(check$errors, list(message))
  check
}

run_exercise_parity <- function(config, notebooks_dir) {
  check <- list(status = "ok", errors = list(), warnings = list())

  chapter <- as.character(sub("\\..*$", "", names(config$expected_chunks)[[1L]]))
  notebook_path <- file.path(notebooks_dir, config$id, paste0("chapter-", chapter, ".ipynb"))
  expected_refs <- names(config$expected_chunks)
  source_refs_all <- extract_source_exercise_refs(config$source)
  source_refs <- source_refs_all[source_refs_all %in% expected_refs]
  notebook_refs <- extract_notebook_exercise_refs(notebook_path)

  if (!file.exists(notebook_path)) {
    check <- add_check_error(check, paste0("Generated notebook not found: ", notebook_path))
    check$status <- "failed"
    return(check)
  }

  missing_expected_in_source <- setdiff(expected_refs, source_refs_all)
  if (length(missing_expected_in_source) > 0L) {
    check <- add_check_error(
      check,
      paste0("Expected exercises missing in source: ", paste(missing_expected_in_source, collapse = ", "))
    )
  }

  unexpected_source_refs <- setdiff(source_refs_all, expected_refs)
  if (length(unexpected_source_refs) > 0L) {
    check$warnings <- c(
      check$warnings,
      list(paste0("Source has exercises outside configured export set: ", paste(unexpected_source_refs, collapse = ", ")))
    )
  }

  source_dups <- unique(source_refs[duplicated(source_refs)])
  if (length(source_dups) > 0L) {
    check <- add_check_error(check, paste0("Duplicate exercises in source: ", paste(source_dups, collapse = ", ")))
  }

  notebook_dups <- unique(notebook_refs[duplicated(notebook_refs)])
  if (length(notebook_dups) > 0L) {
    check <- add_check_error(check, paste0("Duplicate exercises in notebook: ", paste(notebook_dups, collapse = ", ")))
  }

  if (length(expected_refs) != length(notebook_refs)) {
    check <- add_check_error(
      check,
      paste0("Exercise count mismatch (expected=", length(expected_refs), ", notebook=", length(notebook_refs), ")")
    )
  }

  missing_in_notebook <- setdiff(expected_refs, notebook_refs)
  if (length(missing_in_notebook) > 0L) {
    check <- add_check_error(
      check,
      paste0("Exercises missing in notebook: ", paste(missing_in_notebook, collapse = ", "))
    )
  }

  unexpected_in_notebook <- setdiff(notebook_refs, expected_refs)
  if (length(unexpected_in_notebook) > 0L) {
    check <- add_check_error(
      check,
      paste0("Unexpected notebook exercises: ", paste(unexpected_in_notebook, collapse = ", "))
    )
  }

  if (!identical(expected_refs, notebook_refs)) {
    check <- add_check_error(
      check,
      paste0(
        "Exercise order mismatch. expected=[", paste(expected_refs, collapse = ", "),
        "] notebook=[", paste(notebook_refs, collapse = ", "), "]"
      )
    )
  }

  if (length(check$errors) > 0L) {
    check$status <- "failed"
  }

  check
}

emit_summary <- function(report) {
  cat("Parity/Traceability validation summary\n")
  for (ws in report$workshops) {
    parity <- ws$checks$exercise_parity
    lo_parity <- ws$checks$lo_mapping_parity
    fsaudit_cov <- ws$checks$fsaudit_coverage
    cat(
      "- ", ws$workshop_id,
      ": exercise_parity=", parity$status,
      ", lo_mapping_parity=", lo_parity$status,
      ", fsaudit_coverage=", fsaudit_cov$status,
      "\n",
      sep = ""
    )
    if (length(parity$errors) > 0L) {
      for (msg in parity$errors) {
        cat("::error title=Exercise parity::", ws$workshop_id, " :: ", msg, "\n", sep = "")
      }
    }
    if (length(lo_parity$errors) > 0L) {
      for (msg in lo_parity$errors) {
        cat("::error title=LO mapping parity::", ws$workshop_id, " :: ", msg, "\n", sep = "")
      }
    }
    if (length(lo_parity$warnings) > 0L) {
      for (msg in lo_parity$warnings) {
        cat("::warning title=LO mapping parity::", ws$workshop_id, " :: ", msg, "\n", sep = "")
      }
    }
    if (length(fsaudit_cov$errors) > 0L) {
      for (msg in fsaudit_cov$errors) {
        cat("::error title=FSAudit coverage::", ws$workshop_id, " :: ", msg, "\n", sep = "")
      }
    }
    if (length(fsaudit_cov$warnings) > 0L) {
      for (msg in fsaudit_cov$warnings) {
        cat("::warning title=FSAudit coverage::", ws$workshop_id, " :: ", msg, "\n", sep = "")
      }
    }
  }
}

main <- function() {
  args <- parse_args(commandArgs(trailingOnly = TRUE))
  if (isTRUE(args$help)) {
    print_help()
    return(invisible(NULL))
  }

  ensure_jsonlite()

  chapter_filter <- strsplit(args$chapters, ",", fixed = TRUE)[[1]]
  chapter_filter <- trimws(chapter_filter)

  configs <- get_workshop_export_configs()
  configs <- Filter(function(cfg) {
    any(startsWith(names(cfg$expected_chunks)[[1]], paste0(chapter_filter, ".")))
  }, configs)

  report <- build_report(configs)
  report$status <- "ok"

  metadata <- load_traceability_metadata(metadata_dir = args$metadata_dir, strict = TRUE)
  if (!isTRUE(metadata$enabled)) {
    stop("Traceability metadata is required for LO parity checks")
  }

  for (idx in seq_along(configs)) {
    report$workshops[[idx]]$checks$exercise_parity <- run_exercise_parity(configs[[idx]], args$notebooks_dir)
    report$workshops[[idx]]$checks$lo_mapping_parity <- run_lo_mapping_parity(configs[[idx]], metadata)
    report$workshops[[idx]]$checks$fsaudit_coverage <- run_fsaudit_coverage(configs[[idx]], args$notebooks_dir)

    if (identical(report$workshops[[idx]]$checks$exercise_parity$status, "failed")) {
      report$status <- "failed"
      report$errors <- c(report$errors, report$workshops[[idx]]$checks$exercise_parity$errors)
    }
    if (identical(report$workshops[[idx]]$checks$lo_mapping_parity$status, "failed")) {
      report$status <- "failed"
      report$errors <- c(report$errors, report$workshops[[idx]]$checks$lo_mapping_parity$errors)
    }
    if (identical(report$workshops[[idx]]$checks$fsaudit_coverage$status, "failed")) {
      report$status <- "failed"
      report$errors <- c(report$errors, report$workshops[[idx]]$checks$fsaudit_coverage$errors)
    }
  }

  if (!is.null(args$output_json)) {
    dir.create(dirname(args$output_json), recursive = TRUE, showWarnings = FALSE)
    if (!requireNamespace("jsonlite", quietly = TRUE)) {
      stop("jsonlite is required for --output-json")
    }
    writeLines(jsonlite::toJSON(report, auto_unbox = TRUE, pretty = TRUE), args$output_json)
  }

  emit_summary(report)

  if (identical(report$status, "failed")) {
    quit(status = 1L)
  }
}

if (sys.nframe() == 0L) {
  main()
}
