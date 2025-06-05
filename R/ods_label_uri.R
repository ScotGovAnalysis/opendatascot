#' functions to label a dataset full of uri
#'
#' \code{ods_create_label_lookup} returns a dataset that is then used as a lookup
#'
#' @return \code{tibble}.

ods_create_label_lookup <- function(uri_list) {

  query <- paste0("PREFIX qb: <http://purl.org/linked-data/cube#>
        PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
        PREFIX xsd: <http://www.w3.org/2001/XMLSchema#>

    select ?uri ?labled_uri
    where {
      values ?uri{<", paste(uri_list, collapse = "> <"), ">
    }
    ?uri rdfs:label ?labled_uri.}")

  query <- gsub("[\n]", "", query)

  return(ods_query_database(query = query))

}

#' Find all geographies that contain, or are contained by, a certain geography
#'
#' \code{ods_label_uri} labels a dataset that comprises of uri
#'
#' @return \code{tibble}.
#'
#' @export

ods_label_uri <- function(dataset, uri) {

  uri_list <- unique(dataset[[uri]])

  label_lookup <- ods_create_label_lookup(uri_list)

  labeled_dataset <- merge(dataset, label_lookup,
                           by.x = uri,
                           by.y = "uri",
                           all.x = TRUE)

  labeled_dataset[[uri]] <- labeled_dataset$labled_uri
  labeled_dataset$labled_uri <- NULL

  return(labeled_dataset)

  }

ods_label_dataset <- function(dataset) {
#ods_label_uri(test, "adultDisabilityPaymentIndicators")

temp_dataset <- dataset

uri_refs <- colnames(dataset)[!colnames(dataset) %in% c("value")]
for(uri_i in uri_refs) {
  temp_dataset <- ods_label_uri(temp_dataset,uri_i)
}

return(temp_dataset)
}
