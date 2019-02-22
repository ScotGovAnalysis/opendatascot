#' Generate a SPARQL query to call on API
#'
#' \code{ods_print_query} returns a valid SPARQL query to call on the \href{https://statistics.gov.scot/}{statistics.gov.scot} API
#'
#' The \code{dataset} parameter must be passed a valid dataset name (a full list can be obtained by calling \code{ods_all_datasets()}.
#' Other parameters can also be used to filter the dataset.
#'
#' @param dataset \code{string}. The identifying final part of a URI for a dataset on \href{https://statistics.gov.scot/}{statistics.gov.scot}.
#' @param start_date \code{string}. Filter data points after this date.
#' @param end_date \code{string}. Filter data points before this date.
#' @param geography \code{string}. A valid SG geography code, or portion thereof.
#' @param ... Arbitrary filters requiring valid scheme = value structure.
#'
#' @return \code{string}. A valid SPARQL query.
#'
#' @examples
#' ods_print_query("average-household-size")
#'
#' @export

ods_print_query <- function(dataset,
                            start_date=NULL,
                            end_date=NULL,
                            geography=NULL,
                            ...) {

  temp_locations <- ods_schemes(dataset)
  locations <- data.frame(lapply(temp_locations,
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

  if (length(schemes >= 1)) {

    #initialise query builder
    query_addition <- ""

    #builder for simple one arguemnt filter
    for (i in 1:length(schemes)){
      if (length(values[[i]]) == 1) {
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