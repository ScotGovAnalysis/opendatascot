context("ods_structure")

test_that("ods_structure returns list", {
  skip_on_cran()
  expect_is(ods_structure("homelessness-applications"), "list")
})
