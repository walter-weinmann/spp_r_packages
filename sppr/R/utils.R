# Title : sppr_utils Objective : Utility functionality.
# Created by: Walter Weinma/
# +nn Created on: 16.11.2020

# ==============================================================================
#' Install and initialize the package packrat.
#'
#' @import packrat
#' @import utils
#' @export
# ------------------------------------------------------------------------------

init_packrat <- function() {
  print("1. Step: Install the packrat package <===============================")

  if (!"packrat" %in% installed.packages()) {
    install.packages("packrat",
                     repos = "https://cran.r-project.org/")
    print("Installed package: packrat")
  }

  print("2. Step: Initialize packrat <========================================")

  packrat::init()

  print("3. Step: Terminate R <===============================================")

  quit(save = "no")
}

# ==============================================================================
#' Install the required packages and show the current installation state.
#'
#' @import utils
#' @export
# ------------------------------------------------------------------------------

install_required <- function() {
  print("1. Step: Install the required packages <=============================")

  for (package in required_packages()) {
    if (!package %in% installed.packages()) {
      install.packages(package, repos = "https://cran.r-project.org/")
      print("Installed package:", package)
    }
  }

  print("2. Step: Show the current installation state <=======================")

  show_installed()
}

# ==============================================================================
#' Remove required packages and show the current installation state.
#'
#' @import utils
#' @export
# ------------------------------------------------------------------------------

remove_required <- function() {
  print("1. Step: Remove the required packages <==============================")

  for (package in required_packages()) {
    if (package %in% installed.packages()) {
      remove.packages(package)
      print("Removed package:", package)
    }
  }

  print("2. Step: Show the current installation state <=======================")

  show_installed()
}

# ==============================================================================
#' Definition of the required packages.
#'
#' @param add_ons Character vvector containing additional pacckage names.
# ------------------------------------------------------------------------------

required_packages <- function(add_ons = vector()) {
  sort(append(add_ons,
              c("assertive",
                "data.table",
                "DBI",
                "dplyr",
                "forecast",
                "formatR",
                "ggplot2",
                "installr",
                "knitr",
                "lintr",
                "magrittr",
                "pillar",
                "R6",
                "readr",
                "rmarkdown",
                "roxygen2",
                "RSQLite",
                "stringr",
                "testthat",
                "TSstudio",
                "xts",
                "zoo"),
              after = length(add_ons)))
}

# ==============================================================================
#' Show the status of the required packages.
#'
#' @export
# ------------------------------------------------------------------------------

show_installed <- function() {
  sapply(required_packages(c("devtools", "packrat")),
         function(x) {
           x %in% installed.packages()
         }
  )
}
