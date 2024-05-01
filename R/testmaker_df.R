#' Workhorse function to generate `testthat` tests for dataframe inputs
#'
#' Generates R code to test expectations based on a template database. Intended workflow:
#' when writing functions to work with a dataframe with a specific expected structure,
#' load an example of that dataframe into the environment and then call `testmaker_df(exampledataframe)`.
#' This will print testthat::expect_* function calls based on the dimensions of the example data frame, the classes
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
testmaker_df = function(x, return.style = c("clip", "text", "none"), silent = FALSE){
  validate_testmaker(x, return.style, silent)

  test.text = c(testmaker_df_dim(x, return.style = "text", silent = TRUE),
                testmaker_df_class(x, return.style = "text", silent = TRUE),
                testmaker_df_names(x, return.style = "text", silent = TRUE)

  )

  finish_testmaker(test.text = test.text, return.style = return.style, silent = silent)
}
