spp_test <- "../database/spp_runit.db"

# ==============================================================================

test_that("distr_year.df(): eod - content & structure test", {
  result <- sppr::distr_year.df(sppr::eod_raw.df(spp_test))

  expect_equal(class(result),
               c("grouped_df",
                 "tbl_df",
                 "tbl",
                 "data.frame"))
  expect_equal(dim(result),
               c(2,
                 2))
  expect_equal(c(names(result)),
               c("Year",
                 "Trading Days"))
})

# ==============================================================================

test_that("distr_year.df(): mid - content & structure test", {
  result <- sppr::distr_year.df(sppr::mid_raw.df(spp_test))

  expect_equal(class(result),
               c("grouped_df",
                 "tbl_df",
                 "tbl",
                 "data.frame"))
  expect_equal(dim(result),
               c(2,
                 2))
  expect_equal(c(names(result)),
               c("Year",
                 "Trading Days"))
})

# ==============================================================================

test_that("distr_year_symbol.df(): eod - content & structure test", {
  result <- sppr::distr_year_symbol.df(sppr::eod_raw.df(spp_test))

  expect_equal(class(result),
               c("tbl_df",
                 "tbl",
                 "data.frame"))
  expect_equal(dim(result),
               c(2,
                 2))
  expect_equal(c(names(result)),
               c("Year",
                 "Symbols"))
})

# ==============================================================================

test_that("distr_year_symbol.df(): mid - content & structure test", {
  result <- sppr::distr_year_symbol.df(sppr::mid_raw.df(spp_test))

  expect_equal(class(result),
               c("tbl_df",
                 "tbl",
                 "data.frame"))
  expect_equal(dim(result),
               c(2,
                 2))
  expect_equal(c(names(result)),
               c("Year",
                 "Symbols"))
})



