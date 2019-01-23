
context("opendatascot")


test_that("scotgov_get with geography filtering produces no warning", {

  expect_silent(scotgov_get(dataset = "average-household-size", geography = "S12000039"))

})


test_that("scotgov_get with start date filtering produces no warning", {

  expect_silent(scotgov_get(dataset = "average-household-size",
                            start_date = 2010))

})

test_that("scotgov_get with end date filtering produces no warning", {

  expect_silent(scotgov_get(dataset = "average-household-size",
                            end_date = 2010))

})

test_that("scotgov_get with date and geography filtering produces no warning", {

  expect_silent(scotgov_get(dataset = "average-household-size",
                            end_date = 2010, geography = "S12000039"))

})

test_that("scotgov_get with arbitrary filtering produces no warning", {

  expect_silent(scotgov_get("homelessness-applications",
                            refPeriod = c("2015/2016", "2016/2017"),
                            applicationType = "All applications"))

})

test_that("get_structure produces no warning", {

  expect_silent(get_structure("homelessness-applications"))

})

test_that("list_sg_dataeset produces no warning", {

  expect_silent(list_sg_datasets())

})
