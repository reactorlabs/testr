#!# graal tests for basic fastr concepts and nodes

#!# function calls and arguments passing -------------------------------------------------------------------------------

#! simple function invocation, an empty function (however this is a return of const null)
#!# code size 49
f <- function() {
}
f()
f()

#! simple function invocation with return value
#!# code size 49
f <- function() {
  4
}
f()
f()

#! function call with an argument, returning constant
#!# codesize 404
f <- function(x) {
  4
}
f(1)
f(2)


#! return of an argument
#!# code size 397
f <- function(x) {
  x
}
f(1)
f(2)

#! function invocation with argument read
#!# code size 404
f <- function(x) {
  x
  4
}
f(1)
f(2)

#! function invocation with two arguments
#!# code size 713
f <- function(x,y) {
  4
}
f(1,2)
f(2,3)

#! function invocation with optional argument specified always
#!# code size 404
f <- function(x = 6) {
  4
}
f(1)
f(2)

#! function invocation with optional argument never specified
#!# code size 414, 306
f <- function(x = 6) {
  4
}
f()
f()

#! function invocation with optional argument specified after optimization
#!# code size 306
f <- function(x = 6) {
  4
}
f()
f(8)

#! function invocation with referenced arguments
#!# code size 415
f <- function(x) {
  x
  4
}
a = c(1,2,3)
f(a)
f(a)

#!# basic language features - arithmetics on scalars -------------------------------------------------------------------

#! addition of constants XXX
f <- function() {
  4 + 6
}
f()
f()




