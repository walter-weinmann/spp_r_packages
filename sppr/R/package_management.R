# Title : package_management
# Objective : Package Management.
# Created by: Walter Weinmann
# Created on: 16.11.2020

cran_repository <- "https://cran.r-project.org/"

# Definition of the basic packages outside sppr.
packages_basic <- c("sppr")

# Definition of the packages imported by sppr.
packages_imported <- c("dplyr",
                       "magrittr",
                       "roxygen2",
                       "RSQLite",
                       "stringr",
                       "testthat",
                       "utils")

# Definition of the other sppr packages.
packages_others <- c("assertive",
                     "data.table",
                     "DBI",
                     "devtools",
                     "forecast",
                     "formatR",
                     "ggplot2",
                     "installr",
                     "knitr",
                     "lintr",
                     "pillar",
                     "R6",
                     "readr",
                     "rmarkdown",
                     "TSstudio",
                     "vctrs",
                     "xts",
                     "zoo")

# ==============================================================================
#' Create a combined and sorted character vector containing the necessary
#' package names.
#'
#' @param add_on_1,add_on_2 Character vectors containing additional pacckage
#'                          names. Defaults to an empty vector
# ------------------------------------------------------------------------------

get_packages <- function(add_on_1 = vector(), add_on_2 = vector()) {
  add_ons <- append(add_on_1,
                    add_on_2,
                    after = length(add_on_1))

  sort(append(add_ons,
              packages_others,
              after = length(add_ons)))

  sort(c("assertive",
         "dplyr",
         "ggplot2",
         "RSQLite"))
}

# ==============================================================================
#' Install all packages relevant for sppr and show the resulting installation
#' state.
#'
#' @param library character vector giving the library directories where to
#'                install the packages. If missing, defaults to the first
#'                element of .libPaths()
#' @param repository character vector, the base URL(s) of the repositories to
#'                   use, e.g., the URL of a CRAN mirror such as
#'                   "https://cloud.r-project.org". If missing, defaults to
#'                   "https://cran.r-project.org/"
#' @import utils
#' @export
# ------------------------------------------------------------------------------

install <- function(library = .libPaths()[1],
                    repository = cran_repository) {
  for (package in get_packages(packages_imported)) {
    if (length(find.package(package, lib.loc = library, quiet = TRUE)) == 0) {
      install.packages(package,
                       library,
                       force   = TRUE,
                       quiet   = TRUE,
                       repos   = repository,
                       verbose = FALSE)
    }
  }

  sppr::show_packages(library)
}

# ==============================================================================
#' Remove packages and show the resulting installation state.
#'
#' @param library character vector giving the library directories where to
#'                remove the packages. If missing, defaults to the first
#'                element of .libPaths()
#' @import utils
#' @export
# ------------------------------------------------------------------------------

remove <- function(library = .libPaths()[1]) {
  for (package in get_packages()) {
    if (length(find.package(package, lib.loc = library, quiet = TRUE)) == 1) {
      remove.packages(package, library)
    }
  }

  sppr::show_packages(library)
}

# ==============================================================================
#' Show the status of all packages relevant for sppr.
#'
#' @param library character vector giving the library directories where to
#'                search for the packages. If missing, defaults to the first
#'                element of .libPaths()
#' @export
# ------------------------------------------------------------------------------

show_packages <- function(library = .libPaths()[1]) {
  sapply(get_packages(packages_basic,
                      packages_imported),
         function(x) {
           x %in% installed.packages(library)
         }
  )
}

# ==============================================================================
#' Update all packages and show the resulting installation state.
#'
#' @param library character vector giving the library directories where to
#'                update the packages. If missing, defaults to the first
#'                element of .libPaths()
#' @param repository character vector, the base URL(s) of the repositories to
#'                   use, e.g., the URL of a CRAN mirror such as
#'                   "https://cloud.r-project.org". If missing, defaults to
#'                   "https://cran.r-project.org/"
#' @import utils
#' @export
# ------------------------------------------------------------------------------

update <- function(library = .libPaths()[1],
                   repository = cran_repository) {
  update.packages(lib.loc = library,
                  repos   = repository,
                  ask     = TRUE)

  sppr::show_packages(library)
}
