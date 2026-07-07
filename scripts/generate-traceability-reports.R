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

write_markdown_report <- function(coverage, bloom_summary, path) {
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

  dir.create(args$output_dir, recursive = TRUE, showWarnings = FALSE)

  coverage_csv <- file.path(args$output_dir, "learning-objective-coverage.csv")
  bloom_csv <- file.path(args$output_dir, "learning-objective-bloom-summary.csv")
  coverage_md <- file.path(args$output_dir, "learning-objective-coverage.md")

  utils::write.csv(coverage, coverage_csv, row.names = FALSE)
  utils::write.csv(bloom_summary, bloom_csv, row.names = FALSE)
  write_markdown_report(coverage, bloom_summary, coverage_md)

  message("Generated ", coverage_csv)
  message("Generated ", bloom_csv)
  message("Generated ", coverage_md)
}

if (sys.nframe() == 0L) {
  main()
}
