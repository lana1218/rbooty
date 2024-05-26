test_that("calc_theta works for means", {

  correct_result <- 3

  my_result <- calc_theta(c(1, 2, 3, 4, 5), "mean")

  expect_equal(my_result, correct_result)
})


test_that("calc_theta works for medians", {

  correct_result <- 3

  my_result <- calc_theta(c(1, 2, 3, 4, 5), "median")

  expect_equal(my_result, correct_result)
})


test_that("calc_theta works for quantiles", {

  correct_result <- c(2)

  my_result <- calc_theta(c(1, 2, 3, 4, 5), "quantile", 0.25)

  expect_equal(my_result, correct_result)
})


test_that("calc_theta works for standard deviations", {

  correct_result <- 2

  my_result <- round(calc_theta(c(1, 2, 3, 4, 5), "sd"))

  expect_equal(my_result, correct_result)
})


test_that("calc_theta works for interquartile ranges", {

  correct_result <- 2

  my_result <- calc_theta(c(1, 2, 3, 4, 5), "iqr")

  expect_equal(my_result, correct_result)
})


test_that("bootstrap works", {

  correct_result <- 3

  my_result <- round(mean(bootstrap(emp_dist = c(1, 2, 3, 4, 5), stat = "mean")))

  expect_equal(my_result, correct_result)
})


test_that("bootstrap works for invalid statistic error", {

  correct_result <- "Please enter valid statistic\nvalues = mean, median, sd, iqr, quantile"

  my_result <- bootstrap(emp_dist = c(1, 2, 3, 4, 5), stat = "mode")

  expect_equal(my_result, correct_result)
})


test_that("bootstrap works for invalid quantile error", {

  correct_result <- "Please enter valid quantile between (0, 1)"

  my_result <- bootstrap(emp_dist = c(1, 2, 3, 4, 5), stat = "quantile")

  expect_equal(my_result, correct_result)
})

test_that("bootstrap works for invalid quantile error 2", {

  correct_result <- "Please enter valid quantile between (0, 1)"

  my_result <- bootstrap(emp_dist = c(1, 2, 3, 4, 5), stat = "quantile",
                         quantile = 2.6)

  expect_equal(my_result, correct_result)
})
