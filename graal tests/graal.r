#!# tests for graal and PE, starting from the simplest ones to the more advanced

#! a program without any function
#!t 1
a <- 1
a

#! a program with a function with no arguments returning constant
#!t 2
f <- function() {
  1
}
a <- 0
a <- a + f()
a <- a + f()
a

#! a program with function with an argument (unused) returning constant
#!t 2
f <- function(x) {
  1
}
a <- 0
a <- a + f(a)
a <- a + f(a)
a

#! a program with function with argument returing the argument itself, called with constant
#!t 3
f <- function(x) {
  x
}
a <- 0
a <- a + f(1)
a <- a + f(2)
a

#! a program with function(int) returning the argument passed a non-constant
#!t 4
f <- function(x) {
  x
}
a <- 1
a <- a + f(a)
a <- a + f(a)
a

#! a program with function(int) returning updated argument being called by constant
#!t 7
f <- function(x) {
  x + 2
}
a <- 0
a <- a + f(1)
a <- a + f(2)
a

#! a program with function(int) returning updated argument passed a non-constant
#!t 10
f <- function(x) {
  x + 2
}
a <- 1
a <- a + f(a)
a <- a + f(a)
a

#! a nested function call, returning const, with no arguments, only inner function should enter PE
#!t 4
f1 <- function() {
  f2()
  f2()
}
f2 <- function() {
  4
}
a = 0
a = a + f1()
a

#! a nested function call, returning var, with an argument, only inner function should enter PE
#!t 2
f1 <- function(x) {
  f2(x)
  f2(x)
}
f2 <- function(x) {
  x
}
a = 1
a = a + f1(a)
a

#! a nested function call, returning changed var, with an argument, only inner function should enter PE
#!t 7
f1 <- function(x) {
  x  = x + f2(x)
  f2(x)
}
f2 <- function(x) {
  x + 2
}
a = 1
a = a + f1(a)
a

#! a nested function call, returning const, with no arguments, both functions should enter PE
#!t 8
f1 <- function() {
  f2()
  f2()
}
f2 <- function() {
  4
}
a = 0
a = a + f1()
a = a + f1()
a

#! a nested function call, returning var, with an argument, both functions should enter PE
#!t 4
f1 <- function(x) {
  f2(x)
  f2(x)
}
f2 <- function(x) {
  x
}
a = 1
a = a + f1(a)
a = a + f1(a)
a

#! a nested function call, returning changed var, with an argument, both functions should enter PE
#!t 25
f1 <- function(x) {
  x  = x + f2(x)
  f2(x)
}
f2 <- function(x) {
  x + 2
}
a = 1
a = a + f1(a)
a = a + f1(a)
a

#! nested function definitions, innermost entering PE
#!t 5
f1 <- function(x) {
  f2 <- function(y) {
    y + 1
  }
  x + f2(x) + f2(x)
}
f1(1)

#! nested function definitions, both entering PE
#!t 5 5
f1 <- function(x) {
  f2 <- function(y) {
    y + 1
  }
  x + f2(x) + f2(x)
}
f1(1)
f1(1)

#! nested function definitions, argument update, innermost entering PE
#!t 5
f1 <- function(x) {
  f2 <- function(y) {
    y + 1
    y = y + 1
  }
  x = x + f2(x) + f2(x)
  x
}
f1(1)

#! nested function definitions, argument update, both entering PE
#!t 5 5
f1 <- function(x) {
  f2 <- function(y) {
    y = y + 1
    y
  }
  x = x + f2(x) + f2(x)
  x
}
f1(1)
f1(1)

#! read from enclosing frame works correctly
#!t 5 5
f <- function(x) {
  x = x + a
  x
}
a = 3
f(2)
f(2)

#! read from enclosing frame of a function works correctly
#!t 8
f1 <- function() {
  f2 <- function() {
    a + 2
  }
  a = 4
  a = f2()
  a = f2()
  a
}
f1()

