#' Computes estimated mean, sd, and confidence intervals based on given the
#' bootstrap distribution for given scale parameter
#'
#' @param boot_dist Bootstrap Distribution
#'
#' @return A vector containing the boostrap mean, sd, and CI
#'
#' @export

bs_scale <- function(boot_dist) {

  mean <- mean(boot_dist)

  sd <- sd(boot_dist)

  CI <- get_scale_pivotal_ci()

  return(list(mean = mean, sd = sd, CI = CI))
}

get_scale_pivotal_ci <- function(emp_dist, boot_dist, stat, quantile) {

  theta_actual <- calc_theta(emp_dist, stat, quantile)
  U <- quantile(boot_dist, 1 - alpha/2)
  L <- quantile(boot_dist, 1 - alpha/2)

  c(2*theta_actual - U, 2*theta_actual - L)

}
