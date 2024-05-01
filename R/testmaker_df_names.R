

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


#' Generate `stopifnot` code for dataframe column names disregarding order
#'
#' @inheritParams testmaker_df_class_sin
#'
#' @inherit testmaker_df_class_sin return
#' @export
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
