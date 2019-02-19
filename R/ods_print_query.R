#' Generate SPARQL query to download data from statistics.gov.scot
#'
#' \code{ods_print_query(} returns a tibble of data from statistics.gov.scot
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
#' @param ... arbitrary filters requiring valid scheme = value structure
#' @return A string consisting of a valid SPARQL query
#'
#' @examples
#' ods_print_query("average-house-size")
#'
#' @export
ods_print_query <- function(dataset,
                            start_date=NULL,
                            end_date=NULL,
                            geography=NULL,
                            ...) {

  TEMP_locations <- ods_schemes(dataset)
  locations <- data.frame(lapply(TEMP_locations,
                                 as.character),
                          stringsAsFactors = FALSE)
  schemes <- gsub("[()%]", "", ods_names(locations[, ]))
  question_marked_schemes <- unlist(
    lapply(schemes,
           function(x) paste0("?", x)
    )
  )
  uri_schemes <- unlist(
    lapply(
      question_marked_schemes,
      function(x) paste0(x, "URI")
    )
  )

  #start the sparql query
  select_line <- paste(
    paste(
      "select", paste(question_marked_schemes, collapse = " ")
    ),
    "?value")
  data_line <- paste0("?data qb:dataSet <http://statistics.gov.scot/data/",
                      dataset,
                      ">.")

  query <- paste("PREFIX qb: <http://purl.org/linked-data/cube#>
                 PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
                 PREFIX xsd: <http://www.w3.org/2001/XMLSchema#>",
                 select_line,
                 "where {",
                 data_line)

  #iter over the schemes, and generate a sparql line
  for (i in 1:length(locations[, ])) {
    query_addition <- paste0("?data ",
                             locations[i, ],
                             " ",
                             uri_schemes[i],
                             ". ",
                             uri_schemes[i],
                             " rdfs:label ",
                             question_marked_schemes[i],
                             ".")

    query <- paste(query, query_addition)
  }

  #filter based on date if requested
  if (!is.null(start_date) & !is.null(end_date)){
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

  #Build filter for additional arguements
  #names of all the arguements
  schemes <- names(list(...))
  #list of all the names and values of the arguemnts
  values <- list(...)

  if ( length(schemes >= 1) ) {

    #initialise query builder
    query_addition <- ""

    #builder for simple one arguemnt filter
    for (i in 1:length(schemes)){
      if ( length(values[[i]]) == 1) {
        query_addition <- paste0(query_addition,
                                 "filter (?", schemes[[i]], " = '",
                                 values[[i]], "'^^xsd:string) ")
      } else {

        #builder for multiple value arguments - makes a big chain of OR statements
        builder <- "filter ("
        for (j in 1:length(values[[i]])){
          builder <- paste0(builder,
                            "?",
                            schemes[[i]],
                            " = '",
                            values[[i]][[j]],
                            "'^^xsd:string")
          if (j != length(values[[i]])) {
            builder <- paste0(builder, "||")
          }
        }
        query_addition <- paste0(query_addition, builder, ") ")
      }
    }

    query <- paste(query, query_addition)

  }

  #expose the measureType scheme's value as a value
  query <- paste(query, "?data ?measureTypeURI ?value. }")

  return(query)

}
