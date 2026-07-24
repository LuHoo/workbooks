#!/usr/bin/env Rscript

parse_args <- function(args) {
  out <- list(
    output_dir = "rendered-workshops",
    type = "all",
    limit = NA_integer_,
    help = FALSE
  )

  i <- 1L
  while (i <= length(args)) {
    arg <- args[[i]]
    if (identical(arg, "--output-dir")) {
      i <- i + 1L
      if (i > length(args)) stop("Missing value after --output-dir")
      out$output_dir <- args[[i]]
    } else if (identical(arg, "--type")) {
      i <- i + 1L
      if (i > length(args)) stop("Missing value after --type")
      out$type <- args[[i]]
    } else if (identical(arg, "--limit")) {
      i <- i + 1L
      if (i > length(args)) stop("Missing value after --limit")
      out$limit <- as.integer(args[[i]])
      if (is.na(out$limit) || out$limit < 1L) stop("--limit must be a positive integer")
    } else if (identical(arg, "--help") || identical(arg, "-h")) {
      out$help <- TRUE
    } else {
      stop("Unsupported option: ", arg)
    }
    i <- i + 1L
  }

  if (!out$type %in% c("all", "rmd", "ipynb")) {
    stop("--type must be one of: all, rmd, ipynb")
  }

  out
}

print_help <- function() {
  cat(
    "Usage:\n",
    "  Rscript scripts/render-workshop-word.R [options]\n\n",
    "Options:\n",
    "  --output-dir <path>  Folder for rendered .docx files (default: rendered-workshops).\n",
    "  --type <kind>       Render all, rmd, or ipynb inputs (default: all).\n",
    "  --limit <n>         Render only the first n selected files; useful for smoke tests.\n",
    "  --help              Show this help.\n",
    sep = ""
  )
}

slugify <- function(path) {
  stem <- tools::file_path_sans_ext(basename(path))
  stem <- gsub("\\s+", "-", stem)
  stem <- gsub("[()]", "", stem)
  stem <- gsub("[^A-Za-z0-9._-]+", "-", stem)
  stem <- gsub("-+", "-", stem)
  tolower(gsub("^-|-$", "", stem))
}

collect_inputs <- function(type) {
  rmd <- character()
  ipynb <- character()

  if (type %in% c("all", "rmd")) {
    source("scripts/workshop-export-config.R", chdir = FALSE)
    rmd <- vapply(
      get_workshop_export_configs(),
      function(config) config$r_workshop_output,
      character(1L)
    )
    rmd <- rmd[file.exists(rmd)]
  }

  if (type %in% c("all", "ipynb")) {
    ipynb <- list.files(
      "notebooks/workshops",
      pattern = "\\.ipynb$",
      full.names = TRUE
    )
  }

  c(rmd, sort(ipynb))
}

render_one <- function(input_path, output_dir, render_env) {
  kind <- if (grepl("\\.Rmd$", input_path, ignore.case = TRUE)) "rmd" else "ipynb"
  output_file <- paste0(slugify(input_path), "-", kind, ".docx")
  dir.create(output_dir, recursive = TRUE, showWarnings = FALSE)
  output_dir_abs <- normalizePath(output_dir, winslash = "/", mustWork = TRUE)
  output_path <- file.path(output_dir_abs, output_file)

  message("Rendering ", input_path, " -> ", output_path)
  if (identical(kind, "ipynb")) {
    rmarkdown::pandoc_convert(
      input = normalizePath(input_path, winslash = "/", mustWork = TRUE),
      to = "docx",
      output = normalizePath(output_path, winslash = "/", mustWork = FALSE),
      options = c("--standalone")
    )
  } else {
    rmarkdown::render(
      input = input_path,
      output_format = "word_document",
      output_file = output_file,
      output_dir = output_dir_abs,
      envir = render_env,
      clean = TRUE,
      quiet = TRUE
    )
  }
  output_path
}

main <- function() {
  args <- parse_args(commandArgs(trailingOnly = TRUE))
  if (isTRUE(args$help)) {
    print_help()
    return(invisible(NULL))
  }

  if (!requireNamespace("rmarkdown", quietly = TRUE)) {
    stop("The rmarkdown package is required.")
  }
  if (!rmarkdown::pandoc_available()) {
    stop(
      "Pandoc is required to render Word documents. ",
      "Install it with `brew install pandoc`, or set RSTUDIO_PANDOC to an existing Pandoc folder."
    )
  }

  inputs <- collect_inputs(args$type)
  if (!length(inputs)) {
    stop("No workshop notebooks found for type: ", args$type)
  }

  if (!is.na(args$limit)) {
    inputs <- head(inputs, args$limit)
  }

  render_env <- globalenv()
  outputs <- vapply(
    inputs,
    render_one,
    character(1L),
    output_dir = args$output_dir,
    render_env = render_env
  )
  message("Rendered ", length(outputs), " Word document(s) to ", args$output_dir)
  invisible(outputs)
}

if (sys.nframe() == 0L) {
  main()
}
