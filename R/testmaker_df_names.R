

#' Generate `testthat` code for dataframe column names
#'
#' @inheritParams testmaker_df_tt
#'
#' @inherit testmaker_df_dim_tt return
#' @export
#'
#' @examples
#' testmaker_df_names_tt(cars, return.style = "text")

testmaker_df_names_tt = function(x,  return.style = c("clip", "text", "none"), silent = FALSE){
  validate_testmaker(x, return.style, silent)

  test.text = glue::glue('expect_equal(names(res), c({text.use}))',
                         text.use = glue::glue_collapse(glue::glue('"{names(x)}"'), sep = ", "))

  finish_testmaker(test.text = test.text, return.style = return.style, silent = silent)
}


#' Generate `stopifnot` code for dataframe column names
#'
#' @inheritParams testmaker_df_class_sin
#'
#' @inherit testmaker_df_class_sin return
#' @export
#'
#' @examples
#' testmaker_df_names_sin(cars, return.style = "text")

testmaker_df_names_sin = function(x,  return.style = c("clip", "text", "none"), silent = FALSE, object.name = "res"){
  validate_testmaker(x, return.style, silent, object.name)
  names.vec = glue::glue_collapse(glue::glue('"{names(x)}"'), sep = ", ")
  test.text = glue::glue('stopifnot(\'`{object.name}` column names do not match expectation.\\nShould be: c({names.vec})\' = identical(names({object.name}), c({names.vec})))')
  # test.text = paste0('stopifnot(identical(names(', object.name, '),c(', paste0(paste0('"', names(x), '"'), collapse = ", "), ')))')

  finish_testmaker(test.text = test.text, return.style = return.style, silent = silent)
}


#' **DEPRECATED** Generate `stopifnot` code for dataframe column names disregarding order
#'
#' @inheritParams testmaker_df_class_sin
#'
#' @inherit testmaker_df_class_sin return
#'
#' @examples
#' testmaker_df_names_sin(cars, return.style = "text")

testmaker_df_names_sin_orderless = function(x,  return.style = c("clip", "text", "none"), silent = FALSE, object.name = "res"){
  validate_testmaker(x, return.style, silent, object.name)

  test.text = c(glue::glue('stopifnot(\'`{object.name}` contains unexpected columns.\\n Expecting {names.list}.\' = all(names({object.name}) %in% c({names.list})))',
                           names.list = glue::glue_collapse(glue::glue('"{names(x)}"'), sep = ", ")),
                glue::glue('stopifnot(\'`{object.name}` does not contain all expected columns.\\n Expecting {names.list}.\' = all(c({names.list}) %in% names({object.name})))',
                           names.list = glue::glue_collapse(glue::glue('"{names(x)}"'), sep = ", "))
  )
  # test.text = c(paste0('stopifnot(all(names(', object.name, ') %in% c(', paste0(paste0('"', names(x), '"'), collapse = ", "), ')))'),
  #               paste0('stopifnot(all(c(', paste0(paste0('"', names(x), '"'), collapse = ", "), ') %in% names(', object.name, ')))'))

  finish_testmaker(test.text = test.text, return.style = return.style, silent = silent)
}

testmaker_df_names_cli = function(x,  return.style = c("clip", "text", "none"), silent = FALSE, object.name = "res", for.fun = FALSE){
  validate_testmaker(x, return.style, silent, object.name)

  abort.args = ifelse(for.fun,', call = call' ,'')
  object.name.text = ifelse(for.fun, '{arg}', object.name)

  names.vec = glue::glue_collapse(glue::glue('"{names(x)}"'), sep = ", ")
  # test.text = glue::glue('stopifnot(\'`{object.name}` column names do not match expectation.\\nShould be: c({names.vec})\' = identical(names({object.name}), c({names.vec})))')
  # test.text = paste0('stopifnot(identical(names(', object.name, '),c(', paste0(paste0('"', names(x), '"'), collapse = ", "), ')))')

  text.precursor = glue::glue('names.expected = {paste0(capture.output(dput(names(x))), collapse = "")}\n',
                              'names.surprising = names({object.name})[! names({object.name}) %in% names.expected]\n',
                              'names.missing = names.expected[! names.expected %in% names({object.name})]\n',
                              'names.expected.dup = names.expected[duplicated(names.expected)]\n',
                              'names.provided.dup = names({object.name})[duplicated(names({object.name}))]\n',
                              'text.use = c("One or more column names in `{object.name.text}` does not match expectations.",\n',
                              '"Missing column(s): {{ifelse(length(names.missing) == 0, \\"[none]\\", paste0(names.missing, collapse = \\", \\"))}}.",\n',
                              '"Unexpected column(s): {{ifelse(length(names.surprising) == 0, \\"[none]\\",paste0(names.surprising, collapse = \\", \\"))}}")\n',
                              'if(length(c(names.expected.dup, names.provided.dup)) != 0){{\n',
                              'text.use = c(text.use,',
                              '"!" = "Warning: there is some column name duplication.",\n',
                              'paste0("Expected duplicate names: ",\n' ,
                              'ifelse(length(names.expected.dup) == 0,\n',
                              '"[none]",\n',
                              'paste0(names.expected.dup, collapse = ", ")), "."),\n',
                              'paste0("Observed duplicate names: ",\n',
                              'ifelse(length(names.provided.dup) == 0, "[none]", paste0(names.provided.dup, collapse = ", ")), "."\n',
                              ')\n', ')\n','}}'
  )
  text.if = glue::glue('if(!identical(names({object.name}), c({names.vec})))')
  text.alert = glue::glue('cli::cli_abort(text.use{abort.args})\n')
  test.text = glue::glue('{paste0(text.precursor, collapse = "\n")}\n{text.if}{{\n{text.alert}\n}}')
  test.text = paste0(as.character(test.text), collapse = "\n")


  finish_testmaker(test.text = test.text, return.style = return.style, silent = silent)
}
