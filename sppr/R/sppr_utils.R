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


#' Distribution of the volume of data on year and symbol.
#'
#' @param df_tad A dataframe containing transaction data
#' @import dplyr
#' @import stringr
#' @export

get_distr_year_symbol <- function(df_tad) {
  df_date_symbol <- data.frame(str_sub(df_tad$date, 1, 4), df_tad$symbol)
  colnames(df_date_symbol) <- c("year", "symbol")
  str(df_date_symbol)

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
