# Title : sppr_utils Objective : Utility functionality.
# Created by: Walter Weinmann Created on: 16.11.2020

#' Create a data frame containing the raw end-of-day data.
#'
#' @param database Directory path and file name of the database
#' @return A data frame containing the raw end-of-day data
#' @import RSQLite
#' @export

create_df_eod_raw <- function(database) {
  con <- dbConnect(RSQLite::SQLite(), database)
  RSQLite::initExtension(con)

  df_raw_eod <- dbGetQuery(con, "SELECT substr(date,1,4) year FROM eod_data")

  dbDisconnect(con)

  df_raw_eod
}

#' Install the required packages from the Swiss CRAN network.
#'
#' @importFrom utils install.packages
#' @export

sppr_install <- function() {
  install.packages(c("DBI", "dplyr", "devtools", "forecast", "formatR",
                     "ggplot2", "knitr", "lintr", "readr", "rmarkdown",
                     "roxygen2", "RSQLite", "testthat", "TSstudio", "xts",
                     "zoo"), repos = "https://stat.ethz.ch/CRAN/")

  quit(save = "no")
}
