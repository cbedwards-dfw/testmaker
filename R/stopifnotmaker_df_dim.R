#' Generate `stopifnot` code for dataframe dimensions
#'
#' @inheritParams stopifnotmaker_df
#' @param object.name Name of the object to apply the stopifnot to; presumably the name of the dataframe argument
#' in the function the test is being written for. Character string; default "res".
#'
#' @return Either nothing or a character vector of lines of R code for writing a stopifnot test.
#' @export
#'
#' @examples
#' stopifnotmaker_df_dim(cars, return.style = "text")
stopifnotmaker_df_dim =function(x,  return.style = c("clip", "text", "none"), silent = FALSE, object.name = "res"){
  validate_testmaker(x, return.style, silent, object.name)

  res = dim(x)
  test.text = paste0('stopifnot(', c("nrow", "ncol"), '(', object.name, ') == ', res, ')')

  finish_testmaker(test.text = test.text, return.style = return.style, silent = silent)
}
