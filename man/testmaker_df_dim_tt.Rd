% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/testmaker_df_dim.R
\name{testmaker_df_dim_tt}
\alias{testmaker_df_dim_tt}
\title{Generate \code{testthat} code for dataframe dimensions}
\usage{
testmaker_df_dim_tt(
  x,
  return.style = c("clip", "text", "none"),
  silent = FALSE
)
}
\arguments{
\item{x}{Template dataframe of target object (e.g. we expect our test object to share properties with this)}

\item{return.style}{Designation for what to return. "clip" returns nothing, but loads the text into the clipboard.
"text" returns the text as a character vector, "none" returns nothing}

\item{silent}{Suppress printing text to console? logical; default of false.}
}
\value{
Either nothing or a character vector of lines of R code for writing a testthat test, depending on \code{return.style}.
}
\description{
From a provided template data frame, generates testthat code to check that the nrow and ncols of the \code{res} dataframe match
the dimensions of the template data frame. Default behavior loads the code into the clipboard for easy pasting into code.
}
\examples{
testmaker_df_dim_tt(cars, return = "none")
}
