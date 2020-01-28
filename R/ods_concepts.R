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

ods_find_lower_geographies <- function(datset, scheme) {

  endpoint <- "http://statistics.gov.scot/sparql"

  query_text <- read_query_file("concepts")
  query <- glue::glue(query_text, dataset = dataset, scheme = scheme, .open = "[", .close = "]")
  query_data <- ods_query_database(endpoint, query)

  return(query_data)
}
