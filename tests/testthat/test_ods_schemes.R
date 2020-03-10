context("ods_scheme")

test_that("Entered a dataset with a space",
    expect_that(ods_schemes("bus accessibility"),
                throws_error("Blanks space detected in requested dataset name, replace with a dash '-' for a valid dataset name"
                             , fixed = TRUE))
    )

with_mock_api(
test_that("Mispelled dataset entered",
          expect_that(ods_schemes("busaccessibility"),
                      throws_error("No schemes detected for this dataset. Dataset may not be convertable to a dataframe, or the name may be spelled incorrectly"
                                   , fixed = TRUE))
)
)
