# Utilities shared by private support notebooks.

notebook_repo_root <- function(start = getwd()) {
  path <- normalizePath(start, mustWork = TRUE)

  repeat {
    if (file.exists(file.path(path, ".git"))) return(path)
    parent <- dirname(path)
    if (identical(parent, path)) {
      stop("Could not find the repository root from: ", start, call. = FALSE)
    }
    path <- parent
  }
}

#' Save a support-notebook figure for use by the book
#'
#' Filenames are preserved exactly because they may be referenced by LaTeX.
#' A `.pdf` suffix is added only when no extension was supplied.
save_book_figure <- function(plot, filename, width = 10, height = 6.18,
                             device = "pdf", dpi = 300, ...) {
  if (missing(plot)) stop("`plot` is required.", call. = FALSE)
  if (missing(filename)) stop("`filename` is required.", call. = FALSE)
  if (!is.character(filename) || length(filename) != 1L || is.na(filename)) {
    stop("`filename` must be one non-missing character string.", call. = FALSE)
  }
  if (!nzchar(trimws(filename))) {
    stop("`filename` must not be empty.", call. = FALSE)
  }
  if (grepl("[/\\\\]$", filename) || basename(filename) %in% c(".", "..") ||
      dir.exists(filename)) {
    stop("`filename` must name a file, not a directory: ", filename, call. = FALSE)
  }

  if (!nzchar(tools::file_ext(basename(filename)))) {
    filename <- paste0(filename, ".pdf")
  }

  output_dir <- file.path(notebook_repo_root(), "PNG_files")
  dir.create(output_dir, recursive = TRUE, showWarnings = FALSE)
  output_path <- file.path(output_dir, filename)
  dir.create(dirname(output_path), recursive = TRUE, showWarnings = FALSE)

  ggplot2::ggsave(
    filename = output_path,
    plot = plot,
    width = width,
    height = height,
    device = device,
    dpi = dpi,
    ...
  )

  invisible(output_path)
}

#' Save a base-R support-notebook figure for use by the book
#'
#' `plot_code` is evaluated while a PDF graphics device is open. This companion
#' is for plots from base R and packages such as car that do not return ggplots.
save_book_base_figure <- function(plot_code, filename, width = 10,
                                  height = 6.18, ...) {
  if (missing(plot_code)) stop("`plot_code` is required.", call. = FALSE)
  if (missing(filename)) stop("`filename` is required.", call. = FALSE)
  if (!is.character(filename) || length(filename) != 1L || is.na(filename) ||
      !nzchar(trimws(filename))) {
    stop("`filename` must be one non-empty character string.", call. = FALSE)
  }
  if (grepl("[/\\\\]$", filename) || basename(filename) %in% c(".", "..") ||
      dir.exists(filename)) {
    stop("`filename` must name a file, not a directory: ", filename, call. = FALSE)
  }
  if (!nzchar(tools::file_ext(basename(filename)))) {
    filename <- paste0(filename, ".pdf")
  }
  if (!identical(tolower(tools::file_ext(filename)), "pdf")) {
    stop("Base-R book figures currently require a PDF filename.", call. = FALSE)
  }

  output_dir <- file.path(notebook_repo_root(), "PNG_files")
  dir.create(output_dir, recursive = TRUE, showWarnings = FALSE)
  output_path <- file.path(output_dir, filename)
  dir.create(dirname(output_path), recursive = TRUE, showWarnings = FALSE)

  grDevices::pdf(output_path, width = width, height = height, ...)
  on.exit(grDevices::dev.off(), add = TRUE)
  eval(substitute(plot_code), envir = parent.frame())

  invisible(output_path)
}
