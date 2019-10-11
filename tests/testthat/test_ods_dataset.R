context("ods_dataset")

test_that("ods_dataset with geography filtering produces no warning", {
  skip_on_cran()
  expect_silent(ods_dataset(dataset = "average-household-size", geography = "la"))
})

test_that("ods_dataset with arbitrary filtering produces no warning", {
  skip_on_cran()
  expect_silent(ods_dataset("homelessness-applications",
                            refPeriod = c("2015/2016", "2016/2017"),
                            applicationType = "All applications"))
})

test_that("ods_dataset with geography filtering returns data.frame", {
  skip_on_cran()
  expect_is(ods_dataset(dataset = "average-household-size", geography = "la"), "data.frame")
})

#test_that("ods_dataset with geography filtering returns correct ref area", {
#  skip_on_cran()
#  expect_equal(ods_dataset(dataset = "average-household-size", geography = "S12000039")$refArea[1], "West Dunbartonshire")
#})

#test_that("ods_dataset with arbitrary filtering returns correct value", {
#  skip_on_cran()
#  expect_equal(ods_dataset(dataset = "average-household-size", refArea="West Lothian", refPeriod="2018", measureType="Ratio")$value
#, 2.31)
#})
