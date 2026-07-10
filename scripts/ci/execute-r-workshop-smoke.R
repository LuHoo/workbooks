#!/usr/bin/env Rscript

workshops <- c(
  "notebooks/workshops/Probability distributions workshop.Rmd",
  "notebooks/workshops/Hypothesis testing workshop.Rmd"
)

output_dir <- "generated/notebook-execution-artifacts/r-smoke"
dir.create(output_dir, recursive = TRUE, showWarnings = FALSE)

runtime <- list(
  r_version = as.character(getRversion()),
  fsaudit_version = as.character(packageVersion("FSaudit"))
)

cat("R runtime diagnostics:\n")
print(runtime)

for (workshop in workshops) {
  if (!file.exists(workshop)) {
    stop(
      "Missing workshop notebook: ", workshop,
      ". Remediation: ensure notebooks/workshops submodule content is checked out (actions/checkout with submodules: recursive) before CI execution."
    )
  }

  output_file <- file.path(output_dir, paste0(basename(workshop), ".md"))

  cat("Knitting ", workshop, "\n", sep = "")
  tryCatch(
    {
      knitr::knit(
        input = workshop,
        output = output_file,
        quiet = TRUE,
        envir = new.env(parent = globalenv())
      )
    },
    error = function(err) {
      stop(
        "R workshop execution failed for ", workshop,
        ". Error: ", conditionMessage(err),
        ". Remediation: verify Binder/CI R dependencies and chapter data availability."
      )
    }
  )
}

cat("Representative R workshop notebooks executed successfully\n")
