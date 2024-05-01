#' Generate testthat code for dataframe column classes
#'
#' @inheritParams testmaker_df_dim_tt
#'
#' @inherit testmaker_df_dim_tt return
#' @export
#'
#' @examples
#' testmaker_df_class_tt(cars, return.style = "text")
testmaker_df_class_tt = function(x,  return.style = c("clip", "text", "none"), silent = FALSE){
  validate_testmaker(x, return.style, silent)

  class.list = lapply(x, typeof)
  # test.text = paste0('expect_type(res$', names(res), ', "', unlist(res), '")')
  test.text = glue::glue('expect_type(res${names(class.list)}, "{unlist(class.list)}")')

  finish_testmaker(test.text = test.text, return.style = return.style, silent = silent)
}


#' Generate `stopifnot` code for dataframe column classes
#'
#' @inheritParams testmaker_df_dim_sin
#'
#' @inherit testmaker_df_dim_sin return
#' @export
#'
#' @examples
#' testmaker_df_class_sin(cars, return.style = "text")
testmaker_df_class_sin = function(x,  return.style = c("clip", "text", "none"), silent = FALSE, object.name = "res"){
  validate_testmaker(x, return.style, silent, object.name)

  cur.type = lapply(x, typeof)
  test.text = glue::glue('stopifnot("In `{object.name}`, type of column `{names(cur.type)}` is not {cur.type}" = typeof({object.name}${names(cur.type)}) == "{cur.type}")')
  # test.text = paste0('stopifnot(typeof(', object.name, '$', names(x), ') == "', unlist(res), '")')

  finish_testmaker(test.text = test.text, return.style = return.style, silent = silent)
}


#' Generate `cli_abort` code for dataframe column classes
#'
#' @inheritParams testmaker_df_dim_cli
#'
#' @inherit testmaker_df_dim_cli return
#' @export
#'
#' @examples
#' testmaker_df_class_cli(cars, return.style = "text")

testmaker_df_class_cli = function(x,  return.style = c("clip", "text", "none"), silent = FALSE, object.name = "res"){
  validate_testmaker(x, return.style, silent, object.name)

  cur.type = lapply(x, typeof)
  test.text = glue::glue('stopifnot("In `{object.name}`, type of column `{names(cur.type)}` is not {cur.type}" = typeof({object.name}${names(cur.type)}) == "{cur.type}")')
  # test.text = paste0('stopifnot(typeof(', object.name, '$', names(x), ') == "', unlist(res), '")')
  #
  text.if = glue::glue('if(typeof({object.name}${names(cur.type)}) != "{cur.type}")')
  text.alert = glue::glue('cli::cli_abort(glue::glue("Expect type of `{object.name}${names(cur.type)}` to be {cur.type}, but is {{val}}!",
                          val = typeof({object.name}${names(cur.type)})))')
  test.text = glue::glue("{text.if}{{\n  {text.alert}\n}}")
  test.text = paste0(as.character(test.text), collapse = "\n")

  finish_testmaker(test.text = test.text, return.style = return.style, silent = silent)
}
