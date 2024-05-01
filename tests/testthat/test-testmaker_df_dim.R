test_that("testmaker_df_dim_tt works correctly", {
  expect_equal(class(testmaker_df_dim_tt(cars, return.style = "text", silent = TRUE)), c("glue", "character"))
  expect_equal(length(testmaker_df_dim_tt(cars, return.style = "text", silent = TRUE)), 2)
})

test_that("testmaker_df_dim_tt errors correctly", {
  expect_error(testmaker_df_dim_tt(1:10), "x must be a dataframe")
  expect_error(testmaker_df_dim_tt(cars, return.style = "character", silent = TRUE), "`return.style` must be")
})

