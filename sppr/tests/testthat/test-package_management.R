# ==============================================================================

test_that("install(): all packages are installed", {
  result <- sppr::install()
  expect_equal(length(result[result == FALSE]), 0)
})

test_that("install(): install twice", {
  result <- sppr::install()
  result <- sppr::install()
  expect_equal(length(result[result == FALSE]), 0)
})

# ==============================================================================

test_that("update(): all packages are updated", {
  result <- sppr::update()
  expect_equal(length(result[result == FALSE]), 0)
})

test_that("update(): update twice", {
  result <- sppr::update()
  result <- sppr::update()
  expect_equal(length(result[result == FALSE]), 0)
})

# ==============================================================================

test_that("remove(): most packages are removed", {
  result <- sppr::remove()
  expect_equal(length(result[result == TRUE]), 8)
})

test_that("remove(): remove twice", {
  result <- sppr::remove()
  result <- sppr::remove()
  expect_equal(length(result[result == TRUE]), 8)
})

test_that("remove(): all packages are reinstalled", {
  result <- sppr::install()
  expect_equal(length(result[result == FALSE]), 0)
})

