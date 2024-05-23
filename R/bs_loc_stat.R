#' Computes estimated bootstrap mean, bootstrap sd, percentile interval, and pivotal interval for a location-based statistic (mean, median, quantile)
#'
#' @param emp_dist Empirical distribution to bootstrap
#' @param B Number of bootstrap iterations to perform
#' @param stat Location-based statistic to use. Options: mean, median, or quantile
#' @param quantile Quantile to calculate between 0 and 1 if stat = quantile
#' @param alpha Alpha level for CI's. Default alpha = 0.05 for 95% conf. Conf = (1 - alpha)*100%
#'
#' @return A list containing the boostrap mean, bootsrap sd, percentile interval, and pivotal interval
#'
#' @export
bs_loc_stat <- function(emp_dist, B = 5000, stat, quantile = NULL, alpha = .05) {

  # check for valid location-based statistic
  if (!(stat %in% c("mean", "median", "quantile"))) {
    return("Please enter valid center of measure statistic\n
            values = mean, median, quantile")
  }

  # check for valid alpha level
  if (alpha >= 1 | alpha <= 0 | !is.numeric(alpha)) {
    return("Please enter valid alpha level between (0, 1)")
  }

  # create bootstrap distribution for statistic
  boot_dist <- bootstrap(emp_dist, B, stat, quantile)

  # return message if invalid quantile was specified
  if (!is.numeric(boot_dist)) {
    return(boot_dist)
  }

  # calculate mean and sd of bootstrap distribution
  mean <- mean(boot_dist)
  s_boot <- sd(boot_dist)

  # calculate percentile interval for bootstrap distribution
  percentile_ci = unname(quantile(boot_dist, c(alpha/2, 1 - alpha/2)))

  # calculate pivotal interval for bootstrap distribution
  pivotal_ci = get_pivotal_ci_loc(emp_dist, boot_dist, stat, quantile, alpha)

  # return elements in a list
  list(mean = mean, s_boot = s_boot, percentile_ci = percentile_ci, pivotal_ci = pivotal_ci)
}


#' Computes the pivotal interval for a location-based statistic
#'
#' @param emp_dist Empirical distribution to bootstrap
#' @param boot_dist Bootstrap distribution for statistic
#' @param stat Measure of center to use as statistic. Options: mean, median, quantile
#' @param quantile Quantile to calculate between 0 and 1 if stat = quantile
#' @param alpha Alpha level for CI's. Default alpha = 0.05 for 95% conf. Conf = (1 - alpha)*100%
#'
#' @return Returns the pivotal CI for specified statistic
#'
get_pivotal_ci_loc <- function(emp_dist, boot_dist, stat, quantile, alpha = .05) {

  theta_actual <- calc_theta(emp_dist, stat, quantile) # calculate stat on empirical distribution

  U <- unname(quantile(boot_dist, 1 - alpha/2)) # calculate U and L values for specified alpha
  L <- unname(quantile(boot_dist, alpha/2))

  c(2*theta_actual - U, 2*theta_actual - L) # return lower and up limits of CI

}

df <- read.csv(here::here("tests", "data", "tips.csv"))
bs_loc_stat(df$TipPercent, stat = "mean", alpha = .05)

