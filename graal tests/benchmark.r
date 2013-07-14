
#! scalar benchmark
#!g size = (10000000)

f = function(a,b) {
  x = _timerStart()
  for (i in 1:@size) {
    a = a + b
  }
  x
}
a = 1
b = 2
f(a,b)
a = 1
b = 2
_timerEnd(f(a,b),"tmr")

#! vector benchmark

#!g size = (10000)
#!g vsize = (100000)

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
_timerEnd(f(a,b),"tmr")




#! a more complex benchmark
#!g size =  (1000)
#!g vsize = (10)

s = as.vector(array(1,c(@vsize)))
inc = as.vector(array(1,c(@vsize)))


f2 = function(b) {
  b = b + s
  s <<- s + inc
  b
}

f = function(a) {
  x = _timerStart();
  for (i in 1:@size) {
    a = a + f2(a)
  }
  s <<- a
  x
}
a = as.vector(array(0,c(@vsize)))
f(a)
a = as.vector(array(0,c(@vsize)))
s = as.vector(array(1,c(@vsize)))
_timerEnd(f(a),"tmr")

#! SNIPPET
f3 <- function() {
    x = 3
}
f3()
f3()
f3()


#! simple benchmark

#!# codesize 6169

f = function(a,b) {
  for (i in 1:10000) {
    a = a + b
  }
  NULL
}
a = as.vector(array(0,c(100000)))
b = as.vector(array(2,c(100000)))
f(a,b)
f(a,b)

#! TEST
#!g size=(10 # 100 # 1000 # 5000 # 10000 # 50000 # 100000 # 500000 # 1000000 # 5000000 # 10000000)

f1 <- function(c,d) {
  if (c < d) {
    c
  } else {
    d
  }
}
f2 <- function(a,b) {
  a + f1(a,b)
}
ftest <- function() {
  t = _timerStart()
  a = 0
  for (i in 1:@size) {
    a = a + f2(3,4)
    a = a - f2(3,4)
  }
  t
}
ftest()
t = ftest()
_timerEnd(t,"tmr")