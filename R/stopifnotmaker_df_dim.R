

#' Title
#'
#' @inheritParams testmaker_df_dim
#' @param object.name Name of the object to apply the stopifnot to; presumably the name of the dataframe argument
#' in the function the test is being written for. Character string; default "res".
#'
#' @return Either nothing or a character vector of lines of R code for writing a stopifnot test.
#' @export
#'
#' @examples
#' stopifnotmaker_df_dim(cars, return.style = "text")
stopifnotmaker_df_dim =function(x,  return.style = c("clip", "text", "none"), silent = FALSE, object.name = "res"){
  if(!return.style[1] %in% c("clip", "text", "none")){
    cli::cli_abort('`return.style` must be "clip", "text" or "none"')
  }
  res = dim(x)
  test.text = paste0('stopfinot(', c("nrow", "ncol"), '(', object.name, ') == ', res, '))')
  if(!silent){
    cat(test.text, sep = "\n")
  }
  if(return.style[1] == "clip"){
    clipr::write_clip(test.text)
  }else if(return.style[1] == "text"){
    return(test.text)
  }
}
