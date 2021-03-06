#' Best practices for exporting adverb-wrapped functions
#'
#' @description
#'
#' Functions like [insistently()], [safely()], [slowly()], and
#' [quietly()] help resolve challenging issues in programming. For
#' example, [safely()] modifies a function to return both an error and
#' a result. These functions work by returning an enhanced version of
#' the original function. They are often called **adverb** functions
#' and are typically named with an informative prefix such as `safe_`
#' or `insist_.` For instance, an insistent variant of `scrape_data()`
#' created with `insistently()` might be called `insist_scrape_data()`.
#'
#' Exporting functions created with purrr adverbs in your package
#' requires some precautions. Because the functions created by adverbs
#' contain internal purrr code, creating them once and for all when
#' the package is built might cause problems when purrr is
#' updated. Instead, the function must be created by the purrr adverb
#' each time the package is loaded in memory via the [.onLoad()] hook
#' of the package. This prevents the generated functions to contain
#' outdated internal purrr code (which could even refer to functions
#' that no longer exist in the purrr namespace).
#'
#' An example if provided below for `insist`, but it would be very
#' similar for functions generated by other adverbs.
#'
#' ```
#' #' My function
#  '#' @export
#' insist_my_function <- function(...) "dummy"
#'
#' my_function <- function(...) {
#'   # Implementation
#' }
#'
#' .onLoad <- function(lib, pkg) {
#'   insist_my_function <<- purrr::insistently(my_function)
#' }
#'```
#'
#' @name faq-adverbs-export
NULL
