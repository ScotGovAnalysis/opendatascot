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
  query <- read_query_file("all_datasets")
  result <- ods_query_database(endpoint, query)
  result$URI <- ods_names(result$URI)

  return(result)
}
