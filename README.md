
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

Learn more in **vignette(“opendatascot”)** or **?ods\_dataset**.

**ods\_all\_datasets()** finds all datasets currently loaded onto
statistics.gov.scot, and their publisher

**ods\_dataset()** returns data from a dataset in statistics.gov.scot

**ods\_structure()** finds the full sets of categories and values for a
particular dataset (helpful for creating new filters for
**ods\_dataset**\!)

**ods\_print\_query()** produces the SPARQL query used by
**ods\_dataset()**.

**ods\_find\_higher\_geography()** and
**ods\_find\_higher\_geography()** will find all geographical areas with
contain, or are contained by a specified geography.

## Examples

Get a dataframe of all datasets on statistics.gov.scot, their uri, and
publisher

``` r
opendatascot::ods_all_datasets()

    #> # A tibble: 287 x 3
    #>    URI                      Name                      Publisher            
    #>    <chr>                    <chr>                     <chr>                
    #>  1 6-in-1-immunisation      6-in-1 Immunisation       NHS Information Serv…
    #>  2 affordable-housing-supp… Affordable Housing Suppl… Scottish Government  
    #>  3 age-at-first-birth       Age of First Time Mothers NHS Information Serv…
    #>  4 alcohol-related-dischar… Alcohol Related Hospital… NHS Information Serv…
    #>  5 alcohol-related-hospita… Alcohol Related Hospital… NHS Information Serv…
    #>  6 alcohol-use-ever-among-… Alcohol use ever among y… Scottish Government  
    #>  7 annual-business-survey   Annual Business Survey    Scottish Government  
    #>  8 smoking-at-booking       Ante-Natal Smoking        NHS Information Serv…
    #>  9 area-improvement---shs   Area improvement - Scott… Scottish Government  
    #> 10 attendance-allowance     Attendance Allowance      Scottish Government  
    #> # … with 277 more rows
```

Discover the structure of the dataset on homelessness applications - so
we can use this in a later filter

``` r
opendatascot::ods_structure("homelessness-applications")

#> $schemes
#> [1] "http://purl.org/linked-data/sdmx/2009/dimension#refArea"  
#> [2] "http://purl.org/linked-data/sdmx/2009/dimension#refPeriod"
#> [3] "http://purl.org/linked-data/cube#measureType"             
#> [4] "http://statistics.gov.scot/def/dimension/applicationType" 
#> 
#> $categories
#> $categories$refArea
#>  [1] "S92000003" "S12000013" "S12000036" "S12000042" "S12000014"
#>  [6] "S12000029" "S12000006" "S12000035" "S12000008" "S12000030"
#> [11] "S12000017" "S12000045" "S12000018" "S12000038" "S12000010"
#> [16] "S12000033" "S12000027" "S12000005" "S12000019" "S12000040"
#> [21] "S12000020" "S12000041" "S12000039" "S12000021" "S12000011"
#> [26] "S12000028" "S12000034" "S12000023" "S12000026" "S12000047"
#> [31] "S12000048" "S12000050" "S12000049"
#> 
#> $categories$refPeriod
#>  [1] "2007-2008" "2008-2009" "2009-2010" "2010-2011" "2011-2012"
#>  [6] "2012-2013" "2013-2014" "2014-2015" "2015-2016" "2016-2017"
#> [11] "2017-2018" "2018-2019"
#> 
#> $categories$measureType
#> [1] "count"
#> 
#> $categories$applicationType
#> [1] "all-applications"                                    
#> [2] "assessed-as-homeless-or-threatened-with-homelessness"
```

After viewing the structure - we decide we only want the data for “all
applications” and for the periods “2015-2016” and “2016-2017”, so we add
these to the filter.

