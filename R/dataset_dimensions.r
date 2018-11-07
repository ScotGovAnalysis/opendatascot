# Replacement to older fuctions which will return the dimensions of the dataset
# An internal function for scotgov_get

dataset_dimensions <- function(dataset) {
  endpoint <- "http://statistics.gov.scot/sparql"
  query <- paste0(
    "PREFIX qb: <http://purl.org/linked-data/cube#>
    SELECT ?componentProperty ?componentReference
    WHERE {
      <http://statistics.gov.scot/data/",dataset, "> qb:structure ?structure. #selects the structure of the dataset
      ?structure qb:component ?value. #exposes the components of the dataset as value
      ?value ?componentProperty ?componentReference .
      }"
    )
  query_data <- SPARQL::SPARQL(endpoint,query)$results
  query_filter <- query_data[query_data$componentProperty=='<http://purl.org/linked-data/cube#dimension>',]
  result <- query_filter$componentReference
  return(data.frame(result))
}
