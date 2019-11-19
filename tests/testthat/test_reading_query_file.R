context("Test reding query file")

test_that(desc = "Throw errors on wrong x",
          code = {
            expect_error(object = read_query_file(file_name = NULL),
                         regexp = "^Assertion\\son\\s\\'file_name\\'\\sfailed.*")
            expect_error(object = read_query_file(file_name = NA),
                         regexp = "^Assertion\\son\\s\\'file_name\\'\\sfailed.*")
          })

test_that(desc = "Comments are removed",
          code = expect_false(object = grepl(
            pattern = "^#",
            x = read_query_file(file_name = "find_lower_level_geographies")
          )))

test_that(desc = "Lines are merged",
          code = expect_length(
            object = read_query_file(file_name = "find_lower_level_geographies"),
            n = 1
          ))
