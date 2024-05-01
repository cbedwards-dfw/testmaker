#' Workhorse function to generate `stopifnot` tests for dataframe inputs
#'
#' Generates R code to test expectations based on a template database. Intended workflow:
#' when writing functions to work with a dataframe with a specific expected structure,
#' load an example of that dataframe into the environment and then call `testmaker_df(exampledataframe)`.
#' This will print `stopifnot(...)` function calls based on the dimensions of the example data frame, the classes
#' of the columns, and the names of the columns. Note that this is not intended to replace decision-making, but rather
#' to streamline the process of generating the relevant code. In particular, testing the number of rows is often not appropriate
#' (e.g., in many use cases the input data frame is expected to have unknown nrow).
#'
#' @inheritParams testmaker_df
#' @param object.name Name of the object to apply the stopifnot to; presumably the name of the dataframe argument
#' @param col.order.matters When we generate code to test for column names, should we test for exact equivalence (`TRUE`), or just the presence of all the same column names (`FALSE`)?. Logical, defaults to TRUE
#'
#' @inherit testmaker_df return
#' @export
#'
#' @examples
#' \dontrun{
#' stopifnotmaker(cars)
#' }
stopifnotmaker_df = function(x, return.style = c("clip", "text", "none"), silent = FALSE, object.name = "res", col.order.matters = TRUE){
  validate_testmaker(x, return.style, silent, object.name)


  test.text = c(stopifnotmaker_df_dim(x, return.style = "text", silent = TRUE, object.name),
                stopifnotmaker_df_class(x, return.style = "text", silent = TRUE, object.name))

  if(col.order.matters){
    test.text = c(test.text,
                  stopifnotmaker_df_names(x, return.style = "text", silent = TRUE, object.name))
  }else{
    test.text = c(test.text,
                  stopifnotmaker_df_names_orderless(x, return.style = "text", silent = TRUE, object.name))
  }

  finish_testmaker(test.text = test.text, return.style = return.style, silent = silent)
}