#! read from enclosing frame of a function works correctly, both functions in PE
#!t 8 8
f1 <- function() {
  f2 <- function() {
    a + 2
  }
  a = 4
  a = f2()
  a = f2()
  a
}
f1()
f1()

#! read from enclosing frame & return (from Tomas K)
#!t 1
g <- function() {
  x <- 1;
  f <- function() {
    x
  }
  f()
  f()
}
g()

#! assignment in function hides the outer definition in top environment
#!t 4 5 7
f <- function(x) {
  a = x
  a
}
a = 7
f(4)
f(5)
a

#! assignment in function with read from the outer top environment
#!t 11 12 7
f <- function(x) {
  a = a + x
  a
}
a = 7
f(4)
f(5)
a

#! assignment in function hides the outer definition in function environment
#!t 2 3
f1 <- function(x) {
  f2 <- function(x) {
    a = x
    a
  }
  a = x
  f2(4)
  f2(5)
  a
}
f1(2)
f1(3)

#! assignment in function with read from the outer function environment
#!t 2 3
f1 <- function(x) {
  f2 <- function(x) {
    a = a + x
    a
  }
  a = x
  f2(4)
  f2(5)
  a
}
f1(2)
f1(3)

#! assignment in function with read from the outer function environment, returning inner value
#!t 7 8
f1 <- function(x) {
  f2 <- function(x) {
    a = a + x
    a
  }
  a = x
  f2(4)
  f2(5)
}
f1(2)
f1(3)

#! multiple nesting for read access works too
#!t 6 7
f1 <- function(x) {
  f2 <- function(x) {
    f3 <- function(x) {
      f4 <- function(x) {
        x + 1
      }
      f4(x) + 1
    }
    f3(x) + 1
  }
  f2(x) + 1
}
f1(2)
f1(3)

#! superassignment for top level frame works
#!t 2 2 7
f <- function(x) {
  a <<- x + a
  x
}
a = 3
f(2)
f(2)
a

#! superassignment for outer level frame works
#!t 5 6
f1 <- function(x) {
  f2 <- function(x) {
    a <<- x + a
    x
  }
  a = x
  a = a + f2(1)
  a = a + f2(2)
  a
}
f1(2)
f1(3)

#!# deoptimize tests ---------------------------------------------------------------------------------------------------

#! argument value change for function works
#!t 3 4
f <- function(x) {
  x + 2
}
f(1)
f(2)

#! argument change int -- double works
#!t 3 4 5.2
f <- function(x) {
  x + 2
}
f(1L)
f(2L)
f(3.2)

#! argument change double -- int works
#!t 3.1 4.1 5
f <- function(x) {
  x + 2L
}
f(1.1)
f(2.1)
f(3L)

#!# TODO add more deoptimize tests for types

#! different if branches took - from Tomas K (exact)
#!t 1
f <- function(i) {
  if (i<=1)
    return (1)
}
f(2)
f(1)

#! different branches took 
#!t FALSE FALSE TRUE
f <- function(x) {
  if (x > 3) {
    TRUE
  } else {
    FALSE
  }
}
f(1)
f(1)
f(4)

#! different branches took, PE takes different values
#!t FALSE FALSE TRUE
f <- function(x) {
  if (x > 3) {
    TRUE
  } else {
    FALSE
  }
}
f(1)
f(2)
f(4)

#! different type into if statement
#!t TRUE TRUE TRUE
f <- function(x) {
  if (x) {
    TRUE
  } else {
    FALSE 
  }
}
f(3)
f(4)
f(TRUE)

#! different type and different result
#!t TRUE TRUE FALSE
f <- function(x) {
  if (x) {
    TRUE
  } else {
    FALSE 
  }
}
f(3)
f(4)
f(FALSE)

#!# TODO more deoptimize tests







#!# Tomas's tests, not sorted yet

#! 
#!t 1 1 
f <- function(i) {
  1[i]
} 
f(1)
f(TRUE)









































