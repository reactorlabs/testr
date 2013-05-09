#! b25-prog-4
#!#g size = (10 # 50 # 100 # 500 # 1000)
#!g size = (10)

# extracted from R Benchmark 2.5 (06/2008) [Simon Urbanek]
# http://r.research.att.com/benchmarks/R-benchmark-25.R

# III. Programming
# Creation of a 500x500 Toeplitz matrix (loops)

b25prog <- function(args) {
  t = _timerStart()
  runs = if (length(args)) as.integer(args[[1]]) else 105L

  for (i in 1:runs) {
    b <- rep(0, 500*500)
    dim(b) <- c(500, 500)

        # Rem: there are faster ways to do this
        # but here we want to time loops (220*220 'for' loops)!

    for (j in 1:500) {
      for (k in 1:500) {
        b[k,j] <- abs(j - k) + 1
      }
    }
  }
  t
}

b25prog(@size)
t = b25prog(@size)
_timerEnd(t,"tmr")
