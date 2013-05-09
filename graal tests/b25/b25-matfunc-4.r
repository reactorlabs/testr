#! b25-matfunc-4
#!g size = (6L)

# extracted from R Benchmark 2.5 (06/2008) [Simon Urbanek]
# http://r.research.att.com/benchmarks/R-benchmark-25.R

# II. Matrix functions
# Cholesky decomposition of a 3000x3000 matrix

b25matfunc <- function(args) {
  t = _timerStart()
  runs = if (length(args)) as.integer(args[[1]]) else 6L

  for (i in 1:runs) {
    a <- rnorm(3000*3000)
    dim(a) <- c(3000, 3000)
    a <- crossprod(a, a)
    b <- chol(a)
  }
  t
}

b25matfunc(@size)
_timerEnd(b25matfunc(@size),"tmr")