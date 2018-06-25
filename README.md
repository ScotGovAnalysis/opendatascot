
<!-- README.md is generated from README.Rmd. Please edit that file -->
scotgov
=======

**In development - functionality may change.**

Use scotgov to programmatically download data from [statistics.gov.scot](statistics.gov.scot).

We intend for this package to be a useful tool when building [reproducible analytical pipelines](https://ukgovdatascience.github.io/rap_companion/). It is simple to use and follows the concept of DOTADIW: "Do One Thing and Do It Well".

Installation
------------

Install scotgov from GitHub with:

``` r
# install.packages("devtools")
devtools::install_github("jsphdms/scotgov")
```

If the above does not work, you can install from source:

1.  Go to the scotgov [repository](https://github.com/jsphdms/scotgov) on GitHub
2.  Click **Clone or download** then **Download ZIP**
3.  Save the file locally (e.g. your H drive) and Unzip
4.  Install with install.packages()

``` r
install.packages("your/directory/scotgov", repos = NULL,
                 type="source", lib = "your/R/package/library/directory")
```

Example
-------

You will need the URI for your dataset. Find this on the [statistics.gov.scot](statistics.gov.scot) web page for your dataset (in the API tab):

``` r
library(scotgov)

household_size <- scotgov_get("http://statistics.gov.scot/data/average-household-size")
head(household_size)
#>                 refArea refPeriod measureType value
#> 1 Dumfries and Galloway      2003       Ratio  2.25
#> 2         East Ayrshire      2003       Ratio  2.32
#> 3          East Lothian      2003       Ratio  2.32
#> 4     North Lanarkshire      2003       Ratio  2.35
#> 5                 Angus      2003       Ratio  2.24
#> 6           Dundee City      2003       Ratio  2.09
```
