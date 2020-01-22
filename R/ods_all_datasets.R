#' List all datasets
#'
#' \code{ods_all_datasets} returns details of all datasets available from \href{https://statistics.gov.scot/}{statistics.gov.scot}
#'
#' @return \code{data.frame}. Contains the URI, Name, Publisher and Dataset Name of every dataset.
#'
#' @examples
#' ods_all_datasets()
#'
#' @export

ods_all_datasets <- function() {

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
  qdata <- ods_query_database(endpoint, query)

  #result <- qdata$results
  result <- qdata

  #result["dataset_name"] <- sapply(result["URI"], function(x) ods_names(x))
  return(result)
}

