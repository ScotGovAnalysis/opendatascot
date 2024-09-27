
<!-- README.md is generated from README.Rmd. Please edit that file -->

# opendatascot <img src = "man/figures/logo.svg" alt = "opendatascot logo" align = "right" height = 150/>

[![Project Status: WIP – Initial development is in progress, but there
has not yet been a stable, usable release suitable for the
public.](https://www.repostatus.org/badges/latest/wip.svg)](https://www.repostatus.org/#wip)

Use opendatascot to download data from
[statistics.gov.scot](http://statistics.gov.scot/home) with a single
line of R code. opendatascot removes the need to write SPARQL code; you
simply need the URI of a dataset. opendatascot can be used
interactively, or as part of a [Reproducible Analytical Pipeline
(RAP)](https://analysisfunction.civilservice.gov.uk/support/reproducible-analytical-pipelines/).

## Installation

If you are working within the Scottish Government network, you can
install opendatascot in the same way as with other R packages. The
easiest way to do this is by using the
[pkginstaller](https://github.com/ScotGovAnalysis/pkginstaller/tree/main)
add-in. Further guidance is available on
[eRDM](https://erdm.scotland.gov.uk:8443/documents/A42404229/details).

Alternatively, opendatascot can be installed directly from GitHub. Note
that this method requires the devtools package and may not work from
within the Scottish Government network.

``` r
devtools::install_github(
  "ScotGovAnalysis/opendatascot",
  upgrade = "never",
  build_vignettes = TRUE
)
```

Finally, opendatascot can also be installed by downloading the [zip of
the
repository](https://github.com/ScotGovAnalysis/opendatascot/archive/main.zip)
and running the following code, replacing the section marked `<>`
(including the arrows themselves) with the location of the downloaded
zip:

``` r
devtools::install_local(
  "<FILEPATH OF ZIPPED FILE>/opendatascot-main.zip",
  upgrade = "never",
  build_vignettes = TRUE
)
```

## Usage

Learn more in **vignette(“opendatascot”)** or **?ods_dataset**.

**ods_all_datasets()** finds all datasets currently loaded onto
statistics.gov.scot, and their publisher

**ods_dataset()** returns data from a dataset in statistics.gov.scot

**ods_structure()** finds the full sets of categories and values for a
particular dataset (helpful for creating new filters for
**ods_dataset**!)

**ods_print_query()** produces the SPARQL query used by
**ods_dataset()**.

**ods_find_higher_geography()** and **ods_find_higher_geography()** will
find all geographical areas with contain, or are contained by a
specified geography.

## Examples

Get a dataframe of all datasets on statistics.gov.scot, their uri, and
publisher

``` r
opendatascot::ods_all_datasets()
```

    #> # A tibble: 297 × 3
    #>    URI                                                           Name  Publisher
    #>    <chr>                                                         <chr> <chr>    
    #>  1 6-in-1-immunisation                                           6-in… Public H…
    #>  2 adult-disability-payment-applications-and-payments            Adul… Scottish…
    #>  3 adults-16-64-years-with-low-or-no-qualifications              Adul… Scottish…
    #>  4 affordable-housing-supply-programme                           Affo… Scottish…
    #>  5 age-at-first-birth                                            Age … Public H…
    #>  6 alcohol-related-discharge                                     Alco… Public H…
    #>  7 alcohol-related-hospital-statistics                           Alco… Public H…
    #>  8 alcohol-use-ever-among-young-people-salsus                    Alco… Scottish…
    #>  9 annual-business-survey                                        Annu… Scottish…
    #> 10 information-and-communication-technologies-ict-including-rel… Annu… Scottish…
    #> # ℹ 287 more rows

Discover the structure of the dataset on homelessness applications - so
we can use this in a later filter

``` r
opendatascot::ods_structure("homelessness-applications")
```

    #> $schemes
    #> [1] "http://purl.org/linked-data/sdmx/2009/dimension#refArea"  
    #> [2] "http://purl.org/linked-data/sdmx/2009/dimension#refPeriod"
    #> [3] "http://purl.org/linked-data/cube#measureType"             
    #> [4] "http://statistics.gov.scot/def/dimension/applicationType" 
    #> 
    #> $categories
    #> $categories$refArea
    #>  [1] "West Dunbartonshire"   "West Lothian"          "Scotland"             
    #>  [4] "Clackmannanshire"      "Dumfries and Galloway" "East Ayrshire"        
    #>  [7] "East Lothian"          "East Renfrewshire"     "Na h-Eileanan Siar"   
    #> [10] "Falkirk"               "Highland"              "Inverclyde"           
    #> [13] "Midlothian"            "Moray"                 "North Ayrshire"       
    #> [16] "Orkney Islands"        "Scottish Borders"      "Shetland Islands"     
    #> [19] "South Ayrshire"        "South Lanarkshire"     "Stirling"             
    #> [22] "Aberdeen City"         "Aberdeenshire"         "Argyll and Bute"      
    #> [25] "City of Edinburgh"     "Renfrewshire"          "Angus"                
    #> [28] "Dundee City"           "East Dunbartonshire"   "Fife"                 
    #> [31] "Perth and Kinross"     "Glasgow City"          "North Lanarkshire"    
    #> 
    #> $categories$refPeriod
    #>  [1] "2010/2011" "2011/2012" "2012/2013" "2008/2009" "2009/2010" "2007/2008"
    #>  [7] "2013/2014" "2014/2015" "2015/2016" "2016/2017" "2017/2018" "2018/2019"
    #> [13] "2019/2020" "2020/2021" "2021/2022" "2022/2023"
    #> 
    #> $categories$measureType
    #> [1] "Count"
    #> 
    #> $categories$applicationType
    #> [1] "All applications"                                    
    #> [2] "Assessed as homeless or threatened with homelessness"

After viewing the structure, we decide we only want the data for
“all-applications” and for the periods “2015/2016” and “2016/2017”, so
we add these to the filter.

``` r
opendatascot::ods_dataset("homelessness-applications",
                          applicationType = "all-applications",
                          refPeriod = c("2015/2016", "2016/2017"))
```

    #> # A tibble: 66 × 5
    #>    refArea   refPeriod measureType applicationType  value
    #>    <chr>     <chr>     <chr>       <chr>            <dbl>
    #>  1 S12000008 2015/2016 count       all-applications   505
    #>  2 S12000026 2015/2016 count       all-applications   623
    #>  3 S92000003 2015/2016 count       all-applications 34969
    #>  4 S12000013 2015/2016 count       all-applications   157
    #>  5 S12000048 2015/2016 count       all-applications   898
    #>  6 S12000042 2015/2016 count       all-applications  1474
    #>  7 S12000006 2015/2016 count       all-applications   668
    #>  8 S12000029 2015/2016 count       all-applications  1894
    #>  9 S12000014 2015/2016 count       all-applications  1064
    #> 10 S12000049 2015/2016 count       all-applications  5977
    #> # ℹ 56 more rows

If you’re only interested in a particular geographical level, you can
use the “geography” argument to return only specific levels.

``` r
opendatascot::ods_dataset("homelessness-applications",
                          geography = "la")
```

    #> # A tibble: 1,024 × 5
    #>    refArea   refPeriod measureType applicationType                         value
    #>    <chr>     <chr>     <chr>       <chr>                                   <dbl>
    #>  1 S12000033 2010/2011 count       all-applications                         3406
    #>  2 S12000014 2010/2011 count       assessed-as-homeless-or-threatened-wit…  1780
    #>  3 S12000021 2010/2011 count       assessed-as-homeless-or-threatened-wit…   672
    #>  4 S12000027 2010/2011 count       all-applications                          270
    #>  5 S12000029 2010/2011 count       assessed-as-homeless-or-threatened-wit…  2323
    #>  6 S12000038 2010/2011 count       all-applications                         1253
    #>  7 S12000010 2010/2011 count       all-applications                         1192
    #>  8 S12000040 2010/2011 count       all-applications                         1932
    #>  9 S12000019 2010/2011 count       all-applications                          660
    #> 10 S12000020 2010/2011 count       all-applications                          662
    #> # ℹ 1,014 more rows

Option for geography are:<br/> **“dz”** - returns datazones only<br/>
**“iz”** - returns intermediate zones only<br/> **“hb”** - returns
healthboards only<br/> **“la”** - returns local authorities only<br/>
**“sc”** - returns Scotland as a whole only<br/>

## Geography manipulation

If you’re looking for information about what geographies are contained
by, or containing, other geographies, there are two handy functions to
help - **ods_find_lower_geographies()** will return a dataframe of all
geographies that are contained by the geography you pass it
**ods_find_higher_geographies()** will return a dataframe of all
geographies that contain the geography you pass it

``` r
all_zones_in_iz <- opendatascot::ods_find_lower_geographies("S02000003")
all_zones_in_iz
```

    #> # A tibble: 7 × 2
    #>   geography description    
    #>   <chr>     <chr>          
    #> 1 S01000005 2001 Data Zones
    #> 2 S01000001 2001 Data Zones
    #> 3 S01000013 2001 Data Zones
    #> 4 S01000006 2001 Data Zones
    #> 5 S01000007 2001 Data Zones
    #> 6 S01000008 2001 Data Zones
    #> 7 S01000024 2001 Data Zones

This dataframe can then be passed to ods_dataset to get information
about these geographies! We just need to select the vector of geography
codes, and use the refArea filter option:

``` r
opendatascot::ods_dataset("house-sales-prices",
                          refArea = all_zones_in_iz$geography,
                          measureType = "mean",
                          refPeriod = "2013")
```

    #> # A tibble: 7 × 4
    #>   refArea   refPeriod measureType  value
    #>   <chr>         <dbl> <chr>        <dbl>
    #> 1 S01000001      2013 mean        175003
    #> 2 S01000005      2013 mean        174404
    #> 3 S01000006      2013 mean        195652
    #> 4 S01000007      2013 mean        391278
    #> 5 S01000008      2013 mean        158028
    #> 6 S01000013      2013 mean        174314
    #> 7 S01000024      2013 mean        324571

## Future development

This package is under active development, so any further functionality
will be mentioned here when it’s ready. If something important is
missing, feel free to contact the contributors or [add a new
issue](https://github.com/scotgovanalysis/opendatascot/issues).

Since this package is under active development, breaking changes may be
necessary. We will make it clear once the package is reasonably stable.
