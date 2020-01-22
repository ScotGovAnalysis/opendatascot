# small function to send sparql query to statistics.gov.scot
# internal function for ods_dataset
#' @noRd
#'
#'
ods_query_database <- function(endpoint, query) {

#endpoint <- "http://statistics.gov.scot/sparql"

post_data <- readr::read_csv(
  httr::content(
    httr::POST(
      url = endpoint,
      config = httr::accept("text/csv"),
      body = list(query = query)
      ),
    as = "text",
    encoding = "UTF-8"
    )
  )

return(post_data)

}
