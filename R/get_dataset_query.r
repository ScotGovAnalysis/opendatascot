#' Generate SPARQL query to download data from statistics.gov.scot
#'
#' \code{get_dataset_query} returns a tibble of data from statistics.gov.scot
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
#' @param ... arbitrary filters requiring valid dimension = value structure
#' @return A string consisting of a valid SPARQL query
#'
#' @examples
#' get_dataset_query("average-house-size")
#'
#' @export
get_dataset_query <- function(dataset,start_date=NULL,end_date=NULL,geography=NULL,...) {
  
  TEMP_locations <- dataset_dimensions(dataset)
  locations <- data.frame(lapply(TEMP_locations, as.character), stringsAsFactors=FALSE)
  dimensions <- gsub("[()%]", "", get_names(locations[,]))
  question_marked_dimensions <-unlist(lapply(dimensions,function(x) paste0('?',x)))
  uri_dimensions <-unlist(lapply(question_marked_dimensions,function(x) paste0(x,"URI")))
  
  #start the sparql query
  select_line <- paste(paste("select",paste(question_marked_dimensions,collapse=" ")),"?value")
  data_line <- paste0("?data qb:dataSet <http://statistics.gov.scot/data/",dataset,">.")
  
  query<- paste("PREFIX qb: <http://purl.org/linked-data/cube#> PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#> PREFIX xsd: <http://www.w3.org/2001/XMLSchema#>",
                select_line,
                "where {",
                data_line)
  
  #iter over the dimensions, and generate a sparql line
  for (i in 1:length(locations[,])) {
    query_addition <- paste0("?data ",
                             locations[i,],
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
  if(!is.null(start_date) & !is.null(end_date)) {
    query_addition <- paste0("FILTER (?refPeriod >= '",start_date,"'^^xsd:date && ?refPeriod <= '",end_date,"'^^xsd:date)")
    query <- paste(query, query_addition)
  } else if(!is.null(start_date)) {
    query_addition <- paste0("FILTER (?refPeriod >= '",start_date,"'^^xsd:date)")
    query <- paste(query, query_addition)
  } else if(!is.null(end_date)) {
    query_addition <- paste0("FILTER (?refPeriod <= '",end_date,"'^^xsd:date)")
    query <- paste(query, query_addition)
  }
  
  #filter based on geography if requested
  if(!is.null(geography)) {
    query_addition <- paste0("FILTER( regex(str(?refAreaURI), '",geography,"' ))")
    query <- paste(query, query_addition)
  }
  
  #Build filter for additional arguements
  #names of all the arguements
  dimensions <- names(list(...))
  #list of all the names and values of the arguemnts
  values <- list(...)

  #initialise query builder
  query_addition<-""

  #builder for simple one arguemnt filter
  for(i in 1:length(dimensions)){
    if( length(values[[i]]) == 1) {
      query_addition<- paste0(query_addition, "filter (?", dimensions[[i]], " = '", values[[i]],"'^^xsd:string) ")
    } else {

      #builder for multiple value arguments - makes a big chain of OR statements
      builder<-"filter ("
      for (j in 1:length(values[[i]])){
        builder <- paste0(builder,"?", dimensions[[i]], " = '", values[[i]][[j]],"'^^xsd:string")
        if(j != length(values[[i]])) {
          builder <- paste0(builder,"||")
        }
      }
      query_addition<- paste0(query_addition,builder,") ")
    }
  }
    
  #expose the measureType dimension's value as a value
  query<-paste(query, "?data ?measureTypeURI ?value. }")
                
  return(query)
  
}
