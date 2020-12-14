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
                     repos = "https://cran.r-project.org/",
                     force = TRUE)
    print("Installed package: packrat")
  }

  print("2.1 Step: Save changes in packrat (status) <=========================")

  packrat::status()

  print("2.2 Step: Save changes in packrat (clean) <==========================")

  packrat::clean()

  print("2.3 Step: Save changes in packrat (snapshot <========================")

  packrat::snapshot(infer.dependencies = FALSE)

  print("3. Step: Terminate R <===============================================")

  quit(save = "no")
}

# ==============================================================================
#' Install the required packages and show the current installation state.
#'
#' @param library Character vector describing the location of R library
#'                trees to search through
#' @import utils
#' @export
# ------------------------------------------------------------------------------

install_required <- function(library = "packrat/lib/x86_64-w64-mingw32/4.0.3") {
  print("1. Step: Install the required packages <=============================")

  for (package in required_packages()) {
    if (!package %in% installed.packages(library)) {
      install.packages(package,
                       repos = "https://cran.r-project.org/",
                       force = TRUE)
      print(paste("Installed package:", package, sep = " "))
    }
  }

  print("2.1 Step: Save changes in packrat (status) <=========================")

  packrat::status()

  print("2.2 Step: Save changes in packrat (clean) <==========================")

  packrat::clean()

  print("2.3 Step: Save changes in packrat (snapshot <========================")

  packrat::snapshot(infer.dependencies = FALSE)

  print("3. Step: Show the current installation state <=======================")

  show_installed(library)
}

# ==============================================================================
#' Remove required packages and show the current installation state.
#'
#' @param library Character vector describing the location of R library
#'                trees to search through
#' @import utils
#' @export
# ------------------------------------------------------------------------------

remove_required <- function(library = "packrat/lib/x86_64-w64-mingw32/4.0.3") {
  print("1. Step: Remove the required packages <==============================")

  for (package in required_packages()) {
    if (package %in% installed.packages(lib.loc = library)) {
      remove.packages(package, library)
      print(paste("Removed package:", package, sep = " "))
    }
  }

  print("2.1 Step: Save changes in packrat (status) <=========================")

  packrat::status()

  print("2.2 Step: Save changes in packrat (clean) <==========================")

  packrat::clean()

  print("2.3 Step: Save changes in packrat (snapshot <========================")

  packrat::snapshot(infer.dependencies = FALSE)

  print("3. Step: Show the current installation state <=======================")

  show_installed(library)
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
#' @param library Character vector describing the location of R library
#'                trees to search through
#' @export
# ------------------------------------------------------------------------------

show_installed <- function(library = "packrat/lib/x86_64-w64-mingw32/4.0.3") {
  sapply(required_packages(c("devtools", "packrat", "sppr")),
         function(x) {
           x %in% installed.packages(lib.loc = library)
         }
  )
}
