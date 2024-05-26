
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

## Summarizing the bootsrap distribution

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
#>  $ percentile_ci: num [1:2] 15.9 18.9
#>  $ pivotal_ci   : num [1:2] 14.8 17.8
#>  $ boot_dist    : num [1:5000] 18.1 17.2 16.6 16.6 18.2 ...

sd_stat <- bs_scale_stat(tips$TipPercent, stat = "sd")
str(sd_stat)
#> List of 5
#>  $ mean         : num 5.49
#>  $ s_boot       : num 1.43
#>  $ percentile_ci: num [1:2] 2.83 8.18
#>  $ pivotal_ci   : num [1:2] 4.06 11.75
#>  $ boot_dist    : num [1:5000] 4.62 6.85 3.82 5.74 6.25 ...
```

You can also get a dataframe of the bootstrap distribution.

``` r
boot_dist <- bootstrap(tips$TipPercent, stat = "mean")

head(boot_dist)
#> [1] 19.05667 18.60667 16.67667 20.82333 18.60667 19.31333
```
