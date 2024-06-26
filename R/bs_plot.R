#' Plots a given bootstrap distribution
#'
#' @param boot_dist Bootstrap Distribution
#' @param stat A string corresponding to the statistic of bootstrap distribution
#'
#' @return A plot of the bootstrap distribution
#'
#' @importFrom ggplot2 ggplot aes geom_histogram labs theme_classic
#'
#' @export
bs_plot <- function(boot_dist, stat){
  df <- data.frame(values = boot_dist)

  ggplot(df, aes(x = values)) +
    geom_histogram(fill = "lightblue",
                   color = "black",
                   alpha = 0.7) +
    labs(title = paste("Bootstrap distribution of the", stat),
         x = paste0(stat, "*"),
         y = "") +
    theme_classic()
}
