# Title : explore
# Objective : Data Exploration.
# Created by: Walter Weinmann
# Created on: 16.11.2020

# ==============================================================================
#' Distribution of the volume of data on year.
#'
#' @param tad_raw.df A data frame containing transaction data, i.e. end-of-day
#'                  data or market index data
#' @return A data frame containing the year and the number of data entries
#'         in that year.
#' @import assertr
#' @import dplyr
#' @import magrittr
#' @import stringr
#' @export
# ------------------------------------------------------------------------------

distr_year.df <- function(tad_raw.df) {
  tad_raw.df %>%
    is_data.frame() %>%
    has_attributes(c("date"))

  is_date_string(tad_raw.df$date,
                 "%d")

  data.frame(Year = str_sub(tad_raw.df$date,
                            1,
                            4)) %>%
    group_by(Year) %>%
    count(Year,
          name = "Trading Days")
}

# ==============================================================================
#' Distribution of the volume of data on year and symbol.
#'
#' @param tad_raw.df A dataframe containing transaction data, i.e. end-of-day
#'               data or market index data
#' @import assertr
#' @import dplyr
#' @import magrittr
#' @import stringr
#' @export
# ------------------------------------------------------------------------------

distr_year_symbol.df <- function(tad_raw.df) {
  tad_raw.df %>%
    is_data.frame() %>%
    has_attributes(c("date", "symbol"))

  is_date_string(tad_raw.df$date,
                 "%d")

  data.frame(Year   = str_sub(tad_raw.df$date,
                              1,
                              4),
             symbol = tad_raw.df$symbol) %>%
    group_by(Year) %>%
    summarise(Symbols = n_distinct(Year, symbol))
}

# ==============================================================================
#' Barplot of the number of symbols per year.
#'
#' @param tad_raw.df A data frame containing transaction data, i.e. end-of-day
#'                  data or market index data
#' @import ggplot2
#' @export
# ------------------------------------------------------------------------------

distr_year_symbols.barplot <- function(tad_raw.df) {
  ggplot(data = distr_year_symbol.df(tad_raw.df),
         aes(x = Year,
             y = Symbols)) +
    geom_bar(stat = "identity",
             fill = "steelblue") +
    geom_text(aes(label = Symbols),
              vjust = 1.6,
              color = "white",
              size  = 3.5) +
    theme_minimal()
}

# ==============================================================================
#' Barplot of the number of trading days per year.
#'
#' @param tad_raw.df A data frame containing transaction data, i.e. end-of-day
#'                  data or market index data
#' @import ggplot2
#' @export
# ------------------------------------------------------------------------------

distr_year_trading_days.barplot <- function(tad_raw.df) {
  ggplot(data = distr_year.df(tad_raw.df),
         aes(x = Year,
             y = `Trading Days`)) +
    geom_bar(stat = "identity",
             fill = "steelblue") +
    geom_text(aes(label = `Trading Days`),
              vjust = 1.6,
              color = "white",
              size  = 3.5) +
    theme_minimal()
}

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

  df_raw_eod <- dbGetQuery(con, "
  SELECT t.symbol,
         m.name,
         min(t.date) first_day,
         max(t.date) last_day
    FROM eod_data t JOIN stocks m
      ON t.symbol = m.marketstack
   GROUP BY t.symbol
   ORDER BY t.symbol")

  dbDisconnect(con)

  df_raw_eod
}

# ==============================================================================
#' Create a data frame containing the raw end-of-day data.
#'
#' @param database Directory path and file name of the database
#' @return A data frame containing the raw end-of-day data
#' @import RSQLite
#' @export
# ------------------------------------------------------------------------------

eod_raw.df <- function(database) {
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

  df_raw_mid <- dbGetQuery(con, "
  SELECT t.symbol,
         m.name,
         min(t.date) first_day,
         max(t.date) last_day
    FROM mid_data t JOIN market_indices m
      ON t.symbol = m.symbol
   GROUP BY m.symbol
   ORDER BY m.symbol")

  dbDisconnect(con)

  df_raw_mid
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
