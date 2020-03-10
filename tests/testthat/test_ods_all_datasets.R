context("ods_all_datasets")

with_mock_api({
  test_that("ods_all_datasets produces no warning", {
    expect_silent(ods_all_datasets())
  })
})

test_datasets <- ods_all_datasets()

with_mock_api({
  testthat::test_that("data frame should be returned by ods_all_datasets", {
    expect_is(ods_all_datasets(), "data.frame")
  })
})
