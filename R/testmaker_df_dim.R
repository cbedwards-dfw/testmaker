#' Generate `testthat` code for dataframe dimensions
#'
#' From a provided template data frame, generates testthat code to check that the nrow and ncols of the `res` dataframe match
#' the dimensions of the template data frame. Default behavior loads the code into the clipboard for easy pasting into code.
#'
#' @inheritParams testmaker_df
#'
#' @inherit testmaker_df return
#' @export
#'
#' @examples
#' testmaker_df_dim(cars, return = "text")
testmaker_df_dim = function(x,  return.style = c("clip", "text", "none"), silent = FALSE){
  validate_testmaker(x, return.style, silent)

  res = dim(x)
  test.text = paste0('expect_equal(', c("nrow", "ncol"), '(res), ', res, '))')

  finish_testmaker(test.text = test.text, return.style = return.style, silent = silent)
}
