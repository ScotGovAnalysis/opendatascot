context("ods_all_datasets")

test_that("ods_all_datasets produces no warning", {
  expect_silent(ods_all_datasets())
})

testthat::test_that("data frame should be returned by ods_all_datasets", {
  expect_is(ods_all_datasets(), "data.frame")
})
