#' Download a dataset csv
#'
#' \code{ods_get_csv} returns a dataset from \href{https://statistics.gov.scot/}{statistics.gov.scot}
#' The \code{dataset} parameter must be passed a valid dataset name (a full list can be obtained by calling \code{ods_all_datasets()}.
#'
#' @param dataset \code{string}. The identifying final part of a URI for a dataset on \href{https://statistics.gov.scot/}{statistics.gov.scot}.
#'
#' @return \code{tibble}.
#' When invalid arguments are used returns \code{NULL} with \code{warning} (see \code{ods_error_message}).
#'
#' @examples
#' ods_get_csv("average-household-size")
#'
#' @export

ods_get_csv <- function(dataset) {

    if ("readr" %in% rownames(utils::installed.packages())) {
      #download with readr if available
      result <- readr::read_csv(paste0("https://statistics.gov.scot/downloads/",
                                       "cube-table?uri=http%3A%2F%2F",
                                       "statistics.gov.scot%2Fdata%2F",
                                       dataset))
    } else {
      result <- utils::read.csv(paste0("https://statistics.gov.scot/downloads/",
                                       "cube-table?uri=http%3A%2F%2F",
                                       "statistics.gov.scot%2Fdata%2F",
                                       dataset))
    }
    
    return(result)
}
