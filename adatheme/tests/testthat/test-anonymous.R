library(testthat)
library(ggplot2)
library(adatheme)
context("anonymous")

# To test single argument case
test_that(" ", {

  data_in  <- ggplot(mtcars, aes(x = wt, y = mpg, colour = factor(gear))) +
    geom_point() + theme(axis.text.x = element_blank(),
                         axis.ticks.x = element_blank(), axis.title.x = element_blank())

  data_out <- ggplot(mtcars, aes(x = wt, y = mpg, colour = factor(gear))) +
    geom_point() + anonymous(X = x)

  testthat::expect_equal(data_in, data_out)
})


# To test two arguments case
test_that(" ", {

  data_in  <- ggplot(mtcars, aes(x = wt, y = mpg, colour = factor(gear))) +
    geom_point() + theme(axis.text = element_blank(),
                         axis.ticks = element_blank(), axis.title = element_blank())

  data_out <- ggplot(mtcars, aes(x = wt, y = mpg, colour = factor(gear))) +
    geom_point() + anonymous(X = x, Y = y)

  testthat::expect_equal(data_in, data_out)
})

# To test no argument case
test_that(" ", {

  data_in  <- ggplot(mtcars, aes(x = wt, y = mpg, colour = factor(gear))) +
    geom_point()

  data_out <- ggplot(mtcars, aes(x = wt, y = mpg, colour = factor(gear))) +
    geom_point() + anonymous()

  testthat::expect_equal(data_in, data_out)
})
