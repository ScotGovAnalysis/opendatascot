# Collects the dimensions and measureType values of a scotgov dataset
# An internal fuction for the scotgov_get function


dataset_structure <- function(dataset) {
  endpoint <- "http://statistics.gov.scot/sparql"
  query <-   paste0(
    "PREFIX qb: <http://purl.org/linked-data/cube#>
      
    SELECT ?value
    WHERE {
      <",dataset, ">  qb:structure ?structure. #selects the structure of the dataset
      ?structure qb:component ?value. #exposes the components of the dataset as value
    }"
  )
      
  query_data <- SPARQL(endpoint,query)
  result <- query_data$results
  
  return(data.frame(result))
  
}  
