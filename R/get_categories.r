get_categories <- function(dataset,dimension) {

  endpoint <- "http://statistics.gov.scot/sparql"

  query <- paste0("PREFIX qb: <http://purl.org/linked-data/cube#> PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#> select distinct ?category where { ?data qb:dataSet <http://statistics.gov.scot/data/", dataset, ">. ?data ", dimension, " ?categoryURI. ?categoryURI rdfs:label ?category.}")

  query_data <- SPARQL::SPARQL(endpoint, query)

  result <- query_data$results

return(result)
  
}
