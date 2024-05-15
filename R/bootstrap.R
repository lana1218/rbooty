#' Creates a Boostrap Distribution for a given statistic on a given empiracal distirbution
#'
#' @param emp_dist Empirical Distribution to boostrap
#' @param B Number of boostrap interations to perform
#' @param stat Statistic to create bootsrap distribution for
#' @param quantile Quantile to calculate between 0 and 1 if stat = quantile
#'
#' @return A vector containing the boostr
#'
#' @export

bootstrap <- function(emp_dist, B = 5000, stat, quantile=NULL) {

  stopifnot(
    is.numeric(emp_dist),
    B > 0
  )

  if (!(stat %in% c("mean", "median", "sd", 'iqr', "quantile"))) {
    return("Please enter valid statistic\n
           values = mean, median, sd, iqr, quantile")
  }
  if (stat == "quantile" & !is.numeric(quantile)) {
    return("Please enter valid quantile between (0, 1)")
  }

  theta_star <- as.numeric(B)
  for (i in 1:B) {
    boot_sample <- sample(emp_dist, replace = TRUE)
    theta_star[i] <- calc_theta(boot_sample, stat, quantile)
  }
  theta_star
}

#' Calculates a specified statistic on a bootstrap sample
#'
#' @param boot_sample Empirical Distribution to bootstrap
#' @param stat Statistic to calculate for bootstrap sample
#' @param quantile Quantile to calculate between 0 and 1 if stat = quantile
#'
#' @return Specified statistic for bootstrap sample
#'
calc_theta <- function(boot_sample, stat, quantile = NULL) {
  if (stat == "mean") {
   return(mean(boot_sample))
  }
  if (stat == "median") {
    return(median(boot_sample))
  }
  if (stat == "quantile") {
    return(quantile(boot_sample, quantile))
  }
  if (stat == "sd") {
    return(sd(boot_sample))
  }
  if (stat == "iqr") {
    return(quantile(boot_sample, .75) - quantile(boot_sample, .25))
  }
}






