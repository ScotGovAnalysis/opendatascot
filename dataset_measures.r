# Returns the values of the measureType field for a ScotGov dataset
# An internal function for the get_scotgov function

dataset_measures <- function(dataset) {
  endpoint <- "http://statistics.gov.scot/sparql"
  query <-   paste0(
    "PREFIX qb: <http://purl.org/linked-data/cube#>
    SELECT distinct ?value
    WHERE {
      ?data qb:dataSet <",dataset,">.
      ?data qb:measureType ?value.
    }"
  )
  
  query_data <- SPARQL(endpoint,query)
  result <- query_data$results
  
  return(data.frame(result))
  
}
