
<!-- README.md is generated from README.Rmd. Please edit that file -->

# opendatascot <img src = "man/figures/logo.svg" align = "right" height = 150/>

[![Project Status: WIP – Initial development is in progress, but there
has not yet been a stable, usable release suitable for the
public.](https://www.repostatus.org/badges/latest/wip.svg)](https://www.repostatus.org/#wip)
[![Travis-CI Build
Status](https://travis-ci.org/datasciencescotland/opendatascot.svg?branch=master)](https://travis-ci.org/datasciencescotland/opendatascot)
[![AppVeyor build
status](https://ci.appveyor.com/api/projects/status/github/datasciencescotland/opendatascot?branch=master&svg=true)](https://ci.appveyor.com/project/datasciencescotland/opendatascot)

Use opendatascot to download data from
[statistics.gov.scot](http://statistics.gov.scot/home) with a single
line of R code. opendatascot removes the need to write SPARQL code; you
simply need the URI of a dataset. opendatascot can be used
interactively, or as part of a [reproducible analytical
pipeline](https://ukgovdatascience.github.io/rap_companion/).

## Installation

Install opendatascot from GitHub with:

``` r
# install.packages("devtools")
devtools::install_github("datasciencescotland/opendatascot")
```

If the above does not work, you can install from source:

1.  Go to the opendatascot
    [repository](https://github.com/datasciencescotland/opendatascot) on
    GitHub
2.  Click **Clone or download** then **Download ZIP**
3.  Save the file locally (e.g. your H drive) and Unzip
4.  Install with install.packages()

<!-- end list -->

``` r
install.packages("your/directory/opendatascot", repos = NULL,
                 type="source")
```

## Usage

Find the name of the dataset you want using **ods\_all\_datasets()**

Learn more in **vignette(“opendatascot”)** or **?ods\_dataset**.

Use **ods\_all\_datasets()** to find all datasets currently loaded onto
statistics.gov.scot

Use **ods\_dataset()** to get the data from a dataset in
statistics.gov.scot

Use **ods\_structure()** to find all the full sets of categories and
values for a particular dataset (helpful for creating new filters for
**ods\_dataset**\!)

Use **ods\_print\_query()** to produce the SPARQL query used by
**ods\_dataset()**.

## Examples

Get a dataframe of all datasets on statistics.gov.scot, their uri, and
publisher **all\_scotgov\_datasets \<- ods\_all\_datasets()**

Discover the structure of the dataset on homelessness applications - so
we can use this in a later filter **our\_structure \<-
ods\_structure(“homelessness-applications”)**

After viewing our\_structure - we decide we only want the data for “all
applications” and for the periods “2015/2016” and “2016/2017”, so we add
these to the filter.

Only interested in a particular geographical level? Use the “geography”
argument to return only specific levels.

``` r
local_authority_only <- ods_dataset("homelessness-applications",
                              geography = "la")
```

Option for geography are: “dz” - returns datazones only “iz” - returns
intermediate zones only “hb” - returns healthboards only “la” - returns
local authorities only “sc” - returns Scotland as a whole only

## Geography manipulation

If you’re looking for information about what geographies are contained
by, or containing, other geographies, there are two handy functions to
help - **ods\_find\_lower\_geographies()** will return a dataframe of
all geographies that are contained by the geography you pass it
**ods\_find\_higher\_geographies()** will return a dataframe of all
geographies that contain the geography you pass it

``` r
all_zones_in_iz <- ods_find_lower_geographies("S02000003")
```

This dataframe can then be passed to ods\_dataset to get infomation
about these geographies\! We just need to select the vector of geography
codes, and use the refArea filter option:

``` r
data_about_these_geographies <- ods_dataset("house-sales-prices",
                                             refArea = all_zones_in_iz$geography)
```

## Future development

This package is under active development, so any further functionality
will be mentioned here when it’s ready. If something important is
missing, feel free to contact the contributors or [add a new
issue](https://github.com/jsphdms/opendatascot/issues).

Since this package is under active development, breaking changes may be
necessary. We will make it clear once the package is reasonably stable.
