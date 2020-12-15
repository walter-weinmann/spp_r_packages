# Title : package_management Objective : Package Management.
# Created by: Walter Weinma/
# +nn Created on: 16.11.2020

cran_repository <- "https://cran.r-project.org/"

# Definition of the basic packages outside sppr.
packages_basic <- c("devtools",
                    "sppr")

# Definition of the packages imported by sppr.
packages_imported <- c("dplyr",
                       "magrittr",
                       "roxygen2",
                       "RSQLite",
                       "stringr",
                       "utils")

# Definition of the other sppr packages.
packages_others <- c("assertive",
                     "data.table",
                     "DBI",
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
                     "testthat",
                     "TSstudio",
                     "xts",
                     "zoo")

# ==============================================================================
#' Create a combined and sorted character vector containing the necessary
#' package names.
#'
#' @param add_on_1 Character vector containing additional pacckage names.
#' @param add_on_2 Character vector containing additional pacckage names.
# ------------------------------------------------------------------------------

get_packages <- function(add_on_1 = vector(), add_on_2 = vector()) {
  add_ons <- append(add_on_1,
                    add_on_2,
                    after = length(add_on_1))

  sort(append(add_ons,
              packages_others,
              after = length(add_ons)))
}

# ==============================================================================
#' Install all packages relevant for sppr and show the resulting installation
#' state.
#'
#' @param library Character vector describing the location of R library
#'                trees to search through
#' @import utils
#' @export
# ------------------------------------------------------------------------------

install <- function(library = .libPaths()[1]) {
  print("1. Step: Install the required packages <=============================")

  for (package in get_packages(packages_imported)) {
    if (length(find.package(package, lib.loc = library, quiet = TRUE)) == 0) {
      install.packages(package,
                       library,
                       repos = cran_repository,
                       force = TRUE)
      print(paste("Installed package:", package, sep = " "))
    }
  }

  print("2. Step: Show the current installation state <=======================")

  show_packages(library)
}

# ==============================================================================
#' Remove packages and show the resulting installation state.
#'
#' @param library Character vector describing the location of R library
#'                trees to search through
#' @import utils
#' @export
# ------------------------------------------------------------------------------

remove <- function(library = .libPaths()[1]) {
  print("1. Step: Remove the required packages <==============================")

  for (package in get_packages()) {
    if (length(find.package(package, lib.loc = library, quiet = TRUE)) == 1) {
      remove.packages(package, library)
      print(paste("Removed package:", package, sep = " "))
    }
  }

  print("2. Step: Show the current installation state <=======================")

  show_packages(library)
}

# ==============================================================================
#' Show the status of all packages relevant for sppr.
#'
#' @param library Character vector describing the location of R library
#'                trees to search through
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
#' @param library Character vector describing the location of R library
#'                trees to search through
#' @import utils
#' @export
# ------------------------------------------------------------------------------

update <- function(library = .libPaths()[1]) {
  print("1. Step: Updata all packages <=======================================")

  update.packages(lib.loc = library,
                  repos   = cran_repository,
                  ask     = TRUE)

  print("2. Step: Show the current installation state <=======================")

  show_packages(library)
}
