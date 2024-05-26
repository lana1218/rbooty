#' Computes estimated bootstrap mean, bootstrap sd, percentile interval, and pivotal interval for a location-based statistic (mean, median, quantile)
#'
#' @param emp_dist Empirical distribution to bootstrap
#' @param B Number of bootstrap iterations to perform
#' @param stat Measure of center to use as statistic: mean, median, or quantile
#' @param quantile Quantile to calculate between 0 and 1 if stat = quantile
#' @param alpha Alpha level for CI's: Conf = (1 - alpha)
#'
#' @return A list containing the boostrap mean, bootsrap sd, percentile interval, and pivotal interval
#'
#' @export

bs_center <- function(emp_dist, B = 5000, stat, quantile = NULL, alpha = .05) {

  if (!(stat %in% c("mean", "median", "quantile"))) {
    return("Please enter valid center of measure statistic: values = mean, median, quantile")
  }

  if (stat == "quantile" & !is.numeric(quantile)) {
    return("Please enter valid quantile between (0, 1)")
  }
  if (stat == "quantile" && (quantile > 1 | quantile < 0)) {
    return("Please enter valid quantile between (0, 1)")
  }

  if (alpha >= 1 | alpha <= 0) {
    return("Please enter valid alpha level between (0, 1)")
  }

  boot_dist <- bootstrap(emp_dist, B, stat, quantile)


  mean <- mean(boot_dist)
  sd <- sd(boot_dist)

  percentile_ci <- quantile(boot_dist, c(alpha/2, 1 - alpha/2))
  pivotal_ci <- get_pivotal_ci_center(emp_dist, boot_dist, stat, quantile, alpha)


  list(mean = mean, sd = sd, percentile_ci = percentile_ci, pivotal_ci = pivotal_ci)
}

#' Computes the pivotal interval for a location based statistic measuring
#'
#' @param emp_dist Empirical distribution to bootstrap
#' @param boot_dist Bootstrap distribution for estimated statistic
#' @param stat Measure of center to use as statistic: mean, median, or specific quantile
#' @param quantile Quantile to calculate between 0 and 1 if stat = quantile
#' @param alpha Alpha level for CI's: Conf = (1 - alpha)
#'
#' @return Returns the pivotal CI for specified statistic

get_pivotal_ci_center <- function(emp_dist, boot_dist, stat, quantile, alpha) {

  theta_actual <- calc_theta(emp_dist, stat, quantile)
  U <- quantile(boot_dist, 1 - alpha/2)
  L <- quantile(boot_dist, alpha/2)

  output <- c(2*theta_actual - U, 2*theta_actual - L)
  names(output) <- c('2.5%', '97.5%')

  output
}
