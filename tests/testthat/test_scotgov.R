context("scotgov")


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
