
#' Validation function for testmaker functions
#'
#' Internal helper function to streamline validation
#'
#' @inheritParams testmaker_df_dim_tt
#' @param return.style Defines what is returned by testmaker functions. SHOULD be "clip", "text", or "none"
#' @param object.name Name of the object to apply the stopifnot to; presumably the name of the dataframe argument
#' in the function the test is being written for. Defaults to NULL; provide when validating a stopifnot_* function.
#'
#'
#'
validate_testmaker = function(x, return.style, silent, object.name = NULL, call = rlang::caller_env()){
  if(!is.data.frame(x)){
    abort.var = class(x)
    cli::cli_abort('`x` must be a dataframe, but is {abort.var}.', call = call)
  }
  if(!is.logical(silent)){
    abort.var = class(silent)
    cli::cli_abort('`silent` must be logical, but is {abort.var}.', call = call)
  }
  if(!return.style[1] %in% c("clip", "text", "none")){
    cli::cli_abort('`return.style` must be "clip", "text" or "none", but is {return.style}', call = call)
  }
  if(!is.null(object.name) & !is.character(object.name)){
    abort.var = class(object.name)
    cli::cli_abort("`object.name` must be a character string, but is {abort.var}.", call = call)
  }
  if(!is.null(object.name) & length(object.name)!=1){
    abort.var = length(object.name)
    cli::cli_abort("`object.name` must have length 1, but is {abort.var}.", call = call)
  }
}


#' Handle the standardized return options for all stopifnotmaker and testmaker functions
#'
#' Internal helper function.
#'
#' @inheritParams testmaker_df_dim_tt
#' @param test.text Character vector of the finished lines of codes to display or provide as appropriate.
#'
#' @inherit testmaker_df_dim_tt return
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
