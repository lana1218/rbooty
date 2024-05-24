#' Computes estimated bootstrap mean, bootstrap sd, percentile interval, and pivotal interval for a scale-based statistic (sd, iqr)
#'
#' @param emp_dist Empirical distribution to bootstrap
#' @param B Number of bootstrap iterations to perform
#' @param stat Scale-based statistic to use. Options: sd, iqr
#' @param alpha Alpha level for CI's. Default alpha = 0.05 for 95% conf. Conf = (1 - alpha)*100%
#'
#' @return A list containing the boostrap mean, bootsrap sd, percentile interval, and pivotal interval
#'
#' @export
bs_scale_stat <- function(emp_dist, B = 5000, stat, alpha = .05) {

  # check for valid scale-based statistic
  if (!(stat %in% c("sd", "iqr"))) {
    return("Please enter valid scale statistic\n
            values = sd, iqr")
  }

  # check for valid alpha level
  if (alpha >= 1 | alpha <= 0 | !is.numeric(alpha)) {
    return("Please enter valid alpha level between (0, 1)")
  }

  # create bootstrap distribution for statistic
  boot_dist <- bootstrap(emp_dist, B, stat)


  # calculate mean and sd of bootstrap distribution
  mean <- mean(boot_dist)
  s_boot <- sd(boot_dist)

  # calculate percentile interval for bootstrap distribution
  percentile_ci = unname(quantile(boot_dist, c(alpha/2, 1 - alpha/2)))

  # calculate pivotal interval for bootstrap distribution
  pivotal_ci = get_pivotal_ci_scale(emp_dist, boot_dist, stat, alpha)

  # return elements in a list
  list(mean = mean,
       s_boot = s_boot,
       percentile_ci = percentile_ci,
       pivotal_ci = pivotal_ci,
       boot_dist = boot_dist)
}


#' Computes the pivotal interval for a scale-based statistic
#'
#' @param emp_dist Empirical distribution to bootstrap
#' @param boot_dist Bootstrap distribution for statistic
#' @param stat Measure of variability to use as statistic. Options: sd, iqr
#' @param alpha Alpha level for CI's. Default alpha = 0.05 for 95% conf. Conf = (1 - alpha)*100%
#'
#' @return Returns the pivotal CI for specified statistic
#'
get_pivotal_ci_scale <- function(emp_dist, boot_dist, stat, alpha) {

  theta_actual <- calc_theta(emp_dist, stat)
  U <- unname(quantile(boot_dist, 1 - alpha/2))
  L <- unname(quantile(boot_dist, alpha/2))

  c(theta_actual^2/U, theta_actual^2/L)

}

df <- read.csv(here::here("tests", "data", "tips.csv"))
bs_scale_stat(df$TipPercent, stat = "sd", alpha = .05)

