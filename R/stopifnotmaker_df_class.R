#' Generate `stopifnot` code for dataframe column classes
#'
#' @inheritParams stopifnotmaker_df_dim
#'
#' @inherit stopifnotmaker_df_dim return
#' @export
#'
#' @examples
#' stopifnotmaker_df_class(cars, return.style = "text")
stopifnotmaker_df_class = function(x,  return.style = c("clip", "text", "none"), silent = FALSE, object.name = "res"){
  validate_testmaker(x, return.style, silent, object.name)

  res = lapply(x, class)
  test.text = paste0('stopifnot(class(', object.name, '$', names(x), ') == "', unlist(res), '")')

  finish_testmaker(test.text = test.text, return.style = return.style, silent = silent)
}
