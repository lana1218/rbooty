#' Creates a Bootstrap Distribution for a given statistic using an given empirical distribution
#'
#' @param emp_dist Empirical Distribution to bootstrap from
#' @param B Number of bootstrap iterations to perform. Default = 5000
#' @param stat Statistic to create bootstrap distribution for. Options: mean, median, sd, iqr, quantile
#' @param quantile Quantile to calculate between 0 and 1 if stat = quantile
#'
#' @return A vector of size B containing bootstrap distribution for given statistic
#'
#' @export
bootstrap <- function(emp_dist, B = 5000, stat, quantile = NULL) {

  stopifnot(
    is.numeric(emp_dist), # only bootstrap for quantitative data
    B > 0 # number of iterations must be greater than 0
  )

  # check for valid stat parameter
  if (!(stat %in% c("mean", "median", "sd", 'iqr', "quantile"))) {
    return("Please enter valid statistic\n
           values = mean, median, sd, iqr, quantile")
  }
  # check for valid quantile parameter if stat specified is a quantile
  if (stat == "quantile" & !is.numeric(quantile)) {
    return("Please enter valid quantile between (0, 1)")
  }

  # initialize vector of size B for bootstrap distribution
  theta_star <- as.numeric(B)
  # iterate B number of times
  for (i in 1:B) {
    boot_sample <- sample(emp_dist, replace = TRUE) # sample with replacement from empiracal distribution
    theta_star[i] <- calc_theta(boot_sample, stat, quantile) # calculate statistic for each bootstrap sample
  }
  theta_star # return final bootstrap distribution
}


#' Calculates a specified statistic on a bootstrap sample
#'
#' @param data Data to calculate statistic on
#' @param stat Statistic to calculate on the data. Options: mean, median, sd, iqr, quantile
#' @param quantile Quantile to calculate between 0 and 1 if stat = quantile
#'
#' @return Value for the calculated statistic on the data
#'
calc_theta <- function(data, stat, quantile = NULL) {

  stopifnot(
    is.numeric(data) # only calculate statistics on quantitative responses
  )

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
  else {
    return("Please specify valid stat. Options: mean, median, sd, iqr, quantile")
  }
}


df <- read.csv(here::here("tests", "data", "tips.csv"))
bootstrap(df$TipPercent, stat = "mean")
