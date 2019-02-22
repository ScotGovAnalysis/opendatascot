context("ods_print_query")

expected_return_value1 <- "PREFIX qb: <http://purl.org/linked-data/cube#>"
expected_return_value2 <- "PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>"
expected_return_value3 <- "PREFIX xsd: <http://www.w3.org/2001/XMLSchema#>"
expected_return_value4 <- "select  \\?value where \\{ \\?data qb:dataSet <http://statistics\\.gov\\.scot/data/average-house-size>\\. \\?data  \\.  rdfs:label \\. \\?data  \\.  rdfs:label \\. \\?data \\?measureTypeURI \\?value\\. \\}"
expected_return_value5 <- "select  \\?value where \\{ \\?data qb:dataSet <http://statistics\\.gov\\.scot/data/average-house-size>\\. \\?data  \\.  rdfs:label \\. \\?data  \\.  rdfs:label \\. FILTER \\(\\?refPeriod >= '2017'\\^\\^xsd:date && \\?refPeriod <= '2018'\\^\\^xsd:date\\) \\?data \\?measureTypeURI \\?value\\. \\}"

printed_query <- ods_print_query("average-house-size")
printed_query_with_filter <- ods_print_query(dataset = "average-house-size",
                                             start_date = 2017,
                                             end_date = 2018)

test_that("ods_print_query produces correct query without filters", {
  skip_on_cran()
  expect_match(printed_query, expected_return_value1)
  expect_match(printed_query, expected_return_value2)
  expect_match(printed_query, expected_return_value3)
  expect_match(printed_query, expected_return_value4)
})

test_that("ods_print_query produces correct query with filters", {
  skip_on_cran()
  expect_match(printed_query_with_filter, expected_return_value1)
  expect_match(printed_query_with_filter, expected_return_value2)
  expect_match(printed_query_with_filter, expected_return_value3)
  expect_match(printed_query_with_filter, expected_return_value5)
})
