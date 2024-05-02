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

  class.list = lapply(x, class)
  # test.text = paste0('expect_type(res$', names(res), ', "', unlist(res), '")')
  test.text = glue::glue('expect_equal(class(res${names(class.list)}), "{unlist(class.list)}")')

  finish_testmaker(test.text = test.text, return.style = return.style, silent = silent)
}


#' **DEPRECATED** Generate `stopifnot` code for dataframe column classes
#'
#' @inheritParams testmaker_df_dim_sin
#'
#' @inherit testmaker_df_dim_sin return
#'
#' @examples
#' testmaker_df_class_sin(cars, return.style = "text")
testmaker_df_class_sin = function(x,  return.style = c("clip", "text", "none"), silent = FALSE, object.name = "res"){
  validate_testmaker(x, return.style, silent, object.name)

  cur.type = lapply(x, class)
  test.text = glue::glue('stopifnot("In `{object.name}`, type of column `{names(cur.type)}` is not {cur.type}" = class({object.name}${names(cur.type)}) == "{cur.type}")')
  # test.text = paste0('stopifnot(class(', object.name, '$', names(x), ') == "', unlist(res), '")')

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

testmaker_df_class_cli = function(x,  return.style = c("clip", "text", "none"), silent = FALSE, object.name = "res", for.fun = FALSE){
  validate_testmaker(x, return.style, silent, object.name)

  abort.args = ifelse(for.fun,', call = call' ,'')
  object.name.text = ifelse(for.fun, '{arg}', object.name)

  cur.type = lapply(x, class)
  text.precursor = c('test.df = rbind( ## if individual column classes don\'t matter, delete their entries below',
                              paste0(as.character(glue::glue('  data.frame(name = "{names(cur.type)}", correct = "{cur.type}", cur = class({object.name}${names(cur.type)}))')), collapse =",\n"),
                     ')',
                     'test.vec = test.df$correct != test.df$cur')
  finish_testmaker(test.text = text.precursor, return.style = return.style, silent = silent)
  text.if = 'if(any(test.vec))'
  text.alert = glue::glue('cli::cli_abort(c("`{object.name.text}` must have appropriate column classes.",\n',
                          'glue::glue(\'Column `{{test.df$name[test.vec]}}` must be of class "{{test.df$correct[test.vec]}}" but is class "{{test.df$cur[test.vec]}}".\')){abort.args}\n',
                          ')')
  test.text = c(text.precursor, glue::glue("{text.if}{{\n  {text.alert}\n}}"))
  test.text = paste0(as.character(test.text), collapse = "\n")
  finish_testmaker(test.text = test.text, return.style = return.style, silent = silent)
}
