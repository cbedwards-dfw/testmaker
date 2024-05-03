## doing some fiddly stuff with eval(parse(text)) -- allows calling our
## generated R code within the tests.

test_that("testthat code does not fail for mtcars vs mtcars", {
  sin.text = testmaker_df_tt(mtcars, return.style = "text", silent = TRUE)
  sin.text = c("res = mtcars", sin.text)
  eval(parse(text = sin.text))
})

test_that("Stopifnot code correctly errors for mismatched mtcars vs cars", {
  sin.text = testmaker_df_sin(mtcars, return.style = "text", silent = TRUE)
  sin.text = c("res = cars", sin.text)
  expect_error(eval(parse(text = sin.text)))
})


test_that("Stopifnot code works for mtcars vs mtcars", {
  sin.text = testmaker_df_sin(mtcars, return.style = "text", silent = TRUE)
  sin.text = c("res = mtcars", sin.text)
  expect_no_error(eval(parse(text = sin.text)))
})

test_that("Stopifnot code correctly errors for mtcars vs cars", {
  sin.text = testmaker_df_sin(mtcars, return.style = "text", silent = TRUE)
  sin.text = c("res = cars", sin.text)
  expect_error(eval(parse(text = sin.text)))
})

test_that("Stopifnot code supports custom argument name", {
  sin.text = testmaker_df_sin(mtcars, return.style = "text", object.name = "arg1", silent = TRUE)
  sin.text = c("arg1 = mtcars", sin.text)
  expect_no_error(eval(parse(text = sin.text)))
})

test_that("Stopifnot name comparison errors at name re-arrangement unless _orderless version",{
  mtcars.rearrange = mtcars[,c(2:ncol(mtcars), 1)] ## create re-arrange version in base R
  ## test ordered
  sin.text = testmaker_df_names_sin(mtcars, return.style = "text", silent = TRUE)
  sin.text = c("res = mtcars.rearrange", sin.text)
  expect_error(eval(parse(tex = sin.text)))
  ## orderless
  sin.text = testmaker_df_names_sin_orderless(mtcars, return.style = "text", silent = TRUE)
  sin.text = c("res = mtcars.rearrange", sin.text)
  expect_no_error(eval(parse(text = sin.text)))
})

test_that("Testing that stopifnot name comparison orderless works properly",{
  ## orderless should fail if one or more columns is missing
  mtcars.rearrange = mtcars[,c(2:ncol(mtcars), 1)] ## create re-arrange version in base R
  sin.text = testmaker_df_names_sin_orderless(mtcars, return.style = "text", silent = TRUE)
  sin.text = c("res = mtcars.rearrange[,-1]", sin.text)
  expect_error(eval(parse(text = sin.text)))
  sin.text[1] = "res = mtcars"
  expect_no_error(eval(parse(text = sin.text)))
})

test_that("Testing that df_validator produces working validation function",{
  ## orderless should fail if one or more columns is missing
  sin.text = testmaker_df_validater(cars, return.style = "text", silent = TRUE, object.name = "res")
  ##extra fiddliness: creating a helper function dynamically, testing using mock main function
  sin.text[1] = paste0("df_check ", sin.text[1])
  eval(parse(text = sin.text))
  new_fun = function(data){df_check(data)}
  expect_no_error(new_fun(cars))
  expect_error(new_fun(mtcars))
  expect_error(new_fun(1:10))
})


test_that("Testing that df_validator produces working validation function for larger dataframe",{
  ## orderless should fail if one or more columns is missing
  sin.text = testmaker_df_validater(mtcars, return.style = "text", silent = TRUE, object.name = "res")
  ##extra fiddliness: creating a helper function dynamically, testing using mock main function
  sin.text[1] = paste0("df_check ", sin.text[1])
  eval(parse(text = sin.text))
  new_fun = function(data){df_check(data)}
  expect_no_error(new_fun(mtcars))
  expect_error(new_fun(cars))
  expect_error(new_fun(1:10))
})
