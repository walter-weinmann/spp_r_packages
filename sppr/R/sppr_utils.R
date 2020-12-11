# Title : sppr_utils Objective : Utility functionality.
# Created by: Walter Weinmann Created on: 16.11.2020

#' Install the required packages from the Swiss CRAN network.
#' @importFrom utils install.packages
#' @export

sppr_install <- function() {
  install.packages(c("DBI", "dplyr", "devtools", "forecast", "formatR",
                     "ggplot2", "knitr", "lintr", "readr", "rmarkdown",
                     "roxygen2", "RSQLite", "testthat", "TSstudio", "xts",
                     "zoo"), repos = "https://stat.ethz.ch/CRAN/")

  quit(save = "no")
}
