
#! TEST
f2 <- function(j,k,l,m,n,o,p) {
  4
}

f <- function() {
  x = _timerStart()
  for (i in 1:1000000) {
    f2(1,2,3,4,5,6,7)
  }
  x
}

f()
_timerEnd(f(),"tmr")

#! scalar benchmark
#!g size = ( 40000000 )
#!#g size = (1000000 # 2000000 # 3000000 # 4000000 # 5000000 # 6000000 # 70000000 # 80000000 # 90000000 # 100000000 )

f = function(a,b) {
  x = _timerStart()
  for (i in 1:@size) {
    a = a + b
  }
  x
}
a = 1
b = 2
dim(a) = c(1)
dim(b) = c(1)
f(a,b)
a = 1
b = 2
dim(a) = c(1)
dim(b) = c(1)
#f(a,b)
#a = 1
#b = 2
#f(a,b)
#a = 1
#b = 2
_timerEnd(f(a,b),"tmr")

#! vector benchmark

#!g size = (5000)
#!g vsize = (50000)

#!#g size = (1000  # 3000 # 5000 # 7500 # 10000 # 15000 # 20000)
#!#g vsize = (1000 # 5000 # 10000 # 50000 # 100000)

f = function(a,b) {
  x = _timerStart()
  for (i in 1:@size) {
    a = a + b
  }
  x
}
a = as.vector(array(0,c(@vsize)))
b = as.vector(array(2,c(@vsize)))
f(a,b)
#f(a,b)
#f(a,b)
_timerEnd(f(a,b),"tmr")
