# Title : sppr_utils Objective : Utility functionality.
# Created by: Walter Weinmann Created on: 16.11.2020


#' Install the required packages via pacman.
#'
#' @import pacman
#' @import utils
#' @export

sppr_install <- function() {

  print("1. Step: Install packrat <===========================================")

  if (!"packrat" %in% installed.packages()) {
    install.packages("packrat", repos = "https://cran.r-project.org/")
    packrat::init()
  }

  print("2. Step: Install pacman <============================================")

  if (!"pacman" %in% installed.packages()) {
    install.packages("pacman", repos = "https://cran.r-project.org/")
  }

  print("3. Step: Setting CRAN Repoitory <====================================")

  pacman:::p_set_cranrepo(default_repo = "http://cran.r-project.org/")

  print("4. Step: Load and install or update packages <=======================")

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
                 "packrat",
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

  print("5. Step: Verify loaded packages <====================================")

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
                   "packrat",
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

  print("6. Step: Packrat snapshot <==========================================")

  packrat::snapshot()

  print("7. Step: Packrat status <============================================")

  packrat::status()
}
