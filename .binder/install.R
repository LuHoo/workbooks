options(repos = c(CRAN = "https://cloud.r-project.org"))

install.packages(c(
  "IRkernel",
  "jsonlite",
  "knitr",
  "rmarkdown",
  "remotes",
  "devtools",
  "readr",
  "ggplot2",
  "car",
  "gridExtra",
  "tidyr",
  "corrplot",
  "lmtest",
  "latex2exp",
  "scales"
))

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
