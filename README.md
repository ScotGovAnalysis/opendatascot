
<!-- README.md is generated from README.Rmd. Please edit that file -->
opendatascot <img src = "man/figures/logo.svg" align = "right" height = 150/>
=============================================================================

[![Project Status: WIP – Initial development is in progress, but there has not yet been a stable, usable release suitable for the public.](https://www.repostatus.org/badges/latest/wip.svg)](https://www.repostatus.org/#wip) [![Travis-CI Build Status](https://travis-ci.org/jsphdms/opendatascot.svg?branch=master)](https://travis-ci.org/jsphdms/opendatascot) [![AppVeyor build status](https://ci.appveyor.com/api/projects/status/github/jsphdms/opendatascot?branch=master&svg=true)](https://ci.appveyor.com/project/jsphdms/opendatascot)

Use opendatascot to download data from [statistics.gov.scot](http://statistics.gov.scot/home) with a single line of R code. opendatascot removes the need to write SPARQL code; you simply need the URI of a dataset. The package generates a SPARQL query for a given dataset with optional filters, and runs the query against the statistics.gov.scot api. opendatascot can be used interactively, or as part of a [reproducible analytical pipeline](https://ukgovdatascience.github.io/rap_companion/).

There are existing packages that query open data sources (such as [cbsodataR](https://CRAN.R-project.org/package=cbsodataR), [eurostat](https://CRAN.R-project.org/package=eurostat), and [helsinki](https://CRAN.R-project.org/package=helsinki)) though none that query SPARQL apis. The structure of the statistics.gov.scot api is similar to other uk public sector statistics sites such as [Office for National Statistics](http://statistics.data.gov.uk/) and [MyNHS open data](https://opendata.nhs.uk/), so the opendatascot package could be expanded to call these apis in future.

Installation
------------

Install opendatascot from GitHub with:

``` r
# install.packages("devtools")
devtools::install_github("jsphdms/opendatascot")
```

If the above does not work, you can install from source:

1.  Go to the opendatascot [repository](https://github.com/jsphdms/opendatascot) on GitHub
2.  Click **Clone or download** then **Download ZIP**
3.  Save the file locally (e.g. your H drive) and Unzip
4.  Install with install.packages()

``` r
install.packages("your/directory/opendatascot", repos = NULL,
                 type="source", lib = "your/R/package/library/directory")
```

Usage
-----

Find the name of the dataset you want using `list_sg_dataset()`

Learn more in `vignette("opendatascot")` or `?ods_dataset`.

Use `list_sg_dataset()` to find all datasets currently loaded onto statistics.gov.scot

Use `ods_dataset()` to get the data from a dataset in statistics.gov.scot

Use `ods_structure()` to find all the full sets of categories and values for a particular dataset (helpful for creating new filters for `ods_dataset`!)

Use `ods_print_query()` to produce the SPARQL query used by `ods_dataset()`.

Examples
--------

Get a dataframe of all datasets on statistics.gov.scot, their uri, and publisher `all_scotgov_datasets <- ods_all_datasets()`

Discover the structure of the dataset on homelessness applications - so we can use this in a later filter `our_structure <- ods_structure("homelessness-applications")`

After viewing our\_structure - we decide we only want the data for "all applications" and for the periods "2015/2016" and "2016/2017", so we add these to the filter.

``` r
filtered_data <- ods_dataset("homelessness-applications",
                              refPeriod = c("2015/2016", "2016/2017"),
                              applicationType = "All applications")
```

Future development
------------------

This package is under active development, so any further functionality will be mentioned here when it's ready. If something important is missing, feel free to contact the contributors or [add a new issue](https://github.com/jsphdms/opendatascot/issues).

Since this package is under active development, breaking changes may be necessary. We will make it clear once the package is reasonably stable.
