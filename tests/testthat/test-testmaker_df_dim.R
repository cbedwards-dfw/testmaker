test_that("testmaker_df_dim_tt works correctly", {
  expect_equal(class(testmaker_df_dim_tt(cars, return.style = "text", silent = TRUE)), c("glue", "character"))
  expect_equal(length(testmaker_df_dim_tt(cars, return.style = "text", silent = TRUE)), 2)
})

test_that("testmaker_df_dim_tt errors correctly", {
  expect_error(testmaker_df_dim_tt(1:10), "must be a dataframe, but is")
  expect_error(testmaker_df_dim_tt(cars, return.style = "character", silent = TRUE), "`return.style` must be")
})


test_that("testmaker_df_dim_cli generates code that behaves", {
  sin.text = testmaker_df_dim_cli(mtcars, return.style = "text", silent = TRUE)
  sin.text = c("res = mtcars.rearrange[,-1]", sin.text)
  expect_error(eval(parse(text = sin.text)))
  sin.text[1] = "res = mtcars"
  expect_no_error(eval(parse(text = sin.text)))
})
