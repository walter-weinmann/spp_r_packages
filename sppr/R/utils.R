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
  print("1. Step: Install packrat <===========================================")

  if (!"packrat" %in% installed.packages()) {
    install.packages("packrat",
                     repos = "https://cran.r-project.org/")
  }

  print("2. Step: Initialize packrat <========================================")

  packrat::init(options = list(local.repos = "~/lib/R"))

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
  for (package in required_packages()) {
    if (!package %in% installed.packages()) {
      install.packages(package, repos = "https://cran.r-project.org/")
    }
  }
}

# ==============================================================================
#' Install the required packages via librarian.
#'
#' @import librarian
#' @import utils
#' @export
# ------------------------------------------------------------------------------

install_with_librarian <- function() {
  print("1. Step: Install librarian <=========================================")

  if (!"librarian" %in% installed.packages()) { install.packages("librarian",
                                                                 repos =
                                                                   "https://cran.r-project.org/") }

  print("2. Step: Install packages <==========================================")

  librarian::shelf(assertive, data.table, DBI, devtools, dplyr, forecast,
                   formatR, ggplot2, installr, knitr, lintr, magrittr,
                   pillar, R6, readr,
                   rmarkdown, roxygen2, RSQLite, stringr, testthat, TSstudio,
                   xts, zoo,
                   cran_repo = "http://cran
                   .r-project.org/")

  print("3. Step: Verify loaded packages <====================================")

  librarian::check_installed(assertive, data.table, DBI, devtools, dplyr,
                             forecast, formatR, ggplot2, installr, knitr,
                             librarian, lintr, magrittr, pillar, R6, readr,
                             rmarkdown, roxygen2, RSQLite,
                             stringr, testthat, TSstudio, xts, zoo)
}

# ==============================================================================
  #' Install the required packages via pacman.
  #'
  #' @import pacman
  #' @import utils
  #' @export
# ------------------------------------------------------------------------------

install_with_pacman <- function() {

  print("1. Step: Install pacman <============================================")

  if (!"pacman" %in% installed.packages()) { install.packages("pacman", repos
    = "https://cran.r-project.org/") }

  print("2. Step: Setting CRAN Repoitory <====================================")

  pacman:::p_set_cranrepo(default_repo = "http://cran.r-project.org/")

  print("3. Step: Load and install or update packages <=======================")

  pacman::p_load("assertive", "data.table", "DBI", "devtools", "dplyr",
                 "forecast", "formatR", "ggplot2", "installr", "knitr",
                 "lintr", "magrittr", "pillar", "R6", "readr", "rmarkdown",
                 "roxygen2",
                 "RSQLite", "stringr", "testthat", "TSstudio", "xts", "zoo",
                 install = TRUE,
                 update
                         = TRUE)

  print("4. Step: Verify loaded packages <====================================")

  pacman::p_loaded("assertive", "data.table", "DBI", "devtools", "dplyr",
                   "forecast", "formatR", "ggplot2", "installr", "knitr",
                   "lintr", "magrittr", "pillar", "R6", "readr", "rmarkdown",
                   "roxygen2",
                   "RSQLite", "stringr", "testthat", "TSstudio", "xts", "zoo")
}

# ==============================================================================
#' Install the required packages.
#'
#' @param add_ons Character vvector containing additional pacckage names.
# ------------------------------------------------------------------------------

required_packages <- function(add_ons = vector()) {
  c(c("assertive",
      "data.table",
      "DBI",
      "devtools",
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
