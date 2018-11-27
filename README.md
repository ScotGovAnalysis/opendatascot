
<!-- README.md is generated from README.Rmd. Please edit that file -->
scotgov
=======

[![Travis-CI Build Status](https://travis-ci.org/jsphdms/scotgov.svg?branch=master)](https://travis-ci.org/jsphdms/scotgov)

:construction: :construction: :construction: **Package under construction - watch this space for updates** :construction: :construction: :construction:

Use scotgov to download data from [statistics.gov.scot](http://statistics.gov.scot/home) with a single line of R code. scotgov removes the need to write SPARQL code; you simply need the URI of a dataset. scotgov can be used interactively, or as part of a [reproducible analytical pipeline](https://ukgovdatascience.github.io/rap_companion/).

Installation
------------

Install from GitHub:

``` r
# install.packages("devtools")
devtools::install_github("jsphdms/scotgov")
```

Or you can install from source:

1.  Go to the scotgov [repository](https://github.com/jsphdms/scotgov) on GitHub
2.  Click **Clone or download** then **Download ZIP**
3.  Save the file locally (e.g. your H drive)
4.  Unzip the file
5.  Install with `install.packages()`

``` r
install.packages("your/directory/scotgov-master/scotgov-master", repos = NULL,
                 type="source", lib = "your/R/package/library/directory")
```

Having trouble installing from source? Check you followed the steps above precisely; a small error can cause the install to fail. The best approach is to copy the code above into a text editor and carefully update the two directories. In particular, notice the repetition of **scotgov-master**.

Usage
-----

Learn more in `vignette("scotgov")` or `?scotgov_get`.

Find the name of the dataset you want using `list_sg_dataset()`

Learn more in `vignette("scotgov")` or `?scotgov_get`.

Use `list_sg_dataset()` to find all datasets currently loaded onto statistics.gov.scot

Use `scotgov_get()` to get the data from a dataset in statistics.gov.scot

Use `get_structure()` to find all the full sets of categories and values for a particular dataset (helpful for creating new filters for scotgov\_get!)

Use `get_dataset_query()` to produce the SPARQL query used by scotgov\_get().

Future development
------------------

This package is under active development, so any further functionality will be mentioned here when it's ready. If something important is missing, feel free to contact the contributors or [add a new issue](https://github.com/jsphdms/scotgov/issues).

Since this package is under active development, breaking changes may be necessary. We will make it clear once the package is reasonably stable.
