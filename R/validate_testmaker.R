
#' Validation function for testmaker functions
#'
#' Internal helper function to streamline validation
#'
#' @inheritParams testmaker_df_dim
#' @param return.style Defines what is returned by testmaker functions. SHOULD be "clip", "text", or "none"
#' @param object.name Name of the object to apply the stopifnot to; presumably the name of the dataframe argument
#' in the function the test is being written for. Defaults to NULL; provide when validating a stopifnot_* function.
#'
#'
#'
validate_testmaker = function(x, return.style, silent, object.name = NULL){
  stopifnot("x must be a dataframe" = is.data.frame(x))
  stopifnot("`silent must be logical" = is.logical(silent))
  if(!return.style[1] %in% c("clip", "text", "none")){
    cli::cli_abort('`return.style` must be "clip", "text" or "none"')
  }
  if(!is.null(object.name) & !is.character(object.name)){
    cli::cli_abort("`object.name` must be a character string")
  }
  if(!is.null(object.name) & length(object.name)!=1){
    cli::cli_abort("`object.name` must have length 1")
  }
}


#' Handle the standardized return options for all stopifnotmaker and testmaker functions
#'
#' Internal helper function.
#'
#' @inheritParams testmaker_df_dim
#' @param test.text Character vector of the finished lines of codes to display or provide as appropriate.
#'
#' @inherit testmaker_df_dim return
#'
finish_testmaker = function(test.text, return.style, silent){
  if(!silent){
    cat(test.text, sep = "\n")
  }
  if(return.style[1] == "clip"){
    clipr::write_clip(test.text)
  }else if(return.style[1] == "text"){
    return(test.text)
  }
}
