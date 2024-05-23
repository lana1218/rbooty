#' Puts output of bs_center, bs_scale, and bs_plot outputs into a table
#'
#' @param emp_dist Empirical distribution to bootstrap
#' @param B Number of bootstrap iterations to perform
#' @param stat Measure of center to use as statistic: mean, median, or quantile
#' @param quantile Quantile to calculate between 0 and 1 if stat = quantile
#' @param alpha Alpha level for CI's: Conf = (1 - alpha)
#'
#' @return A table and plot
#'
#' @export
#'

bs_summarize <- function(emp_dist,
                         B = 5000,
                         stat,
                         quantile = NULL,
                         alpha = .05) {

  # stopping conditions
  if (!(stat %in% c("mean", "median", "quantile", "sd", "iqr"))) {
    return("Please enter valid center of measure statistic\n
            values = mean, median, quantile, sd, iqr")
  }

  # specific stats
  if (stat %in% c("mean", "median", "quantile")) {
    boot_list <- bs_center(emp_dist, B, stat, quantile, alpha)
  }

  else if (stat %in% c("sd", "iqr")){
    boot_list <- boot_scale(emp_dist, B, stat, alpha)
  }





}
