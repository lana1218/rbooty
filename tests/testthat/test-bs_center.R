test_that("bs_center works for invalid quantile error", {

  correct_result <- "Please enter valid quantile between (0, 1)"

  my_result <- bs_loc_stat(emp_dist = c(1, 2, 3, 4, 5), stat = "quantile")

  expect_equal(my_result, correct_result)
})


test_that("bs_center works for invalid quantile error 2", {

  correct_result <- "Please enter valid quantile between (0, 1)"

  my_result <- bs_loc_stat(emp_dist = c(1, 2, 3, 4, 5), stat = "quantile", quantile = 2.6)

  expect_equal(my_result, correct_result)
})


test_that("bs_center works for invalid alpha", {

  correct_result <- "Please enter valid alpha level between (0, 1)"

  my_result <- bs_loc_stat(emp_dist = c(1, 2, 3, 4, 5), stat = "mean", alpha = 2.6)

  expect_equal(my_result, correct_result)
})


test_that("get_pivotal_ci_center works", {

  correct_result <- c(2.445, 4.555)

  my_result <- get_pivotal_ci_loc(emp_dist = c(1, 2, 3, 4, 5),
                                     boot_dist = c(2.6, 1.4, 3.4, 3.0, 2.6, 2.8, 3.4, 3.6, 2.8, 1.6),
                                     stat = "mean", quantile = NULL, alpha = 0.05)

  expect_equal(my_result, correct_result)
})
