spp_test <- "../database/spp_test.db"

# ==============================================================================

test_that("eod_range_symbol.df(): content & structure test", {
  result <- sppr::eod_range_symbol.df(spp_test)

  expect_equal(class(result),
               "data.frame")
  expect_equal(dim(result),
               c(14,
                 4))
  expect_equal(c(names(result)),
               c("symbol",
                 "name",
                 "first_day",
                 "last_day"))
})

# ==============================================================================

test_that("eod_raw.df(): content & structure test", {
  result <- sppr::eod_raw.df(spp_test)

  expect_equal(class(result),
               "data.frame")
  expect_equal(dim(result),
               c(6596,
                 9))
  expect_equal(c(names(result)),
               c("date",
                 "symbol",
                 "exchange",
                 "open",
                 "high",
                 "low",
                 "close",
                 "volume",
                 "adj_close"))
})

# ==============================================================================

test_that("mid_range_symbol.df(): content & structure test", {
  result <- sppr::mid_range_symbol.df(spp_test)

  expect_equal(class(result),
               "data.frame")
  expect_equal(dim(result),
               c(41,
                 4))
  expect_equal(c(names(result)),
               c("symbol",
                 "name",
                 "first_day",
                 "last_day"))
})

# ==============================================================================

test_that("mid_raw.df(): content & structure test", {
  result <- sppr::mid_raw.df(spp_test)

  expect_equal(class(result),
               "data.frame")
  expect_equal(dim(result),
               c(19871,
                 8))
  expect_equal(c(names(result)),
               c("date",
                 "symbol",
                 "open",
                 "high",
                 "low",
                 "close",
                 "volume",
                 "adj_close"))
})












