context("ods_query_database")


test_that("Excessively large dataset throws error", {
  skip_on_cran()
  expect_that(
    httptest::with_mock_api({
    ods_query_database("http://statistics.gov.scot/sparql",
                                 "PREFIX qb: <http://purl.org/linked-data/cube#>                 PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>                 PREFIX xsd: <http://www.w3.org/2001/XMLSchema#> select   ?refArea ?refPeriod ?measureType ?weekend ?value where { ?data qb:dataSet <http://statistics.gov.scot/data/bus-accessibility>. ?data <http://purl.org/linked-data/sdmx/2009/dimension#refArea> ?refArea. ?data <http://purl.org/linked-data/sdmx/2009/dimension#refPeriod> ?refPeriod. ?data <http://purl.org/linked-data/cube#measureType> ?measureType. ?data <http://statistics.gov.scot/def/dimension/weekday/weekend> ?weekend. ?data ?measureType ?value. } order by ?refPeriod ?refArea")
    }), throws_error("Requested data is too large for statistics.gov.scot to return. Either add more filters to ods_dataset(), or use get_csv().\n       Check ods_structure for categories to filter on."
      , fixed = TRUE))

})
