#' Plots the bootstrap distribution
#'
#' @param boot_dist Bootstrap Distribution
#' @param stat A string corresponding to the statistic of boostrap distribution
#'
#' @return A plot of the boostrap distribution
#'
#' @importFrom ggplot2 ggplot
#'
#' @export
#'
bs_plot <- function(boot_dist, stat){
  ggplot(df, aes(x = values)) +
    geom_histogram(fill = "lightblue",
                   color = "black",
                   alpha = 0.7) +
    labs(title = paste("Bootstrap distribution of the", stat),
         x = paste0(stat, "*"),
         y = "") +
    theme_classic()
}
