#!/usr/bin/env Rscript

source("scripts/workshop-export-config.R", chdir = FALSE)
source("scripts/workshop-ir.R", chdir = FALSE)
source("scripts/workshop-ir-validate.R", chdir = FALSE)

parse_args <- function(args) {
  out <- list(
    config_id = NULL,
    output_dir = "generated/python-notebooks",
    renderer = "scripts/workshop-ir-python-renderer.py",
    python = "python3"
  )

  i <- 1L
  while (i <= length(args)) {
    arg <- args[[i]]
    if (identical(arg, "--config-id")) {
      i <- i + 1L
      if (i > length(args)) stop("Missing value after --config-id")
      out$config_id <- args[[i]]
    } else if (identical(arg, "--output-dir")) {
      i <- i + 1L
      if (i > length(args)) stop("Missing value after --output-dir")
      out$output_dir <- args[[i]]
    } else if (identical(arg, "--renderer")) {
      i <- i + 1L
      if (i > length(args)) stop("Missing value after --renderer")
      out$renderer <- args[[i]]
    } else if (identical(arg, "--python")) {
      i <- i + 1L
      if (i > length(args)) stop("Missing value after --python")
      out$python <- args[[i]]
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
    "  Rscript scripts/export-python-notebooks.R [options]\n\n",
    "Options:\n",
    "  --config-id <id>       Render one configured workshop id only.\n",
    "  --output-dir <path>    Output directory (default: generated/python-notebooks).\n",
    "  --renderer <path>      Python renderer path (default: scripts/workshop-ir-python-renderer.py).\n",
    "  --python <binary>      Python executable (default: python3).\n",
    "  --help                 Show this help.\n",
    sep = ""
  )
}

resolve_configs <- function(config_id = NULL) {
  configs <- get_workshop_export_configs()
  if (is.null(config_id)) {
    return(configs)
  }

  matched <- Filter(function(cfg) identical(cfg$id, config_id), configs)
  if (length(matched) != 1L) {
    stop(
      "Unknown config id '", config_id, "'. Supported values: ",
      paste(vapply(configs, function(cfg) cfg$id, character(1L)), collapse = ", ")
    )
  }
  matched
}

render_config <- function(config, output_dir, renderer_path, python_bin) {
  ir <- parse_support_notebook_to_ir(input_path = config$source)
  validate_workshop_ir(
    ir = ir,
    source_path = config$source,
    config = config,
    strict = TRUE
  )

  ir_json <- jsonlite::toJSON(ir, auto_unbox = TRUE, null = "null", pretty = FALSE)
  ir_tmp <- tempfile(pattern = paste0("ir-", config$id, "-"), fileext = ".json")
  writeLines(ir_json, ir_tmp, useBytes = TRUE)

  chapter_number <- ir$chapter$chapter_number
  output_path <- file.path(output_dir, config$id, paste0("chapter-", chapter_number, ".ipynb"))
  dir.create(dirname(output_path), recursive = TRUE, showWarnings = FALSE)

  args <- c(
    renderer_path,
    "--input-ir", ir_tmp,
    "--output-notebook", output_path,
    "--target-language", "python",
    "--exercise-refs", paste(names(config$expected_chunks), collapse = ",")
  )

  out <- system2(python_bin, args = args, stdout = TRUE, stderr = TRUE)
  status <- attr(out, "status")
  if (!is.null(status) && status != 0L) {
    stop(
      "Python renderer failed for config ", config$id,
      " with status ", status, ":\n",
      paste(out, collapse = "\n")
    )
  }

  message("Generated ", output_path, " from ", config$source)
  invisible(output_path)
}

main <- function() {
  args <- parse_args(commandArgs(trailingOnly = TRUE))
  if (isTRUE(args$help)) {
    print_help()
    return(invisible(NULL))
  }

  if (!requireNamespace("jsonlite", quietly = TRUE)) {
    stop("jsonlite is required to export Python notebooks from IR")
  }

  if (!file.exists(args$renderer)) {
    stop("Renderer not found: ", args$renderer)
  }

  configs <- resolve_configs(args$config_id)
  outputs <- lapply(configs, function(cfg) {
    render_config(cfg, args$output_dir, args$renderer, args$python)
  })

  invisible(outputs)
}

if (sys.nframe() == 0L) {
  main()
}
