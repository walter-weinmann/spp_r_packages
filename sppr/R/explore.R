# Title : explore
# Objective : Data Exploration.
# Created by: Walter Weinmann
# Created on: 16.11.2020

# ==============================================================================
#' Distribution of the volume of data on year.
#'
#' @param tad_raw.df A data frame containing transaction data, i.e. end-of-day
#'                   data or market index data
#' @return A data frame containing the year and the number of data entries
#'         in that year.
#' @import dplyr
#' @import stringr
#' @importFrom assertive has_attributes
#' @importFrom assertive is_data.frame
#' @importFrom assertive is_date_string
#' @importFrom magrittr %>%
#' @export
# ------------------------------------------------------------------------------

distr_year.df <- function(tad_raw.df) {
  tad_raw.df %>%
    is_data.frame() %>%
    has_attributes(c("date"))

  is_date_string(tad_raw.df$date,
                 "%d")

  Year <- NULL

  df <- data.frame(Year = str_sub(tad_raw.df$date,
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
#'                   data or market index data
#' @import dplyr
#' @import stringr
#' @importFrom assertive has_attributes
#' @importFrom assertive is_data.frame
#' @importFrom assertive is_date_string
#' @importFrom magrittr %>%
#' @export
# ------------------------------------------------------------------------------

distr_year_symbol.df <- function(tad_raw.df) {
  tad_raw.df %>%
    is_data.frame() %>%
    has_attributes(c("date", "symbol"))

  is_date_string(tad_raw.df$date,
                 "%d")

  Year <- symbol <- NULL

  df <- data.frame(Year   = str_sub(tad_raw.df$date,
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
#'                   data or market index data
#' @import ggplot2
#' @export
# ------------------------------------------------------------------------------

distr_year_symbols.barplot <- function(tad_raw.df) {
  data <- NULL

  ggplot(data = distr_year_symbol.df(tad_raw.df),
         aes(x = data$Year,
             y = data$Symbols)) +
    geom_bar(stat = "identity",
             fill = "steelblue") +
    geom_text(aes(label = data$Symbols),
              vjust = 1.6,
              color = "white",
              size  = 3.5) +
    theme_minimal()
}

# ==============================================================================
#' Barplot of the number of trading days per year.
#'
#' @param tad_raw.df A data frame containing transaction data, i.e. end-of-day
#'                   data or market index data
#' @import ggplot2
#' @export
# ------------------------------------------------------------------------------

distr_year_trading_days.barplot <- function(tad_raw.df) {
  data <- NULL

  ggplot(data = distr_year.df(tad_raw.df),
         aes(x = data$Year,
             y = data$`Trading Days`)) +
    geom_bar(stat = "identity",
             fill = "steelblue") +
    geom_text(aes(label = data$`Trading Days`),
              vjust = 1.6,
              color = "white",
              size  = 3.5) +
    theme_minimal()
}
