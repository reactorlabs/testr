#! b25-matcal-1
#!g size = (22L)

# extracted from R Benchmark 2.5 (06/2008) [Simon Urbanek]
# http://r.research.att.com/benchmarks/R-benchmark-25.R

# I. Matrix calculation
# Creation, transp., deformation of a 2500x2500 matrix

b25matcal <- function(args) {
  t = _timerStart()
  runs = if (length(args)) as.integer(args[[1]]) else 22L

  for (i in 1:runs) {
    a <- matrix(rnorm(2500*2500)/10, ncol=2500, nrow=2500)
    b <- t(a)
    dim(b) <- c(1250, 5000)
    a <- t(b)
  }
  t
}

b25matcal(@size)
_timerEnd(b25matcal(@size),"tmr")
