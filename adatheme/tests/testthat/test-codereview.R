if (requireNamespace("lintr", quietly = TRUE)) {
  context("lints")
  test_that("Code review", {
    lintr::expect_lint_free()
  })
}
