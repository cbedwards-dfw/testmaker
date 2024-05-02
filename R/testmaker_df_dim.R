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

#' **Deprecated** Generate `stopifnot` code for dataframe dimensions
#'
#' @inheritParams testmaker_df_sin
#'
#' @return Either nothing or a character vector of lines of R code for writing a stopifnot test.
#'
#' @examples
#' testmaker_df_dim_sin(cars, return.style = "text")
testmaker_df_dim_sin = function(x,  return.style = c("clip", "text", "none"), silent = FALSE, object.name = "res"){

  validate_testmaker(x, return.style, silent, object.name)

  cur.dim = dim(x)
  test.text = glue::glue('stopifnot("Number of {dim.labels} in `{object.name}` must be {cur.dim}" = {dim.fun}({object.name}) == {cur.dim})',
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
testmaker_df_dim_cli = function(x,  return.style = c("clip", "text", "none"), silent = FALSE, object.name = "res", for.fun = FALSE){

  validate_testmaker(x = x, return.style = return.style, silent = silent, object.name = object.name)

  cur.dim = dim(x)
  dim.fun = c("nrow", "ncol")

  #logic to support including this in a helper function
  abort.args = ifelse(for.fun,', call = call' ,'')
  object.name.text = ifelse(for.fun, '{arg}', object.name)

  text.if = glue::glue('if({dim.fun}({object.name}) != {cur.dim})')
  text.alert = glue::glue("abort.val = {dim.fun}({object.name})\n",
                          'cli::cli_abort("Number of {dim.labels} in `{object.name.text}` must be {cur.dim}, but is {{abort.val}}."{abort.args})',
                    dim.labels = c("rows", "columns"))
  test.text = glue::glue("{text.if}{{\n  {text.alert}\n}}")
  test.text = paste0(as.character(test.text), collapse = "\n")

  finish_testmaker(test.text = test.text, return.style = return.style, silent = silent)

}
