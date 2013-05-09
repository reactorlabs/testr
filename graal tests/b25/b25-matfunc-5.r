#! b25-matfunc-5
#!g size = (2L)

# extracted from R Benchmark 2.5 (06/2008) [Simon Urbanek]
# http://r.research.att.com/benchmarks/R-benchmark-25.R

# II. Matrix functions
# Inverse of a 1600x1600 random matrix

b25matfunc <- function(args) {
  t = _timerStart()
  runs = if (length(args)) as.integer(args[[1]]) else 2L

  for (i in 1:runs) {
    a <- rnorm(1600*1600)
    dim(a) <- c(1600, 1600)
    b <- qr.solve(a)
  }
  t
}

b25matfunc(@size)
_timerEnd(b25matfunc(@size),"tmr")