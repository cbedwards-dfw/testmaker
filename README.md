
<!-- README.md is generated from README.Rmd. Please edit that file -->

# testmaker

<!-- badges: start -->
<!-- badges: end -->

The goal of testmaker is to streamline the generation of parameter
checking and testthat test generation for dataframes, based on template
data frames. This package was inspired by a package development workshop
put on by Andy Teucher (<https://andyteucher.ca>) and Sam Albers
(<https://samalbers.science>).

When developing R code for packages, it’s valuable to write test
functions using the `testthat` framework. When writing functions for
packages and for other large projects (especially involving multiple
people or functions), it’s also valuable to write small tests to check
that provided inputs are what you intend them to be. I’m involved in
work that has a few dataframes that are used repeatedly in many
functions (either generating them or taking them in as arguments). This
package streamlines writing R code checks the basic characteristics of a
dataframe: dimensions, column names, column types. The central conceit
of this package is that as a developer you have a template dataframe
with the correct characteristics; the functions in this package identify
those characteristics, write appropriate R code to test for them, and
print that code / copy it to your system clipboard for easy adding to
your code.

## Installation

You can install the development version of testmaker like so:

``` r
devtools::install.packages(https://github.com/cbedwards-dfw/testmaker)
```

## Example

### Writing testthat tests

Let’s presume we are writing a function to aggregate data from different
sources, and we know that if the code works correctly, the final
dataframe should have the same column names and column types as the
dataframe `mtcars`. We can easily generate appropriate code for a
`testthat` test:

``` r
testmaker::testmaker_df_tt(mtcars, return.style = "none")
#> expect_equal(nrow(res), 32)
#> expect_equal(ncol(res), 11)
#> expect_type(res$mpg, "double")
#> expect_type(res$cyl, "double")
#> expect_type(res$disp, "double")
#> expect_type(res$hp, "double")
#> expect_type(res$drat, "double")
#> expect_type(res$wt, "double")
#> expect_type(res$qsec, "double")
#> expect_type(res$vs, "double")
#> expect_type(res$am, "double")
#> expect_type(res$gear, "double")
#> expect_type(res$carb, "double")
#> expect_equal(names(res), c("mpg", "cyl", "disp", "hp", "drat", "wt", "qsec", "vs", "am", "gear", "carb"))
```

Note that I specify `return.style = "none"` here because the default
behavior of saving to the clipboard behaves poorly when compiling readme
files.

Several of the generated lines may not be appropriate. For example, we
may not expect *our* data frame to have the same number of rows as
`mtcars`. The general use-case is to call the function with the default
return.style, paste into your test function, and delete any lines that
are not appropriate for your scenario. The functions of this package are
*not* intended to replace the decision-making in writing tests, merely
to reduce the typing necessary.

Individual functions for generating code to test for individual
characteristics can be called separately
(e.g. `testmaker_df_names_tt()`), but I generally find it easier to call
the primary function and just delete the generated lines I do not need.

### Checking inputs

Let’s presume we’re writing a function that takes as an input a
dataframe with the same number of columns, same column names, and same
types as `mtcars`. As an example, the following function code takes
`mtcars`-like dataframes and makes a paired plot. Perhaps we have dozens
of alternative `mtcars` type dataframes that do

``` r
foo = function(dat){
  pairs(mtcars,
        labels = c())
}
```

This function is fairly fragile – if we feed it data that doesn’t match
the columns names (in order) that we’re expecting, our labels will be
wrong. If any of the columns of our input are characters, `pairs` will
error. If we want to make this function more robust by adding in error
checks to compare the argument `dat` with the characteristics we’re
expecting, we can use `testmaker_df_sin()`

``` r
testmaker::testmaker_df_sin(mtcars, return.style = "none", object.name = "dat")
#> stopifnot(nrow(dat) == 32)
#> stopifnot(ncol(dat) == 11)
#> stopifnot(typeof(dat$mpg) == "double")
#> stopifnot(typeof(dat$cyl) == "double")
#> stopifnot(typeof(dat$disp) == "double")
#> stopifnot(typeof(dat$hp) == "double")
#> stopifnot(typeof(dat$drat) == "double")
#> stopifnot(typeof(dat$wt) == "double")
#> stopifnot(typeof(dat$qsec) == "double")
#> stopifnot(typeof(dat$vs) == "double")
#> stopifnot(typeof(dat$am) == "double")
#> stopifnot(typeof(dat$gear) == "double")
#> stopifnot(typeof(dat$carb) == "double")
#> stopifnot(identical(names(dat), c("mpg", "cyl", "disp", "hp", "drat", "wt", "qsec", "vs", "am", "gear", "carb")))
```

Here we specify the object name (or we can leave at the default, which
is “res”, and then find/replace in the new text).

## Function name conventions

Primary functions are written in the form
`testmaker_df_{output type}()`, where the output type is in abbreviated
form: `tt` refers to `testthat`, `sin` refers to `stopIfNot`, and `cli`
refers to `cli_abort`. Sub functions are written in the form
`testmaker_df_{dataframe characteristic}_{output type}()`. The inclusion
of `_df_` leaves room to develop equivalent functions for other data
types if that becomes useful.

## Dev wishlist

I intend to add the following features:

- `.*_cli()` functions that provide equivalent output to the `.*sin()`
  functions but using `cli::cli_abort()`. This would match the
  conventions used in other FRAM team packages.
- 

## Dev notes

It was suggested this could be provided in the testthat setup files:
<https://testthat.r-lib.org/articles/special-files.html>. From that: \>
Helper files live in tests/testtthat/, start with helper, and end with
.r or .R. They are sourced by devtools::load_all() (so they’re available
interactively when developing your packages) and by test_check() and
friends (so that they’re available no matter how your tests are
executed).

I will dig into how this package can easily be inserted in the the
testthat setup files, and will update documentation with instructions
when I have done so.
