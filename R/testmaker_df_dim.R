#' Generate `testthat` code for dataframe dimensions
#'
#' From a provided template data frame, generates testthat code to check that the nrow and ncols of the `res` dataframe match
#' the dimensions of the template data frame. Default behavior loads the code into the clipboard for easy pasting into code.
#'
#' @inheritParams testmaker_df_tt
#'
#' @inherit testmaker_df_tt return
#' @export
#'
#' @examples
#' testmaker_df_dim_tt(cars, return = "none")
testmaker_df_dim_tt = function(x,  return.style = c("clip", "text", "none"), silent = FALSE){

  validate_testmaker(x, return.style, silent)

  cur.dim = dim(x)
  test.text = glue::glue('expect_equal({dimfun}(res), {cur.dim})',dimfun = c("nrow", "ncol"))

  finish_testmaker(test.text = test.text, return.style = return.style, silent = silent)

}

#' Generate `stopifnot` code for dataframe dimensions
#'
#' @inheritParams testmaker_df_sin
#'
#' @return Either nothing or a character vector of lines of R code for writing a stopifnot test.
#' @export
#'
#' @examples
#' testmaker_df_dim_sin(cars, return.style = "text")
testmaker_df_dim_sin = function(x,  return.style = c("clip", "text", "none"), silent = FALSE, object.name = "res"){

  validate_testmaker(x, return.style, silent, object.name)

  cur.dim = dim(x)
  test.text = glue::glue('stopifnot("Number of {dim.labels} in `{object.name}` is not {cur.dim}" = {dim.fun}({object.name}) == {cur.dim})',
                         dim.fun = c("nrow", "ncol"),
                         dim.labels = c("rows", "columns"))
  # test.text = paste0('stopifnot(', c("nrow", "ncol"), '(', object.name, ') == ', res, ')')

  finish_testmaker(test.text = test.text, return.style = return.style, silent = silent)

}

#' Generate `cli_abort` code for dataframe dimensions
#'
#' @inheritParams testmaker_df_sin
#'
#' @return Either nothing or a character vector of lines of R code for writing a stopifnot test.
#' @export
#'
#' @examples
#' testmaker_df_dim_cli(cars, return.style = "text")
#'
testmaker_df_dim_cli = function(x,  return.style = c("clip", "text", "none"), silent = FALSE, object.name = "res"){

  validate_testmaker(x, return.style, silent, object.name)

  cur.dim = dim(x)
  dim.fun = c("nrow", "ncol")

  text.if = glue::glue('if({dim.fun}({object.name}) != {cur.dim})')
  text.alert = glue::glue('cli::cli_abort(glue::glue("Number of {dim.labels} does not match expectation. Expected {cur.dim}, found {{val}}!",
                          val = {dim.fun}({object.name})))',
                    dim.labels = c("rows", "columns"))
  test.text = glue::glue("{text.if}{{\n  {text.alert}\n}}")
  test.text = paste0(as.character(test.text), collapse = "\n")

  finish_testmaker(test.text = test.text, return.style = return.style, silent = silent)

}
