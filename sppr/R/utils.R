# Title : sppr_utils Objective : Utility functionality.
# Created by: Walter Weinmann Created on: 16.11.2020


#' Install the required packages via librarian.
#'
#' @import pacman
#' @import utils
#' @export

sppr_install_librarian <- function() {

  print("1. Step: Install librarian <=========================================")

  if (!"librarian" %in% installed.packages()) {
    install.packages("librarian", repos = "https://cran.r-project.org/")
  }

  print("2. Step: Install packages <==========================================")

  librarian::shelf(assertive,
                   data.table,
                   DBI,
                   devtools,
                   dplyr,
                   forecast,
                   formatR,
                   ggplot2,
                   installr,
                   knitr,
                   lintr,
                   magrittr,
                   pillar,
                   R6,
                   readr,
                   rmarkdown,
                   roxygen2,
                   RSQLite,
                   stringr,
                   testthat,
                   TSstudio,
                   xts,
                   zoo,
                   cran_repo = "http://cran.r-project.org/"
  )

  print("3. Step: Verify loaded packages <====================================")

  librarian:::check_pkg_status(assertive,
                               data.table,
                               DBI,
                               devtools,
                               dplyr,
                               forecast,
                               formatR,
                               ggplot2,
                               installr,
                               knitr,
                               librarian,
                               lintr,
                               magrittr,
                               pillar,
                               R6,
                               readr,
                               rmarkdown,
                               roxygen2,
                               RSQLite,
                               stringr,
                               testthat,
                               TSstudio,
                               xts,
                               zoo,
                               "installed"
  )
}

  #' Install the required packages via pacman.
  #'
  #' @import pacman
  #' @import utils
  #' @export

sppr_install_pacman <- function() {

  print("1. Step: Install pacman <============================================")

  if (!"pacman" %in% installed.packages()) {
    install.packages("pacman", repos = "https://cran.r-project.org/")
  }

  print("2. Step: Setting CRAN Repoitory <====================================")

  pacman:::p_set_cranrepo(default_repo = "http://cran.r-project.org/")

  print("3. Step: Load and install or update packages <=======================")

  pacman::p_load("assertive",
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
                 "zoo",
                 install = TRUE,
                 update = TRUE
  )

  print("4. Step: Verify loaded packages <====================================")

  pacman::p_loaded("assertive",
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
                   "zoo"
  )
}
