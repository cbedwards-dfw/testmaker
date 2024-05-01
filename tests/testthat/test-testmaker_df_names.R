test_that("multiplication works", {
  expect_equal(2 * 2, 4)
})

test_that("testmaker_df_dim_cli generates code that behaves", {
  cli.text = testmaker_df_names_cli(cars, return.style = "text", silent = TRUE, object.name = "res")
  res = cars
  expect_no_error(eval(parse(text = cli.text)))
  res = cars
  names(res)[1] = "turtle"
  expect_error(eval(parse(text = cli.text)))

})
