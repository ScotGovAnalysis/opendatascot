#' find all datasets in opendatascotland
#'
#' \code{list_sg_datasets} returns a list of all datasets from statistics.gov.scot
#'
#'
#' This is a generic function: methods can be defined for it directly
#' or via the \code{\link{Summary}} group generic. For this to work properly,
#' the arguments \code{...} should be unnamed, and dispatch is on the
#' first argument.
#'
#' @param endpoint An API endpoint for statistics.gov.scot
#' @return A list of data from statistics.gov.scot
#'
#' @examples
#' list_st_datasets()
#'
#' @export

list_sg_datasets <- function() {

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
  qdata <- SPARQL::SPARQL(endpoint, query)

  result <- qdata$results

  result['dataset_name'] <- sapply(result['URI'], function(x) get_names(x))
                                   
  return(data.frame(result))
}
