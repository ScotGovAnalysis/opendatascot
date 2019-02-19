context("ods_all_datasets")

test_that("ods_all_datasets produces no warning", {
  skip_on_cran()
  expect_silent(ods_all_datasets())
})

test_datasets <- ods_all_datasets()

test_that("ods_all_datasets returns data.frame", {
  skip_on_cran()
  expect_is(test_datasets, "data.frame")
})
