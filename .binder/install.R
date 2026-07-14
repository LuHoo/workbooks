snapshot <- Sys.getenv("ADA_RSPM_SNAPSHOT", unset = "2024-10-15")
options(repos = c(
  CRAN = sprintf(
    "https://packagemanager.posit.co/cran/__linux__/jammy/%s",
    snapshot
  )
))

required_packages <- c(
  "IRkernel",
  "jsonlite",
  "knitr",
  "rmarkdown",
  "remotes",
  "devtools",
  "readr",
  "ggplot2",
  "car",
  "pbkrtest",
  "lme4",
  "nloptr",
  "gridExtra",
  "tidyr",
  "corrplot",
  "lmtest",
  "latex2exp",
  "scales"
)

install.packages(required_packages)

remotes::install_github(
  "LuHoo/FSaudit@5a36801a712d9d736bb2c5a3992e7b8b644c7418",
  upgrade = "never",
  dependencies = TRUE
)

remotes::install_github(
  "LuHoo/aicpa@4a49d0357544eb22ed3314005af2f82b3cf0f53a",
  upgrade = "never",
  dependencies = TRUE
)

missing_packages <- required_packages[!vapply(required_packages, requireNamespace, quietly = TRUE, FUN.VALUE = logical(1L))]
if (length(missing_packages) > 0L) {
  stop(
    sprintf(
      "Binder build failed: required R packages unavailable after installation: %s",
      paste(missing_packages, collapse = ", ")
    )
  )
}

for (pkg in c("FSaudit", "aicpa")) {
  if (!requireNamespace(pkg, quietly = TRUE)) {
    stop(sprintf("Binder build failed: required R package '%s' is unavailable.", pkg))
  }
}

cat("Binder R dependency build verification passed\n")
