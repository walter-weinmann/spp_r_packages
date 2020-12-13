# Title : sppr_utils Objective : Utility functionality.
# Created by: Walter Weinma/
# +nn Created on: 16.11.2020

# ==============================================================================
#' Initialize packrat.
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
  }

  print("2. Step: Initialize packrat <========================================")

  packrat::init()

  print("3. Step: Terminate R <===============================================")

  quit(save = "no")
}

# ==============================================================================
#' Install the required packages.
#'
#' @import utils
#' @export
# ------------------------------------------------------------------------------

install <- function() {
  print("1. Step: Install the required packages <=============================")

  for (package in sppr::required_packages()) {
    if (!package %in% installed.packages()) {
      install.packages(package, repos = "https://cran.r-project.org/")
    }
  }

  print("2. Step: Show the installation result <==============================")

  sapply(sppr::required_packages(c("devtools", "packrat")),
         function(x) {
           x %in% installed.packages()
         }
  )
}

# ==============================================================================
#' Definition of the required packages.
#'
#' @param add_ons Character vvector containing additional pacckage names.
# ------------------------------------------------------------------------------

required_packages <- function(add_ons = vector()) {
  c(c("assertive",
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
    add_ons)
}
