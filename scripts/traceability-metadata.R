source("scripts/traceability-id-conventions.R", chdir = FALSE)

read_traceability_yaml <- function(path, entity_name) {
  if (!file.exists(path)) {
    stop("Missing traceability metadata file for ", entity_name, ": ", path)
  }

  data <- yaml::read_yaml(path)
  if (is.null(data)) {
    return(list())
  }
  if (!is.list(data)) {
    stop("Traceability file must contain a list of records: ", path)
  }

  data
}

extract_required_field <- function(records, field, entity_name, source_path) {
  values <- vapply(
    records,
    function(record) {
      if (!is.list(record) || is.null(record[[field]]) || !nzchar(record[[field]])) {
        stop("Record in ", source_path, " missing required field '", field, "' for ", entity_name)
      }
      as.character(record[[field]])
    },
    character(1L)
  )
  values
}

validate_traceability_mappings <- function(metadata) {
  lo_ids <- extract_required_field(
    metadata$learning_objectives,
    "id",
    "learning objective",
    metadata$paths$learning_objectives
  )
  wx_ids <- extract_required_field(
    metadata$workshop_exercises,
    "id",
    "workshop exercise",
    metadata$paths$workshop_exercises
  )
  rq_ids <- extract_required_field(
    metadata$review_questions,
    "id",
    "review question",
    metadata$paths$review_questions
  )

  assert_valid_learning_objective_ids(lo_ids)
  assert_valid_workshop_exercise_ids(wx_ids)
  assert_valid_review_question_ids(rq_ids)

  if (length(metadata$lo_to_workshop) > 0L) {
    map_lo <- extract_required_field(
      metadata$lo_to_workshop,
      "lo_id",
      "LO to workshop mapping",
      metadata$paths$lo_to_workshop
    )
    map_wx <- extract_required_field(
      metadata$lo_to_workshop,
      "workshop_id",
      "LO to workshop mapping",
      metadata$paths$lo_to_workshop
    )

    unknown_lo <- unique(setdiff(map_lo, lo_ids))
    unknown_wx <- unique(setdiff(map_wx, wx_ids))
    if (length(unknown_lo) > 0L) {
      stop("Unknown LO IDs in lo_to_workshop: ", paste(unknown_lo, collapse = ", "))
    }
    if (length(unknown_wx) > 0L) {
      stop("Unknown workshop IDs in lo_to_workshop: ", paste(unknown_wx, collapse = ", "))
    }
  }

  if (length(metadata$lo_to_review) > 0L) {
    map_lo <- extract_required_field(
      metadata$lo_to_review,
      "lo_id",
      "LO to review mapping",
      metadata$paths$lo_to_review
    )
    map_rq <- extract_required_field(
      metadata$lo_to_review,
      "review_question_id",
      "LO to review mapping",
      metadata$paths$lo_to_review
    )

    unknown_lo <- unique(setdiff(map_lo, lo_ids))
    unknown_rq <- unique(setdiff(map_rq, rq_ids))
    if (length(unknown_lo) > 0L) {
      stop("Unknown LO IDs in lo_to_review: ", paste(unknown_lo, collapse = ", "))
    }
    if (length(unknown_rq) > 0L) {
      stop("Unknown review question IDs in lo_to_review: ", paste(unknown_rq, collapse = ", "))
    }
  }
}

load_traceability_metadata <- function(metadata_dir = "metadata/traceability", strict = FALSE) {
  if (!dir.exists(metadata_dir)) {
    return(list(enabled = FALSE, reason = "metadata directory not found", directory = metadata_dir))
  }

  if (!requireNamespace("yaml", quietly = TRUE)) {
    stop("The yaml package is required to read traceability metadata.")
  }

  paths <- list(
    learning_objectives = file.path(metadata_dir, "learning_objectives.yml"),
    workshop_exercises = file.path(metadata_dir, "workshop_exercises.yml"),
    review_questions = file.path(metadata_dir, "review_questions.yml"),
    lo_to_workshop = file.path(metadata_dir, "lo_to_workshop.yml"),
    lo_to_review = file.path(metadata_dir, "lo_to_review.yml")
  )

  missing_files <- names(paths)[!file.exists(unlist(paths, use.names = FALSE))]
  if (length(missing_files) > 0L) {
    message_text <- paste(
      "Traceability metadata directory exists but required file(s) are missing:",
      paste(missing_files, collapse = ", ")
    )
    if (isTRUE(strict)) {
      stop(message_text)
    }
    return(list(enabled = FALSE, reason = message_text, directory = metadata_dir))
  }

  metadata <- list(
    enabled = TRUE,
    directory = metadata_dir,
    paths = paths,
    learning_objectives = read_traceability_yaml(paths$learning_objectives, "learning objectives"),
    workshop_exercises = read_traceability_yaml(paths$workshop_exercises, "workshop exercises"),
    review_questions = read_traceability_yaml(paths$review_questions, "review questions"),
    lo_to_workshop = read_traceability_yaml(paths$lo_to_workshop, "LO to workshop mappings"),
    lo_to_review = read_traceability_yaml(paths$lo_to_review, "LO to review mappings")
  )

  validate_traceability_mappings(metadata)
  metadata
}

build_workshop_traceability_id <- function(workshop_id, exercise, chunk_index) {
  sprintf("WX-%s-%s-%d", workshop_id, exercise, chunk_index)
}
