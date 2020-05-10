# Geo Lookup Data
# The following script prepares geographic lookup data. The data provides simple
# lookup tables linking data zone to common high level geographies.

# Packages
library("tidyverse")
library("readxl")

# Source 2001 and 2011 data zones
dta_datazones <- read_xlsx(
  path = {
    tmp_xlsx_dz_lookup <-
      tempfile(pattern = "dz_lookup", fileext = ".xlsx")
    download.file(url = "https://www2.gov.scot/Resource/0048/00483037.xlsx",
                  destfile = tmp_xlsx_dz_lookup)
    tmp_xlsx_dz_lookup
  },
  sheet = "AreaMatch",
  col_names = c(
    "datazone_2001",
    "datazone_2011",
    "area_match",
    "pct_2011_area"
  ),
  col_types = c(
    datazone_2011 = "text",
    datazone_2011 = "text",
    area_match = "numeric",
    pct_2011_area = "numeric"
  ),
  range = "A2:D25075"
)

geo_lookup <- mtcars

# Embed geo_lookup data within package
usethis::use_data(geo_lookup, overwrite = TRUE)
