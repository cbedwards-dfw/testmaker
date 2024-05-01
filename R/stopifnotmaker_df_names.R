#' Generate `stopifnot` code for dataframe column names
#'
#' @inheritParams stopifnotmaker_df_class
#'
#' @inherit stopifnotmaker_df_class return
#' @export
#'
#' @examples
#' stopifnotmaker_df_names(cars, return.style = "text")

stopifnotmaker_df_names = function(x,  return.style = c("clip", "text", "none"), silent = FALSE, object.name = "res"){
  validate_testmaker(x, return.style, silent, object.name)

  test.text = paste0('stopifnot(identical(names(', object.name, '),c(', paste0(paste0('"', names(x), '"'), collapse = ", "), ')))')

  finish_testmaker(test.text = test.text, return.style = return.style, silent = silent)
}



#' Generate `stopifnot` code for dataframe column names disregarding order
#'
#' @inheritParams stopifnotmaker_df_class
#'
#' @inherit stopifnotmaker_df_class return
#' @export
#'
#' @examples
#' stopifnotmaker_df_names(cars, return.style = "text")

stopifnotmaker_df_names_orderless = function(x,  return.style = c("clip", "text", "none"), silent = FALSE, object.name = "res"){
  validate_testmaker(x, return.style, silent, object.name)

  test.text = c(paste0('stopifnot(all(names(', object.name, ') %in% c(', paste0(paste0('"', names(x), '"'), collapse = ", "), ')))'),
                paste0('stopifnot(all(c(', paste0(paste0('"', names(x), '"'), collapse = ", "), ') %in% names(', object.name, ')))'))

  finish_testmaker(test.text = test.text, return.style = return.style, silent = silent)
}
