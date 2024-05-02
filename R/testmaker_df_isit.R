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
testmaker_df_isit_tt = function(x,  return.style = c("clip", "text", "none"), silent = FALSE){

  validate_testmaker(x, return.style, silent)

  cur.dim = dim(x)
  test.text = glue::glue('expect_true(is.data.frame(res))')

  finish_testmaker(test.text = test.text, return.style = return.style, silent = silent)

}

testmaker_df_isit_cli = function(x,  return.style = c("clip", "text", "none"), silent = FALSE, object.name = "res", for.fun = FALSE){

  validate_testmaker(x, return.style, silent)

  abort.args = ifelse(for.fun,', call = call' ,'')
  object.name.text = ifelse(for.fun, '{arg}', object.name)

  text.if = glue::glue('if(!is.data.frame({object.name}))')
  text.alert = glue::glue("abort.val = class({object.name})\n",
                          'cli::cli_abort("`{object.name.text}` must be dataframe, but is {{abort.val}}."{abort.args})')
  test.text = glue::glue("{text.if}{{\n  {text.alert}\n}}")
  test.text = paste0(as.character(test.text), collapse = "\n")

  finish_testmaker(test.text = test.text, return.style = return.style, silent = silent)

}
