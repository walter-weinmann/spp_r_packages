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
            symbol", .libPaths()[1])

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
            symbol", .libPaths()[1])

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
  colnames(df_year) <- c("year", .libPaths()[1])
  count(group_by(df_year$year))
}


#' Install the required packages manually.
#'
#' @importFrom utils install.packages
#' @export

sppr_install <- function() {

  sppr_remove()

  if (!"dplyr" %in% installed.packages()) {
    install.packages("dplyr", repos = "https://cran.r-project.org")
  }

  if (!"DBI" %in% installed.packages()) {
    install.packages("DBI", repos = "https://cran.r-project.org")
  }
  if (!"devtools" %in% installed.packages()) {
    install.packages("devtools", repos = "https://cran.r-project.org")
  }
  if (!"forecast" %in% installed.packages()) {
    install.packages("forecast", repos = "https://cran.r-project.org")
  }
  if (!"formatR" %in% installed.packages()) {
    install.packages("formatR", repos = "https://cran.r-project.org")
  }
  if (!"ggplot2" %in% installed.packages()) {
    install.packages("ggplot2", repos = "https://cran.r-project.org")
  }
  if (!"knitr" %in% installed.packages()) {
    install.packages("knitr", repos = "https://cran.r-project.org")
  }
  if (!"lintr" %in% installed.packages()) {
    install.packages("lintr", repos = "https://cran.r-project.org")
  }
  if (!"pillar" %in% installed.packages()) {
    install.packages("pillar", repos = "https://cran.r-project.org")
  }
  if (!"R6" %in% installed.packages()) {
    install.packages("R6", repos = "https://cran.r-project.org")
  }
  if (!"readr" %in% installed.packages()) {
    install.packages("readr", repos = "https://cran.r-project.org")
  }
  if (!"rmarkdown" %in% installed.packages()) {
    install.packages("rmarkdown", repos = "https://cran.r-project.org")
  }
  if (!"roxygen2" %in% installed.packages()) {
    install.packages("roxygen2", repos = "https://cran.r-project.org")
  }
  if (!"RSQLite" %in% installed.packages()) {
    install.packages("RSQLite", repos = "https://cran.r-project.org")
  }
  if (!"stringr" %in% installed.packages()) {
    install.packages("stringr", repos = "https://cran.r-project.org")
  }
  if (!"testthat" %in% installed.packages()) {
    install.packages("testthat", repos = "https://cran.r-project.org")
  }
  if (!"TSstudio" %in% installed.packages()) {
    install.packages("TSstudio", repos = "https://cran.r-project.org")
  }
  # wwe
  # if (!"xts" %in% installed.packages()) {
  #   install.packages("xts", repos = "https://cran.r-project.org")
  # }
  if (!"zoo" %in% installed.packages()) {
    install.packages("zoo", repos = "https://cran.r-project.org")
  }
}


#' Install the required packages via librarian.
#'
#' @importFrom utils install.packages
#' @export

sppr_install_librarian <- function() {

  sppr_remove()

  if (!"librarian" %in% installed.packages()) {
    install.packages("librarian", repos = "https://cran.r-project.org")
  }

  librarian::shelf(DBI,
                   devtools,
                   dplyr,
                   forecast,
                   formatR,
                   ggplot2,
                   knitr,
                   lintr,
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
                   zoo)
}


#' Install the required packages via pacman.
#'
#' @importFrom utils install.packages
#' @export

sppr_install_pacman <- function() {

  package_names <- c("DBI",
                     "devtools",
                     "dplyr",
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
                     "zoo")

  if (!"pacman" %in% installed.packages()) {
    install.packages("pacman", repos = "https://cran.r-project.org/")
  }

  pacman:::p_unload(all)

  pacman:::p_set_cranrepo(default_repo = "http://cran.r-project.org/")

  pacman:::p_load(cat(paste(shQuote(package_names,
                                    type = "cmd"),
                            collapse = ", ")),
                  install = TRUE,
                  update = TRUE,
                  character.only = FALSE
  )
}


#' Install the required packages manually.
#'
#' @importFrom utils remove.packages
#' @export

sppr_remove <- function() {

  if ("DBI" %in% installed.packages()) {
    remove.packages("DBI", .libPaths()[1])
  }
  if ("devtools" %in% installed.packages()) {
    remove.packages("devtools", .libPaths()[1])
  }
  if ("dplyr" %in% installed.packages()) {
    remove.packages("dplyr", .libPaths()[1])
  }
  if ("forecast" %in% installed.packages()) {
    remove.packages("forecast", .libPaths()[1])
  }
  if ("formatR" %in% installed.packages()) {
    remove.packages("formatR", .libPaths()[1])
  }
  if ("ggplot2" %in% installed.packages()) {
    remove.packages("ggplot2", .libPaths()[1])
  }
  if ("knitr" %in% installed.packages()) {
    remove.packages("knitr", .libPaths()[1])
  }
  if ("lintr" %in% installed.packages()) {
    remove.packages("lintr", .libPaths()[1])
  }
  if ("pillar" %in% installed.packages()) {
    remove.packages("pillar", .libPaths()[1])
  }
  if ("R6" %in% installed.packages()) {
    remove.packages("R6", .libPaths()[1])
  }
  if ("readr" %in% installed.packages()) {
    remove.packages("readr", .libPaths()[1])
  }
  if ("rmarkdown" %in% installed.packages()) {
    remove.packages("rmarkdown", .libPaths()[1])
  }
  if ("roxygen2" %in% installed.packages()) {
    remove.packages("roxygen2", .libPaths()[1])
  }
  if ("RSQLite" %in% installed.packages()) {
    remove.packages("RSQLite", .libPaths()[1])
  }
  if ("stringr" %in% installed.packages()) {
    remove.packages("stringr", .libPaths()[1])
  }
  if ("testthat" %in% installed.packages()) {
    remove.packages("testthat", .libPaths()[1])
  }
  if ("TSstudio" %in% installed.packages()) {
    remove.packages("TSstudio", .libPaths()[1])
  }
  if ("xts" %in% installed.packages()) {
    remove.packages("xts", .libPaths()[1])
  }
  if ("zoo" %in% installed.packages()) {
    remove.packages("zoo", .libPaths()[1])
  }
}


