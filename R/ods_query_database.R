# small function to send sparql query to statistics.gov.scot
# internal function for ods_dataset
#' @noRd
#'
#'
ods_query_database <- function(endpoint, query) {

#endpoint <- "http://statistics.gov.scot/sparql"

#tryCatch({
content_returned <- httr::content(
    httr::POST(
      url = endpoint,
      config = httr::accept("text/csv"),
      body = list(query = query)
      ),
    as = "text",
    encoding = "UTF-8"
    )
#})

if(content_returned == "Response too large") {
  stop("Requested data is too large for statistics.gov.scot to return. Either add more filters to ods_dataset(), or use get_csv().
       Check ods_structure for categories to filter on.")
} else if(content_returned == "Request Timeout") {
  stop("Request has timed out, suggesting the data is too large for statistics.gov.scot to return. Either add more filters to ods_dataset(), or use get_csv().
       Check ods_structure for categories to filter on.")
}

post_data <- readr::read_csv(content_returned)

return(post_data)

}