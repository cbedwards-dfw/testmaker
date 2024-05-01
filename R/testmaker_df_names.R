

#' Generate `testthat` code for dataframe column names
#'
#' @inheritParams testmaker_df_dim
#'
#' @inherit testmaker_df_dim return
#' @export
#'
#' @examples
#' testmaker_df_names(cars, return.style = "text")

testmaker_df_names = function(x,  return.style = c("clip", "text", "none"), silent = FALSE){
  validate_testmaker(x, return.style, silent)

  test.text = paste0('expect_equal(names(res), c(', paste0(paste0('"', names(x), '"'), collapse = ", "), '))')

  finish_testmaker(test.text = test.text, return.style = return.style, silent = silent)
}
