#' Generate `testthat` code to check contents of column(s) against template
#'
#' Useful for QA/QC when (a) all entries of a column should fall within a contained set (e.g. fishery columns in FRAM model outputs or manipulations
#' should only contain fishery IDs present in the FRAM database), and/or (b) when all entries of some template column should present in the output template (e.g.,
#' if processing of a FRAM model table should result in a dataframe with all fishery ids present in the
#' FRAM database). For example, in the `framrsquared` package, we may have functions in which we expect
#' the `fishery_id` column of the function output to contain only fishery_ids present in the FRAM database. Similarly,
#' we may expect that the output `fishery_id` column contains ALL of the fishery_ids present in the FRAM database.
#'
#' Depending on the number of unique variables in the column(s), this can generate very long code. This function includes comments to
#' distinguish between checking against unexpected entries and checking against missing entries.
#'
#' @inheritParams testmaker_df_tt
#' @param cols character or character vector of columns in `x`.
#'
#' @inherit testmaker_df_tt return
#' @export
#'
#' @examples
#' dat = data.frame(state.x77, state = rownames(state.x77))
#' dat$category = sample(letters[1:5], size = nrow(dat), replace = TRUE)
#' testmaker_df_colcontent_tt(dat, c("state", "category"), return.style = "none")
testmaker_df_colcontent_tt = function(x, cols, return.style = c("clip", "text", "none"), silent = FALSE){
  validate_testmaker(x, return.style, silent)
  stopifnot("`cols` must be a character or character vector" = is.character(cols))
  stopifnot("`cols` must be column names in `x`" = all(cols %in% names(x)))

  contents.vec = unlist(lapply(x[,cols, drop = FALSE], function(x) {dput_to_string(unique(x))}))
  test.text = c( "## Recreating expected entries",
                 glue::glue('entries.expect = list({vectext})',
                            vectext = glue::glue_collapse(
                              glue::glue('{cols} = {contents.vec}'),
                              sep = ",\n")),
                 "## Checking that column(s) contain no unexpected entries",
                 glue::glue('expect_true(all(unique(res${cols}) %in% entries.expect${cols}))'),
                 "## Checking that column(s) contain all expected entries",
                 glue::glue('expect_true(all(entries.expect${cols} %in% unique(res${cols})))')
  )
  finish_testmaker(test.text = test.text, return.style = return.style, silent = silent)
}

#' Helper function to convert string to R code to regenerate that string.
#'
#' @param object R object, expecting a vector
#'
#' @return Character atomic of R code to recreate the object. Plays well with `glue` functions and `cat()`.
#'
#' @examples
#' \dontrun{
#' temp = dput_to_string(rownames(mtcars))
#' cat(temp)
#' }
dput_to_string <- function(object){
  paste0(utils::capture.output(dput(object)), collapse = "\n  ")
}



