snapshot <- Sys.getenv("ADA_RSPM_SNAPSHOT", unset = "2024-10-15")
options(repos = c(
  CRAN = sprintf(
    "https://packagemanager.posit.co/cran/__linux__/jammy/%s",
    snapshot
  )
))

runtime_packages <- c(
  "IRkernel",
  "jsonlite",
  "knitr",
  "rmarkdown",
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

# Build-time-only exception: remotes is needed to install pinned GitHub runtime
# dependencies during the image build, but it is not required by workshop
# notebooks at runtime.
build_time_packages <- c("remotes")

install.packages(c(runtime_packages, build_time_packages))

missing_build_time <- build_time_packages[
  !vapply(build_time_packages, requireNamespace, quietly = TRUE, FUN.VALUE = logical(1L))
]
if (length(missing_build_time) > 0L) {
  stop(
    sprintf(
      "Binder build failed: required build-time R packages unavailable after installation: %s",
      paste(missing_build_time, collapse = ", ")
    )
  )
}

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

missing_runtime <- runtime_packages[
  !vapply(runtime_packages, requireNamespace, quietly = TRUE, FUN.VALUE = logical(1L))
]
if (length(missing_runtime) > 0L) {
  stop(
    sprintf(
      "Binder build failed: required runtime R packages unavailable after installation: %s",
      paste(missing_runtime, collapse = ", ")
    )
  )
}

for (pkg in c("FSaudit", "aicpa")) {
  if (!requireNamespace(pkg, quietly = TRUE)) {
    stop(sprintf("Binder build failed: required R package '%s' is unavailable.", pkg))
  }
}

cat("Binder R dependency build verification passed\n")
