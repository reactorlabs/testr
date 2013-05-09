#! b25-matfunc-2
#!g size = (19L)

# extracted from R Benchmark 2.5 (06/2008) [Simon Urbanek]
# http://r.research.att.com/benchmarks/R-benchmark-25.R

# II. Matrix functions
# Eigenvalues of a 600x600 random matrix

b25matfunc <- function(args) {
  t = _timerStart()
  runs = if (length(args)) as.integer(args[[1]]) else 19L

  for (i in 1:runs) {
    a <- array(rnorm(600*600), dim = c(600, 600))
    b <- eigen(a, symmetric=FALSE, only.values=TRUE)$values
        # the 2.5 version of the benchmark uses $Value instead of $values but that is not working with R
  }
  t
}

b25matfunc(@size)
_timerEnd(b25matfunc(@size),"tmr")