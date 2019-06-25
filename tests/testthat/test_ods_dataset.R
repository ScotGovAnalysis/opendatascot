context("ods_dataset")

test_that("ods_dataset with geography filtering produces no warning", {
  skip_on_cran()
  expect_silent(ods_dataset(dataset = "average-household-size", geography = "S12000039"))
})

test_that("ods_dataset with start date filtering produces no warning", {
  skip_on_cran()
  expect_silent(ods_dataset(dataset = "average-household-size",
                            start_date = 2010))
})

test_that("ods_dataset with end date filtering produces no warning", {
  skip_on_cran()
  expect_silent(ods_dataset(dataset = "average-household-size",
                            end_date = 2010))
})

test_that("ods_dataset with date and geography filtering produces no warning", {
  skip_on_cran()
  expect_silent(ods_dataset(dataset = "average-household-size",
                            end_date = 2010, geography = "S12000039"))
})

test_that("ods_dataset with arbitrary filtering produces no warning", {
  skip_on_cran()
  expect_silent(ods_dataset("homelessness-applications",
                            refPeriod = c("2015/2016", "2016/2017"),
                            applicationType = "All applications"))
})

test_that("ods_dataset with geography filtering returns data.frame", {
  skip_on_cran()
  expect_is(ods_dataset(dataset = "average-household-size", geography = "S12000039"), "data.frame")
})

test_that("ods_dataset with geography filtering returns correct ref area", {
  skip_on_cran()
  expect_equal(ods_dataset(dataset = "average-household-size", geography = "S12000039")$refArea[1], "West Dunbartonshire")
})
