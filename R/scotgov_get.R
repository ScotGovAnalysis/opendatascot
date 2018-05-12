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
#' @param endpoint An API endpoint for statistics.gov.scot
#' @return A tibble of data from statistics.gov.scot
#'
#' @examples
#' scotgov_get("http://statistics.gov.scot/sparql")

require(SPARQL)

scotgov_get <- function(dataset) {
  
  endpoint <- "http://statistics.gov.scot/sparql"
  
  components <- get_names(dataset_structure(dataset))
  measures <- get_names(dataset_measures(dataset))
  dimensions <- components[!components %in% measures]
  locations <- unlist(lapply(dimensions,location_generator))
  question_marked_dimensions <-unlist(lapply(dimensions,function(x) paste0('?',x)))
  
  #start the sparql query
  select_line <- paste(paste("select",paste(question_marked_dimensions,collapse=" ")),"?value")
  data_line <- paste0("?data qb:dataSet <",dataset,">.")
  
  query<- paste("PREFIX qb: <http://purl.org/linked-data/cube#> PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#> ",
                select_line,
                "where {",
                data_line)
  
  #iter over the dimensions, and generate a sparql line
  for (i in length(locations)) {
    query_addition <- paste0("?data ",
                             locations[i],
                             " ",
                             question_marked_dimensions[i],
                             ".")
    query <- paste(query, query_addition)
  }
  
  #expose the measureType dimension's value as a value
  query<-paste(query, "?data ?measureType ?value. }")
  
  query_data <- SPARQL(endpoint,query)
  result <- query_data$results
  
  return(result)
  
}
