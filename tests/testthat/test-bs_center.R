test_that("bs_center works for means", {

  correct_result <- list(mean = 3, sd = 1,
                         percentile_ci = c(`2.5%` = 2, `97.5%` = 4),
                         pivotal_ci = c(`2.5%` = 2, `97.5%` = 4))

  my_result <- lapply(bs_center(emp_dist = c(1, 2, 3, 4, 5), stat = "mean"),
                      FUN=round)

  expect_equal(my_result, correct_result)
})


test_that("bs_center works for medians", {

  correct_result <- list(mean = 3, sd = 1,
                         percentile_ci = c(`2.5%` = 1, `97.5%` = 5),
                         pivotal_ci = c(`2.5%` = 1, `97.5%` = 5))

  my_result <- lapply(bs_center(emp_dist = c(1, 2, 3, 4, 5), stat = "median"),
                      FUN=round)

  expect_equal(my_result, correct_result)
})


test_that("bs_center works for quantiles", {

  correct_result <- list(mean = 2, sd = 1,
                         percentile_ci = c(`2.5%` = 1, `97.5%` = 4),
                         pivotal_ci = c(`2.5%` = 0, `97.5%` = 3))

  my_result <- lapply(bs_center(emp_dist = c(1, 2, 3, 4, 5), stat = "quantile",
                                quantile = 0.25),
                      FUN=round)

  expect_equal(my_result, correct_result)
})


test_that("bs_center works for invalid statistic error", {

  correct_result <- "Please enter valid center of measure statistic: values = mean, median, quantile"

  my_result <- bs_center(emp_dist = c(1, 2, 3, 4, 5), stat = "sd")

  expect_equal(my_result, correct_result)
})


test_that("bs_center works for invalid quantile error", {

  correct_result <- "Please enter valid quantile between (0, 1)"

  my_result <- bs_center(emp_dist = c(1, 2, 3, 4, 5), stat = "quantile")

  expect_equal(my_result, correct_result)
})


test_that("bs_center works for invalid quantile error 2", {

  correct_result <- "Please enter valid quantile between (0, 1)"

  my_result <- bs_center(emp_dist = c(1, 2, 3, 4, 5), stat = "quantile", quantile = 2.6)

  expect_equal(my_result, correct_result)
})


test_that("bs_center works for invalid alpha", {

  correct_result <- "Please enter valid alpha level between (0, 1)"

  my_result <- bs_center(emp_dist = c(1, 2, 3, 4, 5), stat = "mean", alpha = 2.6)

  expect_equal(my_result, correct_result)
})


test_that("get_pivotal_ci_center works", {

  correct_result <- c(`2.5%` = 2.445, `97.5%` = 4.555)

  my_result <- get_pivotal_ci_center(emp_dist = c(1, 2, 3, 4, 5),
                                     boot_dist = c(2.6, 1.4, 3.4, 3.0, 2.6, 2.8, 3.4, 3.6, 2.8, 1.6),
                                     stat = "mean", quantile = NULL, alpha = 0.05)

  expect_equal(my_result, correct_result)
})
