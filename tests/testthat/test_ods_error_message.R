context("ods_error_message")

test_that("non-existent dataset produces correct message", {
  skip_on_cran()
  expect_that(ods_dataset("made-up-dataset")
              , throws_error("The dataset 'made-up-dataset' does not exist.\nA full list of available datsets can be found by running 'ods_all_datasets()'."
                             , fixed = TRUE))
  })

test_that("non-existent dataset produces correct message with filter", {
  skip_on_cran()
  expect_that(ods_dataset("made-up-dataset", start_date = 2017)
              , throws_error("The dataset 'made-up-dataset' does not exist.\nA full list of available datsets can be found by running 'ods_all_datasets()'."
                             , fixed = TRUE))
})

test_that("large dataset produces correct message", {
  skip_on_cran()
  expect_that(ods_dataset("working-age-claimants-of-benefits-key")
              , throws_error("The dataset 'working-age-claimants-of-benefits-key' is too large to be downloaded directly.\nTry adding filters to reduce size or contact statistics.enquiries@gov.scot if you require the full dataset."
                             , fixed = TRUE))
})

test_that("large dataset produces correct message with filter", {
  skip_on_cran()
  expect_that(ods_dataset("working-age-claimants-of-benefits-key", start_date = 2017)
              , throws_error("The dataset 'working-age-claimants-of-benefits-key' is too large to be downloaded directly.\nTry adding filters to reduce size or contact statistics.enquiries@gov.scot if you require the full dataset."
                 , fixed = TRUE))
})

test_that("syntax error produces correct message", {
skip_on_cran()
expect_that(ods_dataset("spaces in dataset")
            , throws_error("The query generated from the dataset 'spaces in dataset' produced a syntax error, possibly a result of spaces in the dataset name.\nA full list of available datsets can be found by running 'ods_all_datasets()'."
                           , fixed = TRUE))
})

test_that("syntax error produces correct message", {
  skip_on_cran()
  expect_that(ods_dataset("spaces in dataset", start_date = 2017)
              , throws_error("The query generated from the dataset 'spaces in dataset' produced a syntax error, possibly a result of spaces in the dataset name.\nA full list of available datsets can be found by running 'ods_all_datasets()'."
                             , fixed = TRUE))
})
