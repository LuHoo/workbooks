#!/usr/bin/env Rscript

policy_name <- "deterministic-sampling-v2"

args <- commandArgs(trailingOnly = TRUE)

if (length(args) > 0) {
  if (length(args) != 2 || args[[1]] != "--policy") {
    stop(
      "Usage: Rscript scripts/ci/execute-r-workshop-smoke.R [--policy ",
      policy_name,
      "]"
    )
  }
  if (args[[2]] != policy_name) {
    stop(
      "Unsupported R workshop coverage policy: ", args[[2]],
      ". Supported policy: ", policy_name,
      "."
    )
  }
}

workshops <- list(
  list(
    chapter = "hypothesis-testing",
    path = "notebooks/workshops/Hypothesis testing workshop.Rmd",
    reason = "Covers inferential workflow and FSaudit/aicpa runtime integration"
  ),
  list(
    chapter = "regression-analysis",
    path = "notebooks/workshops/Regression analysis workshop.Rmd",
    reason = "Covers the heaviest runtime path and catches complex model/dependency regressions"
  )
)

output_dir <- "generated/notebook-execution-artifacts/r-smoke"
dir.create(output_dir, recursive = TRUE, showWarnings = FALSE)

runtime <- list(
  r_version = as.character(getRversion()),
  fsaudit_version = as.character(packageVersion("FSaudit"))
)

cat("R runtime diagnostics:\n")
print(runtime)

cat("R workshop execution coverage policy: ", policy_name, "\n", sep = "")
cat("Selected workshops:\n")
for (entry in workshops) {
  cat(
    "- Chapter: ", entry$chapter,
    " | Notebook: ", entry$path,
    " | Reason: ", entry$reason,
    "\n",
    sep = ""
  )
}

failures <- list()

record_failure <- function(chapter, notebook, stage, err_message) {
  failures[[length(failures) + 1]] <<- list(
    chapter = chapter,
    notebook = notebook,
    stage = stage,
    error = err_message
  )
}

for (entry in workshops) {
  workshop <- entry$path

  if (!file.exists(workshop)) {
    record_failure(
      chapter = entry$chapter,
      notebook = workshop,
      stage = "preflight-exists",
      err_message = paste0(
        "Missing workshop notebook. ",
        "Remediation: ensure notebooks/workshops submodule content is checked out ",
        "(actions/checkout with submodules: recursive) before CI/local execution."
      )
    )
    next
  }

  output_file <- file.path(output_dir, paste0(basename(workshop), ".md"))

  cat("Knitting chapter ", entry$chapter, ": ", workshop, "\n", sep = "")
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
      record_failure(
        chapter = entry$chapter,
        notebook = workshop,
        stage = "knit",
        err_message = paste0(
          conditionMessage(err),
          ". Remediation: verify Binder/CI R dependencies and chapter data availability."
        )
      )
    }
  )
}

if (length(failures) > 0) {
  cat("\nR workshop execution validation failed.\n")
  cat("Coverage policy: ", policy_name, "\n", sep = "")
  for (failure in failures) {
    cat(
      "\nChapter: ", failure$chapter,
      "\nNotebook: ", failure$notebook,
      "\nStage: ", failure$stage,
      "\nError: ", failure$error,
      "\n",
      sep = ""
    )
  }
  stop(
    "R workshop execution gate failed under ",
    policy_name,
    ": ",
    length(failures),
    " of ",
    length(workshops),
    " selected notebooks failed.",
    call. = FALSE
  )
}

cat(
  "R workshop execution validation passed under ",
  policy_name,
  " (",
  length(workshops),
  "/",
  length(workshops),
  " selected notebooks executed).\n",
  sep = ""
)
