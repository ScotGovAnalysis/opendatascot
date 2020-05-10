# Geo Lookup Data
# The following script prepares geographic lookup data. The data provides simple
# lookup tables linking data zone to common high level geographies.

# Source and prepare the data

# Embed geo_lookup data within package
usethis::use_data(geo_lookup, overwrite = TRUE)
