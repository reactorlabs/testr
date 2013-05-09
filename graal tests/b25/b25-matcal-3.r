#! b25-matcal-3
#!g size = (12L)

# extracted from R Benchmark 2.5 (06/2008) [Simon Urbanek]
# http://r.research.att.com/benchmarks/R-benchmark-25.R

# I. Matrix calculation
# Sorting of 7,000,000 random values

b25matcal <- function(args) {
  t = _timerStart()
  runs = if (length(args)) as.integer(args[[1]]) else 12L

  for (i in 1:runs) {
    a <- rnorm(7000000)
    b <- sort(a, method="quick")
  }
  t
}

b25matcal(@size)
_timerEnd(b25matcal(@size),"tmr")
