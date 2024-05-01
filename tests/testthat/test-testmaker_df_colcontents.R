test_that("testmaker_df_colcontents succeeds when expected to",{
  dat = data.frame(state.x77, state = rownames(state.x77))
  dat$category = sample(letters[1:5], size = nrow(dat), replace = TRUE)
  tt.text = testmaker_df_colcontent_tt(dat, c("state", "category"), return.style = "text", silent = TRUE)
  tt.text = c("res = dat", tt.text)
  expect_no_error(eval(parse(text = tt.text)))

  sin.text = testmaker_df_colcontent_sin(dat, c("state", "category"), return.style = "text", silent = TRUE)
  sin.text = c("res = dat", sin.text)
  expect_no_error(eval(parse(text = sin.text)))
})


test_that("testmaker_df_colcontents generates errors when expected to",{
  dat = data.frame(state.x77, state = rownames(state.x77))
  dat$category = sample(letters[1:5], size = nrow(dat), replace = TRUE)
  res = dat
  tt.text = testmaker_df_colcontent_tt(res, c("state", "category"), return.style = "text", silent = TRUE)
  res$state[1:5] =NA
  expect_error(eval(parse(text = tt.text)))

  sin.text = testmaker_df_colcontent_sin(dat, c("state", "category"), return.style = "text", silent = TRUE, object.name = "res")
  res = dat[-1,]
  expect_error(eval(parse(text = sin.text)), "Missing expected value")

  sin.text = testmaker_df_colcontent_sin(dat, c("state", "category"), return.style = "text", silent = TRUE, object.name = "res")

  res = rbind(dat[1,], dat)
  res$state[1] = "BC"
  expect_error(eval(parse(text = sin.text)), "Unexpected value in")
})


