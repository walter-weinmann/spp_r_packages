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

  df_raw_eod <- dbGetQuery(con, "
  SELECT date,
         symbol,
         exchange,
         open,
         high,
         low,
         close,
         volume,
         open_adj_orig adj_open,
         high_adj_orig adj_high,
         low_adj_orig adj_low,
         close_adj_orig adj_close,
         volume_adj_orig adj_volume
    FROM eod_data
   ORDER BY date,
            symbol")

  dbDisconnect(con)

  df_raw_eod
}


#' Create a data frame containing the raw market index data.
#'
#' @param database Directory path and file name of the database
#' @return A data frame containing the raw market index data
#' @import RSQLite
#' @export

create_df_mid_raw <- function(database) {
  con <- dbConnect(RSQLite::SQLite(), database)
  RSQLite::initExtension(con)

  df_raw_mid <- dbGetQuery(con, "
  SELECT date,
         symbol,
         open,
         high,
         low,
         close,
         volume,
         open_adj_orig adj_open,
         high_adj_orig adj_high,
         low_adj_orig adj_low,
         close_adj_orig adj_close,
         volume_adj_orig adj_volume
    FROM mid_data
   ORDER BY date,
            symbol")

  dbDisconnect(con)

  df_raw_mid
}


#' Distribution of the volume of data on symbol.
#'
#' @param df_tad A dataframe containing transaction data
#' @import dplyr
#' @export

get_distr_symbol <- function(df_tad) {
  count(group_by(df_tad$symbol))
}


#' Distribution of the volume of data on year.
#'
#' @param df_tad A dataframe containing transaction data
#' @import dplyr
#' @import stringr
#' @export

get_distr_year <- function(df_tad) {
  df_year <- data.frame(str_sub(df_tad$date, 1, 4))
  colnames(df_year) <- c("year")
  count(group_by(df_year$year))
}


#' Install the required packages from the Swiss CRAN network.
#'
#' @importFrom utils install.packages
#' @export

sppr_install <- function() {
  if ("DBI" %in% installed.packages()) remove.packages("DBI")
  if ("devtools" %in% installed.packages()) remove.packages("devtools")
  if ("dplyr" %in% installed.packages()) remove.packages("dplyr")
  if ("forecast" %in% installed.packages()) remove.packages("forecast")
  if ("formatR" %in% installed.packages()) remove.packages("formatR")
  if ("ggplot2" %in% installed.packages()) remove.packages("ggplot2")
  if ("knitr" %in% installed.packages()) remove.packages("knitr")
  if ("lintr" %in% installed.packages()) remove.packages("lintr")
  if ("pillar" %in% installed.packages()) remove.packages("pillar")
  if ("R6" %in% installed.packages()) remove.packages("R6")
  if ("readr" %in% installed.packages()) remove.packages("readr")
  if ("rmarkdown" %in% installed.packages()) remove.packages("rmarkdown")
  if ("roxygen2" %in% installed.packages()) remove.packages("roxygen2")
  if ("RSQLite" %in% installed.packages()) remove.packages("RSQLite")
  if ("stringr" %in% installed.packages()) remove.packages("stringr")
  if ("testthat" %in% installed.packages()) remove.packages("testthat")
  if ("TSstudio" %in% installed.packages()) remove.packages("TSstudio")
  if ("xts" %in% installed.packages()) remove.packages("xts")
  if ("zoo" %in% installed.packages()) remove.packages("zoo")

  install.packages(c("dplyr"), repos = "https://stat.ethz.ch/CRAN/")

  install.packages(c("DBI",
                     "devtools",
                     "forecast",
                     "formatR",
                     "ggplot2",
                     "knitr",
                     "lintr",
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
                     "zoo"), repos = "https://stat.ethz.ch/CRAN/")
}
