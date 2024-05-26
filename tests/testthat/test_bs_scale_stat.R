test_that("bs_center works for invalid statistic error", {

  correct_result <- "Please enter valid scale statistic\nvalues = sd, iqr"

  my_result <- bs_scale_stat(emp_dist = c(1, 2, 3, 4, 5), stat = "mean")

  expect_equal(my_result, correct_result)
})


test_that("bs_center works for invalid alpha", {

  correct_result <- "Please enter valid alpha level between (0, 1)"

  my_result <- bs_scale_stat(emp_dist = c(1, 2, 3, 4, 5), stat = "sd", alpha = 2.6)

  expect_equal(my_result, correct_result)
})


test_that("get_pivotal_ci_scale works", {

  correct_result <- c(1.49031297, 2.34192037)

  my_result <- get_pivotal_ci_scale(emp_dist = c(1, 2, 3, 4, 5),
                                    boot_dist = c(1, 1.5, 1.6, 1.6, 1.5, 1.7, 1.6, 1.3, 1.5, 1.6),
                                    stat = "sd", alpha = 0.05)

  expect_equal(my_result, correct_result)
})
