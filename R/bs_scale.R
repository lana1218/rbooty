#' Computes estimated mean, sd, and confidence intervals based on given the
#' bootstrap distribution for given scale-based statistics
#'
#' @param boot_dist Bootstrap Distribution
#'
#' @return A vector containing the boostrap mean, sd, and CI
#'
#' @export

bs_scale <- function(emp_dist, B = 5000, stat, alpha = .05) {

  if (!(stat %in% c("sd", "iqr"))) {
    return("Please enter valid scale statistic\n
            values = sd, iqr")
  }

  if (alpha >= 1 | alpha <= 0 | !is.numeric(alpha)) {
    return("Please enter valid alpha level between (0, 1)")
  }

  boot_dist <- bootstrap(emp_dist, B, stat)


  mean <- mean(boot_dist)
  sd <- sd(boot_dist)

  percentile_ci = quantile(boot_dist, c(alpha/2, 1 - alpha/2))
  pivotal_ci = get_pivotal_ci_scale(emp_dist, boot_dist, stat, alpha)


  list(mean = mean, sd = sd, percentile_ci = percentile_ci, pivotal_ci = pivotal_ci)
}

#' Computes the pivotal interval for a scale-based statistic measuring
#'
#' @param emp_dist Empirical distribution to bootstrap
#' @param boot_dist Bootstrap distribution for estimated statistic
#' @param stat Measure of scale to use as statistic: sd, iqr
#' @param alpha Alpha level for CI's: Conf = (1 - alpha)
#'
#' @return Returns the pivotal CI for specified statistic
#'
get_pivotal_ci_scale <- function(emp_dist, boot_dist, stat, alpha) {

  theta_actual <- calc_theta(emp_dist, stat)
  U <- quantile(boot_dist, 1 - alpha/2)
  L <- quantile(boot_dist, alpha/2)

  c(theta_actual^2/U, theta_actual^2/L)

}
