#' Return a \code{data.frame} of all data sets available on statistics.gov.scot
#'
#'
#' @return A \code{data.frame} of all data sets available on statistics.gov.scot
#' @examples
#' list_sg_datasets()

list_sg_datasets <- function() {
  #library(SPARQL)
  endpoint <- "http://statistics.gov.scot/sparql"

  # create query statement
  query <-
    "PREFIX dcterms: <http://purl.org/dc/terms/>
  PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
  PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
  PREFIX xsd: <http://www.w3.org/2001/XMLSchema#>

  SELECT ?URI ?Name ?Publisher
  WHERE {
  ?URI rdf:type <http://publishmydata.com/def/dataset#Dataset>;
  rdfs:label ?Name;
  dcterms:publisher ?Pub.
  ?Pub rdfs:label ?Publisher.
  }

  ORDER BY ?Name"

  # Step 2 - Use SPARQL package to submit query and save results to a data frame
  qdata <- SPARQL(endpoint,query)

  result <- qdata$results

  return(data.frame(result))
}
