get_workshop_export_configs <- function() {
  list(
    list(
      id = "probability-distributions",
      source = "notebooks/support/probability-distributions/support.Rmd",
      expected_chunks = c(
        "1.1" = 3L,
        "1.2" = 1L,
        "1.3" = 2L,
        "1.4" = 2L,
        "1.5" = 1L,
        "1.6" = 2L,
        "1.7" = 2L
      )
    ),
    list(
      id = "hypothesis-testing",
      source = "notebooks/support/hypothesis-testing/support.Rmd",
      expected_chunks = c(
        "4.1" = 3L,
        "4.2" = 1L,
        "4.3" = 1L,
        "4.4" = 1L,
        "4.5" = 3L,
        "4.6" = 3L,
        "4.7" = 3L,
        "4.8" = 7L,
        "4.9" = 1L,
        "4.10" = 2L
      )
    )
  )
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
