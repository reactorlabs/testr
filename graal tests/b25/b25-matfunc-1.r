#! b25-matfunc-1
#!g size = (26L)

# extracted from R Benchmark 2.5 (06/2008) [Simon Urbanek]
# http://r.research.att.com/benchmarks/R-benchmark-25.R

# II. Matrix functions
# FFT over 2,400,000 random values

b25matfunc <- function(args) {
  t = _timerStart()
  runs = if (length(args)) as.integer(args[[1]]) else 26L

  for (i in 1:runs) {
    a <- rnorm(2400000)
    b <- fft(a)
  }
  t
}

b25matfunc(@size)
_timerEnd(b25matfunc(@size),"tmr")