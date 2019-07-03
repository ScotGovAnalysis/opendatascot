ods_lookup_geography <- function(geography) {
geo_lookup <- read.csv("http://statistics.gov.scot/downloads/file?id=f08c946e-cdfa-44de-9855-2b278a2aaf93%2FDatazone2011Lookup.csv", stringsAsFactors = FALSE)
geo_lookup <- geo_lookup[c(1,2,6,7,10)]
colnames(geo_lookup) <- c("datazone", "interzone", "local_authority", "health_board", "country")

geography_index <-which(geo_lookup == geography, arr.ind=T)

filtered_geography <- geo_lookup[geography_index[,1],]

return(filtered_geography)

}
