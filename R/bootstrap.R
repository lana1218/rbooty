<<<<<<< HEAD
#' Creates a Bootstrap Distribution for a given statistic on a given empirical distribution
#'
#' @param emp_dist Empirical Distribution to bootstrap
#' @param B Number of bootstrap iterations to perform
#' @param stat Statistic to create bootstrap distribution for
=======
#' Creates a Bootstrap Distribution for a given statistic on a given empirical distirbution
#'
#' @param emp_dist Empirical Distribution to bootstrap
#' @param B Number of bootstrap iterations to perform
#' @param stat Statistic to create boottsrap distribution for
>>>>>>> 4698daf56546d9bedf2398364e3a90f44d641d74
#' @param quantile Quantile to calculate between 0 and 1 if stat = quantile
#'
#' @return A vector containing the bootstrap
#'
#' @export

bootstrap <- function(emp_dist, B = 5000, stat, quantile = NULL) {

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
#' @param data Data to calcualte statistic on
#' @param stat Statistic to calculate for bootstrap sample
#' @param quantile Quantile to calculate between 0 and 1 if stat = quantile
#'
#' @return Specified statistic for bootstrap sample
<<<<<<< HEAD

calc_theta <- function(boot_sample, stat, quantile = NULL) {
=======
#'
calc_theta <- function(data, stat, quantile = NULL) {
>>>>>>> 4698daf56546d9bedf2398364e3a90f44d641d74
  if (stat == "mean") {
   return(mean(data))
  }
  if (stat == "median") {
    return(median(data))
  }
  if (stat == "quantile") {
    return(quantile(data, quantile))
  }
  if (stat == "sd") {
    return(sd(data))
  }
  if (stat == "iqr") {
    return(quantile(data, .75) - quantile(data, .25))
  }
}






