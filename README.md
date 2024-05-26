
<!-- README.md is generated from README.Rmd. Please edit that file -->

# rbooty

<!-- badges: start -->
<!-- badges: end -->

rbooty provides comprehensive functions for bootstrapping.

## Installation

You can install the the development version from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("lana1218/rbooty")
```

``` r
library(rbooty)
```

## Summarizing the bootstrap distribution

- `bs_summarize()` allows you to output the summary statistics and
  resulting bootstrap distribution in one output, given a desired
  statistic (mean, median, quantile, sd, iqr)

``` r
library(rbooty)

bs_summarize(tips$TipPercent, stat = "mean")
```

<img src="man/figures/README-unnamed-chunk-4-1.png" width="100%" />

## Other Use Cases

You can calculate the statistics for the bootstrap distribution
independently.

``` r
median_stat <- bs_loc_stat(tips$TipPercent, stat = "median")
str(median_stat)
#> List of 5
#>  $ mean         : num 17.2
#>  $ s_boot       : num 0.908
#>  $ percentile_ci: num [1:2] 16 19
#>  $ pivotal_ci   : num [1:2] 14.8 17.8
#>  $ boot_dist    : num [1:5000] 17.6 18.2 18.9 16.2 16.9 ...

sd_stat <- bs_scale_stat(tips$TipPercent, stat = "sd")
str(sd_stat)
#> List of 5
#>  $ mean         : num 5.48
#>  $ s_boot       : num 1.43
#>  $ percentile_ci: num [1:2] 2.83 8.14
#>  $ pivotal_ci   : num [1:2] 4.09 11.76
#>  $ boot_dist    : num [1:5000] 5.71 6.86 6.05 5.77 4.5 ...
```

You can also get a dataframe of the bootstrap distribution.

``` r
boot_dist <- bootstrap(tips$TipPercent, stat = "mean")

head(boot_dist)
#> [1] 18.01667 18.68333 19.35000 17.54000 17.67667 20.11333
```

You can use bs_plot to plot a bootstrap distribution.

``` r
bs_plot(boot_dist = boot_dist, stat = "mean")
#> `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.
```

<img src="man/figures/README-unnamed-chunk-7-1.png" width="100%" />
