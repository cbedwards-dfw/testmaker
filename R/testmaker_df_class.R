#' Generate testthat code for dataframe column classes
#'
#' @inheritParams testmaker_df_dim
#'
#' @inherit testmaker_df_dim return
#' @export
#'
#' @examples
#' testmaker_df_class(cars, return.style = "text")
testmaker_df_class = function(x,  return.style = c("clip", "text", "none"), silent = FALSE){
  validate_testmaker(x, return.style, silent)

  res = lapply(x, class)
  test.text = paste0('expect_type(res$', names(res), ', "', unlist(res), '")')

  finish_testmaker(test.text = test.text, return.style = return.style, silent = silent)
}
