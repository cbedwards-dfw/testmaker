% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/testmaker_df_names.R
\name{testmaker_df_names_sin}
\alias{testmaker_df_names_sin}
\title{Generate \code{stopifnot} code for dataframe column names}
\usage{
testmaker_df_names_sin(
  x,
  return.style = c("clip", "text", "none"),
  silent = FALSE,
  object.name = "res"
)
}
\arguments{
\item{x}{Template dataframe of target object (e.g. we expect our test object to share properties with this)}

\item{return.style}{Designation for what to return. "clip" returns nothing, but loads the text into the clipboard.
"text" returns the text as a character vector, "none" returns nothing}

\item{silent}{Suppress printing text to console? logical; default of false.}

\item{object.name}{Name of the object to apply the stopifnot to; presumably the name of the dataframe argument}
}
\value{
Either nothing or a character vector of lines of R code for writing a stopifnot test.
}
\description{
Generate \code{stopifnot} code for dataframe column names
}
\examples{
testmaker_df_names_sin(cars, return.style = "text")
}
