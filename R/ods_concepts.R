#' List all unique concepts of a dataset scheme
#'
#' \code{ods_concepts} is an internal function for \code{ods_dataset} that returns all unique values of a dataset scheme
#'
#' @param dataset \code{string}. The identifying final part of a URI for a dataset on \href{https://statistics.gov.scot/}{statistics.gov.scot}.
#' @param scheme \code{string}. The desired scheme of the dataset named in the dataset argument.
#'
#' @return \code{data.frame}.
#'
#' @examples
#' ods_concepts("average-household-size", "<http://purl.org/linked-data/sdmx/2009/dimension#refArea>")
#'
#' @keywords internal
#'
#' @noRd

ods_concepts <- function(dataset, scheme) {

  endpoint <- "http://statistics.gov.scot/sparql"

  #?spaceFill is used here as otherwise SPARQL returns an awkward datastructure
  query <- paste0("PREFIX qb: <http://purl.org/linked-data/cube#>
                  PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
                  select distinct ?concept ?spaceFill
                  where {
                  ?data qb:dataSet <http://statistics.gov.scot/data/", dataset, ">.
                  ?data ", scheme, " ?conceptURI. ?conceptURI rdfs:label ?concept.}")

  query_data <- SPARQL::SPARQL(endpoint, query)

  result <- query_data$results$concept


  return(result)

}
