#' Generate testthat code for dataframe dimensions
#'
#' From a provided template data frame, generates testthat code to check that the nrow and ncols of the `res` dataframe match
#' the dimensions of the template data frame. Default behavior loads the code into the clipboard for easy pasting into code.
#'
#' @param x Template dataframe of target object (e.g. we expect our test object to share properties with this)
#' @param return.style Designation for what to return. "clip" returns nothing, but loads the text into the clipboard.
#' "text" returns the text as a character vector, "none" returns nothing
#' @param silent Suppress printing text to console? logical; default of false.
#'
#' @return Either nothing or a character vector of lines of R code for writing a testthat test.
#' @export
#'
#' @examples
#' testmaker_df_dim(cars, return.style = "text")
testmaker_df_dim = function(x,  return.style = c("clip", "text", "none"), silent = FALSE){
  if(!return.style[1] %in% c("clip", "text", "none")){
    cli::cli_abort('`return.style` must be "clip", "text" or "none"')
  }
  res = dim(x)
  test.text = paste0('expect_equal(', c("nrow", "ncol"), '(res), ', res, '))')
  if(!silent){
    cat(test.text, sep = "\n")
  }
  if(return.style[1] == "clip"){
    clipr::write_clip(test.text)
  }else if(return.style[1] == "text"){
    return(test.text)
  }
}
