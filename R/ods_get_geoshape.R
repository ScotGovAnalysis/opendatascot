#' Return a polygon of a valid statistical geography
#'
#' \code{ods_get_geoshape} returns a string from \href{https://statistics.gov.scot/}{statistics.gov.scot} of all geographies which contain the geography provided
#'
#' The \code{geography} parameter must be passed a valid geography unit.
#'
#' @param geography \code{string}. A valid geography unit from \href{https://statistics.gov.scot/}{statistics.gov.scot}.
#'
#' @return \code{string}.
#'
#' @examples
#' ods_get_geoshape("S02001257")
#'
#' @export

ods_get_geoshape <- function(geography) {

  endpoint <- "http://statistics.gov.scot/sparql"

  query_text <- read_query_file("get_geoshape")
  query <- glue::glue(query_text, geography, .open = "[", .close = "]")
  query <- sub("(}).*", "\\1",  query) #having some issues with extra text, adding hack
  query_data <- ods_query_database(endpoint, query)

  return(query_data$map)

}
query_text <- paste(query_text, collapse = " ")
