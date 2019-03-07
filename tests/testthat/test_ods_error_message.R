context("ods_error_message")

test_that("non-existent dataset produces correct message", {
  skip_on_cran()
  expect_message(ods_dataset("made-up-dataset"),
                 "The dataset 'made-up-dataset' does not exist.",
                 "Compare with existing datasets using 'ods_all_datasets()'.")
})

test_that("non-existent dataset produces correct message with filter", {
  skip_on_cran()
  expect_message(ods_dataset("made-up-dataset", 2017),
                 "There was an unknown error in the generated query; possibly an error in the dataset name provided.",
                 "The dataset name provided was: 'made-up-dataset'.",
                 "Compare with existing datasets using 'ods_all_datasets()'.")
})

# Test passing but function being tested seems to take around 12 mins to run
test_that("large dataset produces correct message", {
  skip_on_cran()
  expect_message(ods_dataset("working-age-claimants-of-benefits-key"),
                 "There was an unknown error in the generated query; possibly an error in the dataset name provided.",
                 "The dataset name provided was: 'working-age-claimants-of-benefits-key'.",
                 "Compare with existing datasets using 'ods_all_datasets()'.",
                 "Original error message: Error in open.connection(con, 'rb'): HTTP error 500.")
})

test_that("large dataset produces correct message with filter", {
  skip_on_cran()
  expect_message(ods_dataset("working-age-claimants-of-benefits-key", 2017),
                 "Dataset 'working-age-claimants-of-benefits-key' is too large to be downloaded in its entirety.",
                 "Try adding filters to reduce size.")
})

test_that("syntax error produces correct message", {
  skip_on_cran()
  expect_message(ods_dataset("spaces in dataset"),
                 "There was an unknown error in the generated query; possibly an error in the dataset name provided.",
                 "The dataset name provided was: 'spaces in dataset'.",
                 "Compare with existing datasets using 'ods_all_datasets()'.",
                 "Original error message: Error in open.connection(con, 'rb'): HTTP error 400.")
})

test_that("syntax error produces correct message with filter", {
  skip_on_cran()
  expect_message(ods_dataset("spaces in dataset", 2017),
                 "There was an unknown error in the generated query; possibly an error in the dataset name provided.",
                 "The dataset name provided was: 'spaces in dataset'.",
                 "Compare with existing datasets using 'ods_all_datasets()'",
                 "Original error message: Error in if (query != '') {: argument is of length zero")
})
