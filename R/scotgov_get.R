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
#'
#' @export
scotgov_get <- function(dataset,
                        start_date=NULL,
                        end_date=NULL,
                        geography=NULL) {

  if (is.null(start_date) & is.null(end_date) & is.null(geography)) {

  if ("readr" %in% rownames(installed.packages())) {
    #download with readr if available
    result <- readr::read_csv(paste0("https://statistics.gov.scot/downloads/",
                                     "cube-table?uri=http%3A%2F%2F",
                                     "statistics.gov.scot%2Fdata%2F",
                                     dataset))
  } else {
    result <- read.csv(paste0("https://statistics.gov.scot/downloads/",
                              "cube-table?uri=http%3A%2F%2F",
                              "statistics.gov.scot%2Fdata%2F",
                              dataset))
  }

    result <- read.csv(paste0("https://statistics.gov.scot/downloads/",
                              "cube-table?uri=http%3A%2F%2F",
                              "statistics.gov.scot%2Fdata%2F",
                              dataset))

  } else {

  endpoint <- "http://statistics.gov.scot/sparql"
  TEMP_locations <- dataset_dimensions(dataset)
  locations <- data.frame(lapply(TEMP_locations, as.character),
                          stringsAsFactors = FALSE)
  dimensions <- gsub("[()%]", "", get_names(locations[, ]))

  question_marked_dimensions <- unlist(
    lapply(dimensions, function(x) paste0("?", x))
    )

  uri_dimensions <- unlist(
    lapply(question_marked_dimensions, function(x) paste0(x, "URI"))
    )

  #start the sparql query
  select_line <- paste("select", paste(question_marked_dimensions), "?value")
  data_line <- paste0("?data qb:dataSet <http://statistics.gov.scot/data/",
                      dataset,
                      ">.")

  query <- paste("PREFIX qb: <http://purl.org/linked-data/cube#> ",
                 "PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#> ",
                 "PREFIX xsd: <http://www.w3.org/2001/XMLSchema#>",
                 select_line,
                 "where {",
                 data_line)

  #iter over the dimensions, and generate a sparql line
  for (i in seq_along(locations[, ])) {
    query_addition <- paste0("?data ",
                             locations[i, ],
                             " ",
                             uri_dimensions[i],
                             ". ",
                             uri_dimensions[i],
                             " rdfs:label ",
                             question_marked_dimensions[i],
                             ".")

    query <- paste(query, query_addition)
  }

  #filter based on date if requested
  if (!is.null(start_date) & !is.null(end_date)) {

    query_addition <- paste0("FILTER (?refPeriod >= '",
                             start_date,
                             "'^^xsd:date && ?refPeriod <= '",
                             end_date,
                             "'^^xsd:date)")
    query <- paste(query, query_addition)

  } else if (!is.null(start_date)) {
    query_addition <- paste0("FILTER (?refPeriod >= '",
                             start_date,
                             "'^^xsd:date)")
    query <- paste(query, query_addition)

  } else if (!is.null(end_date)) {
    query_addition <- paste0("FILTER (?refPeriod <= '",
                             end_date,
                             "'^^xsd:date)")
    query <- paste(query, query_addition)
  }

  #filter based on geography if requested
  if (!is.null(geography)) {
    query_addition <- paste0("FILTER( regex(str(?refAreaURI), '",
                             geography,
                             "' ))")
    query <- paste(query, query_addition)
  }

  #expose the measureType dimension's value as a value
  query <- paste(query, "?data ?measureTypeURI ?value. }")

  query_data <- try(SPARQL::SPARQL(endpoint, query), silent = TRUE)
  if ( query_data[1] ==
       "Error : XML content does not seem to be XML: 'Response too large'\n"){
    stop(Error = paste("Dataset is too large to be downloaded like this.",
                       "Try adding filters to reduce size"))
  }

  result <- query_data$results

  }

  return(result)

}