``` r
opendatascot::ods_dataset("homelessness-applications",
                          applicationType = "all-applications",
                          refPeriod = c("2015-2016", "2016-2017"))
                          
#> # A tibble: 66 x 5
#>    refArea   refPeriod measureType applicationType  value
#>    <chr>     <chr>     <chr>       <chr>            <chr>
#>  1 S12000005 2015-2016 count       all-applications 472  
#>  2 S12000006 2015-2016 count       all-applications 668  
#>  3 S12000008 2015-2016 count       all-applications 505  
#>  4 S12000010 2015-2016 count       all-applications 681  
#>  5 S12000011 2015-2016 count       all-applications 312  
#>  6 S12000013 2015-2016 count       all-applications 157  
#>  7 S12000014 2015-2016 count       all-applications 1066 
#>  8 S12000017 2015-2016 count       all-applications 1056 
#>  9 S12000018 2015-2016 count       all-applications 243  
#> 10 S12000019 2015-2016 count       all-applications 526  
#> # ... with 56 more rows
```

If you’re only interested in a particular geographical level, you can
use the “geography” argument to return only specific levels.

``` r
opendatascot::ods_dataset("homelessness-applications",
                              geography = "la")

#> # A tibble: 768 x 5
#>    refArea   refPeriod measureType applicationType                    value
#>    <chr>     <chr>     <chr>       <chr>                              <chr>
#>  1 S12000005 2007-2008 count       assessed-as-homeless-or-threatene~ 506  
#>  2 S12000005 2007-2008 count       all-applications                   703  
#>  3 S12000006 2007-2008 count       all-applications                   1508 
#>  4 S12000006 2007-2008 count       assessed-as-homeless-or-threatene~ 1090 
#>  5 S12000008 2007-2008 count       assessed-as-homeless-or-threatene~ 702  
#>  6 S12000008 2007-2008 count       all-applications                   1018 
#>  7 S12000010 2007-2008 count       assessed-as-homeless-or-threatene~ 737  
#>  8 S12000010 2007-2008 count       all-applications                   1123 
#>  9 S12000011 2007-2008 count       assessed-as-homeless-or-threatene~ 261  
#> 10 S12000011 2007-2008 count       all-applications                   325  
#> # ... with 758 more rows
```

Option for geography are:<br/> **“dz”** - returns datazones only<br/>
**“iz”** - returns intermediate zones only<br/> **“hb”** - returns
healthboards only<br/> **“la”** - returns local authorities only<br/>
**“sc”** - returns Scotland as a whole only<br/>

## Geography manipulation

If you’re looking for information about what geographies are contained
by, or containing, other geographies, there are two handy functions to
help - **ods\_find\_lower\_geographies()** will return a dataframe of
all geographies that are contained by the geography you pass it
**ods\_find\_higher\_geographies()** will return a dataframe of all
geographies that contain the geography you pass it

``` r
all_zones_in_iz <- ods_find_lower_geographies("S02000003")
all_zones_in_iz

#> # A tibble: 7 x 2
#>   geography description    
#>   <chr>     <chr>          
#> 1 S01000008 2001 Data Zones
#> 2 S01000013 2001 Data Zones
#> 3 S01000007 2001 Data Zones
#> 4 S01000024 2001 Data Zones
#> 5 S01000005 2001 Data Zones
#> 6 S01000001 2001 Data Zones
#> 7 S01000006 2001 Data Zones
```

This dataframe can then be passed to ods\_dataset to get information
about these geographies\! We just need to select the vector of geography
codes, and use the refArea filter option:

``` r
 ods_dataset("house-sales-prices",
             refArea = all_zones_in_iz$geography,
             measureType = "mean",
             refPeriod = "2013"))
#> # A tibble: 7 x 4
#>   refArea   refPeriod measureType value 
#>   <chr>     <chr>     <chr>       <chr> 
#> 1 S01000001 2013      mean        175003
#> 2 S01000005 2013      mean        174404
#> 3 S01000006 2013      mean        195652
#> 4 S01000007 2013      mean        391278
#> 5 S01000008 2013      mean        158028
#> 6 S01000013 2013      mean        174314
#> 7 S01000024 2013      mean        324571
```

## Future development

This package is under active development, so any further functionality
will be mentioned here when it’s ready. If something important is
missing, feel free to contact the contributors or [add a new
issue](https://github.com/jsphdms/opendatascot/issues).

Since this package is under active development, breaking changes may be
necessary. We will make it clear once the package is reasonably stable.
