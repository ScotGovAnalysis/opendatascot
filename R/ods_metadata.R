#' Return the metadata used by a dataset
#'
#' \code{ods_metadata} returns all metadata used by a dataset on \href{https://statistics.gov.scot/}{statistics.gov.scot}
#'
#' The \code{dataset} parameter must be passed a valid dataset name (a full list can be obtained by calling \code{ods_all_datasets()}).
#'
#' @param dataset \code{string}. The identifying final part of a URI for a dataset on \href{https://statistics.gov.scot/}{statistics.gov.scot}.
#'
#' @return \code{data.frame}. All schemes used by the dataset named in the dataset argument.
#'
#' @examples
#' ods_metadata("average-household-size")
#'
#' @export

ods_metadata <- function(dataset) {

  if(grepl(" ", dataset)) {
    stop("Blanks space detected in requested dataset name, replace with a dash '-' for a valid dataset name")
  }

  endpoint <- "http://statistics.gov.scot/sparql"

  query_text <- read_query_file("metadata")
  query <- glue::glue(query_text, dataset = dataset, .open = "[", .close = "]")
  result <- ods_query_database(endpoint, query)
  result$metadata <- ods_names(result$metadata)

  if(length(result) == 0) {
    stop("No metadata detected for this dataset. Dataset may not exist, or the name may be spelled incorrectly")
  }

  return(result)
}
