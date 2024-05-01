test_that("testmaker_df_dim works correctly", {
  expect_equal(class(testmaker_df_dim(cars, return.style = "text")), "character")
  expect_equal(length(testmaker_df_dim(cars, return.style = "text")), 2)
})

test_that("testmaker_df_dim errors correctly", {
  expect_error(testmaker_df_dim(1:10), "x must be a dataframe")
  expect_error(testmaker_df_dim(cars, return.style = "character"), "`return.style` must be")
})

