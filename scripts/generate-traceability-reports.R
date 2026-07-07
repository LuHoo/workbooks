#!/usr/bin/env Rscript

source("scripts/traceability-metadata.R", chdir = FALSE)

load_traceability_metadata <- get("load_traceability_metadata", mode = "function")

parse_cli_args <- function(args) {
  out <- list(
    metadata_dir = "metadata/traceability",
    output_dir = "generated/traceability"
  )

  i <- 1L
  while (i <= length(args)) {
    arg <- args[[i]]
    if (identical(arg, "--metadata-dir")) {
      i <- i + 1L
      if (i > length(args)) stop("Missing value after --metadata-dir")
      out$metadata_dir <- args[[i]]
    } else if (identical(arg, "--output-dir")) {
      i <- i + 1L
      if (i > length(args)) stop("Missing value after --output-dir")
      out$output_dir <- args[[i]]
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
    "  Rscript scripts/generate-traceability-reports.R [options]\n\n",
    "Options:\n",
    "  --metadata-dir <path>   Traceability metadata directory (default: metadata/traceability)\n",
    "  --output-dir <path>     Output report directory (default: generated/traceability)\n",
    sep = ""
  )
}

normalize_text <- function(x) {
  if (is.null(x) || length(x) == 0L || is.na(x)) {
    return("")
  }
  as.character(x)
}

join_unique_ids <- function(values) {
  values <- values[nzchar(values)]
  if (length(values) == 0L) {
    return("")
  }
  paste(sort(unique(values)), collapse = ", ")
}

build_lo_coverage_table <- function(metadata) {
  lo <- metadata$learning_objectives
  if (length(lo) == 0L) {
    return(data.frame(
      lo_id = character(),
      chapter = character(),
      scope = character(),
      section = character(),
      bloom = character(),
      workshop_links = integer(),
      review_links = integer(),
      coverage_status = character(),
      objective_text = character(),
      stringsAsFactors = FALSE
    ))
  }

  lo_to_workshop <- metadata$lo_to_workshop
  lo_to_review <- metadata$lo_to_review

  rows <- lapply(lo, function(item) {
    lo_id <- normalize_text(item$id)
    bloom <- tolower(normalize_text(item$bloom))

    workshop_links <- sum(vapply(
      lo_to_workshop,
      function(m) identical(normalize_text(m$lo_id), lo_id),
      logical(1L)
    ))

    review_links <- sum(vapply(
      lo_to_review,
      function(m) identical(normalize_text(m$lo_id), lo_id),
      logical(1L)
    ))

    coverage_status <- if (workshop_links > 0L && review_links > 0L) {
      "covered-both"
    } else if (workshop_links > 0L) {
      "workshop-only"
    } else if (review_links > 0L) {
      "review-only"
    } else {
      "uncovered"
    }

    data.frame(
      lo_id = lo_id,
      chapter = normalize_text(item$chapter),
      scope = normalize_text(item$scope),
      section = normalize_text(item$section),
      bloom = bloom,
      workshop_links = workshop_links,
      review_links = review_links,
      coverage_status = coverage_status,
      objective_text = normalize_text(item$text),
      stringsAsFactors = FALSE
    )
  })

  out <- do.call(rbind, rows)
  out[order(out$lo_id), , drop = FALSE]
}

build_bloom_summary <- function(coverage) {
  if (nrow(coverage) == 0L) {
    return(data.frame(
      bloom = character(),
      covered_both = integer(),
      workshop_only = integer(),
      review_only = integer(),
      uncovered = integer(),
      total = integer(),
      stringsAsFactors = FALSE
    ))
  }

  blooms <- sort(unique(coverage$bloom))
  blooms <- blooms[nzchar(blooms)]

  rows <- lapply(blooms, function(level) {
    subset <- coverage[coverage$bloom == level, , drop = FALSE]
    data.frame(
      bloom = level,
      covered_both = sum(subset$coverage_status == "covered-both"),
      workshop_only = sum(subset$coverage_status == "workshop-only"),
      review_only = sum(subset$coverage_status == "review-only"),
      uncovered = sum(subset$coverage_status == "uncovered"),
      total = nrow(subset),
      stringsAsFactors = FALSE
    )
  })

  do.call(rbind, rows)
}

build_workshop_entity_table <- function(metadata) {
  workshop_records <- metadata$workshop_exercises
  lo_to_workshop <- metadata$lo_to_workshop

  if (length(workshop_records) == 0L) {
    return(data.frame(
      workshop_traceability_id = character(),
      workshop_id = character(),
      exercise = character(),
      chunk = integer(),
      lo_ids = character(),
      lo_count = integer(),
      mapping_status = character(),
      stringsAsFactors = FALSE
    ))
  }

  rows <- lapply(workshop_records, function(item) {
    wx_id <- normalize_text(item$id)
    linked_lo <- vapply(
      lo_to_workshop,
      function(m) {
        if (identical(normalize_text(m$workshop_id), wx_id)) normalize_text(m$lo_id) else ""
      },
      character(1L)
    )

    linked_lo <- linked_lo[nzchar(linked_lo)]

    data.frame(
      workshop_traceability_id = wx_id,
      workshop_id = normalize_text(item$workshop_id),
      exercise = normalize_text(item$exercise),
      chunk = as.integer(item$chunk),
      lo_ids = join_unique_ids(linked_lo),
      lo_count = length(unique(linked_lo)),
      mapping_status = if (length(linked_lo) > 0L) "mapped" else "unmapped",
      stringsAsFactors = FALSE
    )
  })

  out <- do.call(rbind, rows)
  out[order(out$workshop_traceability_id), , drop = FALSE]
}

build_review_entity_table <- function(metadata) {
  review_records <- metadata$review_questions
  lo_to_review <- metadata$lo_to_review

  if (length(review_records) == 0L) {
    return(data.frame(
      review_traceability_id = character(),
      chapter = integer(),
      ordinal = integer(),
      lo_ids = character(),
      lo_count = integer(),
      mapping_status = character(),
      stringsAsFactors = FALSE
    ))
  }

  rows <- lapply(review_records, function(item) {
    rq_id <- normalize_text(item$id)
    linked_lo <- vapply(
      lo_to_review,
      function(m) {
        if (identical(normalize_text(m$review_question_id), rq_id)) normalize_text(m$lo_id) else ""
      },
      character(1L)
    )

    linked_lo <- linked_lo[nzchar(linked_lo)]

    data.frame(
      review_traceability_id = rq_id,
      chapter = as.integer(item$chapter),
      ordinal = as.integer(item$ordinal),
      lo_ids = join_unique_ids(linked_lo),
      lo_count = length(unique(linked_lo)),
      mapping_status = if (length(linked_lo) > 0L) "mapped" else "unmapped",
      stringsAsFactors = FALSE
    )
  })

  out <- do.call(rbind, rows)
  out[order(out$review_traceability_id), , drop = FALSE]
}

build_lo_to_workshop_table <- function(metadata) {
  lo_records <- metadata$learning_objectives
  lo_to_workshop <- metadata$lo_to_workshop

  if (length(lo_records) == 0L) {
    return(data.frame(
      lo_id = character(),
      bloom = character(),
      workshop_traceability_ids = character(),
      workshop_count = integer(),
      mapping_status = character(),
      stringsAsFactors = FALSE
    ))
  }

  rows <- lapply(lo_records, function(item) {
    lo_id <- normalize_text(item$id)
    linked_wx <- vapply(
      lo_to_workshop,
      function(m) {
        if (identical(normalize_text(m$lo_id), lo_id)) normalize_text(m$workshop_id) else ""
      },
      character(1L)
    )

    linked_wx <- linked_wx[nzchar(linked_wx)]

    data.frame(
      lo_id = lo_id,
      bloom = tolower(normalize_text(item$bloom)),
      workshop_traceability_ids = join_unique_ids(linked_wx),
      workshop_count = length(unique(linked_wx)),
      mapping_status = if (length(linked_wx) > 0L) "mapped" else "unmapped",
      stringsAsFactors = FALSE
    )
  })

  out <- do.call(rbind, rows)
  out[order(out$lo_id), , drop = FALSE]
}

build_lo_to_review_table <- function(metadata) {
  lo_records <- metadata$learning_objectives
  lo_to_review <- metadata$lo_to_review

  if (length(lo_records) == 0L) {
    return(data.frame(
      lo_id = character(),
      bloom = character(),
      review_traceability_ids = character(),
      review_count = integer(),
      mapping_status = character(),
      stringsAsFactors = FALSE
    ))
  }

  rows <- lapply(lo_records, function(item) {
    lo_id <- normalize_text(item$id)
    linked_rq <- vapply(
      lo_to_review,
      function(m) {
        if (identical(normalize_text(m$lo_id), lo_id)) normalize_text(m$review_question_id) else ""
      },
      character(1L)
    )

    linked_rq <- linked_rq[nzchar(linked_rq)]

    data.frame(
      lo_id = lo_id,
      bloom = tolower(normalize_text(item$bloom)),
      review_traceability_ids = join_unique_ids(linked_rq),
      review_count = length(unique(linked_rq)),
      mapping_status = if (length(linked_rq) > 0L) "mapped" else "unmapped",
      stringsAsFactors = FALSE
    )
  })

  out <- do.call(rbind, rows)
  out[order(out$lo_id), , drop = FALSE]
}

build_exceptions_table <- function(coverage, workshop_entity, review_entity) {
  lo_gaps <- if (nrow(coverage) == 0L) {
    coverage
  } else {
    coverage[coverage$coverage_status != "covered-both", , drop = FALSE]
  }

  workshop_gaps <- if (nrow(workshop_entity) == 0L) {
    workshop_entity
  } else {
    workshop_entity[workshop_entity$mapping_status == "unmapped", , drop = FALSE]
  }

  review_gaps <- if (nrow(review_entity) == 0L) {
    review_entity
  } else {
    review_entity[review_entity$mapping_status == "unmapped", , drop = FALSE]
  }

  rows <- list()

  if (nrow(lo_gaps) > 0L) {
    rows[[length(rows) + 1L]] <- data.frame(
      entity_type = "learning_objective",
      entity_id = lo_gaps$lo_id,
      status = lo_gaps$coverage_status,
      details = paste0(
        "workshop_links=", lo_gaps$workshop_links,
        "; review_links=", lo_gaps$review_links
      ),
      stringsAsFactors = FALSE
    )
  }

  if (nrow(workshop_gaps) > 0L) {
    rows[[length(rows) + 1L]] <- data.frame(
      entity_type = "workshop_exercise",
      entity_id = workshop_gaps$workshop_traceability_id,
      status = workshop_gaps$mapping_status,
      details = paste0(
        "workshop_id=", workshop_gaps$workshop_id,
        "; exercise=", workshop_gaps$exercise,
        "; chunk=", workshop_gaps$chunk
      ),
      stringsAsFactors = FALSE
    )
  }

  if (nrow(review_gaps) > 0L) {
    rows[[length(rows) + 1L]] <- data.frame(
      entity_type = "review_question",
      entity_id = review_gaps$review_traceability_id,
      status = review_gaps$mapping_status,
      details = paste0(
        "chapter=", review_gaps$chapter,
        "; ordinal=", review_gaps$ordinal
      ),
      stringsAsFactors = FALSE
    )
  }

  if (length(rows) == 0L) {
    return(data.frame(
      entity_type = character(),
      entity_id = character(),
      status = character(),
      details = character(),
      stringsAsFactors = FALSE
    ))
  }

  out <- do.call(rbind, rows)
  out[order(out$entity_type, out$entity_id), , drop = FALSE]
}

write_markdown_report <- function(
  coverage,
  bloom_summary,
  workshop_entity,
  review_entity,
  lo_to_workshop,
  lo_to_review,
  exceptions,
  path
) {
  lines <- c(
    "# Learning Objective Coverage Report",
    "",
    sprintf("Generated: %s", format(Sys.time(), "%Y-%m-%d %H:%M:%S")),
    "",
    "## Objective Coverage",
    "",
    "| LO ID | Chapter | Scope | Section | Bloom | Workshop Links | Review Links | Status |",
    "|---|---:|---|---|---|---:|---:|---|"
  )

  if (nrow(coverage) == 0L) {
    lines <- c(lines, "| _none_ | - | - | - | - | - | - | - |")
  } else {
    for (i in seq_len(nrow(coverage))) {
      row <- coverage[i, , drop = FALSE]
      lines <- c(
        lines,
        sprintf(
          "| %s | %s | %s | %s | %s | %d | %d | %s |",
          row$lo_id,
          row$chapter,
          row$scope,
          ifelse(nzchar(row$section), row$section, "-"),
          ifelse(nzchar(row$bloom), row$bloom, "-"),
          row$workshop_links,
          row$review_links,
          row$coverage_status
        )
      )
    }
  }

  lines <- c(lines, "", "## Bloom Coverage Summary", "")
  lines <- c(lines, "| Bloom | Covered Both | Workshop Only | Review Only | Uncovered | Total |")
  lines <- c(lines, "|---|---:|---:|---:|---:|---:|")

  if (nrow(bloom_summary) == 0L) {
    lines <- c(lines, "| _none_ | - | - | - | - | - |")
  } else {
    for (i in seq_len(nrow(bloom_summary))) {
      row <- bloom_summary[i, , drop = FALSE]
      lines <- c(
        lines,
        sprintf(
          "| %s | %d | %d | %d | %d | %d |",
          row$bloom,
          row$covered_both,
          row$workshop_only,
          row$review_only,
          row$uncovered,
          row$total
        )
      )
    }
  }

  lines <- c(lines, "", "## Workshop Exercise Traceability (Entity -> LO)", "")
  lines <- c(lines, "| Workshop Traceability ID | Workshop | Exercise | Chunk | Linked LO IDs | LO Count | Status |")
  lines <- c(lines, "|---|---|---|---:|---|---:|---|")

  if (nrow(workshop_entity) == 0L) {
    lines <- c(lines, "| _none_ | - | - | - | - | - | - |")
  } else {
    for (i in seq_len(nrow(workshop_entity))) {
      row <- workshop_entity[i, , drop = FALSE]
      lines <- c(
        lines,
        sprintf(
          "| %s | %s | %s | %d | %s | %d | %s |",
          row$workshop_traceability_id,
          ifelse(nzchar(row$workshop_id), row$workshop_id, "-"),
          ifelse(nzchar(row$exercise), row$exercise, "-"),
          row$chunk,
          ifelse(nzchar(row$lo_ids), row$lo_ids, "-"),
          row$lo_count,
          row$mapping_status
        )
      )
    }
  }

  lines <- c(lines, "", "## Review Question Traceability (Entity -> LO)", "")
  lines <- c(lines, "| Review Traceability ID | Chapter | Ordinal | Linked LO IDs | LO Count | Status |")
  lines <- c(lines, "|---|---:|---:|---|---:|---|")

  if (nrow(review_entity) == 0L) {
    lines <- c(lines, "| _none_ | - | - | - | - | - |")
  } else {
    for (i in seq_len(nrow(review_entity))) {
      row <- review_entity[i, , drop = FALSE]
      lines <- c(
        lines,
        sprintf(
          "| %s | %d | %d | %s | %d | %s |",
          row$review_traceability_id,
          row$chapter,
          row$ordinal,
          ifelse(nzchar(row$lo_ids), row$lo_ids, "-"),
          row$lo_count,
          row$mapping_status
        )
      )
    }
  }

  lines <- c(lines, "", "## Learning Objectives -> Workshop Exercises", "")
  lines <- c(lines, "| LO ID | Bloom | Linked Workshop IDs | Workshop Count | Status |")
  lines <- c(lines, "|---|---|---|---:|---|")

  if (nrow(lo_to_workshop) == 0L) {
    lines <- c(lines, "| _none_ | - | - | - | - |")
  } else {
    for (i in seq_len(nrow(lo_to_workshop))) {
      row <- lo_to_workshop[i, , drop = FALSE]
      lines <- c(
        lines,
        sprintf(
          "| %s | %s | %s | %d | %s |",
          row$lo_id,
          ifelse(nzchar(row$bloom), row$bloom, "-"),
          ifelse(nzchar(row$workshop_traceability_ids), row$workshop_traceability_ids, "-"),
          row$workshop_count,
          row$mapping_status
        )
      )
    }
  }

  lines <- c(lines, "", "## Learning Objectives -> Review Questions", "")
  lines <- c(lines, "| LO ID | Bloom | Linked Review IDs | Review Count | Status |")
  lines <- c(lines, "|---|---|---|---:|---|")

  if (nrow(lo_to_review) == 0L) {
    lines <- c(lines, "| _none_ | - | - | - | - |")
  } else {
    for (i in seq_len(nrow(lo_to_review))) {
      row <- lo_to_review[i, , drop = FALSE]
      lines <- c(
        lines,
        sprintf(
          "| %s | %s | %s | %d | %s |",
          row$lo_id,
          ifelse(nzchar(row$bloom), row$bloom, "-"),
          ifelse(nzchar(row$review_traceability_ids), row$review_traceability_ids, "-"),
          row$review_count,
          row$mapping_status
        )
      )
    }
  }

  lines <- c(lines, "", "## Exceptions (Coverage Gaps)", "")
  lines <- c(lines, "| Entity Type | Entity ID | Status | Details |")
  lines <- c(lines, "|---|---|---|---|")

  if (nrow(exceptions) == 0L) {
    lines <- c(lines, "| _none_ | - | - | - |")
  } else {
    for (i in seq_len(nrow(exceptions))) {
      row <- exceptions[i, , drop = FALSE]
      lines <- c(
        lines,
        sprintf(
          "| %s | %s | %s | %s |",
          row$entity_type,
          row$entity_id,
          row$status,
          ifelse(nzchar(row$details), row$details, "-")
        )
      )
    }
  }

  dir.create(dirname(path), recursive = TRUE, showWarnings = FALSE)
  writeLines(lines, path)
}

main <- function() {
  args <- parse_cli_args(commandArgs(trailingOnly = TRUE))
  if (isTRUE(args$help)) {
    print_help()
    return(invisible(NULL))
  }

  metadata <- load_traceability_metadata(
    metadata_dir = args$metadata_dir,
    strict = TRUE
  )

  coverage <- build_lo_coverage_table(metadata)
  bloom_summary <- build_bloom_summary(coverage)
  workshop_entity <- build_workshop_entity_table(metadata)
  review_entity <- build_review_entity_table(metadata)
  lo_to_workshop <- build_lo_to_workshop_table(metadata)
  lo_to_review <- build_lo_to_review_table(metadata)
  exceptions <- build_exceptions_table(coverage, workshop_entity, review_entity)

  dir.create(args$output_dir, recursive = TRUE, showWarnings = FALSE)

  coverage_csv <- file.path(args$output_dir, "learning-objective-coverage.csv")
  bloom_csv <- file.path(args$output_dir, "learning-objective-bloom-summary.csv")
  workshop_entity_csv <- file.path(args$output_dir, "workshop-exercise-to-lo.csv")
  review_entity_csv <- file.path(args$output_dir, "review-question-to-lo.csv")
  lo_to_workshop_csv <- file.path(args$output_dir, "lo-to-workshop-links.csv")
  lo_to_review_csv <- file.path(args$output_dir, "lo-to-review-links.csv")
  exceptions_csv <- file.path(args$output_dir, "traceability-exceptions.csv")
  coverage_md <- file.path(args$output_dir, "learning-objective-coverage.md")

  utils::write.csv(coverage, coverage_csv, row.names = FALSE)
  utils::write.csv(bloom_summary, bloom_csv, row.names = FALSE)
  utils::write.csv(workshop_entity, workshop_entity_csv, row.names = FALSE)
  utils::write.csv(review_entity, review_entity_csv, row.names = FALSE)
  utils::write.csv(lo_to_workshop, lo_to_workshop_csv, row.names = FALSE)
  utils::write.csv(lo_to_review, lo_to_review_csv, row.names = FALSE)
  utils::write.csv(exceptions, exceptions_csv, row.names = FALSE)
  write_markdown_report(
    coverage,
    bloom_summary,
    workshop_entity,
    review_entity,
    lo_to_workshop,
    lo_to_review,
    exceptions,
    coverage_md
  )

  message("Generated ", coverage_csv)
  message("Generated ", bloom_csv)
  message("Generated ", workshop_entity_csv)
  message("Generated ", review_entity_csv)
  message("Generated ", lo_to_workshop_csv)
  message("Generated ", lo_to_review_csv)
  message("Generated ", exceptions_csv)
  message("Generated ", coverage_md)
}

if (sys.nframe() == 0L) {
  main()
}
