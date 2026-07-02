notebooks <- list(
  list(slug = "probability-distributions", chapter = 1L, title = "Probability distributions"),
  list(slug = "population-estimation", chapter = 2L, title = "Estimating the population mean and proportion"),
  list(slug = "auxiliary-variables-and-stratification", chapter = 3L, title = "Estimation with auxiliary variables and stratification"),
  list(slug = "hypothesis-testing", chapter = 4L, title = "Hypothesis testing"),
  list(slug = "regression-analysis", chapter = 5L, title = "Regression analysis"),
  list(slug = "goodness-of-fit", chapter = 6L, title = "Goodness of fit")
)

for (i in seq_along(notebooks)) {
  notebook <- notebooks[[i]]
  notebook$source <- file.path("notebooks", "support", notebook$slug, "support.Rmd")
  notebook$output <- file.path("notebooks", "workshops", paste0(notebook$title, " workshop.Rmd"))
  notebooks[[i]] <- notebook
}
