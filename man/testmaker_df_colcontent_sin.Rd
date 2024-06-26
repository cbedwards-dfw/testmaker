% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/testmaker_df_colcontents.R
\name{testmaker_df_colcontent_sin}
\alias{testmaker_df_colcontent_sin}
\title{\strong{DEPRECATED} Generate \code{stopifnot} code to check contents of column(s) against template}
\usage{
testmaker_df_colcontent_sin(
  x,
  cols,
  return.style = c("clip", "text", "none"),
  silent = FALSE,
  object.name = "res"
)
}
\arguments{
\item{x}{Template dataframe of target object (e.g. we expect our test object to share properties with this)}

\item{cols}{character or character vector of columns in \code{x}.}

\item{return.style}{Designation for what to return. "clip" returns nothing, but loads the text into the clipboard.
"text" returns the text as a character vector, "none" returns nothing}

\item{silent}{Suppress printing text to console? logical; default of false.}

\item{object.name}{Name of the object to apply the stopifnot to; presumably the name of the dataframe argument}
}
\value{
Either nothing or a character vector of lines of R code for writing a testthat test, depending on \code{return.style}.
}
\description{
\strong{DEPRECATED} Generate \code{stopifnot} code to check contents of column(s) against template
}
