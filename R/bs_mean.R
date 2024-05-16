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
