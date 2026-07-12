source("scripts/workshop-ir.R", chdir = FALSE)
source("scripts/workshop-ir-validate.R", chdir = FALSE)

as_workshop_model <- function(ir) {
  structure(
    list(
      schema_version = ir$schema_version,
      source = ir$source,
      chapter = ir$chapter,
      directives = ir$directives,
      chapter_blocks = ir$chapter_blocks,
      exercises = ir$exercises,
      ir = ir
    ),
    class = "workshop_model"
  )
}

build_workshop_model <- function(
  input_path,
  config = NULL,
  workshop_id = NULL,
  chapter_number = NULL,
  chapter_title = NULL,
  strict = TRUE
) {
  ir <- parse_support_notebook_to_ir(
    input_path = input_path,
    workshop_id = workshop_id,
    chapter_number = chapter_number,
    chapter_title = chapter_title
  )

  validate_workshop_ir(
    ir = ir,
    source_path = input_path,
    config = config,
    strict = strict
  )

  as_workshop_model(ir)
}
