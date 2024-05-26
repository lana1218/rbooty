test_that("bs_center works for standard devitions", {

  correct_result <- list(mean = 1, sd = 0,
                         percentile_ci = c(`2.5%` = 1, `97.5%` = 2),
                         pivotal_ci = c(`2.5%` = 1, `97.5%` = 5))

  my_result <- lapply(bs_scale(emp_dist = c(1, 2, 3, 4, 5), stat = "sd"),
                      FUN=round)

  expect_equal(my_result, correct_result)
})


test_that("bs_center works for interquartile ranges", {

  correct_result <- list(mean = 2, sd = 1,
                         percentile_ci = c(`2.5%` = 0, `97.5%` = 4),
                         pivotal_ci = c(`2.5%` = 1, `97.5%` = Inf))

  my_result <- lapply(bs_scale(emp_dist = c(1, 2, 3, 4, 5), stat = "iqr"),
                      FUN=round)

  expect_equal(my_result, correct_result)
})


test_that("bs_center works for invalid statistic error", {

  correct_result <- "Please enter valid scale statistic: values = sd, iqr"

  my_result <- bs_scale(emp_dist = c(1, 2, 3, 4, 5), stat = "mean")

  expect_equal(my_result, correct_result)
})


test_that("bs_center works for invalid alpha", {

  correct_result <- "Please enter valid alpha level between (0, 1)"

  my_result <- bs_scale(emp_dist = c(1, 2, 3, 4, 5), stat = "sd", alpha = 2.6)

  expect_equal(my_result, correct_result)
})


test_that("get_pivotal_ci_scale works", {

  correct_result <- c(`2.5%` = 1.49031297, `97.5%` = 2.34192037)

  my_result <- get_pivotal_ci_scale(emp_dist = c(1, 2, 3, 4, 5),
                                    boot_dist = c(1, 1.5, 1.6, 1.6, 1.5, 1.7, 1.6, 1.3, 1.5, 1.6),
                                    stat = "sd", alpha = 0.05)

  expect_equal(my_result, correct_result)
})
