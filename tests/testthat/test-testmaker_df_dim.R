test_that("testmaker_df_dim_tt works correctly", {
  expect_equal(class(testmaker_df_dim_tt(cars, return.style = "text", silent = TRUE)), c("glue", "character"))
  expect_equal(length(testmaker_df_dim_tt(cars, return.style = "text", silent = TRUE)), 2)
})

test_that("testmaker_df_dim_tt errors correctly", {
  expect_error(testmaker_df_dim_tt(1:10), "x must be a dataframe")
  expect_error(testmaker_df_dim_tt(cars, return.style = "character", silent = TRUE), "`return.style` must be")
})


test_that("testmaker_df_dim_cli generates code that behaves", {
  sin.text = testmaker_df_dim_cli(cars, return.style = "text", silent = TRUE, object.name = "res")
  res = cars
  expect_no_error(eval(parse(text = sin.text)))
  res = cars[-1,]
  expect_error(eval(parse(text = sin.text)), "Number of rows does not match")
  res = cbind(cars, cars)
  expect_error(eval(parse(text = sin.text)), "Number of columns does not match")
})
