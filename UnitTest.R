context("dropdown_selection_module")
source("utils.R")
test_that("test filter_ship_by_type function", {
  # test wrong inputs
  expect_error(filter_ship_by_type(0))
  expect_error(filter_ship_by_type(11))
  expect_error(filter_ship_by_type(3.5))
  expect_error(filter_ship_by_type("11"))
  # test correct inputs
  expect_equal(nrow(unique(filter_ship_by_type("Cargo")$SHIPNAME)), 381)
})

test_that("test longest_distance", {
  # test wrong inputs
  expect_error(longest_distance(0,1))
  expect_error(longest_distance("11","na"))
  expect_error(longest_distance(3.5,"na"))
  expect_error(longest_distance(1,11))
  # test correct inputs
  expect_equal(longest_distance("Tanker","SUULA")[1,"Distance"], format(round(31806.5922247512, 2), nsmall = 2))
})
