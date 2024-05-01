#' Workhorse function to generate `testthat` tests for dataframe inputs
#'
#' Generates R code to test expectations based on a template database. Intended workflow:
#' when writing functions to work with a dataframe with a specific expected structure,
#' load an example of that dataframe into the environment and then call `testmaker_df_tt(exampledataframe)`.
#' This will print `testthat::expect_*()`function calls based on the dimensions of the example data frame, the classes
#' of the columns, and the names of the columns. Note that this is not intended to replace decision-making, but rather
#' to streamline the process of generating the relevant code. In particular, testing the number of rows is often not appropriate
#' (e.g., in many use cases the input data frame is expected to have unknown nrow).
#'
#' @param x Template dataframe of target object (e.g. we expect our test object to share properties with this)
#' @param return.style Designation for what to return. "clip" returns nothing, but loads the text into the clipboard.
#' "text" returns the text as a character vector, "none" returns nothing
#' @param silent Suppress printing text to console? logical; default of false.
#'
#' @return Either nothing or a character vector of lines of R code for writing a testthat test, depending on `return.style`.
#' @export
#'
#' @examples
#' \dontrun{
#' testmaker_df(cars)
#' }
testmaker_df_tt = function(x, return.style = c("clip", "text", "none"), silent = FALSE){
  validate_testmaker(x, return.style, silent)

  test.text = c(testmaker_df_dim_tt(x, return.style = "text", silent = TRUE),
                testmaker_df_class_tt(x, return.style = "text", silent = TRUE),
                testmaker_df_names_tt(x, return.style = "text", silent = TRUE)

  )

  finish_testmaker(test.text = test.text, return.style = return.style, silent = silent)
}


#' Workhorse function to generate `stopifnot` tests for dataframe inputs
#'
#' Generates R code to test expectations based on a template database. Intended workflow:
#' when writing functions to work with a dataframe with a specific expected structure,
#' load an example of that dataframe into the environment and then call `testmaker_df_sin(exampledataframe)`.
#' This will print `stopifnot(...)` function calls based on the dimensions of the example data frame, the classes
#' of the columns, and the names of the columns. Note that this is not intended to replace decision-making, but rather
#' to streamline the process of generating the relevant code. In particular, testing the number of rows is often not appropriate
#' (e.g., in many use cases the input data frame is expected to have unknown nrow).
#'
#' @inheritParams testmaker_df_tt
#' @param object.name Name of the object to apply the stopifnot to; presumably the name of the dataframe argument
#' @param col.order.matters When we generate code to test for column names, should we test for exact equivalence (`TRUE`), or just the presence of all the same column names (`FALSE`)?. Logical, defaults to TRUE
#'
#' @inherit testmaker_df_tt return
#' @export
#'
#' @examples
#' \dontrun{
#' stopifnotmaker(cars)
#' }
testmaker_df_sin = function(x, return.style = c("clip", "text", "none"), silent = FALSE, object.name = "res", col.order.matters = TRUE){
  validate_testmaker(x, return.style, silent, object.name)


  test.text = c(testmaker_df_dim_sin(x, return.style = "text", silent = TRUE, object.name),
                testmaker_df_class_sin(x, return.style = "text", silent = TRUE, object.name))

  if(col.order.matters){
    test.text = c(test.text,
                  testmaker_df_names_sin(x, return.style = "text", silent = TRUE, object.name))
  }else{
    test.text = c(test.text,
                  testmaker_df_names_sin_orderless(x, return.style = "text", silent = TRUE, object.name))
  }

  finish_testmaker(test.text = test.text, return.style = return.style, silent = silent)
}


#' Workhorse function to generate `cli_abort` tests for dataframe inputs
#'
#' Generates R code to test expectations based on a template database. Intended workflow:
#' when writing functions to work with a dataframe with a specific expected structure,
#' load an example of that dataframe into the environment and then call `testmaker_df(exampledataframe)`.
#' This will print if statements and `cli::cli_abort(...)` function calls based on the dimensions of the example data frame, the classes
#' of the columns, and the names of the columns. Note that this is not intended to replace decision-making, but rather
#' to streamline the process of generating the relevant code. In particular, testing the number of rows is often not appropriate
#' (e.g., in many use cases the input data frame is expected to have unknown nrow).
#'
#' @inheritParams testmaker_df_sin
#' @param col.order.matters When we generate code to test for column names, should we test for exact equivalence (`TRUE`), or just the presence of all the same column names (`FALSE`)?. Logical, defaults to TRUE. `FALSE` LOGIC IS NOT CURRENTLY IMPLEMENTED!
#'
#' @inherit testmaker_df_tt return
#' @export
#'
#' @examples
#' \dontrun{
#' stopifnotmaker(cars)
#' }
testmaker_df_cli = function(x, return.style = c("clip", "text", "none"), silent = FALSE, object.name = "res", col.order.matters = TRUE){
  validate_testmaker(x, return.style, silent, object.name)


  test.text = c(testmaker_df_dim_cli(x, return.style = "text", silent = TRUE, object.name),
                testmaker_df_class_cli(x, return.style = "text", silent = TRUE, object.name))

  if(col.order.matters){
    test.text = c(test.text,
                  testmaker_df_names_cli(x, return.style = "text", silent = TRUE, object.name))
  }else{
    # test.text = c(test.text,
                  # testmaker_df_names_sin_orderless(x, return.style = "text", silent = TRUE, object.name))
  }

  finish_testmaker(test.text = test.text, return.style = return.style, silent = silent)
}
