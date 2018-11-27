#' Download data from statistics.gov.scot
#'
#' \code{scotgov_get} returns a tibble of data from statistics.gov.scot
#'
#'
#' This is a generic function: methods can be defined for it directly
#' or via the \code{\link{Summary}} group generic. For this to work properly,
#' the arguments \code{...} should be unnamed, and dispatch is on the
#' first argument.
#'
#' @param dataset An API endpoint for statistics.gov.scot
#' @param start_date A date
#' @param end_date A date
#' @param geography A string representing a valid SG geography code, or portion thereof
#' @return A tibble of data from statistics.gov.scot
#'
#' @examples
#' scotgov_get("http://statistics.gov.scot/sparql")
#'
#' @export
scotgov_get <- function(dataset,start_date=NULL,end_date=NULL,geography=NULL,...) {

  if(is.null(start_date) &
     is.null(end_date) &
     is.null(geography) &
     length(list(...)) == 0) {

  if("readr" %in% rownames(installed.packages())) {
    #download with readr if available
    result <- readr::read_csv(paste0("https://statistics.gov.scot/downloads/cube-table?uri=http%3A%2F%2Fstatistics.gov.scot%2Fdata%2F",dataset))
  } else {
    result <- read.csv(paste0("https://statistics.gov.scot/downloads/cube-table?uri=http%3A%2F%2Fstatistics.gov.scot%2Fdata%2F",dataset))
  }

    result <- read.csv(paste0("https://statistics.gov.scot/downloads/cube-table?uri=http%3A%2F%2Fstatistics.gov.scot%2Fdata%2F",dataset))

  } else {

  endpoint <- "http://statistics.gov.scot/sparql"
    
  query <- get_dataset_query(dataset)
    
  query_data <- try(SPARQL::SPARQL(endpoint,query),silent = TRUE)

  if( query_data[1] ==  "Error : XML content does not seem to be XML: 'Response too large'\n"){
    stop(Error = "Dataset is too large to be downloaded like this. Try adding filters to reduce size")
  }

  result <- query_data$results

  }

  return(result)

}
