test_that("testmaker_df_dim_cli produces errors (or not) appropriately", {

  cli.text = testmaker_df_class_cli(cars, return.style = "text", silent = TRUE)

  res = cars
  expect_no_error(eval(parse(text = cli.text)))

  res = cars
  res$speed = as.logical(res$speed)
  expect_error(eval(parse(text = cli.text)))
               # "Expect type of [`]res$speed[`] to be double, but is logical!")

  res = cars
  res$dist = as.character(res$dist)
  expect_error(eval(parse(text = cli.text)))


  })
