<!-- README.md is generated from README.Rmd. Please edit that file -->
scotgov
=======

[![Travis-CI Build Status](https://travis-ci.org/jsphdms/scotgov.svg?branch=master)](https://travis-ci.org/jsphdms/scotgov)

[![Project Status: WIP – Initial development is in progress, but there has not yet been a stable, usable release suitable for the public.](https://www.repostatus.org/badges/latest/wip.svg)](https://www.repostatus.org/#wip)

:construction: :construction: :construction: **Package under construction - watch this space for updates** :construction: :construction: :construction:

Use scotgov to download data from [statistics.gov.scot](http://statistics.gov.scot/home) with a single line of R code. scotgov removes the need to write SPARQL code; you simply need the URI of a dataset. scotgov can be used interactively, or as part of a [reproducible analytical pipeline](https://ukgovdatascience.github.io/rap_companion/).

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

Usage
-----

Find the name of the dataset you want using `list_sg_dataset()`

Learn more in `vignette("scotgov")` or `?scotgov_get`.

Use `list_sg_dataset()` to find all datasets currently loaded onto statistics.gov.scot

Use `scotgov_get()` to get the data from a dataset in statistics.gov.scot

Use `get_structure()` to find all the full sets of categories and values for a particular dataset (helpful for creating new filters for scotgov\_get!)

Use `get_dataset_query()` to produce the SPARQL query used by scotgov\_get().

Examples
--------

Get a dataframe of all datasets on statistics.gov.scot, their uri, and publisher `all_scotgov_datasets <- list_sg_datasets()`

Get the name of the ninty-seventh dataset - for use in later queries (results will change as more datasets are added) `one_dataset <- all_scotgov_datasets[97,4]`

Discover the structure of this datasets - so we can use this in a later filter `our_structure <- get_structure("gross-domestic-product-quarterly-output-by-industry")`

After viewing our\_structure - we decide we only want the q-on-q data for some of the sectors, so we add these to the filter.

``` r
filtered_data <- scotgov_get("gross-domestic-product-quarterly-output-by-industry",
                              measureType = "q-on-q",
                              industrySector = c("Distribution, Hotels and Restaurants (Section G,I)",
                                                 "Business Services and Finance (Section K-N)",
                                                 "Transport, Storage and Communication (Section H,J)",
                                                 "Government and Other Services (Section O-T)"))
```

Future development
------------------

This package is under active development, so any further functionality will be mentioned here when it's ready. If something important is missing, feel free to contact the contributors or [add a new issue](https://github.com/jsphdms/scotgov/issues).

Since this package is under active development, breaking changes may be necessary. We will make it clear once the package is reasonably stable.
