registry_source_path <- function() {
  frame_files <- vapply(
    sys.frames(),
    function(env) {
      file <- env$ofile
      if (is.null(file)) "" else as.character(file)
    },
    character(1L)
  )

  caller_files <- frame_files[nzchar(frame_files)]
  this_script <- caller_files[grepl("workshop-export-config\\.R$", caller_files)]

  candidates <- c()
  if (length(this_script)) {
    candidates <- c(
      candidates,
      file.path(dirname(normalizePath(this_script[[1]], winslash = "/", mustWork = FALSE)), "..", "metadata", "workshop-registry.R")
    )
  }
  candidates <- c(candidates, file.path(getwd(), "metadata", "workshop-registry.R"))

  for (candidate in candidates) {
    if (file.exists(candidate)) {
      return(normalizePath(candidate, winslash = "/", mustWork = TRUE))
    }
  }

  stop("Canonical workshop registry not found. Tried: ", paste(candidates, collapse = ", "))
}

source(registry_source_path(), chdir = FALSE)

validate_expected_chunks <- function(expected_chunks, workshop_id) {
  if (is.null(expected_chunks) || !length(expected_chunks)) {
    stop("Registry entry '", workshop_id, "' has no expected_chunks")
  }
  if (is.null(names(expected_chunks)) || any(!nzchar(names(expected_chunks)))) {
    stop("Registry entry '", workshop_id, "' has unnamed expected_chunks")
  }
  if (!all(grepl("^[0-9]+\\.[0-9]+$", names(expected_chunks)))) {
    stop(
      "Registry entry '", workshop_id,
      "' has invalid expected_chunks keys: expected <chapter>.<exercise>"
    )
  }

  chunk_counts <- as.integer(expected_chunks)
  if (any(is.na(chunk_counts)) || any(chunk_counts < 1L)) {
    stop("Registry entry '", workshop_id, "' has invalid expected_chunks values")
  }

  stats::setNames(chunk_counts, names(expected_chunks))
}

validate_registry_entry <- function(entry, index) {
  required_fields <- c("id", "chapter", "title", "expected_chunks")
  missing <- required_fields[!vapply(required_fields, function(field) !is.null(entry[[field]]), logical(1L))]
  if (length(missing) > 0L) {
    stop(
      "Registry entry #", index,
      " is missing required fields: ",
      paste(missing, collapse = ", ")
    )
  }

  id <- as.character(entry$id)
  title <- as.character(entry$title)
  chapter <- as.integer(entry$chapter)

  if (!nzchar(id)) {
    stop("Registry entry #", index, " has empty id")
  }
  if (!nzchar(title)) {
    stop("Registry entry '", id, "' has empty title")
  }
  if (is.na(chapter) || chapter < 1L) {
    stop("Registry entry '", id, "' has invalid chapter number")
  }

  expected_chunks <- validate_expected_chunks(entry$expected_chunks, id)

  list(
    id = id,
    chapter = chapter,
    title = title,
    expected_chunks = expected_chunks
  )
}

canonical_registry_entries <- function() {
  entries <- get_canonical_workshop_registry_entries()
  if (!is.list(entries) || !length(entries)) {
    stop("Canonical workshop registry is empty: ", registry_source_path())
  }

  normalized <- lapply(seq_along(entries), function(i) validate_registry_entry(entries[[i]], i))

  ids <- vapply(normalized, function(entry) entry$id, character(1L))
  if (anyDuplicated(ids)) {
    dup <- unique(ids[duplicated(ids)])
    stop("Canonical workshop registry has duplicate ids: ", paste(dup, collapse = ", "))
  }

  normalized
}

make_workshop_export_config <- function(entry) {
  list(
    id = entry$id,
    chapter = as.integer(entry$chapter),
    title = entry$title,
    source = file.path("notebooks", "support", entry$id, "support.Rmd"),
    expected_chunks = entry$expected_chunks,
    r_workshop_output = file.path("notebooks", "workshops", paste0(entry$title, " workshop.Rmd")),
    published_python_output = sprintf("Workshop %d (Python).ipynb", as.integer(entry$chapter))
  )
}

get_workshop_export_configs <- function() {
  lapply(canonical_registry_entries(), make_workshop_export_config)
}

as_notebook_manifest_entry <- function(config) {
  list(
    slug = config$id,
    chapter = config$chapter,
    title = config$title,
    source = config$source,
    output = config$r_workshop_output
  )
}

get_notebook_manifest <- function() {
  lapply(get_workshop_export_configs(), as_notebook_manifest_entry)
}

resolve_notebook_manifest_entry_by_slug <- function(slug) {
  notebooks <- get_notebook_manifest()
  for (notebook in notebooks) {
    if (identical(notebook$slug, slug)) {
      return(notebook)
    }
  }
  NULL
}

resolve_workshop_export_config <- function(input_path) {
  input_norm <- normalizePath(input_path, winslash = "/", mustWork = FALSE)
  configs <- get_workshop_export_configs()
  for (config in configs) {
    config_norm <- normalizePath(config$source, winslash = "/", mustWork = FALSE)
    if (identical(input_norm, config_norm)) {
      return(config)
    }
  }
  NULL
}

resolve_workshop_export_config_by_id <- function(config_id) {
  configs <- get_workshop_export_configs()
  for (config in configs) {
    if (identical(config$id, config_id)) {
      return(config)
    }
  }
  NULL
}
