# adatheme


The adatheme package is all you need to create beautifull plots in accordance with the ADA Branding guidelines

Installation
============

Development version

``` r
library(devtools)
devtools::install_git("https://username:password@gitlab-nl.dna.adalab.com/research/adatheme.git")
```

Contributions
=============

Please make contributions to this package via pull-requests

Examples
========

Simple scatter plot

``` r
library(ggplot2)
#> Warning: package 'ggplot2' was built under R version 3.1.3
library(adatheme)
#>
#> Attaching package: 'adatheme'
#> The following objects are masked from 'package:ggplot2':
#>
#>     scale_colour_discrete, scale_fill_discrete
theme_set(theme_ada()) # Set ADA theme as default

ggplot(mtcars, aes(x = wt, y = mpg, colour = factor(gear))) +
  geom_point() +
  ggtitle("Cars")
```

![](README-unnamed-chunk-6-1.png)<!-- -->

Bar plot

``` r
library(ggplot2)
library(adatheme)
theme_set(theme_ada()) # Set ADA theme as default

ggplot(diamonds, aes(x = clarity, fill = cut)) +
  geom_bar()
```

![](README-unnamed-chunk-7-1.png)<!-- -->
