# Title : sppr_utils Objective : Utility functionality.
# Created by: Walter Weinma/
# +nn Created on: 16.11.2020

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
              packages_others(),
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

  for (package in get_packages(packages_imported())) {
    if (length(find.package(package, lib.loc = library, quiet = TRUE)) == 0) {
      install.packages(package,
                       library,
                       repos = "https://cran.r-project.org/",
                       force = TRUE)
      print(paste("Installed package:", package, sep = " "))
    }
  }

  print("2. Step: Show the current installation state <=======================")

  show_specific(library)
}

# ==============================================================================
#' Definition of the sppr packages: basic packages.
# ------------------------------------------------------------------------------

packages_basic <- function() {
  c("devtools",
    "sppr")
}

# ==============================================================================
#' Definition of the sppr packages: imported packages.
# ------------------------------------------------------------------------------

packages_imported <- function() {
  c("dplyr",
    "magrittr",
    "roxygen2",
    "RSQLite",
    "stringr",
    "utils")
}

# ==============================================================================
#' Definition of the sppr packages: other packages.
# ------------------------------------------------------------------------------

packages_others <- function() {
  c("assertive",
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

  show_specific(library)
}

# ==============================================================================
#' Show the status of all packages relevant for sppr.
#'
#' @param library Character vector describing the location of R library
#'                trees to search through
#' @export
# ------------------------------------------------------------------------------

show_specific <- function(library = .libPaths()[1]) {
  sapply(get_packages(packages_basic(),
                      packages_imported()),
         function(x) {
           x %in% installed.packages(library)
         }
  )
}
