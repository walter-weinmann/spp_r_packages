# Title : sqlite
# Objective : Database related functions.
# Created by: Walter Weinmann
# Created on: 16.11.2020

# ==============================================================================
#' Create a data frame containing the end-of-day trading day range per symbol.
#'
#' @param database Directory path and file name of the database
#' @return A data frame containing the raw end-of-day data
#' @import RSQLite
#' @export
# ------------------------------------------------------------------------------

eod_range_symbol.df <- function(database) {
  con <- dbConnect(RSQLite::SQLite(), database)
  RSQLite::initExtension(con)

  data.df <- dbGetQuery(con, "
  SELECT t.symbol,
         m.name,
         min(t.date) first_day,
         max(t.date) last_day
    FROM eod_data t JOIN stocks m
      ON t.symbol = m.marketstack
   GROUP BY t.symbol
   ORDER BY t.symbol")

  dbDisconnect(con)

  data.df
}

# ==============================================================================
#' Create a data frame containing the raw end-of-day data.
#'
#' @param database Directory path and file name of the database
#' @return A data frame containing the raw end-of-day data
#' @import assertive
#' @import dplyr
#' @import RSQLite
#' @export
# ------------------------------------------------------------------------------

eod_raw.df <- function(database) {
  con <- dbConnect(RSQLite::SQLite(), database)
  RSQLite::initExtension(con)

  adj_low <- adj_open <- adj_volume <- NULL

  tad_raw.df <- dbGetQuery(con, "
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

  is.na(tad_raw.df$adj_open)
  is.na(tad_raw.df$adj_high)
  is.na(tad_raw.df$adj_low)
  is.na(tad_raw.df$adj_volume)

  select(tad_raw.df,
         -(adj_open:adj_low),
         -adj_volume)
}

# ==============================================================================
#' Create a data frame containing the market index trading day range per symbol.
#'
#' @param database Directory path and file name of the database
#' @return A data frame containing the raw end-of-day data
#' @import RSQLite
#' @export
# ------------------------------------------------------------------------------

mid_range_symbol.df <- function(database) {
  con <- dbConnect(RSQLite::SQLite(), database)
  RSQLite::initExtension(con)

  data.df <- dbGetQuery(con, "
  SELECT t.symbol,
         m.name,
         min(t.date) first_day,
         max(t.date) last_day
    FROM mid_data t JOIN market_indices m
      ON t.symbol = m.symbol
   GROUP BY m.symbol
   ORDER BY m.symbol")

  dbDisconnect(con)

  data.df
}

# ==============================================================================
#' Create a data frame containing the raw market index data.
#'
#' @param database Directory path and file name of the database
#' @return A data frame containing the raw market index data
#' @import RSQLite
#' @export
# ------------------------------------------------------------------------------

mid_raw.df <- function(database) {
  con <- dbConnect(RSQLite::SQLite(), database)
  RSQLite::initExtension(con)

  adj_low <- adj_open <- adj_volume <- NULL

  tad_raw.df <- dbGetQuery(con, "
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

  is.na(tad_raw.df$adj_open)
  is.na(tad_raw.df$adj_high)
  is.na(tad_raw.df$adj_low)
  is.na(tad_raw.df$adj_volume)

  select(tad_raw.df,
         -(adj_open:adj_low),
         -adj_volume)
}
