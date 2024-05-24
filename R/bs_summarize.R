#' Prints summary statistics and plot of bootstrap distribution
#'
#' @param emp_dist Empirical distribution to bootstrap
#' @param B Number of bootstrap iterations to perform
#' @param stat Measure of center to use as statistic: mean, median, or quantile
#' @param quantile Quantile to calculate between 0 and 1 if stat = quantile
#' @param alpha Alpha level for CI's: Conf = (1 - alpha)
#'
#' @return A table and plot
#'
#' @importFrom gridExtra tableGrob
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
    boot_list <- bs_loc_stat(emp_dist, B, stat, quantile, alpha)
  }

  else if (stat %in% c("sd", "iqr")){
    boot_list <- bs_scale_stat(emp_dist, B, stat, alpha)

  }

  boot_df <- data.frame(
    mean = round(boot_list$mean, 3),
    sd = round(boot_list$s_boot, 3),
    `Lower Percentile CI` = round(boot_list$percentile_ci[1], 3),
    `Upper Percentile CI` = round(boot_list$percentile_ci[2], 3),
    `Lower Pivotal CI` = round(boot_list$pivotal_ci[1], 3),
    `Upper Pivotal CI` = round(boot_list$pivotal_ci[2], 3)
  )

  boot_table <- tableGrob(my_df)

  boot_plot <- bs_plot(boot_dist, stat)

  grid.arrange(boot_plot, boot_table)

}
