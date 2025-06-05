
<!-- README.md is generated from README.Rmd. Please edit that file -->

# opendatascot <img src = "man/figures/logo.svg" alt = "opendatascot logo" align = "right" height = 150/>

<!-- badges: start -->

[![Project Status: WIP – Initial development is in progress, but there
has not yet been a stable, usable release suitable for the
public.](https://www.repostatus.org/badges/latest/wip.svg)](https://www.repostatus.org/#wip)

<!-- badges: end -->

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

    #> # A tibble: 269 × 3
    #>    URI                                                           Name  Publisher
    #>    <chr>                                                         <chr> <chr>    
    #>  1 6-in-1-immunisation                                           6-in… Public H…
    #>  2 adult-disability-payment-applications-and-payments            Adul… Scottish…
    #>  3 adults-16-64-years-with-low-or-no-qualifications              Adul… Scottish…
    #>  4 affordable-housing-supply-programme                           Affo… Scottish…
    #>  5 age-at-first-birth                                            Age … Public H…
    #>  6 alcohol-related-hospital-statistics                           Alco… Public H…
    #>  7 alcohol-use-ever-among-young-people-salsus                    Alco… Scottish…
    #>  8 annual-business-survey                                        Annu… Scottish…
    #>  9 information-and-communication-technologies-ict-including-rel… Annu… Scottish…
    #> 10 smoking-at-booking                                            Ante… Public H…
    #> # ℹ 259 more rows

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
    #> [13] "2019/2020" "2020/2021" "2021/2022" "2022/2023" "2023/2024"
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

    #> [1] applicationType measureType     refPeriod       refArea        
    #> [5] value          
    #> <0 rows> (or 0-length row.names)

If you’re only interested in a particular geographical level, you can
use the “geography” argument to return only specific levels.

``` r
opendatascot::ods_dataset("homelessness-applications",
                          geography = "la")
```

    #> [1] "large dataset, return may take a while"

    #>                                           applicationType measureType refPeriod
    #> 1                                        All applications       Count 2007/2008
    #> 2                                        All applications       Count 2010/2011
    #> 3                                        All applications       Count 2008/2009
    #> 4                                        All applications       Count 2008/2009
    #> 5                                        All applications       Count 2007/2008
    #> 6                                        All applications       Count 2007/2008
    #> 7                                        All applications       Count 2007/2008
    #> 8                                        All applications       Count 2009/2010
    #> 9                                        All applications       Count 2007/2008
    #> 10                                       All applications       Count 2010/2011
    #> 11                                       All applications       Count 2007/2008
    #> 12                                       All applications       Count 2009/2010
    #> 13                                       All applications       Count 2007/2008
    #> 14                                       All applications       Count 2009/2010
    #> 15                                       All applications       Count 2012/2013
    #> 16                                       All applications       Count 2007/2008
    #> 17                                       All applications       Count 2012/2013
    #> 18                                       All applications       Count 2011/2012
    #> 19                                       All applications       Count 2007/2008
    #> 20                                       All applications       Count 2009/2010
    #> 21                                       All applications       Count 2009/2010
    #> 22                                       All applications       Count 2007/2008
    #> 23                                       All applications       Count 2009/2010
    #> 24                                       All applications       Count 2009/2010
    #> 25                                       All applications       Count 2007/2008
    #> 26                                       All applications       Count 2016/2017
    #> 27                                       All applications       Count 2009/2010
    #> 28                                       All applications       Count 2013/2014
    #> 29                                       All applications       Count 2007/2008
    #> 30                                       All applications       Count 2007/2008
    #> 31                                       All applications       Count 2007/2008
    #> 32                                       All applications       Count 2007/2008
    #> 33                                       All applications       Count 2007/2008
    #> 34                                       All applications       Count 2009/2010
    #> 35                                       All applications       Count 2007/2008
    #> 36                                       All applications       Count 2007/2008
    #> 37                                       All applications       Count 2007/2008
    #> 38                                       All applications       Count 2007/2008
    #> 39                                       All applications       Count 2007/2008
    #> 40                                       All applications       Count 2009/2010
    #> 41                                       All applications       Count 2007/2008
    #> 42                                       All applications       Count 2007/2008
    #> 43                                       All applications       Count 2013/2014
    #> 44                                       All applications       Count 2007/2008
    #> 45                                       All applications       Count 2007/2008
    #> 46                                       All applications       Count 2007/2008
    #> 47                                       All applications       Count 2011/2012
    #> 48                                       All applications       Count 2007/2008
    #> 49                                       All applications       Count 2011/2012
    #> 50                                       All applications       Count 2015/2016
    #> 51                                       All applications       Count 2011/2012
    #> 52                                       All applications       Count 2011/2012
    #> 53                                       All applications       Count 2009/2010
    #> 54                                       All applications       Count 2007/2008
    #> 55                                       All applications       Count 2017/2018
    #> 56                                       All applications       Count 2009/2010
    #> 57                                       All applications       Count 2009/2010
    #> 58                                       All applications       Count 2011/2012
    #> 59                                       All applications       Count 2007/2008
    #> 60                                       All applications       Count 2011/2012
    #> 61                                       All applications       Count 2007/2008
    #> 62                                       All applications       Count 2009/2010
    #> 63                                       All applications       Count 2007/2008
    #> 64                                       All applications       Count 2007/2008
    #> 65                                       All applications       Count 2013/2014
    #> 66                                       All applications       Count 2013/2014
    #> 67                                       All applications       Count 2008/2009
    #> 68                                       All applications       Count 2013/2014
    #> 69                                       All applications       Count 2008/2009
    #> 70                                       All applications       Count 2009/2010
    #> 71                                       All applications       Count 2009/2010
    #> 72                                       All applications       Count 2008/2009
    #> 73                                       All applications       Count 2008/2009
    #> 74                                       All applications       Count 2010/2011
    #> 75                                       All applications       Count 2010/2011
    #> 76                                       All applications       Count 2008/2009
    #> 77                                       All applications       Count 2008/2009
    #> 78                                       All applications       Count 2011/2012
    #> 79                                       All applications       Count 2008/2009
    #> 80                                       All applications       Count 2008/2009
    #> 81                                       All applications       Count 2013/2014
    #> 82                                       All applications       Count 2008/2009
    #> 83                                       All applications       Count 2008/2009
    #> 84                                       All applications       Count 2008/2009
    #> 85                                       All applications       Count 2008/2009
    #> 86                                       All applications       Count 2010/2011
    #> 87                                       All applications       Count 2012/2013
    #> 88                                       All applications       Count 2010/2011
    #> 89                                       All applications       Count 2008/2009
    #> 90                                       All applications       Count 2012/2013
    #> 91                                       All applications       Count 2008/2009
    #> 92                                       All applications       Count 2010/2011
    #> 93                                       All applications       Count 2010/2011
    #> 94                                       All applications       Count 2008/2009
    #> 95                                       All applications       Count 2010/2011
    #> 96                                       All applications       Count 2010/2011
    #> 97                                       All applications       Count 2012/2013
    #> 98                                       All applications       Count 2012/2013
    #> 99                                       All applications       Count 2008/2009
    #> 100                                      All applications       Count 2012/2013
    #> 101                                      All applications       Count 2012/2013
    #> 102                                      All applications       Count 2008/2009
    #> 103                                      All applications       Count 2014/2015
    #> 104                                      All applications       Count 2008/2009
    #> 105                                      All applications       Count 2008/2009
    #> 106                                      All applications       Count 2008/2009
    #> 107                                      All applications       Count 2008/2009
    #> 108                                      All applications       Count 2008/2009
    #> 109                                      All applications       Count 2008/2009
    #> 110                                      All applications       Count 2014/2015
    #> 111                                      All applications       Count 2012/2013
    #> 112                                      All applications       Count 2008/2009
    #> 113                                      All applications       Count 2014/2015
    #> 114                                      All applications       Count 2008/2009
    #> 115                                      All applications       Count 2010/2011
    #> 116                                      All applications       Count 2008/2009
    #> 117                                      All applications       Count 2010/2011
    #> 118                                      All applications       Count 2008/2009
    #> 119                                      All applications       Count 2012/2013
    #> 120                                      All applications       Count 2010/2011
    #> 121                                      All applications       Count 2008/2009
    #> 122                                      All applications       Count 2008/2009
    #> 123                                      All applications       Count 2012/2013
    #> 124                                      All applications       Count 2016/2017
    #> 125                                      All applications       Count 2010/2011
    #> 126                                      All applications       Count 2010/2011
    #> 127                                      All applications       Count 2012/2013
    #> 128                                      All applications       Count 2008/2009
    #> 129                                      All applications       Count 2010/2011
    #> 130                                      All applications       Count 2018/2019
    #> 131                                      All applications       Count 2014/2015
    #> 132                                      All applications       Count 2009/2010
    #> 133                                      All applications       Count 2016/2017
    #> 134                                      All applications       Count 2010/2011
    #> 135                                      All applications       Count 2014/2015
    #> 136                                      All applications       Count 2016/2017
    #> 137                                      All applications       Count 2011/2012
    #> 138                                      All applications       Count 2016/2017
    #> 139                                      All applications       Count 2012/2013
    #> 140                                      All applications       Count 2018/2019
    #> 141                                      All applications       Count 2012/2013
    #> 142                                      All applications       Count 2012/2013
    #> 143                                      All applications       Count 2009/2010
    #> 144                                      All applications       Count 2011/2012
    #> 145                                      All applications       Count 2011/2012
    #> 146                                      All applications       Count 2014/2015
    #> 147                                      All applications       Count 2020/2021
    #> 148                                      All applications       Count 2011/2012
    #> 149                                      All applications       Count 2014/2015
    #> 150                                      All applications       Count 2009/2010
    #> 151                                      All applications       Count 2009/2010
    #> 152                                      All applications       Count 2011/2012
    #> 153                                      All applications       Count 2016/2017
    #> 154                                      All applications       Count 2015/2016
    #> 155                                      All applications       Count 2022/2023
    #> 156                                      All applications       Count 2009/2010
    #> 157                                      All applications       Count 2009/2010
    #> 158                                      All applications       Count 2011/2012
    #> 159                                      All applications       Count 2011/2012
    #> 160                                      All applications       Count 2009/2010
    #> 161                                      All applications       Count 2015/2016
    #> 162                                      All applications       Count 2009/2010
    #> 163                                      All applications       Count 2009/2010
    #> 164                                      All applications       Count 2019/2020
    #> 165                                      All applications       Count 2017/2018
    #> 166                                      All applications       Count 2009/2010
    #> 167                                      All applications       Count 2009/2010
    #> 168                                      All applications       Count 2015/2016
    #> 169                                      All applications       Count 2015/2016
    #> 170                                      All applications       Count 2015/2016
    #> 171                                      All applications       Count 2021/2022
    #> 172                                      All applications       Count 2013/2014
    #> 173                                      All applications       Count 2013/2014
    #> 174                                      All applications       Count 2017/2018
    #> 175                                      All applications       Count 2009/2010
    #> 176                                      All applications       Count 2019/2020
    #> 177                                      All applications       Count 2011/2012
    #> 178                                      All applications       Count 2011/2012
    #> 179                                      All applications       Count 2013/2014
    #> 180                                      All applications       Count 2011/2012
    #> 181                                      All applications       Count 2015/2016
    #> 182                                      All applications       Count 2009/2010
    #> 183                                      All applications       Count 2011/2012
    #> 184                                      All applications       Count 2009/2010
    #> 185                                      All applications       Count 2013/2014
    #> 186                                      All applications       Count 2015/2016
    #> 187                                      All applications       Count 2021/2022
    #> 188                                      All applications       Count 2009/2010
    #> 189                                      All applications       Count 2015/2016
    #> 190                                      All applications       Count 2009/2010
    #> 191                                      All applications       Count 2011/2012
    #> 192                                      All applications       Count 2011/2012
    #> 193                                      All applications       Count 2010/2011
    #> 194                                      All applications       Count 2010/2011
    #> 195                                      All applications       Count 2011/2012
    #> 196                                      All applications       Count 2011/2012
    #> 197                                      All applications       Count 2010/2011
    #> 198                                      All applications       Count 2013/2014
    #> 199                                      All applications       Count 2015/2016
    #> 200                                      All applications       Count 2012/2013
    #> 201                                      All applications       Count 2010/2011
    #> 202                                      All applications       Count 2012/2013
    #> 203                                      All applications       Count 2013/2014
    #> 204                                      All applications       Count 2010/2011
    #> 205                                      All applications       Count 2012/2013
    #> 206                                      All applications       Count 2013/2014
    #> 207                                      All applications       Count 2015/2016
    #> 208                                      All applications       Count 2015/2016
    #> 209                                      All applications       Count 2012/2013
    #> 210                                      All applications       Count 2010/2011
    #> 211                                      All applications       Count 2014/2015
    #> 212                                      All applications       Count 2010/2011
    #> 213                                      All applications       Count 2012/2013
    #> 214                                      All applications       Count 2016/2017
    #> 215                                      All applications       Count 2014/2015
    #> 216                                      All applications       Count 2012/2013
    #> 217                                      All applications       Count 2016/2017
    #> 218                                      All applications       Count 2017/2018
    #> 219                                      All applications       Count 2014/2015
    #> 220                                      All applications       Count 2010/2011
    #> 221                                      All applications       Count 2019/2020
    #> 222                                      All applications       Count 2016/2017
    #> 223                                      All applications       Count 2014/2015
    #> 224                                      All applications       Count 2018/2019
    #> 225                                      All applications       Count 2010/2011
    #> 226                                      All applications       Count 2012/2013
    #> 227                                      All applications       Count 2010/2011
    #> 228                                      All applications       Count 2023/2024
    #> 229                                      All applications       Count 2014/2015
    #> 230                                      All applications       Count 2010/2011
    #> 231                                      All applications       Count 2018/2019
    #> 232                                      All applications       Count 2014/2015
    #> 233                                      All applications       Count 2014/2015
    #> 234                                      All applications       Count 2016/2017
    #> 235                                      All applications       Count 2010/2011
    #> 236                                      All applications       Count 2023/2024
    #> 237                                      All applications       Count 2010/2011
    #> 238                                      All applications       Count 2012/2013
    #> 239                                      All applications       Count 2010/2011
    #> 240                                      All applications       Count 2013/2014
    #> 241                                      All applications       Count 2012/2013
    #> 242                                      All applications       Count 2020/2021
    #> 243                                      All applications       Count 2010/2011
    #> 244                                      All applications       Count 2014/2015
    #> 245                                      All applications       Count 2018/2019
    #> 246                                      All applications       Count 2014/2015
    #> 247                                      All applications       Count 2011/2012
    #> 248                                      All applications       Count 2014/2015
    #> 249                                      All applications       Count 2014/2015
    #> 250                                      All applications       Count 2019/2020
    #> 251                                      All applications       Count 2019/2020
    #> 252                                      All applications       Count 2016/2017
    #> 253                                      All applications       Count 2012/2013
    #> 254                                      All applications       Count 2020/2021
    #> 255                                      All applications       Count 2012/2013
    #> 256                                      All applications       Count 2018/2019
    #> 257                                      All applications       Count 2018/2019
    #> 258                                      All applications       Count 2016/2017
    #> 259                                      All applications       Count 2018/2019
    #> 260                                      All applications       Count 2014/2015
    #> 261                                      All applications       Count 2020/2021
    #> 262                                      All applications       Count 2016/2017
    #> 263                                      All applications       Count 2014/2015
    #> 264                                      All applications       Count 2013/2014
    #> 265                                      All applications       Count 2013/2014
    #> 266                                      All applications       Count 2014/2015
    #> 267                                      All applications       Count 2016/2017
    #> 268                                      All applications       Count 2014/2015
    #> 269                                      All applications       Count 2013/2014
    #> 270                                      All applications       Count 2018/2019
    #> 271                                      All applications       Count 2015/2016
    #> 272                                      All applications       Count 2013/2014
    #> 273                                      All applications       Count 2016/2017
    #> 274                                      All applications       Count 2022/2023
    #> 275                                      All applications       Count 2018/2019
    #> 276                                      All applications       Count 2013/2014
    #> 277                                      All applications       Count 2011/2012
    #> 278                                      All applications       Count 2011/2012
    #> 279                                      All applications       Count 2013/2014
    #> 280                                      All applications       Count 2017/2018
    #> 281                                      All applications       Count 2011/2012
    #> 282                                      All applications       Count 2013/2014
    #> 283                                      All applications       Count 2013/2014
    #> 284                                      All applications       Count 2011/2012
    #> 285                                      All applications       Count 2020/2021
    #> 286                                      All applications       Count 2020/2021
    #> 287                                      All applications       Count 2019/2020
    #> 288                                      All applications       Count 2013/2014
    #> 289                                      All applications       Count 2021/2022
    #> 290                                      All applications       Count 2017/2018
    #> 291                                      All applications       Count 2012/2013
    #> 292                                      All applications       Count 2015/2016
    #> 293                                      All applications       Count 2017/2018
    #> 294                                      All applications       Count 2021/2022
    #> 295                                      All applications       Count 2022/2023
    #> 296                                      All applications       Count 2011/2012
    #> 297                                      All applications       Count 2021/2022
    #> 298                                      All applications       Count 2017/2018
    #> 299                                      All applications       Count 2015/2016
    #> 300                                      All applications       Count 2015/2016
    #> 301                                      All applications       Count 2015/2016
    #> 302                                      All applications       Count 2022/2023
    #> 303                                      All applications       Count 2017/2018
    #> 304                                      All applications       Count 2013/2014
    #> 305                                      All applications       Count 2011/2012
    #> 306                                      All applications       Count 2012/2013
    #> 307                                      All applications       Count 2017/2018
    #> 308                                      All applications       Count 2021/2022
    #> 309                                      All applications       Count 2019/2020
    #> 310                                      All applications       Count 2019/2020
    #> 311                                      All applications       Count 2013/2014
    #> 312                                      All applications       Count 2023/2024
    #> 313                                      All applications       Count 2017/2018
    #> 314                                      All applications       Count 2011/2012
    #> 315                                      All applications       Count 2011/2012
    #> 316                                      All applications       Count 2012/2013
    #> 317                                      All applications       Count 2013/2014
    #> 318                                      All applications       Count 2013/2014
    #> 319                                      All applications       Count 2015/2016
    #> 320                                      All applications       Count 2014/2015
    #> 321                                      All applications       Count 2013/2014
    #> 322                                      All applications       Count 2014/2015
    #> 323                                      All applications       Count 2014/2015
    #> 324                                      All applications       Count 2017/2018
    #> 325                                      All applications       Count 2012/2013
    #> 326                                      All applications       Count 2019/2020
    #> 327                                      All applications       Count 2018/2019
    #> 328                                      All applications       Count 2019/2020
    #> 329                                      All applications       Count 2018/2019
    #> 330                                      All applications       Count 2016/2017
    #> 331                                      All applications       Count 2020/2021
    #> 332                                      All applications       Count 2020/2021
    #> 333                                      All applications       Count 2014/2015
    #> 334                                      All applications       Count 2015/2016
    #> 335                                      All applications       Count 2019/2020
    #> 336                                      All applications       Count 2016/2017
    #> 337                                      All applications       Count 2014/2015
    #> 338                                      All applications       Count 2019/2020
    #> 339                                      All applications       Count 2019/2020
    #> 340                                      All applications       Count 2016/2017
    #> 341                                      All applications       Count 2012/2013
    #> 342                                      All applications       Count 2017/2018
    #> 343                                      All applications       Count 2018/2019
    #> 344                                      All applications       Count 2018/2019
    #> 345                                      All applications       Count 2021/2022
    #> 346                                      All applications       Count 2018/2019
    #> 347                                      All applications       Count 2014/2015
    #> 348                                      All applications       Count 2023/2024
    #> 349                                      All applications       Count 2016/2017
    #> 350                                      All applications       Count 2018/2019
    #> 351                                      All applications       Count 2014/2015
    #> 352                                      All applications       Count 2020/2021
    #> 353                                      All applications       Count 2016/2017
    #> 354                                      All applications       Count 2018/2019
    #> 355                                      All applications       Count 2021/2022
    #> 356                                      All applications       Count 2022/2023
    #> 357                                      All applications       Count 2016/2017
    #> 358                                      All applications       Count 2018/2019
    #> 359                                      All applications       Count 2018/2019
    #> 360                                      All applications       Count 2015/2016
    #> 361                                      All applications       Count 2015/2016
    #> 362                                      All applications       Count 2013/2014
    #> 363                                      All applications       Count 2017/2018
    #> 364                                      All applications       Count 2012/2013
    #> 365                                      All applications       Count 2016/2017
    #> 366                                      All applications       Count 2020/2021
    #> 367                                      All applications       Count 2022/2023
    #> 368                                      All applications       Count 2013/2014
    #> 369                                      All applications       Count 2017/2018
    #> 370                                      All applications       Count 2022/2023
    #> 371                                      All applications       Count 2021/2022
    #> 372                                      All applications       Count 2015/2016
    #> 373                                      All applications       Count 2020/2021
    #> 374                                      All applications       Count 2018/2019
    #> 375                                      All applications       Count 2017/2018
    #> 376                                      All applications       Count 2018/2019
    #> 377                                      All applications       Count 2020/2021
    #> 378                                      All applications       Count 2022/2023
    #> 379                                      All applications       Count 2019/2020
    #> 380                                      All applications       Count 2020/2021
    #> 381                                      All applications       Count 2016/2017
    #> 382                                      All applications       Count 2014/2015
    #> 383                                      All applications       Count 2018/2019
    #> 384                                      All applications       Count 2018/2019
    #> 385                                      All applications       Count 2014/2015
    #> 386                                      All applications       Count 2015/2016
    #> 387                                      All applications       Count 2016/2017
    #> 388                                      All applications       Count 2018/2019
    #> 389                                      All applications       Count 2020/2021
    #> 390                                      All applications       Count 2014/2015
    #> 391                                      All applications       Count 2020/2021
    #> 392                                      All applications       Count 2015/2016
    #> 393                                      All applications       Count 2016/2017
    #> 394                                      All applications       Count 2019/2020
    #> 395                                      All applications       Count 2019/2020
    #> 396                                      All applications       Count 2017/2018
    #> 397                                      All applications       Count 2019/2020
    #> 398                                      All applications       Count 2015/2016
    #> 399                                      All applications       Count 2017/2018
    #> 400                                      All applications       Count 2017/2018
    #> 401                                      All applications       Count 2023/2024
    #> 402                                      All applications       Count 2015/2016
    #> 403                                      All applications       Count 2016/2017
    #> 404                                      All applications       Count 2017/2018
    #> 405                                      All applications       Count 2013/2014
    #> 406                                      All applications       Count 2022/2023
    #> 407                                      All applications       Count 2019/2020
    #> 408                                      All applications       Count 2023/2024
    #> 409                                      All applications       Count 2021/2022
    #> 410                                      All applications       Count 2019/2020
    #> 411                                      All applications       Count 2020/2021
    #> 412                                      All applications       Count 2022/2023
    #> 413                                      All applications       Count 2021/2022
    #> 414                                      All applications       Count 2021/2022
    #> 415                                      All applications       Count 2022/2023
    #> 416                                      All applications       Count 2023/2024
    #> 417                                      All applications       Count 2015/2016
    #> 418                                      All applications       Count 2016/2017
    #> 419                                      All applications       Count 2021/2022
    #> 420                                      All applications       Count 2021/2022
    #> 421                                      All applications       Count 2017/2018
    #> 422                                      All applications       Count 2020/2021
    #> 423                                      All applications       Count 2019/2020
    #> 424                                      All applications       Count 2019/2020
    #> 425                                      All applications       Count 2015/2016
    #> 426                                      All applications       Count 2023/2024
    #> 427                                      All applications       Count 2022/2023
    #> 428                                      All applications       Count 2023/2024
    #> 429                                      All applications       Count 2017/2018
    #> 430                                      All applications       Count 2023/2024
    #> 431                                      All applications       Count 2023/2024
    #> 432                                      All applications       Count 2016/2017
    #> 433                                      All applications       Count 2021/2022
    #> 434                                      All applications       Count 2023/2024
    #> 435                                      All applications       Count 2022/2023
    #> 436                                      All applications       Count 2023/2024
    #> 437                                      All applications       Count 2023/2024
    #> 438                                      All applications       Count 2015/2016
    #> 439                                      All applications       Count 2015/2016
    #> 440                                      All applications       Count 2020/2021
    #> 441                                      All applications       Count 2016/2017
    #> 442                                      All applications       Count 2022/2023
    #> 443                                      All applications       Count 2017/2018
    #> 444                                      All applications       Count 2016/2017
    #> 445                                      All applications       Count 2019/2020
    #> 446                                      All applications       Count 2013/2014
    #> 447                                      All applications       Count 2020/2021
    #> 448                                      All applications       Count 2020/2021
    #> 449                                      All applications       Count 2015/2016
    #> 450                                      All applications       Count 2019/2020
    #> 451                                      All applications       Count 2020/2021
    #> 452                                      All applications       Count 2022/2023
    #> 453                                      All applications       Count 2017/2018
    #> 454                                      All applications       Count 2015/2016
    #> 455                                      All applications       Count 2017/2018
    #> 456                                      All applications       Count 2019/2020
    #> 457                                      All applications       Count 2017/2018
    #> 458                                      All applications       Count 2021/2022
    #> 459                                      All applications       Count 2019/2020
    #> 460                                      All applications       Count 2021/2022
    #> 461                                      All applications       Count 2017/2018
    #> 462                                      All applications       Count 2023/2024
    #> 463                                      All applications       Count 2022/2023
    #> 464                                      All applications       Count 2023/2024
    #> 465                                      All applications       Count 2019/2020
    #> 466                                      All applications       Count 2016/2017
    #> 467                                      All applications       Count 2017/2018
    #> 468                                      All applications       Count 2019/2020
    #> 469                                      All applications       Count 2020/2021
    #> 470                                      All applications       Count 2018/2019
    #> 471                                      All applications       Count 2020/2021
    #> 472                                      All applications       Count 2023/2024
    #> 473                                      All applications       Count 2018/2019
    #> 474                                      All applications       Count 2020/2021
    #> 475                                      All applications       Count 2021/2022
    #> 476                                      All applications       Count 2021/2022
    #> 477                                      All applications       Count 2017/2018
    #> 478                                      All applications       Count 2020/2021
    #> 479                                      All applications       Count 2022/2023
    #> 480                                      All applications       Count 2020/2021
    #> 481                                      All applications       Count 2022/2023
    #> 482                                      All applications       Count 2021/2022
    #> 483                                      All applications       Count 2017/2018
    #> 484                                      All applications       Count 2019/2020
    #> 485                                      All applications       Count 2016/2017
    #> 486                                      All applications       Count 2018/2019
    #> 487                                      All applications       Count 2018/2019
    #> 488                                      All applications       Count 2021/2022
    #> 489                                      All applications       Count 2023/2024
    #> 490                                      All applications       Count 2022/2023
    #> 491                                      All applications       Count 2019/2020
    #> 492                                      All applications       Count 2020/2021
    #> 493                                      All applications       Count 2017/2018
    #> 494                                      All applications       Count 2021/2022
    #> 495                                      All applications       Count 2021/2022
    #> 496                                      All applications       Count 2020/2021
    #> 497                                      All applications       Count 2021/2022
    #> 498                                      All applications       Count 2019/2020
    #> 499                                      All applications       Count 2022/2023
    #> 500                                      All applications       Count 2023/2024
    #> 501                                      All applications       Count 2023/2024
    #> 502                                      All applications       Count 2022/2023
    #> 503                                      All applications       Count 2022/2023
    #> 504                                      All applications       Count 2020/2021
    #> 505                                      All applications       Count 2023/2024
    #> 506                                      All applications       Count 2018/2019
    #> 507                                      All applications       Count 2021/2022
    #> 508                                      All applications       Count 2019/2020
    #> 509                                      All applications       Count 2021/2022
    #> 510                                      All applications       Count 2022/2023
    #> 511                                      All applications       Count 2018/2019
    #> 512                                      All applications       Count 2022/2023
    #> 513                                      All applications       Count 2017/2018
    #> 514                                      All applications       Count 2023/2024
    #> 515                                      All applications       Count 2021/2022
    #> 516                                      All applications       Count 2022/2023
    #> 517                                      All applications       Count 2023/2024
    #> 518                                      All applications       Count 2021/2022
    #> 519                                      All applications       Count 2023/2024
    #> 520                                      All applications       Count 2018/2019
    #> 521                                      All applications       Count 2023/2024
    #> 522                                      All applications       Count 2022/2023
    #> 523                                      All applications       Count 2023/2024
    #> 524                                      All applications       Count 2020/2021
    #> 525                                      All applications       Count 2021/2022
    #> 526                                      All applications       Count 2021/2022
    #> 527                                      All applications       Count 2022/2023
    #> 528                                      All applications       Count 2023/2024
    #> 529                                      All applications       Count 2022/2023
    #> 530                                      All applications       Count 2023/2024
    #> 531                                      All applications       Count 2021/2022
    #> 532                                      All applications       Count 2023/2024
    #> 533                                      All applications       Count 2020/2021
    #> 534                                      All applications       Count 2022/2023
    #> 535                                      All applications       Count 2022/2023
    #> 536                                      All applications       Count 2022/2023
    #> 537                                      All applications       Count 2023/2024
    #> 538                                      All applications       Count 2018/2019
    #> 539                                      All applications       Count 2020/2021
    #> 540                                      All applications       Count 2023/2024
    #> 541                                      All applications       Count 2021/2022
    #> 542                                      All applications       Count 2023/2024
    #> 543                                      All applications       Count 2022/2023
    #> 544                                      All applications       Count 2019/2020
    #> 545  Assessed as homeless or threatened with homelessness       Count 2011/2012
    #> 546  Assessed as homeless or threatened with homelessness       Count 2008/2009
    #> 547  Assessed as homeless or threatened with homelessness       Count 2008/2009
    #> 548  Assessed as homeless or threatened with homelessness       Count 2010/2011
    #> 549  Assessed as homeless or threatened with homelessness       Count 2007/2008
    #> 550  Assessed as homeless or threatened with homelessness       Count 2012/2013
    #> 551  Assessed as homeless or threatened with homelessness       Count 2009/2010
    #> 552  Assessed as homeless or threatened with homelessness       Count 2009/2010
    #> 553  Assessed as homeless or threatened with homelessness       Count 2007/2008
    #> 554  Assessed as homeless or threatened with homelessness       Count 2009/2010
    #> 555  Assessed as homeless or threatened with homelessness       Count 2007/2008
    #> 556  Assessed as homeless or threatened with homelessness       Count 2007/2008
    #> 557  Assessed as homeless or threatened with homelessness       Count 2009/2010
    #> 558  Assessed as homeless or threatened with homelessness       Count 2008/2009
    #> 559  Assessed as homeless or threatened with homelessness       Count 2009/2010
    #> 560  Assessed as homeless or threatened with homelessness       Count 2008/2009
    #> 561  Assessed as homeless or threatened with homelessness       Count 2007/2008
    #> 562  Assessed as homeless or threatened with homelessness       Count 2012/2013
    #> 563  Assessed as homeless or threatened with homelessness       Count 2011/2012
    #> 564  Assessed as homeless or threatened with homelessness       Count 2008/2009
    #> 565  Assessed as homeless or threatened with homelessness       Count 2008/2009
    #> 566  Assessed as homeless or threatened with homelessness       Count 2012/2013
    #> 567  Assessed as homeless or threatened with homelessness       Count 2007/2008
    #> 568  Assessed as homeless or threatened with homelessness       Count 2007/2008
    #> 569  Assessed as homeless or threatened with homelessness       Count 2011/2012
    #> 570  Assessed as homeless or threatened with homelessness       Count 2009/2010
    #> 571  Assessed as homeless or threatened with homelessness       Count 2012/2013
    #> 572  Assessed as homeless or threatened with homelessness       Count 2010/2011
    #> 573  Assessed as homeless or threatened with homelessness       Count 2007/2008
    #> 574  Assessed as homeless or threatened with homelessness       Count 2009/2010
    #> 575  Assessed as homeless or threatened with homelessness       Count 2010/2011
    #> 576  Assessed as homeless or threatened with homelessness       Count 2009/2010
    #> 577  Assessed as homeless or threatened with homelessness       Count 2007/2008
    #> 578  Assessed as homeless or threatened with homelessness       Count 2007/2008
    #> 579  Assessed as homeless or threatened with homelessness       Count 2007/2008
    #> 580  Assessed as homeless or threatened with homelessness       Count 2007/2008
    #> 581  Assessed as homeless or threatened with homelessness       Count 2009/2010
    #> 582  Assessed as homeless or threatened with homelessness       Count 2014/2015
    #> 583  Assessed as homeless or threatened with homelessness       Count 2009/2010
    #> 584  Assessed as homeless or threatened with homelessness       Count 2013/2014
    #> 585  Assessed as homeless or threatened with homelessness       Count 2007/2008
    #> 586  Assessed as homeless or threatened with homelessness       Count 2007/2008
    #> 587  Assessed as homeless or threatened with homelessness       Count 2009/2010
    #> 588  Assessed as homeless or threatened with homelessness       Count 2011/2012
    #> 589  Assessed as homeless or threatened with homelessness       Count 2008/2009
    #> 590  Assessed as homeless or threatened with homelessness       Count 2011/2012
    #> 591  Assessed as homeless or threatened with homelessness       Count 2007/2008
    #> 592  Assessed as homeless or threatened with homelessness       Count 2010/2011
    #> 593  Assessed as homeless or threatened with homelessness       Count 2008/2009
    #> 594  Assessed as homeless or threatened with homelessness       Count 2013/2014
    #> 595  Assessed as homeless or threatened with homelessness       Count 2008/2009
    #> 596  Assessed as homeless or threatened with homelessness       Count 2009/2010
    #> 597  Assessed as homeless or threatened with homelessness       Count 2010/2011
    #> 598  Assessed as homeless or threatened with homelessness       Count 2013/2014
    #> 599  Assessed as homeless or threatened with homelessness       Count 2010/2011
    #> 600  Assessed as homeless or threatened with homelessness       Count 2011/2012
    #> 601  Assessed as homeless or threatened with homelessness       Count 2007/2008
    #> 602  Assessed as homeless or threatened with homelessness       Count 2008/2009
    #> 603  Assessed as homeless or threatened with homelessness       Count 2011/2012
    #> 604  Assessed as homeless or threatened with homelessness       Count 2011/2012
    #> 605  Assessed as homeless or threatened with homelessness       Count 2009/2010
    #> 606  Assessed as homeless or threatened with homelessness       Count 2012/2013
    #> 607  Assessed as homeless or threatened with homelessness       Count 2010/2011
    #> 608  Assessed as homeless or threatened with homelessness       Count 2012/2013
    #> 609  Assessed as homeless or threatened with homelessness       Count 2016/2017
    #> 610  Assessed as homeless or threatened with homelessness       Count 2008/2009
    #> 611  Assessed as homeless or threatened with homelessness       Count 2013/2014
    #> 612  Assessed as homeless or threatened with homelessness       Count 2014/2015
    #> 613  Assessed as homeless or threatened with homelessness       Count 2011/2012
    #> 614  Assessed as homeless or threatened with homelessness       Count 2015/2016
    #> 615  Assessed as homeless or threatened with homelessness       Count 2007/2008
    #> 616  Assessed as homeless or threatened with homelessness       Count 2010/2011
    #> 617  Assessed as homeless or threatened with homelessness       Count 2008/2009
    #> 618  Assessed as homeless or threatened with homelessness       Count 2008/2009
    #> 619  Assessed as homeless or threatened with homelessness       Count 2011/2012
    #> 620  Assessed as homeless or threatened with homelessness       Count 2010/2011
    #> 621  Assessed as homeless or threatened with homelessness       Count 2012/2013
    #> 622  Assessed as homeless or threatened with homelessness       Count 2010/2011
    #> 623  Assessed as homeless or threatened with homelessness       Count 2010/2011
    #> 624  Assessed as homeless or threatened with homelessness       Count 2014/2015
    #> 625  Assessed as homeless or threatened with homelessness       Count 2008/2009
    #> 626  Assessed as homeless or threatened with homelessness       Count 2016/2017
    #> 627  Assessed as homeless or threatened with homelessness       Count 2008/2009
    #> 628  Assessed as homeless or threatened with homelessness       Count 2016/2017
    #> 629  Assessed as homeless or threatened with homelessness       Count 2010/2011
    #> 630  Assessed as homeless or threatened with homelessness       Count 2013/2014
    #> 631  Assessed as homeless or threatened with homelessness       Count 2014/2015
    #> 632  Assessed as homeless or threatened with homelessness       Count 2007/2008
    #> 633  Assessed as homeless or threatened with homelessness       Count 2008/2009
    #> 634  Assessed as homeless or threatened with homelessness       Count 2014/2015
    #> 635  Assessed as homeless or threatened with homelessness       Count 2009/2010
    #> 636  Assessed as homeless or threatened with homelessness       Count 2009/2010
    #> 637  Assessed as homeless or threatened with homelessness       Count 2013/2014
    #> 638  Assessed as homeless or threatened with homelessness       Count 2015/2016
    #> 639  Assessed as homeless or threatened with homelessness       Count 2011/2012
    #> 640  Assessed as homeless or threatened with homelessness       Count 2014/2015
    #> 641  Assessed as homeless or threatened with homelessness       Count 2010/2011
    #> 642  Assessed as homeless or threatened with homelessness       Count 2014/2015
    #> 643  Assessed as homeless or threatened with homelessness       Count 2010/2011
    #> 644  Assessed as homeless or threatened with homelessness       Count 2014/2015
    #> 645  Assessed as homeless or threatened with homelessness       Count 2007/2008
    #> 646  Assessed as homeless or threatened with homelessness       Count 2009/2010
    #> 647  Assessed as homeless or threatened with homelessness       Count 2013/2014
    #> 648  Assessed as homeless or threatened with homelessness       Count 2008/2009
    #> 649  Assessed as homeless or threatened with homelessness       Count 2011/2012
    #> 650  Assessed as homeless or threatened with homelessness       Count 2016/2017
    #> 651  Assessed as homeless or threatened with homelessness       Count 2010/2011
    #> 652  Assessed as homeless or threatened with homelessness       Count 2008/2009
    #> 653  Assessed as homeless or threatened with homelessness       Count 2009/2010
    #> 654  Assessed as homeless or threatened with homelessness       Count 2014/2015
    #> 655  Assessed as homeless or threatened with homelessness       Count 2009/2010
    #> 656  Assessed as homeless or threatened with homelessness       Count 2007/2008
    #> 657  Assessed as homeless or threatened with homelessness       Count 2012/2013
    #> 658  Assessed as homeless or threatened with homelessness       Count 2013/2014
    #> 659  Assessed as homeless or threatened with homelessness       Count 2009/2010
    #> 660  Assessed as homeless or threatened with homelessness       Count 2007/2008
    #> 661  Assessed as homeless or threatened with homelessness       Count 2009/2010
    #> 662  Assessed as homeless or threatened with homelessness       Count 2017/2018
    #> 663  Assessed as homeless or threatened with homelessness       Count 2009/2010
    #> 664  Assessed as homeless or threatened with homelessness       Count 2011/2012
    #> 665  Assessed as homeless or threatened with homelessness       Count 2007/2008
    #> 666  Assessed as homeless or threatened with homelessness       Count 2011/2012
    #> 667  Assessed as homeless or threatened with homelessness       Count 2008/2009
    #> 668  Assessed as homeless or threatened with homelessness       Count 2007/2008
    #> 669  Assessed as homeless or threatened with homelessness       Count 2017/2018
    #> 670  Assessed as homeless or threatened with homelessness       Count 2009/2010
    #> 671  Assessed as homeless or threatened with homelessness       Count 2013/2014
    #> 672  Assessed as homeless or threatened with homelessness       Count 2013/2014
    #> 673  Assessed as homeless or threatened with homelessness       Count 2009/2010
    #> 674  Assessed as homeless or threatened with homelessness       Count 2007/2008
    #> 675  Assessed as homeless or threatened with homelessness       Count 2011/2012
    #> 676  Assessed as homeless or threatened with homelessness       Count 2008/2009
    #> 677  Assessed as homeless or threatened with homelessness       Count 2013/2014
    #> 678  Assessed as homeless or threatened with homelessness       Count 2011/2012
    #> 679  Assessed as homeless or threatened with homelessness       Count 2014/2015
    #> 680  Assessed as homeless or threatened with homelessness       Count 2008/2009
    #> 681  Assessed as homeless or threatened with homelessness       Count 2013/2014
    #> 682  Assessed as homeless or threatened with homelessness       Count 2008/2009
    #> 683  Assessed as homeless or threatened with homelessness       Count 2007/2008
    #> 684  Assessed as homeless or threatened with homelessness       Count 2012/2013
    #> 685  Assessed as homeless or threatened with homelessness       Count 2015/2016
    #> 686  Assessed as homeless or threatened with homelessness       Count 2009/2010
    #> 687  Assessed as homeless or threatened with homelessness       Count 2012/2013
    #> 688  Assessed as homeless or threatened with homelessness       Count 2013/2014
    #> 689  Assessed as homeless or threatened with homelessness       Count 2015/2016
    #> 690  Assessed as homeless or threatened with homelessness       Count 2012/2013
    #> 691  Assessed as homeless or threatened with homelessness       Count 2008/2009
    #> 692  Assessed as homeless or threatened with homelessness       Count 2010/2011
    #> 693  Assessed as homeless or threatened with homelessness       Count 2014/2015
    #> 694  Assessed as homeless or threatened with homelessness       Count 2009/2010
    #> 695  Assessed as homeless or threatened with homelessness       Count 2013/2014
    #> 696  Assessed as homeless or threatened with homelessness       Count 2012/2013
    #> 697  Assessed as homeless or threatened with homelessness       Count 2015/2016
    #> 698  Assessed as homeless or threatened with homelessness       Count 2012/2013
    #> 699  Assessed as homeless or threatened with homelessness       Count 2010/2011
    #> 700  Assessed as homeless or threatened with homelessness       Count 2007/2008
    #> 701  Assessed as homeless or threatened with homelessness       Count 2012/2013
    #> 702  Assessed as homeless or threatened with homelessness       Count 2008/2009
    #> 703  Assessed as homeless or threatened with homelessness       Count 2007/2008
    #> 704  Assessed as homeless or threatened with homelessness       Count 2016/2017
    #> 705  Assessed as homeless or threatened with homelessness       Count 2017/2018
    #> 706  Assessed as homeless or threatened with homelessness       Count 2010/2011
    #> 707  Assessed as homeless or threatened with homelessness       Count 2012/2013
    #> 708  Assessed as homeless or threatened with homelessness       Count 2010/2011
    #> 709  Assessed as homeless or threatened with homelessness       Count 2018/2019
    #> 710  Assessed as homeless or threatened with homelessness       Count 2016/2017
    #> 711  Assessed as homeless or threatened with homelessness       Count 2015/2016
    #> 712  Assessed as homeless or threatened with homelessness       Count 2016/2017
    #> 713  Assessed as homeless or threatened with homelessness       Count 2011/2012
    #> 714  Assessed as homeless or threatened with homelessness       Count 2013/2014
    #> 715  Assessed as homeless or threatened with homelessness       Count 2015/2016
    #> 716  Assessed as homeless or threatened with homelessness       Count 2010/2011
    #> 717  Assessed as homeless or threatened with homelessness       Count 2018/2019
    #> 718  Assessed as homeless or threatened with homelessness       Count 2012/2013
    #> 719  Assessed as homeless or threatened with homelessness       Count 2015/2016
    #> 720  Assessed as homeless or threatened with homelessness       Count 2016/2017
    #> 721  Assessed as homeless or threatened with homelessness       Count 2012/2013
    #> 722  Assessed as homeless or threatened with homelessness       Count 2010/2011
    #> 723  Assessed as homeless or threatened with homelessness       Count 2016/2017
    #> 724  Assessed as homeless or threatened with homelessness       Count 2011/2012
    #> 725  Assessed as homeless or threatened with homelessness       Count 2013/2014
    #> 726  Assessed as homeless or threatened with homelessness       Count 2010/2011
    #> 727  Assessed as homeless or threatened with homelessness       Count 2010/2011
    #> 728  Assessed as homeless or threatened with homelessness       Count 2010/2011
    #> 729  Assessed as homeless or threatened with homelessness       Count 2012/2013
    #> 730  Assessed as homeless or threatened with homelessness       Count 2007/2008
    #> 731  Assessed as homeless or threatened with homelessness       Count 2008/2009
    #> 732  Assessed as homeless or threatened with homelessness       Count 2017/2018
    #> 733  Assessed as homeless or threatened with homelessness       Count 2012/2013
    #> 734  Assessed as homeless or threatened with homelessness       Count 2018/2019
    #> 735  Assessed as homeless or threatened with homelessness       Count 2010/2011
    #> 736  Assessed as homeless or threatened with homelessness       Count 2012/2013
    #> 737  Assessed as homeless or threatened with homelessness       Count 2014/2015
    #> 738  Assessed as homeless or threatened with homelessness       Count 2014/2015
    #> 739  Assessed as homeless or threatened with homelessness       Count 2016/2017
    #> 740  Assessed as homeless or threatened with homelessness       Count 2008/2009
    #> 741  Assessed as homeless or threatened with homelessness       Count 2011/2012
    #> 742  Assessed as homeless or threatened with homelessness       Count 2018/2019
    #> 743  Assessed as homeless or threatened with homelessness       Count 2011/2012
    #> 744  Assessed as homeless or threatened with homelessness       Count 2007/2008
    #> 745  Assessed as homeless or threatened with homelessness       Count 2016/2017
    #> 746  Assessed as homeless or threatened with homelessness       Count 2011/2012
    #> 747  Assessed as homeless or threatened with homelessness       Count 2016/2017
    #> 748  Assessed as homeless or threatened with homelessness       Count 2011/2012
    #> 749  Assessed as homeless or threatened with homelessness       Count 2014/2015
    #> 750  Assessed as homeless or threatened with homelessness       Count 2007/2008
    #> 751  Assessed as homeless or threatened with homelessness       Count 2018/2019
    #> 752  Assessed as homeless or threatened with homelessness       Count 2014/2015
    #> 753  Assessed as homeless or threatened with homelessness       Count 2016/2017
    #> 754  Assessed as homeless or threatened with homelessness       Count 2011/2012
    #> 755  Assessed as homeless or threatened with homelessness       Count 2016/2017
    #> 756  Assessed as homeless or threatened with homelessness       Count 2015/2016
    #> 757  Assessed as homeless or threatened with homelessness       Count 2013/2014
    #> 758  Assessed as homeless or threatened with homelessness       Count 2015/2016
    #> 759  Assessed as homeless or threatened with homelessness       Count 2017/2018
    #> 760  Assessed as homeless or threatened with homelessness       Count 2016/2017
    #> 761  Assessed as homeless or threatened with homelessness       Count 2013/2014
    #> 762  Assessed as homeless or threatened with homelessness       Count 2015/2016
    #> 763  Assessed as homeless or threatened with homelessness       Count 2010/2011
    #> 764  Assessed as homeless or threatened with homelessness       Count 2018/2019
    #> 765  Assessed as homeless or threatened with homelessness       Count 2015/2016
    #> 766  Assessed as homeless or threatened with homelessness       Count 2011/2012
    #> 767  Assessed as homeless or threatened with homelessness       Count 2015/2016
    #> 768  Assessed as homeless or threatened with homelessness       Count 2009/2010
    #> 769  Assessed as homeless or threatened with homelessness       Count 2011/2012
    #> 770  Assessed as homeless or threatened with homelessness       Count 2013/2014
    #> 771  Assessed as homeless or threatened with homelessness       Count 2018/2019
    #> 772  Assessed as homeless or threatened with homelessness       Count 2014/2015
    #> 773  Assessed as homeless or threatened with homelessness       Count 2019/2020
    #> 774  Assessed as homeless or threatened with homelessness       Count 2011/2012
    #> 775  Assessed as homeless or threatened with homelessness       Count 2016/2017
    #> 776  Assessed as homeless or threatened with homelessness       Count 2017/2018
    #> 777  Assessed as homeless or threatened with homelessness       Count 2009/2010
    #> 778  Assessed as homeless or threatened with homelessness       Count 2017/2018
    #> 779  Assessed as homeless or threatened with homelessness       Count 2015/2016
    #> 780  Assessed as homeless or threatened with homelessness       Count 2012/2013
    #> 781  Assessed as homeless or threatened with homelessness       Count 2013/2014
    #> 782  Assessed as homeless or threatened with homelessness       Count 2013/2014
    #> 783  Assessed as homeless or threatened with homelessness       Count 2019/2020
    #> 784  Assessed as homeless or threatened with homelessness       Count 2009/2010
    #> 785  Assessed as homeless or threatened with homelessness       Count 2012/2013
    #> 786  Assessed as homeless or threatened with homelessness       Count 2019/2020
    #> 787  Assessed as homeless or threatened with homelessness       Count 2013/2014
    #> 788  Assessed as homeless or threatened with homelessness       Count 2007/2008
    #> 789  Assessed as homeless or threatened with homelessness       Count 2013/2014
    #> 790  Assessed as homeless or threatened with homelessness       Count 2019/2020
    #> 791  Assessed as homeless or threatened with homelessness       Count 2011/2012
    #> 792  Assessed as homeless or threatened with homelessness       Count 2017/2018
    #> 793  Assessed as homeless or threatened with homelessness       Count 2015/2016
    #> 794  Assessed as homeless or threatened with homelessness       Count 2011/2012
    #> 795  Assessed as homeless or threatened with homelessness       Count 2016/2017
    #> 796  Assessed as homeless or threatened with homelessness       Count 2017/2018
    #> 797  Assessed as homeless or threatened with homelessness       Count 2013/2014
    #> 798  Assessed as homeless or threatened with homelessness       Count 2015/2016
    #> 799  Assessed as homeless or threatened with homelessness       Count 2013/2014
    #> 800  Assessed as homeless or threatened with homelessness       Count 2019/2020
    #> 801  Assessed as homeless or threatened with homelessness       Count 2008/2009
    #> 802  Assessed as homeless or threatened with homelessness       Count 2011/2012
    #> 803  Assessed as homeless or threatened with homelessness       Count 2011/2012
    #> 804  Assessed as homeless or threatened with homelessness       Count 2009/2010
    #> 805  Assessed as homeless or threatened with homelessness       Count 2010/2011
    #> 806  Assessed as homeless or threatened with homelessness       Count 2017/2018
    #> 807  Assessed as homeless or threatened with homelessness       Count 2019/2020
    #> 808  Assessed as homeless or threatened with homelessness       Count 2012/2013
    #> 809  Assessed as homeless or threatened with homelessness       Count 2015/2016
    #> 810  Assessed as homeless or threatened with homelessness       Count 2017/2018
    #> 811  Assessed as homeless or threatened with homelessness       Count 2015/2016
    #> 812  Assessed as homeless or threatened with homelessness       Count 2010/2011
    #> 813  Assessed as homeless or threatened with homelessness       Count 2017/2018
    #> 814  Assessed as homeless or threatened with homelessness       Count 2015/2016
    #> 815  Assessed as homeless or threatened with homelessness       Count 2013/2014
    #> 816  Assessed as homeless or threatened with homelessness       Count 2017/2018
    #> 817  Assessed as homeless or threatened with homelessness       Count 2017/2018
    #> 818  Assessed as homeless or threatened with homelessness       Count 2008/2009
    #> 819  Assessed as homeless or threatened with homelessness       Count 2014/2015
    #> 820  Assessed as homeless or threatened with homelessness       Count 2013/2014
    #> 821  Assessed as homeless or threatened with homelessness       Count 2017/2018
    #> 822  Assessed as homeless or threatened with homelessness       Count 2014/2015
    #> 823  Assessed as homeless or threatened with homelessness       Count 2010/2011
    #> 824  Assessed as homeless or threatened with homelessness       Count 2008/2009
    #> 825  Assessed as homeless or threatened with homelessness       Count 2017/2018
    #> 826  Assessed as homeless or threatened with homelessness       Count 2018/2019
    #> 827  Assessed as homeless or threatened with homelessness       Count 2014/2015
    #> 828  Assessed as homeless or threatened with homelessness       Count 2016/2017
    #> 829  Assessed as homeless or threatened with homelessness       Count 2012/2013
    #> 830  Assessed as homeless or threatened with homelessness       Count 2019/2020
    #> 831  Assessed as homeless or threatened with homelessness       Count 2018/2019
    #> 832  Assessed as homeless or threatened with homelessness       Count 2012/2013
    #> 833  Assessed as homeless or threatened with homelessness       Count 2018/2019
    #> 834  Assessed as homeless or threatened with homelessness       Count 2012/2013
    #> 835  Assessed as homeless or threatened with homelessness       Count 2011/2012
    #> 836  Assessed as homeless or threatened with homelessness       Count 2020/2021
    #> 837  Assessed as homeless or threatened with homelessness       Count 2018/2019
    #> 838  Assessed as homeless or threatened with homelessness       Count 2020/2021
    #> 839  Assessed as homeless or threatened with homelessness       Count 2018/2019
    #> 840  Assessed as homeless or threatened with homelessness       Count 2014/2015
    #> 841  Assessed as homeless or threatened with homelessness       Count 2018/2019
    #> 842  Assessed as homeless or threatened with homelessness       Count 2014/2015
    #> 843  Assessed as homeless or threatened with homelessness       Count 2008/2009
    #> 844  Assessed as homeless or threatened with homelessness       Count 2013/2014
    #> 845  Assessed as homeless or threatened with homelessness       Count 2020/2021
    #> 846  Assessed as homeless or threatened with homelessness       Count 2017/2018
    #> 847  Assessed as homeless or threatened with homelessness       Count 2010/2011
    #> 848  Assessed as homeless or threatened with homelessness       Count 2014/2015
    #> 849  Assessed as homeless or threatened with homelessness       Count 2007/2008
    #> 850  Assessed as homeless or threatened with homelessness       Count 2014/2015
    #> 851  Assessed as homeless or threatened with homelessness       Count 2012/2013
    #> 852  Assessed as homeless or threatened with homelessness       Count 2012/2013
    #> 853  Assessed as homeless or threatened with homelessness       Count 2016/2017
    #> 854  Assessed as homeless or threatened with homelessness       Count 2018/2019
    #> 855  Assessed as homeless or threatened with homelessness       Count 2020/2021
    #> 856  Assessed as homeless or threatened with homelessness       Count 2020/2021
    #> 857  Assessed as homeless or threatened with homelessness       Count 2018/2019
    #> 858  Assessed as homeless or threatened with homelessness       Count 2016/2017
    #> 859  Assessed as homeless or threatened with homelessness       Count 2018/2019
    #> 860  Assessed as homeless or threatened with homelessness       Count 2020/2021
    #> 861  Assessed as homeless or threatened with homelessness       Count 2016/2017
    #> 862  Assessed as homeless or threatened with homelessness       Count 2014/2015
    #> 863  Assessed as homeless or threatened with homelessness       Count 2020/2021
    #> 864  Assessed as homeless or threatened with homelessness       Count 2014/2015
    #> 865  Assessed as homeless or threatened with homelessness       Count 2009/2010
    #> 866  Assessed as homeless or threatened with homelessness       Count 2014/2015
    #> 867  Assessed as homeless or threatened with homelessness       Count 2014/2015
    #> 868  Assessed as homeless or threatened with homelessness       Count 2020/2021
    #> 869  Assessed as homeless or threatened with homelessness       Count 2018/2019
    #> 870  Assessed as homeless or threatened with homelessness       Count 2016/2017
    #> 871  Assessed as homeless or threatened with homelessness       Count 2013/2014
    #> 872  Assessed as homeless or threatened with homelessness       Count 2020/2021
    #> 873  Assessed as homeless or threatened with homelessness       Count 2018/2019
    #> 874  Assessed as homeless or threatened with homelessness       Count 2020/2021
    #> 875  Assessed as homeless or threatened with homelessness       Count 2016/2017
    #> 876  Assessed as homeless or threatened with homelessness       Count 2018/2019
    #> 877  Assessed as homeless or threatened with homelessness       Count 2018/2019
    #> 878  Assessed as homeless or threatened with homelessness       Count 2015/2016
    #> 879  Assessed as homeless or threatened with homelessness       Count 2018/2019
    #> 880  Assessed as homeless or threatened with homelessness       Count 2016/2017
    #> 881  Assessed as homeless or threatened with homelessness       Count 2018/2019
    #> 882  Assessed as homeless or threatened with homelessness       Count 2016/2017
    #> 883  Assessed as homeless or threatened with homelessness       Count 2018/2019
    #> 884  Assessed as homeless or threatened with homelessness       Count 2009/2010
    #> 885  Assessed as homeless or threatened with homelessness       Count 2018/2019
    #> 886  Assessed as homeless or threatened with homelessness       Count 2020/2021
    #> 887  Assessed as homeless or threatened with homelessness       Count 2018/2019
    #> 888  Assessed as homeless or threatened with homelessness       Count 2018/2019
    #> 889  Assessed as homeless or threatened with homelessness       Count 2015/2016
    #> 890  Assessed as homeless or threatened with homelessness       Count 2015/2016
    #> 891  Assessed as homeless or threatened with homelessness       Count 2015/2016
    #> 892  Assessed as homeless or threatened with homelessness       Count 2020/2021
    #> 893  Assessed as homeless or threatened with homelessness       Count 2011/2012
    #> 894  Assessed as homeless or threatened with homelessness       Count 2020/2021
    #> 895  Assessed as homeless or threatened with homelessness       Count 2013/2014
    #> 896  Assessed as homeless or threatened with homelessness       Count 2017/2018
    #> 897  Assessed as homeless or threatened with homelessness       Count 2019/2020
    #> 898  Assessed as homeless or threatened with homelessness       Count 2015/2016
    #> 899  Assessed as homeless or threatened with homelessness       Count 2019/2020
    #> 900  Assessed as homeless or threatened with homelessness       Count 2019/2020
    #> 901  Assessed as homeless or threatened with homelessness       Count 2017/2018
    #> 902  Assessed as homeless or threatened with homelessness       Count 2015/2016
    #> 903  Assessed as homeless or threatened with homelessness       Count 2015/2016
    #> 904  Assessed as homeless or threatened with homelessness       Count 2021/2022
    #> 905  Assessed as homeless or threatened with homelessness       Count 2019/2020
    #> 906  Assessed as homeless or threatened with homelessness       Count 2009/2010
    #> 907  Assessed as homeless or threatened with homelessness       Count 2021/2022
    #> 908  Assessed as homeless or threatened with homelessness       Count 2015/2016
    #> 909  Assessed as homeless or threatened with homelessness       Count 2021/2022
    #> 910  Assessed as homeless or threatened with homelessness       Count 2019/2020
    #> 911  Assessed as homeless or threatened with homelessness       Count 2021/2022
    #> 912  Assessed as homeless or threatened with homelessness       Count 2019/2020
    #> 913  Assessed as homeless or threatened with homelessness       Count 2019/2020
    #> 914  Assessed as homeless or threatened with homelessness       Count 2017/2018
    #> 915  Assessed as homeless or threatened with homelessness       Count 2017/2018
    #> 916  Assessed as homeless or threatened with homelessness       Count 2017/2018
    #> 917  Assessed as homeless or threatened with homelessness       Count 2019/2020
    #> 918  Assessed as homeless or threatened with homelessness       Count 2015/2016
    #> 919  Assessed as homeless or threatened with homelessness       Count 2017/2018
    #> 920  Assessed as homeless or threatened with homelessness       Count 2013/2014
    #> 921  Assessed as homeless or threatened with homelessness       Count 2021/2022
    #> 922  Assessed as homeless or threatened with homelessness       Count 2017/2018
    #> 923  Assessed as homeless or threatened with homelessness       Count 2017/2018
    #> 924  Assessed as homeless or threatened with homelessness       Count 2019/2020
    #> 925  Assessed as homeless or threatened with homelessness       Count 2019/2020
    #> 926  Assessed as homeless or threatened with homelessness       Count 2021/2022
    #> 927  Assessed as homeless or threatened with homelessness       Count 2012/2013
    #> 928  Assessed as homeless or threatened with homelessness       Count 2021/2022
    #> 929  Assessed as homeless or threatened with homelessness       Count 2015/2016
    #> 930  Assessed as homeless or threatened with homelessness       Count 2017/2018
    #> 931  Assessed as homeless or threatened with homelessness       Count 2021/2022
    #> 932  Assessed as homeless or threatened with homelessness       Count 2017/2018
    #> 933  Assessed as homeless or threatened with homelessness       Count 2014/2015
    #> 934  Assessed as homeless or threatened with homelessness       Count 2019/2020
    #> 935  Assessed as homeless or threatened with homelessness       Count 2019/2020
    #> 936  Assessed as homeless or threatened with homelessness       Count 2014/2015
    #> 937  Assessed as homeless or threatened with homelessness       Count 2019/2020
    #> 938  Assessed as homeless or threatened with homelessness       Count 2019/2020
    #> 939  Assessed as homeless or threatened with homelessness       Count 2014/2015
    #> 940  Assessed as homeless or threatened with homelessness       Count 2017/2018
    #> 941  Assessed as homeless or threatened with homelessness       Count 2010/2011
    #> 942  Assessed as homeless or threatened with homelessness       Count 2021/2022
    #> 943  Assessed as homeless or threatened with homelessness       Count 2017/2018
    #> 944  Assessed as homeless or threatened with homelessness       Count 2014/2015
    #> 945  Assessed as homeless or threatened with homelessness       Count 2010/2011
    #> 946  Assessed as homeless or threatened with homelessness       Count 2021/2022
    #> 947  Assessed as homeless or threatened with homelessness       Count 2021/2022
    #> 948  Assessed as homeless or threatened with homelessness       Count 2019/2020
    #> 949  Assessed as homeless or threatened with homelessness       Count 2021/2022
    #> 950  Assessed as homeless or threatened with homelessness       Count 2016/2017
    #> 951  Assessed as homeless or threatened with homelessness       Count 2021/2022
    #> 952  Assessed as homeless or threatened with homelessness       Count 2019/2020
    #> 953  Assessed as homeless or threatened with homelessness       Count 2019/2020
    #> 954  Assessed as homeless or threatened with homelessness       Count 2020/2021
    #> 955  Assessed as homeless or threatened with homelessness       Count 2016/2017
    #> 956  Assessed as homeless or threatened with homelessness       Count 2012/2013
    #> 957  Assessed as homeless or threatened with homelessness       Count 2021/2022
    #> 958  Assessed as homeless or threatened with homelessness       Count 2020/2021
    #> 959  Assessed as homeless or threatened with homelessness       Count 2021/2022
    #> 960  Assessed as homeless or threatened with homelessness       Count 2020/2021
    #> 961  Assessed as homeless or threatened with homelessness       Count 2018/2019
    #> 962  Assessed as homeless or threatened with homelessness       Count 2020/2021
    #> 963  Assessed as homeless or threatened with homelessness       Count 2016/2017
    #> 964  Assessed as homeless or threatened with homelessness       Count 2014/2015
    #> 965  Assessed as homeless or threatened with homelessness       Count 2012/2013
    #> 966  Assessed as homeless or threatened with homelessness       Count 2022/2023
    #> 967  Assessed as homeless or threatened with homelessness       Count 2008/2009
    #> 968  Assessed as homeless or threatened with homelessness       Count 2018/2019
    #> 969  Assessed as homeless or threatened with homelessness       Count 2018/2019
    #> 970  Assessed as homeless or threatened with homelessness       Count 2008/2009
    #> 971  Assessed as homeless or threatened with homelessness       Count 2022/2023
    #> 972  Assessed as homeless or threatened with homelessness       Count 2016/2017
    #> 973  Assessed as homeless or threatened with homelessness       Count 2022/2023
    #> 974  Assessed as homeless or threatened with homelessness       Count 2020/2021
    #> 975  Assessed as homeless or threatened with homelessness       Count 2022/2023
    #> 976  Assessed as homeless or threatened with homelessness       Count 2022/2023
    #> 977  Assessed as homeless or threatened with homelessness       Count 2022/2023
    #> 978  Assessed as homeless or threatened with homelessness       Count 2022/2023
    #> 979  Assessed as homeless or threatened with homelessness       Count 2020/2021
    #> 980  Assessed as homeless or threatened with homelessness       Count 2022/2023
    #> 981  Assessed as homeless or threatened with homelessness       Count 2022/2023
    #> 982  Assessed as homeless or threatened with homelessness       Count 2022/2023
    #> 983  Assessed as homeless or threatened with homelessness       Count 2020/2021
    #> 984  Assessed as homeless or threatened with homelessness       Count 2022/2023
    #> 985  Assessed as homeless or threatened with homelessness       Count 2022/2023
    #> 986  Assessed as homeless or threatened with homelessness       Count 2018/2019
    #> 987  Assessed as homeless or threatened with homelessness       Count 2016/2017
    #> 988  Assessed as homeless or threatened with homelessness       Count 2022/2023
    #> 989  Assessed as homeless or threatened with homelessness       Count 2022/2023
    #> 990  Assessed as homeless or threatened with homelessness       Count 2020/2021
    #> 991  Assessed as homeless or threatened with homelessness       Count 2020/2021
    #> 992  Assessed as homeless or threatened with homelessness       Count 2022/2023
    #> 993  Assessed as homeless or threatened with homelessness       Count 2022/2023
    #> 994  Assessed as homeless or threatened with homelessness       Count 2022/2023
    #> 995  Assessed as homeless or threatened with homelessness       Count 2022/2023
    #> 996  Assessed as homeless or threatened with homelessness       Count 2022/2023
    #> 997  Assessed as homeless or threatened with homelessness       Count 2022/2023
    #> 998  Assessed as homeless or threatened with homelessness       Count 2022/2023
    #> 999  Assessed as homeless or threatened with homelessness       Count 2020/2021
    #> 1000 Assessed as homeless or threatened with homelessness       Count 2020/2021
    #> 1001 Assessed as homeless or threatened with homelessness       Count 2020/2021
    #> 1002 Assessed as homeless or threatened with homelessness       Count 2020/2021
    #> 1003 Assessed as homeless or threatened with homelessness       Count 2020/2021
    #> 1004 Assessed as homeless or threatened with homelessness       Count 2022/2023
    #> 1005 Assessed as homeless or threatened with homelessness       Count 2018/2019
    #> 1006 Assessed as homeless or threatened with homelessness       Count 2020/2021
    #> 1007 Assessed as homeless or threatened with homelessness       Count 2022/2023
    #> 1008 Assessed as homeless or threatened with homelessness       Count 2022/2023
    #> 1009 Assessed as homeless or threatened with homelessness       Count 2020/2021
    #> 1010 Assessed as homeless or threatened with homelessness       Count 2020/2021
    #> 1011 Assessed as homeless or threatened with homelessness       Count 2017/2018
    #> 1012 Assessed as homeless or threatened with homelessness       Count 2019/2020
    #> 1013 Assessed as homeless or threatened with homelessness       Count 2022/2023
    #> 1014 Assessed as homeless or threatened with homelessness       Count 2015/2016
    #> 1015 Assessed as homeless or threatened with homelessness       Count 2022/2023
    #> 1016 Assessed as homeless or threatened with homelessness       Count 2017/2018
    #> 1017 Assessed as homeless or threatened with homelessness       Count 2022/2023
    #> 1018 Assessed as homeless or threatened with homelessness       Count 2022/2023
    #> 1019 Assessed as homeless or threatened with homelessness       Count 2019/2020
    #> 1020 Assessed as homeless or threatened with homelessness       Count 2022/2023
    #> 1021 Assessed as homeless or threatened with homelessness       Count 2021/2022
    #> 1022 Assessed as homeless or threatened with homelessness       Count 2019/2020
    #> 1023 Assessed as homeless or threatened with homelessness       Count 2022/2023
    #> 1024 Assessed as homeless or threatened with homelessness       Count 2022/2023
    #> 1025 Assessed as homeless or threatened with homelessness       Count 2023/2024
    #> 1026 Assessed as homeless or threatened with homelessness       Count 2021/2022
    #> 1027 Assessed as homeless or threatened with homelessness       Count 2013/2014
    #> 1028 Assessed as homeless or threatened with homelessness       Count 2023/2024
    #> 1029 Assessed as homeless or threatened with homelessness       Count 2021/2022
    #> 1030 Assessed as homeless or threatened with homelessness       Count 2023/2024
    #> 1031 Assessed as homeless or threatened with homelessness       Count 2021/2022
    #> 1032 Assessed as homeless or threatened with homelessness       Count 2023/2024
    #> 1033 Assessed as homeless or threatened with homelessness       Count 2023/2024
    #> 1034 Assessed as homeless or threatened with homelessness       Count 2023/2024
    #> 1035 Assessed as homeless or threatened with homelessness       Count 2021/2022
    #> 1036 Assessed as homeless or threatened with homelessness       Count 2021/2022
    #> 1037 Assessed as homeless or threatened with homelessness       Count 2019/2020
    #> 1038 Assessed as homeless or threatened with homelessness       Count 2021/2022
    #> 1039 Assessed as homeless or threatened with homelessness       Count 2023/2024
    #> 1040 Assessed as homeless or threatened with homelessness       Count 2021/2022
    #> 1041 Assessed as homeless or threatened with homelessness       Count 2015/2016
    #> 1042 Assessed as homeless or threatened with homelessness       Count 2023/2024
    #> 1043 Assessed as homeless or threatened with homelessness       Count 2019/2020
    #> 1044 Assessed as homeless or threatened with homelessness       Count 2019/2020
    #> 1045 Assessed as homeless or threatened with homelessness       Count 2023/2024
    #> 1046 Assessed as homeless or threatened with homelessness       Count 2021/2022
    #> 1047 Assessed as homeless or threatened with homelessness       Count 2023/2024
    #> 1048 Assessed as homeless or threatened with homelessness       Count 2015/2016
    #> 1049 Assessed as homeless or threatened with homelessness       Count 2023/2024
    #> 1050 Assessed as homeless or threatened with homelessness       Count 2021/2022
    #> 1051 Assessed as homeless or threatened with homelessness       Count 2023/2024
    #> 1052 Assessed as homeless or threatened with homelessness       Count 2023/2024
    #> 1053 Assessed as homeless or threatened with homelessness       Count 2021/2022
    #> 1054 Assessed as homeless or threatened with homelessness       Count 2017/2018
    #> 1055 Assessed as homeless or threatened with homelessness       Count 2023/2024
    #> 1056 Assessed as homeless or threatened with homelessness       Count 2023/2024
    #> 1057 Assessed as homeless or threatened with homelessness       Count 2023/2024
    #> 1058 Assessed as homeless or threatened with homelessness       Count 2023/2024
    #> 1059 Assessed as homeless or threatened with homelessness       Count 2023/2024
    #> 1060 Assessed as homeless or threatened with homelessness       Count 2023/2024
    #> 1061 Assessed as homeless or threatened with homelessness       Count 2021/2022
    #> 1062 Assessed as homeless or threatened with homelessness       Count 2012/2013
    #> 1063 Assessed as homeless or threatened with homelessness       Count 2023/2024
    #> 1064 Assessed as homeless or threatened with homelessness       Count 2023/2024
    #> 1065 Assessed as homeless or threatened with homelessness       Count 2016/2017
    #> 1066 Assessed as homeless or threatened with homelessness       Count 2019/2020
    #> 1067 Assessed as homeless or threatened with homelessness       Count 2023/2024
    #> 1068 Assessed as homeless or threatened with homelessness       Count 2023/2024
    #> 1069 Assessed as homeless or threatened with homelessness       Count 2021/2022
    #> 1070 Assessed as homeless or threatened with homelessness       Count 2023/2024
    #> 1071 Assessed as homeless or threatened with homelessness       Count 2019/2020
    #> 1072 Assessed as homeless or threatened with homelessness       Count 2023/2024
    #> 1073 Assessed as homeless or threatened with homelessness       Count 2021/2022
    #> 1074 Assessed as homeless or threatened with homelessness       Count 2023/2024
    #> 1075 Assessed as homeless or threatened with homelessness       Count 2021/2022
    #> 1076 Assessed as homeless or threatened with homelessness       Count 2021/2022
    #> 1077 Assessed as homeless or threatened with homelessness       Count 2020/2021
    #> 1078 Assessed as homeless or threatened with homelessness       Count 2023/2024
    #> 1079 Assessed as homeless or threatened with homelessness       Count 2021/2022
    #> 1080 Assessed as homeless or threatened with homelessness       Count 2023/2024
    #> 1081 Assessed as homeless or threatened with homelessness       Count 2023/2024
    #> 1082 Assessed as homeless or threatened with homelessness       Count 2023/2024
    #> 1083 Assessed as homeless or threatened with homelessness       Count 2022/2023
    #> 1084 Assessed as homeless or threatened with homelessness       Count 2020/2021
    #> 1085 Assessed as homeless or threatened with homelessness       Count 2016/2017
    #> 1086 Assessed as homeless or threatened with homelessness       Count 2018/2019
    #> 1087 Assessed as homeless or threatened with homelessness       Count 2023/2024
    #> 1088 Assessed as homeless or threatened with homelessness       Count 2023/2024
    #>                    refArea value
    #> 1                    Angus  1283
    #> 2        City of Edinburgh  4658
    #> 3        Perth and Kinross  1096
    #> 4       Na h-Eileanan Siar   238
    #> 5                     Fife  3631
    #> 6                    Moray   859
    #> 7         Clackmannanshire   703
    #> 8      West Dunbartonshire  2092
    #> 9             Renfrewshire  1064
    #> 10            Renfrewshire  1253
    #> 11       Perth and Kinross  1222
    #> 12   Dumfries and Galloway  1329
    #> 13       South Lanarkshire  2736
    #> 14           Aberdeen City  2614
    #> 15                    Fife  2833
    #> 16          South Ayrshire   918
    #> 17          North Ayrshire   661
    #> 18        Shetland Islands   202
    #> 19       East Renfrewshire   325
    #> 20            East Lothian  1196
    #> 21           Aberdeenshire  1722
    #> 22            Glasgow City  9947
    #> 23     East Dunbartonshire   713
    #> 24        Clackmannanshire   719
    #> 25                Stirling   887
    #> 26                   Angus   763
    #> 27          North Ayrshire  1066
    #> 28                   Angus   693
    #> 29            East Lothian  1123
    #> 30       North Lanarkshire  3543
    #> 31              Inverclyde   520
    #> 32   Dumfries and Galloway  1508
    #> 33       City of Edinburgh  5148
    #> 34              Inverclyde   585
    #> 35           Aberdeen City  2491
    #> 36           East Ayrshire  1018
    #> 37         Argyll and Bute  1029
    #> 38     East Dunbartonshire   702
    #> 39              Midlothian   742
    #> 40       North Lanarkshire  3004
    #> 41                Highland  2293
    #> 42             Dundee City  2418
    #> 43                   Moray   550
    #> 44     West Dunbartonshire  1866
    #> 45                 Falkirk  2457
    #> 46          North Ayrshire  1452
    #> 47            Renfrewshire  1189
    #> 48          Orkney Islands   137
    #> 49              Inverclyde   439
    #> 50                 Falkirk  1064
    #> 51   Dumfries and Galloway  1006
    #> 52                 Falkirk  1189
    #> 53       East Renfrewshire   354
    #> 54           Aberdeenshire  1586
    #> 55           Aberdeenshire  1085
    #> 56          South Ayrshire   962
    #> 57        Scottish Borders   972
    #> 58       North Lanarkshire  2212
    #> 59      Na h-Eileanan Siar   251
    #> 60                Highland  1289
    #> 61        Scottish Borders  1093
    #> 62          Orkney Islands   137
    #> 63        Shetland Islands   241
    #> 64            West Lothian  1657
    #> 65     East Dunbartonshire   609
    #> 66            West Lothian  1291
    #> 67         Argyll and Bute   867
    #> 68           East Ayrshire   326
    #> 69          North Ayrshire  1370
    #> 70            Renfrewshire  1250
    #> 71              Midlothian   732
    #> 72            Renfrewshire  1272
    #> 73                   Angus  1154
    #> 74                 Falkirk  2311
    #> 75                   Angus  1190
    #> 76            East Lothian  1150
    #> 77                   Moray   744
    #> 78           East Ayrshire   651
    #> 79            Glasgow City 10127
    #> 80           Aberdeenshire  1558
    #> 81            East Lothian   688
    #> 82          South Ayrshire   906
    #> 83          Orkney Islands   100
    #> 84              Inverclyde   633
    #> 85       East Renfrewshire   359
    #> 86      Na h-Eileanan Siar   203
    #> 87                   Moray   553
    #> 88              Midlothian   660
    #> 89     East Dunbartonshire   671
    #> 90              Midlothian   749
    #> 91                Stirling   929
    #> 92            West Lothian  1932
    #> 93       East Renfrewshire   314
    #> 94           East Ayrshire   975
    #> 95       Perth and Kinross  1128
    #> 96                   Moray   662
    #> 97           Aberdeen City  1370
    #> 98                   Angus   793
    #> 99                    Fife  3436
    #> 100    West Dunbartonshire  1364
    #> 101       Scottish Borders   637
    #> 102      North Lanarkshire  3501
    #> 103    West Dunbartonshire  1249
    #> 104      South Lanarkshire  3032
    #> 105             Midlothian   871
    #> 106                Falkirk  2736
    #> 107       Scottish Borders  1067
    #> 108          Aberdeen City  2828
    #> 109               Highland  2375
    #> 110         South Ayrshire   702
    #> 111         Orkney Islands   107
    #> 112      City of Edinburgh  4886
    #> 113      North Lanarkshire  1959
    #> 114       Clackmannanshire   657
    #> 115           East Lothian  1193
    #> 116           West Lothian  1751
    #> 117         South Ayrshire   909
    #> 118  Dumfries and Galloway  1391
    #> 119  Dumfries and Galloway   953
    #> 120          Aberdeen City  3406
    #> 121    West Dunbartonshire  1720
    #> 122            Dundee City  2578
    #> 123           Renfrewshire  1103
    #> 124      Perth and Kinross   824
    #> 125       Shetland Islands   270
    #> 126         North Ayrshire   766
    #> 127      North Lanarkshire  2093
    #> 128       Shetland Islands   268
    #> 129       Scottish Borders   862
    #> 130      Perth and Kinross   943
    #> 131       Clackmannanshire   457
    #> 132     Na h-Eileanan Siar   202
    #> 133               Stirling   634
    #> 134    West Dunbartonshire  2000
    #> 135         North Ayrshire   783
    #> 136        Argyll and Bute   479
    #> 137      Perth and Kinross   978
    #> 138       Clackmannanshire   459
    #> 139        Argyll and Bute   471
    #> 140       Shetland Islands   118
    #> 141               Highland  1025
    #> 142         South Ayrshire   857
    #> 143                  Angus  1171
    #> 144                   Fife  3933
    #> 145      South Lanarkshire  2314
    #> 146           Renfrewshire   838
    #> 147           Renfrewshire   832
    #> 148               Stirling   473
    #> 149          Aberdeen City  1517
    #> 150           Glasgow City 10639
    #> 151           West Lothian  1761
    #> 152    West Dunbartonshire  1545
    #> 153    West Dunbartonshire  1135
    #> 154      Perth and Kinross   898
    #> 155    East Dunbartonshire   428
    #> 156            Dundee City  2290
    #> 157          East Ayrshire   827
    #> 158          Aberdeenshire  1605
    #> 159       Clackmannanshire   708
    #> 160        Argyll and Bute   925
    #> 161          East Ayrshire   505
    #> 162                  Moray   901
    #> 163      South Lanarkshire  3123
    #> 164         North Ayrshire  1098
    #> 165      Perth and Kinross  1000
    #> 166               Highland  2377
    #> 167      Perth and Kinross  1030
    #> 168          Aberdeenshire  1134
    #> 169                  Angus   852
    #> 170       Clackmannanshire   472
    #> 171               Stirling   580
    #> 172        Argyll and Bute   489
    #> 173      City of Edinburgh  4102
    #> 174      North Lanarkshire  2141
    #> 175       Shetland Islands   266
    #> 176      East Renfrewshire   340
    #> 177                  Angus  1203
    #> 178          Aberdeen City  1499
    #> 179         North Ayrshire   736
    #> 180         South Ayrshire   946
    #> 181         Orkney Islands    98
    #> 182               Stirling   958
    #> 183         North Ayrshire   708
    #> 184                Falkirk  2510
    #> 185         South Ayrshire   741
    #> 186               Stirling   585
    #> 187                Falkirk  1142
    #> 188                   Fife  4001
    #> 189           Glasgow City  5977
    #> 190      City of Edinburgh  4781
    #> 191            Dundee City  1613
    #> 192     Na h-Eileanan Siar   174
    #> 193      South Lanarkshire  2935
    #> 194         Orkney Islands   144
    #> 195           Glasgow City  9214
    #> 196           East Lothian   777
    #> 197      North Lanarkshire  2477
    #> 198         Orkney Islands   106
    #> 199    West Dunbartonshire  1124
    #> 200       Clackmannanshire   522
    #> 201            Dundee City  1914
    #> 202     Na h-Eileanan Siar   168
    #> 203               Stirling   337
    #> 204             Inverclyde   529
    #> 205      Perth and Kinross   909
    #> 206       Scottish Borders   679
    #> 207      South Lanarkshire  1894
    #> 208            Dundee City  1474
    #> 209            Dundee City  1472
    #> 210               Highland  2146
    #> 211        Argyll and Bute   434
    #> 212        Argyll and Bute   812
    #> 213             Inverclyde   320
    #> 214      South Lanarkshire  2009
    #> 215           Glasgow City  6327
    #> 216       Shetland Islands   151
    #> 217             Inverclyde   233
    #> 218               Highland  1159
    #> 219           East Lothian   729
    #> 220                   Fife  4533
    #> 221            Dundee City  1414
    #> 222           West Lothian  1363
    #> 223      East Renfrewshire   367
    #> 224          East Ayrshire   808
    #> 225               Stirling   711
    #> 226      South Lanarkshire  2095
    #> 227          Aberdeenshire  1791
    #> 228      South Lanarkshire  2709
    #> 229      City of Edinburgh  4020
    #> 230    East Dunbartonshire   699
    #> 231               Stirling   640
    #> 232                Falkirk  1200
    #> 233     Na h-Eileanan Siar   160
    #> 234           Renfrewshire   776
    #> 235       Clackmannanshire   763
    #> 236      City of Edinburgh  3814
    #> 237  Dumfries and Galloway  1231
    #> 238    East Dunbartonshire   489
    #> 239          East Ayrshire   803
    #> 240     Na h-Eileanan Siar   158
    #> 241               Stirling   355
    #> 242        Argyll and Bute   415
    #> 243           Glasgow City 10422
    #> 244      Perth and Kinross   826
    #> 245      City of Edinburgh  3391
    #> 246          East Ayrshire   516
    #> 247       Scottish Borders   542
    #> 248  Dumfries and Galloway   635
    #> 249                  Moray   588
    #> 250               Highland  1242
    #> 251          Aberdeen City  1487
    #> 252               Highland  1186
    #> 253                Falkirk  1086
    #> 254             Midlothian   496
    #> 255      City of Edinburgh  4314
    #> 256       Scottish Borders   768
    #> 257         Orkney Islands   134
    #> 258                Falkirk  1138
    #> 259      East Renfrewshire   308
    #> 260            Dundee City  1440
    #> 261             Inverclyde   311
    #> 262             Midlothian   508
    #> 263               Stirling   423
    #> 264       Shetland Islands   145
    #> 265             Inverclyde   295
    #> 266    East Dunbartonshire   616
    #> 267      City of Edinburgh  3495
    #> 268         Orkney Islands    85
    #> 269               Highland  1016
    #> 270            Dundee City  1466
    #> 271           Renfrewshire   843
    #> 272            Dundee City  1402
    #> 273       Scottish Borders   689
    #> 274             Midlothian   579
    #> 275       Clackmannanshire   553
    #> 276      South Lanarkshire  2131
    #> 277      City of Edinburgh  4448
    #> 278    East Dunbartonshire   640
    #> 279       Clackmannanshire   478
    #> 280         South Ayrshire   761
    #> 281             Midlothian   760
    #> 282  Dumfries and Galloway   918
    #> 283      Perth and Kinross   824
    #> 284                  Moray   521
    #> 285      South Lanarkshire  2201
    #> 286         Orkney Islands   135
    #> 287    West Dunbartonshire  1022
    #> 288             Midlothian   601
    #> 289          Aberdeen City  1404
    #> 290             Midlothian   560
    #> 291          Aberdeenshire  1416
    #> 292                   Fife  2507
    #> 293           East Lothian   794
    #> 294            Dundee City  1390
    #> 295         North Ayrshire  1094
    #> 296        Argyll and Bute   610
    #> 297           East Lothian   654
    #> 298         North Ayrshire  1044
    #> 299             Midlothian   525
    #> 300             Inverclyde   243
    #> 301        Argyll and Bute   401
    #> 302                Falkirk  1198
    #> 303          East Ayrshire   623
    #> 304                Falkirk  1046
    #> 305         Orkney Islands   153
    #> 306      East Renfrewshire   307
    #> 307        Argyll and Bute   515
    #> 308          Aberdeenshire   904
    #> 309         South Ayrshire   846
    #> 310           Renfrewshire   873
    #> 311          Aberdeen City  1319
    #> 312          Aberdeenshire   850
    #> 313      City of Edinburgh  3277
    #> 314      East Renfrewshire   270
    #> 315           West Lothian  1725
    #> 316          East Ayrshire   471
    #> 317      North Lanarkshire  1871
    #> 318           Renfrewshire   975
    #> 319           West Lothian  1363
    #> 320               Highland  1036
    #> 321          Aberdeenshire  1229
    #> 322             Midlothian   582
    #> 323          Aberdeenshire  1209
    #> 324          Aberdeen City  1709
    #> 325           East Lothian   677
    #> 326     Na h-Eileanan Siar   153
    #> 327         North Ayrshire  1035
    #> 328       Scottish Borders   770
    #> 329                  Angus   716
    #> 330     Na h-Eileanan Siar   136
    #> 331          Aberdeenshire   897
    #> 332      East Renfrewshire   371
    #> 333       Shetland Islands   152
    #> 334    East Dunbartonshire   514
    #> 335          Aberdeenshire  1229
    #> 336           East Lothian   770
    #> 337      South Lanarkshire  1907
    #> 338      South Lanarkshire  2065
    #> 339      Perth and Kinross   758
    #> 340                  Moray   576
    #> 341           Glasgow City  8297
    #> 342                Falkirk  1116
    #> 343        Argyll and Bute   460
    #> 344      South Lanarkshire  1926
    #> 345         South Ayrshire   794
    #> 346           West Lothian  1518
    #> 347                   Fife  2277
    #> 348                   Fife  2733
    #> 349    East Dunbartonshire   528
    #> 350  Dumfries and Galloway   914
    #> 351                  Angus   693
    #> 352           Glasgow City  6422
    #> 353          East Ayrshire   586
    #> 354               Highland  1208
    #> 355    East Dunbartonshire   305
    #> 356           Renfrewshire   935
    #> 357           Glasgow City  5417
    #> 358         South Ayrshire   871
    #> 359                   Fife  2637
    #> 360      North Lanarkshire  1902
    #> 361     Na h-Eileanan Siar   157
    #> 362    West Dunbartonshire  1374
    #> 363    West Dunbartonshire  1047
    #> 364           West Lothian  1411
    #> 365            Dundee City  1268
    #> 366                  Moray   455
    #> 367       Clackmannanshire   593
    #> 368      East Renfrewshire   375
    #> 369         Orkney Islands   118
    #> 370                  Moray   562
    #> 371       Scottish Borders   691
    #> 372  Dumfries and Galloway   668
    #> 373     Na h-Eileanan Siar   153
    #> 374                  Moray   572
    #> 375           West Lothian  1526
    #> 376     Na h-Eileanan Siar   143
    #> 377                   Fife  2550
    #> 378           Glasgow City  6742
    #> 379                   Fife  2626
    #> 380          Aberdeen City  1466
    #> 381          Aberdeen City  1490
    #> 382             Inverclyde   264
    #> 383          Aberdeenshire  1157
    #> 384             Midlothian   492
    #> 385           West Lothian  1336
    #> 386                  Moray   571
    #> 387       Shetland Islands   114
    #> 388           Renfrewshire   849
    #> 389               Stirling   615
    #> 390       Scottish Borders   650
    #> 391       Shetland Islands    85
    #> 392           East Lothian   687
    #> 393      East Renfrewshire   321
    #> 394        Argyll and Bute   434
    #> 395       Shetland Islands   103
    #> 396           Renfrewshire   860
    #> 397  Dumfries and Galloway   884
    #> 398      City of Edinburgh  3641
    #> 399    East Dunbartonshire   451
    #> 400      South Lanarkshire  1989
    #> 401             Inverclyde   376
    #> 402      East Renfrewshire   312
    #> 403         North Ayrshire   762
    #> 404            Dundee City  1401
    #> 405           Glasgow City  6692
    #> 406      North Lanarkshire  1917
    #> 407           East Lothian   728
    #> 408                Falkirk  1161
    #> 409           West Lothian  1190
    #> 410                  Moray   528
    #> 411               Highland  1071
    #> 412  Dumfries and Galloway  1255
    #> 413      City of Edinburgh  2863
    #> 414                  Moray   511
    #> 415     Na h-Eileanan Siar   137
    #> 416          East Ayrshire   883
    #> 417         North Ayrshire   743
    #> 418         South Ayrshire   723
    #> 419      North Lanarkshire  1696
    #> 420               Highland  1251
    #> 421             Inverclyde   201
    #> 422    West Dunbartonshire  1053
    #> 423               Stirling   716
    #> 424           Glasgow City  6075
    #> 425          Aberdeen City  1285
    #> 426    West Dunbartonshire  1095
    #> 427      City of Edinburgh  3617
    #> 428                  Moray   582
    #> 429               Stirling   600
    #> 430         South Ayrshire   936
    #> 431      East Renfrewshire   450
    #> 432         Orkney Islands   125
    #> 433       Clackmannanshire   551
    #> 434                  Angus   547
    #> 435                   Fife  2739
    #> 436        Argyll and Bute   489
    #> 437           Renfrewshire  1026
    #> 438       Shetland Islands   122
    #> 439         South Ayrshire   735
    #> 440       Scottish Borders   686
    #> 441      North Lanarkshire  1894
    #> 442      Perth and Kinross   733
    #> 443       Scottish Borders   696
    #> 444  Dumfries and Galloway   820
    #> 445             Midlothian   480
    #> 446                   Fife  2639
    #> 447      North Lanarkshire  1684
    #> 448         North Ayrshire  1004
    #> 449               Highland  1056
    #> 450         Orkney Islands   119
    #> 451      Perth and Kinross   669
    #> 452      East Renfrewshire   449
    #> 453       Shetland Islands   126
    #> 454       Scottish Borders   623
    #> 455                   Fife  2400
    #> 456          East Ayrshire   865
    #> 457  Dumfries and Galloway   834
    #> 458      South Lanarkshire  2118
    #> 459      City of Edinburgh  3569
    #> 460                   Fife  2529
    #> 461           Glasgow City  5248
    #> 462       Clackmannanshire   616
    #> 463          Aberdeen City  1772
    #> 464    East Dunbartonshire   335
    #> 465           West Lothian  1468
    #> 466                   Fife  2453
    #> 467                  Angus   757
    #> 468    East Dunbartonshire   423
    #> 469            Dundee City  1440
    #> 470           Glasgow City  5682
    #> 471           West Lothian  1462
    #> 472     Na h-Eileanan Siar   152
    #> 473          Aberdeen City  1627
    #> 474          East Ayrshire   790
    #> 475     Na h-Eileanan Siar   153
    #> 476                  Angus   545
    #> 477      East Renfrewshire   329
    #> 478           East Lothian   629
    #> 479          Aberdeenshire  1011
    #> 480                Falkirk  1073
    #> 481       Scottish Borders   776
    #> 482           Glasgow City  7009
    #> 483     Na h-Eileanan Siar   128
    #> 484       Clackmannanshire   523
    #> 485          Aberdeenshire  1044
    #> 486                Falkirk  1010
    #> 487             Inverclyde   205
    #> 488       Shetland Islands    87
    #> 489          Aberdeen City  1763
    #> 490               Stirling   584
    #> 491      North Lanarkshire  2125
    #> 492    East Dunbartonshire   256
    #> 493                  Moray   537
    #> 494         Orkney Islands   131
    #> 495         North Ayrshire  1141
    #> 496  Dumfries and Galloway   900
    #> 497             Inverclyde   325
    #> 498                  Angus   679
    #> 499         Orkney Islands   138
    #> 500           West Lothian  1169
    #> 501               Stirling   603
    #> 502      South Lanarkshire  2517
    #> 503           West Lothian  1251
    #> 504       Clackmannanshire   501
    #> 505               Highland  1383
    #> 506      North Lanarkshire  2366
    #> 507          East Ayrshire   874
    #> 508                Falkirk  1164
    #> 509      Perth and Kinross   614
    #> 510         South Ayrshire   875
    #> 511    East Dunbartonshire   428
    #> 512          East Ayrshire  1096
    #> 513       Clackmannanshire   515
    #> 514       Shetland Islands    95
    #> 515    West Dunbartonshire  1203
    #> 516             Inverclyde   292
    #> 517           Glasgow City  7725
    #> 518  Dumfries and Galloway   998
    #> 519  Dumfries and Galloway  1157
    #> 520    West Dunbartonshire  1037
    #> 521      Perth and Kinross   856
    #> 522       Shetland Islands   111
    #> 523         North Ayrshire  1161
    #> 524                  Angus   506
    #> 525             Midlothian   441
    #> 526           Renfrewshire   909
    #> 527                  Angus   649
    #> 528             Midlothian   740
    #> 529               Highland  1413
    #> 530       Scottish Borders   736
    #> 531        Argyll and Bute   398
    #> 532           East Lothian   790
    #> 533      City of Edinburgh  2426
    #> 534           East Lothian   700
    #> 535        Argyll and Bute   512
    #> 536            Dundee City  1430
    #> 537         Orkney Islands   141
    #> 538           East Lothian   795
    #> 539         South Ayrshire   813
    #> 540            Dundee City  1386
    #> 541      East Renfrewshire   391
    #> 542      North Lanarkshire  2226
    #> 543    West Dunbartonshire  1203
    #> 544             Inverclyde   255
    #> 545           West Lothian  1367
    #> 546                Falkirk  2069
    #> 547          Aberdeenshire  1073
    #> 548            Dundee City  1335
    #> 549           West Lothian  1262
    #> 550          East Ayrshire   409
    #> 551             Inverclyde   376
    #> 552      South Lanarkshire  2450
    #> 553      East Renfrewshire   261
    #> 554               Stirling   618
    #> 555           Glasgow City  7257
    #> 556          Aberdeenshire  1026
    #> 557                Falkirk  1876
    #> 558    East Dunbartonshire   448
    #> 559       Shetland Islands   156
    #> 560           Renfrewshire  1001
    #> 561                  Moray   596
    #> 562          Aberdeen City  1201
    #> 563            Dundee City  1253
    #> 564      Perth and Kinross   724
    #> 565     Na h-Eileanan Siar   183
    #> 566       Clackmannanshire   365
    #> 567      Perth and Kinross   848
    #> 568          Aberdeen City  1361
    #> 569       Clackmannanshire   537
    #> 570          East Ayrshire   670
    #> 571           West Lothian  1078
    #> 572    West Dunbartonshire  1187
    #> 573             Midlothian   614
    #> 574    East Dunbartonshire   489
    #> 575        Argyll and Bute   626
    #> 576          Aberdeenshire  1274
    #> 577        Argyll and Bute   720
    #> 578    East Dunbartonshire   501
    #> 579         South Ayrshire   614
    #> 580      North Lanarkshire  2664
    #> 581                  Angus   945
    #> 582        Argyll and Bute   332
    #> 583      East Renfrewshire   265
    #> 584    West Dunbartonshire  1020
    #> 585      South Lanarkshire  2174
    #> 586           East Lothian   737
    #> 587      Perth and Kinross   794
    #> 588       Scottish Borders   402
    #> 589         Orkney Islands    56
    #> 590             Midlothian   633
    #> 591                  Angus   961
    #> 592               Highland  1729
    #> 593         North Ayrshire  1019
    #> 594         Orkney Islands    82
    #> 595          Aberdeen City  1992
    #> 596         South Ayrshire   679
    #> 597         North Ayrshire   672
    #> 598                   Fife  2088
    #> 599           East Lothian   936
    #> 600         Orkney Islands   113
    #> 601       Scottish Borders   810
    #> 602  Dumfries and Galloway  1033
    #> 603      North Lanarkshire  1692
    #> 604                  Moray   373
    #> 605           East Lothian   949
    #> 606       Shetland Islands   117
    #> 607      Perth and Kinross   969
    #> 608         North Ayrshire   579
    #> 609       Clackmannanshire   405
    #> 610             Midlothian   625
    #> 611      Perth and Kinross   711
    #> 612           Glasgow City  5013
    #> 613      East Renfrewshire   201
    #> 614      Perth and Kinross   745
    #> 615         North Ayrshire  1037
    #> 616                  Angus   994
    #> 617            Dundee City  1479
    #> 618               Stirling   626
    #> 619                Falkirk  1035
    #> 620    East Dunbartonshire   465
    #> 621            Dundee City  1171
    #> 622           West Lothian  1498
    #> 623               Stirling   475
    #> 624               Highland   969
    #> 625       Clackmannanshire   457
    #> 626         Orkney Islands    98
    #> 627           West Lothian  1320
    #> 628             Midlothian   484
    #> 629          Aberdeen City  2033
    #> 630         South Ayrshire   577
    #> 631      North Lanarkshire  1489
    #> 632     Na h-Eileanan Siar   142
    #> 633    West Dunbartonshire  1032
    #> 634                  Angus   600
    #> 635     Na h-Eileanan Siar   158
    #> 636                  Moray   664
    #> 637               Highland   962
    #> 638          Aberdeenshire   970
    #> 639     Na h-Eileanan Siar   138
    #> 640               Stirling   371
    #> 641                  Moray   503
    #> 642                Falkirk   933
    #> 643  Dumfries and Galloway   910
    #> 644           Renfrewshire   684
    #> 645               Stirling   503
    #> 646               Highland  1857
    #> 647           Renfrewshire   733
    #> 648          East Ayrshire   727
    #> 649           East Lothian   685
    #> 650            Dundee City   942
    #> 651             Midlothian   519
    #> 652      South Lanarkshire  2323
    #> 653      City of Edinburgh  4645
    #> 654                   Fife  1855
    #> 655  Dumfries and Galloway   955
    #> 656                   Fife  2389
    #> 657          Aberdeenshire  1078
    #> 658    East Dunbartonshire   481
    #> 659         Orkney Islands    85
    #> 660  Dumfries and Galloway  1090
    #> 661         North Ayrshire   877
    #> 662                  Moray   365
    #> 663           Renfrewshire  1010
    #> 664           Glasgow City  6321
    #> 665               Highland  1592
    #> 666    East Dunbartonshire   451
    #> 667      City of Edinburgh  4709
    #> 668             Inverclyde   343
    #> 669             Inverclyde   156
    #> 670       Clackmannanshire   564
    #> 671                  Angus   618
    #> 672               Stirling   304
    #> 673                   Fife  2722
    #> 674       Clackmannanshire   506
    #> 675      South Lanarkshire  1962
    #> 676               Highland  1876
    #> 677        Argyll and Bute   351
    #> 678      Perth and Kinross   789
    #> 679            Dundee City  1116
    #> 680                  Angus   925
    #> 681             Inverclyde   249
    #> 682       Scottish Borders   791
    #> 683       Shetland Islands   137
    #> 684               Stirling   321
    #> 685               Stirling   394
    #> 686        Argyll and Bute   682
    #> 687     Na h-Eileanan Siar   121
    #> 688       Shetland Islands   112
    #> 689      East Renfrewshire   276
    #> 690         Orkney Islands    87
    #> 691                   Fife  2117
    #> 692      North Lanarkshire  1922
    #> 693         Orkney Islands    64
    #> 694             Midlothian   550
    #> 695                Falkirk   817
    #> 696                  Angus   701
    #> 697      City of Edinburgh  3495
    #> 698         South Ayrshire   652
    #> 699                   Fife  3164
    #> 700         Orkney Islands    89
    #> 701    West Dunbartonshire  1010
    #> 702         South Ayrshire   643
    #> 703          East Ayrshire   702
    #> 704         North Ayrshire   673
    #> 705            Dundee City  1024
    #> 706      City of Edinburgh  4539
    #> 707      South Lanarkshire  1767
    #> 708                Falkirk  1780
    #> 709           Renfrewshire   704
    #> 710           West Lothian  1093
    #> 711  Dumfries and Galloway   484
    #> 712    West Dunbartonshire   976
    #> 713       Shetland Islands   157
    #> 714         North Ayrshire   634
    #> 715     Na h-Eileanan Siar   123
    #> 716       Shetland Islands   147
    #> 717               Stirling   463
    #> 718                  Moray   398
    #> 719         North Ayrshire   696
    #> 720           East Lothian   656
    #> 721    East Dunbartonshire   376
    #> 722         South Ayrshire   675
    #> 723                  Moray   369
    #> 724        Argyll and Bute   457
    #> 725      City of Edinburgh  3997
    #> 726             Inverclyde   381
    #> 727      East Renfrewshire   242
    #> 728          Aberdeenshire  1393
    #> 729           Glasgow City  5952
    #> 730                Falkirk  1845
    #> 731           Glasgow City  7187
    #> 732      Perth and Kinross   833
    #> 733                Falkirk   821
    #> 734           West Lothian  1132
    #> 735         Orkney Islands    98
    #> 736       Scottish Borders   495
    #> 737      East Renfrewshire   303
    #> 738         North Ayrshire   680
    #> 739      East Renfrewshire   270
    #> 740      North Lanarkshire  2600
    #> 741         South Ayrshire   696
    #> 742      Perth and Kinross   799
    #> 743               Stirling   398
    #> 744      City of Edinburgh  4863
    #> 745       Scottish Borders   576
    #> 746    West Dunbartonshire  1169
    #> 747      Perth and Kinross   705
    #> 748                  Angus   971
    #> 749  Dumfries and Galloway   466
    #> 750            Dundee City  1603
    #> 751          East Ayrshire   624
    #> 752          East Ayrshire   402
    #> 753     Na h-Eileanan Siar   108
    #> 754      City of Edinburgh  4359
    #> 755          East Ayrshire   473
    #> 756          East Ayrshire   434
    #> 757          Aberdeen City   814
    #> 758    East Dunbartonshire   434
    #> 759             Midlothian   525
    #> 760                  Angus   621
    #> 761     Na h-Eileanan Siar   111
    #> 762         South Ayrshire   619
    #> 763      South Lanarkshire  2323
    #> 764         Orkney Islands   107
    #> 765           West Lothian  1101
    #> 766          Aberdeen City  1225
    #> 767          Aberdeen City  1160
    #> 768    West Dunbartonshire  1263
    #> 769                   Fife  2718
    #> 770          East Ayrshire   260
    #> 771       Scottish Borders   628
    #> 772    West Dunbartonshire  1036
    #> 773          Aberdeen City  1251
    #> 774           Renfrewshire   962
    #> 775        Argyll and Bute   401
    #> 776       Clackmannanshire   459
    #> 777           West Lothian  1351
    #> 778          Aberdeen City  1381
    #> 779       Shetland Islands   108
    #> 780      Perth and Kinross   751
    #> 781                  Moray   370
    #> 782           West Lothian  1071
    #> 783           Renfrewshire   727
    #> 784            Dundee City  1704
    #> 785      City of Edinburgh  4220
    #> 786      South Lanarkshire  1757
    #> 787      North Lanarkshire  1452
    #> 788           Renfrewshire   866
    #> 789       Scottish Borders   565
    #> 790       Scottish Borders   646
    #> 791  Dumfries and Galloway   783
    #> 792                  Angus   606
    #> 793      South Lanarkshire  1590
    #> 794               Highland  1115
    #> 795           Renfrewshire   614
    #> 796       Scottish Borders   589
    #> 797       Clackmannanshire   362
    #> 798        Argyll and Bute   326
    #> 799  Dumfries and Galloway   694
    #> 800           West Lothian  1233
    #> 801      East Renfrewshire   264
    #> 802          Aberdeenshire  1244
    #> 803          East Ayrshire   554
    #> 804      North Lanarkshire  2316
    #> 805     Na h-Eileanan Siar   158
    #> 806    East Dunbartonshire   363
    #> 807            Dundee City  1022
    #> 808      East Renfrewshire   232
    #> 809            Dundee City  1086
    #> 810          East Ayrshire   494
    #> 811           East Lothian   592
    #> 812           Renfrewshire   974
    #> 813       Shetland Islands   105
    #> 814           Glasgow City  4553
    #> 815          Aberdeenshire  1023
    #> 816      City of Edinburgh  3145
    #> 817      East Renfrewshire   274
    #> 818       Shetland Islands   163
    #> 819       Shetland Islands   127
    #> 820      East Renfrewshire   301
    #> 821           Glasgow City  4217
    #> 822           East Lothian   628
    #> 823           Glasgow City  7391
    #> 824                  Moray   535
    #> 825           West Lothian  1246
    #> 826      City of Edinburgh  3209
    #> 827           West Lothian  1096
    #> 828             Inverclyde   197
    #> 829      North Lanarkshire  1708
    #> 830        Argyll and Bute   339
    #> 831    West Dunbartonshire   931
    #> 832           Renfrewshire   839
    #> 833          Aberdeen City  1312
    #> 834               Highland   890
    #> 835             Inverclyde   323
    #> 836      Perth and Kinross   569
    #> 837                Falkirk   817
    #> 838    East Dunbartonshire   208
    #> 839               Highland  1131
    #> 840             Midlothian   531
    #> 841                  Angus   599
    #> 842         South Ayrshire   597
    #> 843        Argyll and Bute   616
    #> 844      South Lanarkshire  1817
    #> 845      East Renfrewshire   302
    #> 846     Na h-Eileanan Siar   102
    #> 847          East Ayrshire   667
    #> 848          Aberdeenshire  1019
    #> 849    West Dunbartonshire   874
    #> 850    East Dunbartonshire   481
    #> 851        Argyll and Bute   368
    #> 852           East Lothian   593
    #> 853      North Lanarkshire  1523
    #> 854            Dundee City  1018
    #> 855       Clackmannanshire   392
    #> 856          Aberdeen City  1226
    #> 857                   Fife  2109
    #> 858                Falkirk   912
    #> 859           Glasgow City  4683
    #> 860           West Lothian  1221
    #> 861                   Fife  1962
    #> 862      South Lanarkshire  1625
    #> 863      City of Edinburgh  2066
    #> 864      Perth and Kinross   686
    #> 865          Aberdeen City  1855
    #> 866      City of Edinburgh  3878
    #> 867          Aberdeen City  1250
    #> 868           Renfrewshire   677
    #> 869       Clackmannanshire   469
    #> 870           Glasgow City  4370
    #> 871            Dundee City  1104
    #> 872       Scottish Borders   561
    #> 873  Dumfries and Galloway   717
    #> 874                  Angus   409
    #> 875          Aberdeen City  1232
    #> 876           East Lothian   660
    #> 877             Inverclyde   150
    #> 878      North Lanarkshire  1443
    #> 879         South Ayrshire   638
    #> 880         South Ayrshire   627
    #> 881       Shetland Islands    96
    #> 882  Dumfries and Galloway   615
    #> 883                  Moray   382
    #> 884       Scottish Borders   692
    #> 885     Na h-Eileanan Siar   113
    #> 886         South Ayrshire   673
    #> 887        Argyll and Bute   351
    #> 888             Midlothian   468
    #> 889         Orkney Islands    77
    #> 890             Inverclyde   180
    #> 891                  Moray   397
    #> 892                  Moray   335
    #> 893         North Ayrshire   629
    #> 894           East Lothian   534
    #> 895           Glasgow City  4982
    #> 896          Aberdeenshire   914
    #> 897                  Angus   510
    #> 898                   Fife  1936
    #> 899      North Lanarkshire  1792
    #> 900    East Dunbartonshire   360
    #> 901  Dumfries and Galloway   641
    #> 902           Renfrewshire   689
    #> 903                  Angus   742
    #> 904       Shetland Islands    79
    #> 905       Clackmannanshire   422
    #> 906           Glasgow City  8072
    #> 907           Glasgow City  5767
    #> 908                Falkirk   789
    #> 909       Scottish Borders   575
    #> 910      East Renfrewshire   302
    #> 911          East Ayrshire   671
    #> 912          Aberdeenshire  1060
    #> 913             Inverclyde   192
    #> 914           Renfrewshire   690
    #> 915                Falkirk   867
    #> 916    West Dunbartonshire   913
    #> 917         North Ayrshire   926
    #> 918             Midlothian   474
    #> 919         Orkney Islands    97
    #> 920             Midlothian   557
    #> 921    West Dunbartonshire  1021
    #> 922      North Lanarkshire  1789
    #> 923        Argyll and Bute   423
    #> 924         South Ayrshire   724
    #> 925           East Lothian   638
    #> 926      North Lanarkshire  1373
    #> 927  Dumfries and Galloway   755
    #> 928       Clackmannanshire   439
    #> 929    West Dunbartonshire   891
    #> 930         North Ayrshire   825
    #> 931               Highland  1174
    #> 932               Highland  1023
    #> 933     Na h-Eileanan Siar   136
    #> 934         Orkney Islands    93
    #> 935       Shetland Islands    92
    #> 936       Scottish Borders   535
    #> 937          East Ayrshire   718
    #> 938      Perth and Kinross   642
    #> 939             Inverclyde   208
    #> 940                   Fife  1955
    #> 941       Clackmannanshire   585
    #> 942          Aberdeenshire   760
    #> 943      South Lanarkshire  1653
    #> 944                  Moray   384
    #> 945       Scottish Borders   658
    #> 946          Aberdeen City  1119
    #> 947                   Fife  2065
    #> 948               Stirling   593
    #> 949             Inverclyde   277
    #> 950       Shetland Islands    95
    #> 951            Dundee City  1010
    #> 952           Glasgow City  5285
    #> 953     Na h-Eileanan Siar   123
    #> 954  Dumfries and Galloway   689
    #> 955      South Lanarkshire  1621
    #> 956             Midlothian   579
    #> 957      South Lanarkshire  1669
    #> 958                Falkirk   829
    #> 959      Perth and Kinross   528
    #> 960     Na h-Eileanan Siar   124
    #> 961         North Ayrshire   789
    #> 962    West Dunbartonshire   872
    #> 963               Stirling   421
    #> 964       Clackmannanshire   365
    #> 965             Inverclyde   262
    #> 966      City of Edinburgh  3340
    #> 967             Inverclyde   389
    #> 968      East Renfrewshire   268
    #> 969          Aberdeenshire   972
    #> 970           East Lothian   830
    #> 971     Na h-Eileanan Siar   113
    #> 972    East Dunbartonshire   406
    #> 973               Stirling   431
    #> 974         Orkney Islands   116
    #> 975      Perth and Kinross   585
    #> 976                Falkirk   841
    #> 977      South Lanarkshire  2156
    #> 978    West Dunbartonshire  1041
    #> 979             Inverclyde   224
    #> 980       Shetland Islands    93
    #> 981             Midlothian   542
    #> 982        Argyll and Bute   443
    #> 983      South Lanarkshire  1656
    #> 984          Aberdeenshire   848
    #> 985             Inverclyde   270
    #> 986      North Lanarkshire  2018
    #> 987      City of Edinburgh  3325
    #> 988               Highland  1356
    #> 989         North Ayrshire   917
    #> 990               Highland   993
    #> 991                   Fife  2045
    #> 992           West Lothian  1047
    #> 993      East Renfrewshire   404
    #> 994    East Dunbartonshire   331
    #> 995           East Lothian   573
    #> 996           Glasgow City  5380
    #> 997         Orkney Islands   114
    #> 998  Dumfries and Galloway   995
    #> 999               Stirling   466
    #> 1000       Argyll and Bute   370
    #> 1001         East Ayrshire   656
    #> 1002     North Lanarkshire  1425
    #> 1003        North Ayrshire   783
    #> 1004                  Fife  2306
    #> 1005     South Lanarkshire  1573
    #> 1006         Aberdeenshire   753
    #> 1007                 Moray   393
    #> 1008                 Angus   550
    #> 1009           Dundee City  1114
    #> 1010          Glasgow City  5318
    #> 1011        South Ayrshire   627
    #> 1012     City of Edinburgh  3417
    #> 1013         East Ayrshire   825
    #> 1014      Clackmannanshire   359
    #> 1015      Scottish Borders   674
    #> 1016          East Lothian   656
    #> 1017           Dundee City  1100
    #> 1018          Renfrewshire   763
    #> 1019               Falkirk   970
    #> 1020     North Lanarkshire  1597
    #> 1021          West Lothian   900
    #> 1022              Highland  1170
    #> 1023         Aberdeen City  1274
    #> 1024      Clackmannanshire   471
    #> 1025          Renfrewshire   848
    #> 1026            Midlothian   389
    #> 1027          East Lothian   602
    #> 1028         East Ayrshire   719
    #> 1029          East Lothian   538
    #> 1030     South Lanarkshire  2267
    #> 1031        North Ayrshire   951
    #> 1032         Aberdeenshire   698
    #> 1033   West Dunbartonshire  1008
    #> 1034      Clackmannanshire   484
    #> 1035              Stirling   452
    #> 1036 Dumfries and Galloway   803
    #> 1037            Midlothian   456
    #> 1038       Argyll and Bute   334
    #> 1039            Midlothian   654
    #> 1040        South Ayrshire   661
    #> 1041              Highland   961
    #> 1042 Dumfries and Galloway   841
    #> 1043                  Fife  2152
    #> 1044   West Dunbartonshire   895
    #> 1045        North Ayrshire   997
    #> 1046     City of Edinburgh  2560
    #> 1047     City of Edinburgh  3375
    #> 1048      Scottish Borders   491
    #> 1049              Highland  1263
    #> 1050               Falkirk   938
    #> 1051               Falkirk  1011
    #> 1052        Orkney Islands   119
    #> 1053                 Angus   441
    #> 1054              Stirling   424
    #> 1055     East Renfrewshire   324
    #> 1056          Glasgow City  6199
    #> 1057      Scottish Borders   667
    #> 1058   East Dunbartonshire   252
    #> 1059                 Moray   399
    #> 1060                 Angus   492
    #> 1061   East Dunbartonshire   243
    #> 1062                  Fife  2269
    #> 1063         Aberdeen City  1270
    #> 1064      Shetland Islands    77
    #> 1065         Aberdeenshire   919
    #> 1066 Dumfries and Galloway   727
    #> 1067        South Ayrshire   846
    #> 1068     Perth and Kinross   718
    #> 1069          Renfrewshire   709
    #> 1070    Na h-Eileanan Siar   123
    #> 1071                 Moray   386
    #> 1072              Stirling   443
    #> 1073                 Moray   385
    #> 1074          East Lothian   645
    #> 1075     East Renfrewshire   320
    #> 1076    Na h-Eileanan Siar   128
    #> 1077            Midlothian   443
    #> 1078       Argyll and Bute   416
    #> 1079        Orkney Islands   108
    #> 1080            Inverclyde   343
    #> 1081     North Lanarkshire  1864
    #> 1082          West Lothian   994
    #> 1083        South Ayrshire   758
    #> 1084      Shetland Islands    71
    #> 1085              Highland  1086
    #> 1086   East Dunbartonshire   352
    #> 1087           Dundee City  1106
    #> 1088                  Fife  2157

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

    #> [1] "large dataset, return may take a while"

    #>   measureType refPeriod   refArea  value
    #> 1        Mean      2013 S01000001 175003
    #> 2        Mean      2013 S01000005 174404
    #> 3        Mean      2013 S01000006 195652
    #> 4        Mean      2013 S01000007 391278
    #> 5        Mean      2013 S01000008 158028
    #> 6        Mean      2013 S01000013 174314
    #> 7        Mean      2013 S01000024 324571

## Future development

This package is under active development, so any further functionality
will be mentioned here when it’s ready. If something important is
missing, feel free to contact the contributors or [add a new
issue](https://github.com/scotgovanalysis/opendatascot/issues).

Since this package is under active development, breaking changes may be
necessary. We will make it clear once the package is reasonably stable.
