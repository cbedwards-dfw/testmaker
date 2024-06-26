% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/testmaker_df_class.R
\name{testmaker_df_class_cli}
\alias{testmaker_df_class_cli}
\title{Generate \code{cli_abort} code for dataframe column classes}
\usage{
testmaker_df_class_cli(
  x,
  return.style = c("clip", "text", "none"),
  silent = FALSE,
  object.name = "res",
  for.fun = FALSE
)
}
\arguments{
\item{x}{Template dataframe of target object (e.g. we expect our test object to share properties with this)}

\item{return.style}{Designation for what to return. "clip" returns nothing, but loads the text into the clipboard.
"text" returns the text as a character vector, "none" returns nothing}

\item{silent}{Suppress printing text to console? logical; default of false.}

\item{object.name}{Name of the object to apply the stopifnot to; presumably the name of the dataframe argument}

\item{for.fun}{Is the resulting text meant to be inserted into a helper function?
If \code{TRUE}, adds in support for correctly identifying the argument name and function name
based on have arguments \code{arg = rlang::caller_arg(x)} and \code{call = rlang::caller_env()} in the helper function.}
}
\value{
Either nothing or a character vector of lines of R code for writing a stopifnot test.
}
\description{
Generate \code{cli_abort} code for dataframe column classes
}
\examples{
testmaker_df_class_cli(cars, return.style = "text")
}
