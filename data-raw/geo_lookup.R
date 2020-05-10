# Geo Lookup Data
# The following script prepares geographic lookup data. The data provides simple
# lookup tables linking data zone to common high level geographies.

# Packages ----------------------------------------------------------------

library("tidyverse")  # Easier data manipulation
library("readxl")     # Importing MS Excel files

# Downloads ---------------------------------------------------------------

# Relevant sources are downloaded and stored

sources <-
  map(
    .x = c(
      "https://www2.gov.scot/Resource/0048/00483037.xlsx",
      "https://www2.gov.scot/Resource/0046/00462937.csv"
    ),
    .f = function(.x) {
      t <- tempfile()
      download.file(.x, t)
      t
    }
  )

# Imports -----------------------------------------------------------------

# Read imported files

# Source 2001 and 2011 data zones
dta_datazones <- read_xlsx(
  path = sources[[1]],
  sheet = "AreaMatch",
  col_names = c(
    "datazone_2011",
    "datazone_2001",
    "area_match",
    "pct_2011_area"
  ),
  col_types = c(
    datazone_2011 = "text",
    datazone_2001 = "text",
    area_match = "numeric",
    pct_2011_area = "numeric"
  ),
  range = "A2:D25075"
) %>%
  arrange(desc(pct_2011_area)) %>%
  distinct(datazone_2011, .keep_all = TRUE) %>%
  arrange(datazone_2011) %>%
  select(datazone_2011, datazone_2001)

# Prepare higher geography lookup for 2011 data zones
dta_higher_geos <- read_csv(
  file = sources[[2]],
  col_names = c(
    "DataZone",
    "InterZone",
    "MMWard",
    "Council",
    "SPConst",
    "CHP",
    "HBCode"
  ),
  col_types = cols(.default = col_character()),
  skip = 1
)


# Joins -------------------------------------------------------------------

# Prepare final data set to be available in the package
dta_geo <- left_join(x = dta_datazones,
                     y = dta_higher_geos,
                     by = c("datazone_2011" = "DataZone"))

# Export ------------------------------------------------------------------

# Export data to be available in the package
geo_lookup <- dta_geo

# Embed geo_lookup data within package, xz compression produces notably better
# results, version 3 is selected for compatblity with R >= 3.5.
usethis::use_data(
  geo_lookup,
  overwrite = TRUE,
  compress = "xz",
  version = 3
)
