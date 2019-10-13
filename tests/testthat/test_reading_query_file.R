context("Test reding query file")

test_that(desc = "Throw errors on wrong x",
          code = {
            expect_error(object = read_query_file(x = NULL),
                         regexp = "^Assertion\\son\\s\\'x\\'\\sfailed.*")
            expect_error(object = read_query_file(x = NA),
                         regexp = "^Assertion\\son\\s\\'x\\'\\sfailed.*")
          })
