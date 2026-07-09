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
      id = "auxiliary-variables-and-stratification",
      source = "notebooks/support/auxiliary-variables-and-stratification/support.Rmd",
      expected_chunks = c(
        "3.1" = 1L,
        "3.2" = 7L,
        "3.3" = 4L,
        "3.4" = 3L,
        "3.5" = 3L,
        "3.6" = 4L,
        "3.7" = 7L,
        "3.8" = 2L,
        "3.9" = 7L
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
    ),
    list(
      id = "regression-analysis",
      source = "notebooks/support/regression-analysis/support.Rmd",
      expected_chunks = c(
        "5.1" = 1L,
        "5.2" = 1L,
        "5.3" = 8L,
        "5.4" = 1L,
        "5.5" = 1L,
        "5.6" = 2L,
        "5.7" = 4L,
        "5.8" = 1L,
        "5.9" = 3L,
        "5.10" = 1L,
        "5.11" = 1L,
        "5.12" = 1L,
        "5.13" = 3L,
        "5.14" = 1L,
        "5.15" = 2L,
        "5.16" = 1L,
        "5.17" = 2L,
        "5.18" = 2L,
        "5.19" = 5L,
        "5.20" = 3L,
        "5.21" = 1L,
        "5.22" = 2L,
        "5.23" = 3L,
        "5.24" = 2L,
        "5.25" = 2L,
        "5.26" = 4L,
        "5.27" = 1L,
        "5.28" = 1L,
        "5.29" = 1L,
        "5.30" = 1L,
        "5.31" = 4L,
        "5.32" = 1L,
        "5.33" = 2L,
        "5.34" = 1L,
        "5.35" = 2L
      )
    ),
    list(
      id = "goodness-of-fit",
      source = "notebooks/support/goodness-of-fit/support.Rmd",
      expected_chunks = c(
        "6.1" = 1L,
        "6.2" = 18L
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

resolve_workshop_export_config_by_id <- function(config_id) {
  configs <- get_workshop_export_configs()
  for (config in configs) {
    if (identical(config$id, config_id)) {
      return(config)
    }
  }
  NULL
}
