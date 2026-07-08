# Identifier conventions for learning-objective traceability.
#
# This module provides stable regex-based ID validation for:
# - learning objectives (LO)
# - workshop exercises (WX)
# - review questions (RQ)

TRACEABILITY_ID_PATTERNS <- list(
  lo_chapter = "^LO-C[0-9]+-[0-9]{2}$",
  lo_section = "^LO-C[0-9]+S[0-9]+\\.[0-9]+-[0-9]{2}$",
  workshop_exercise = "^WX-[a-z0-9-]+-[0-9]+\\.[0-9]+-[0-9]+$",
  review_question = "^RQ-C[0-9]+-[0-9]{3}$"
)

is_valid_learning_objective_id <- function(id) {
  if (!is.character(id) || length(id) != 1L || is.na(id)) {
    return(FALSE)
  }

  grepl(TRACEABILITY_ID_PATTERNS$lo_chapter, id) ||
    grepl(TRACEABILITY_ID_PATTERNS$lo_section, id)
}

is_valid_workshop_exercise_id <- function(id) {
  if (!is.character(id) || length(id) != 1L || is.na(id)) {
    return(FALSE)
  }

  grepl(TRACEABILITY_ID_PATTERNS$workshop_exercise, id)
}

is_valid_review_question_id <- function(id) {
  if (!is.character(id) || length(id) != 1L || is.na(id)) {
    return(FALSE)
  }

  grepl(TRACEABILITY_ID_PATTERNS$review_question, id)
}

assert_unique_ids <- function(ids, entity_name) {
  if (!is.character(ids)) {
    stop(entity_name, " IDs must be a character vector.")
  }

  duplicates <- unique(ids[duplicated(ids)])
  if (length(duplicates) > 0L) {
    stop(
      "Duplicate ", entity_name, " IDs found: ",
      paste(duplicates, collapse = ", ")
    )
  }

  TRUE
}

assert_valid_learning_objective_ids <- function(ids) {
  assert_unique_ids(ids, "learning objective")

  invalid <- ids[!vapply(ids, is_valid_learning_objective_id, logical(1L))]
  if (length(invalid) > 0L) {
    stop(
      "Invalid learning objective IDs: ",
      paste(unique(invalid), collapse = ", "),
      ". Expected LO-C<chapter>-NN or LO-C<chapter>S<section>-NN."
    )
  }

  TRUE
}

assert_valid_workshop_exercise_ids <- function(ids) {
  assert_unique_ids(ids, "workshop exercise")

  invalid <- ids[!vapply(ids, is_valid_workshop_exercise_id, logical(1L))]
  if (length(invalid) > 0L) {
    stop(
      "Invalid workshop exercise IDs: ",
      paste(unique(invalid), collapse = ", "),
      ". Expected WX-<workshop_id>-<exercise>-<chunk>."
    )
  }

  TRUE
}

assert_valid_review_question_ids <- function(ids) {
  assert_unique_ids(ids, "review question")

  invalid <- ids[!vapply(ids, is_valid_review_question_id, logical(1L))]
  if (length(invalid) > 0L) {
    stop(
      "Invalid review question IDs: ",
      paste(unique(invalid), collapse = ", "),
      ". Expected RQ-C<chapter>-NNN."
    )
  }

  TRUE
}
