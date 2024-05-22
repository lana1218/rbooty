#' Computes estimated mean, sd, and confidence intervals based on given the
#' bootstrap distribution
#'
#' @param boot_dist Bootstrap Distribution
#'
#' @return A vector containing the boostrap mean, sd, and CI
#'
#' @export

bs_mean <- function(boot_dist) {

  mean <- mean(boot_star)

  sd <- sd(boot_dist)

  ### insert code for confidence intervals

  c(mean, sd)
}


#' Computes estimated mean, sd, and confidence intervals based on given the
#' bootstrap distribution
#'
#' @param emp_dist Empirical distribution to bootstrap
#' @param B Number of boostrap interations to perform
#' @param stat Measure of center to use as statistic: mean, median, or specific quantile
#' @param quantile Quantile to calculate between 0 and 1 if stat = quantile
#' @param alpha Alpha level for CI's: Conf = 1 - alpha
#'
#' @return A list containing the boostrap mean, sd, and CI's
#'
#' @export

bs_center <- function(emp_dist, B = 5000, stat, quantile = NULL, alpha = .05) {

  if (!(stat %in% c("mean", "median", "quantile"))) {
    return("Please enter valid center of measure statistic\n
            values = mean, median, quantile")
  }

  if (stat == "quantile" & !is.numeric(quantile)) {
    return("Please enter valid quantile between (0, 1)")
  }

  if (alpha >= 1 | alpha <= 0 | !is.numeric(alpha)) {
    return("Please enter valid alpha level between (0, 1)")
  }

  boot_dist <- bootstrap(emp_dist, B, stat, quantile)

  mean <- mean(boot_star)

  sd <- sd(boot_dist)

}

get_pivotal_ci <- function(emp_dist, boot_dist, stat, quantile) {

  theta_actual <- calc_theta(emp_dist, stat, quantile, alpha)
  U <- quantile(boot_dist, 1 - alpha/2)
  L <- quantile(boot_dist, 1 - alpha/2)

  c(2*theta_actual - U, 2*theta_actual - L)

}
