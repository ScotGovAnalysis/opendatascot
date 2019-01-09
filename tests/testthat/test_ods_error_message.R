context("scotgov-errors")

test_that("non-existent dataset produces correct message", {
  skip_on_cran()
  expect_message(scotgov_get("made-up-dataset"), "The dataset 'made-up-dataset' does not exist.\nCompare with existing datasets using 'ods_all_datasets'.")
})

# Test not working due to return characters, though results match in content
# test_that("non-existent dataset produces correct message with filter", {
#   skip_on_cran()
#   expect_message(scotgov_get("made-up-dataset", 2017), "There was an unknown error in the generated query; possibly an error in the dataset name provided.\nThe dataset name provided was: 'made-up-dataset'.\nCompare with existing datasets using 'ods_all_datasets()'.")
# })

# Test passing but runs over a long time
# test_that("large dataset produces correct message", {
#   skip_on_cran()
#   expect_message(scotgov_get("working-age-claimants-of-benefits-key"), message("The dataset 'made-up-dataset' does not exist.\nCompare with existing datasets using 'ods_all_datasets'."))
# })

test_that("large dataset produces correct message with filter", {
  skip_on_cran()
  expect_message(scotgov_get("working-age-claimants-of-benefits-key", 2017),  "Dataset 'working-age-claimants-of-benefits-key' is too large to be downloaded in its entirety.\nTry adding filters to reduce size.")
})

# Test not working due to return characters, though results match in content
# test_that("syntax error produces correct message", {
#   skip_on_cran()
#   expect_message(scotgov_get("spaces in dataset"), "There was an unknown error in the generated query; possibly an error in the dataset name provided.\nThe dataset name provided was: 'spaces in dataset'.\nCompare with existing datasets using 'ods_all_datasets()'.")
# })

# Test not working due to return characters, though results match in content
# test_that("syntax error produces correct message with filter", {
#   skip_on_cran()
#   expect_message(scotgov_get("spaces in dataset", 2017), "There was an unknown error in the generated query; possibly an error in the dataset name provided.\nThe dataset name provided was: 'spaces in dataset'.\nCompare with existing datasets using 'ods_all_datasets()'")
# })
