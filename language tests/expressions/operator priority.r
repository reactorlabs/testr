#!# various sources, R intro
#!# since the operator priorities are dealt with on parser level, any variability with respect to types is not expected

#!# since [ and [[ are also parentheses, their priority is not relevant

#! $ has greater priority than :
#!t 1 2 3 4 5 6 7 8 9 10
a = list(c=10,b=10)
1:a$c

#! ^ is right justified
#!t 256 256 64
2^2^3
2^(2^3)
(2^2)^3

#! ^ has greater priority than unary -
#!t -4 4
-2^2
(-2)^2

#!# ^ has greater priority than unary + cannot be checked
#! unary + and unary - are selected in order they appear
#!t "+" "-" "+" "-" 2
a = -1
'+' <- function(x) {
  print("+")
  x
}
'-' <- function(x) {
  print('-')
  a * x
}
+-+-2


#! unary minus has greater priority than sequence
#!t 6
length(-1:4)

#! sequence is left justified
#!w  numerical expression has 4 elements: only the first used
#!o 1 2 3 4 5 6 7
1:4:7

#! sequence has greater priority than %% operator
#!t 0 0 1
10 %% 1 : 3

#! sequence has greater priority than %% operator
#!t 1 0 1
1 : 3 %% 2

#! %% is left justified
#!t 1 NaN
100 %% 15 %% 3
100 %% (15 %% 3)

#! %/% is left justified
#!t 6 100
100 %/% 5 %/% 3
100 %/% (5 %/% 3)

#! priority of %% and %/% is the same
#!t 5 24 8 228
456 %% 145 %/% 4
456 %% (145 %/% 4)
456 %/% 56 %% 27
456 %/% (56 %% 27)

#!# %*% is left justified cannot be determined, the operator is associative - see the next test

#! %*% and %/% are of the same priority 
#!ttt
a = matrix(1:4,2,2)
b = matrix(c(100,456,134,78), 2,2)
d = matrix(c(3,7,5,11), 2, 2)
(a %*% b %/% d) != (a %*% (b %/% d))
(b %/% d %*% a) != (b %/% (d %*% a))

#!# %o% is left justified cannot be determined alone, the operator is associative - see the next test

#! %o% and %/% are of the same priority
#!ttt
a = c(10,20,30)
b = c(2,4,7)
d = c(7,8,9)
(a %o% b %/% d) != (a %o% (b %/% d))
(a %/% b %o% d) != (a %/% (b %o% d))

#! %x% and %/% are of the same priority
#!ttt
a = c(10,20,30)
b = c(4,3,7)
d = c(10,15,18)
(a %x% b %/% d) != (a %x% (b %/% d))
(a %/% b %x% d) != (a %/% (b %x% d))

#! %/% has greater priority than *
a = 10
b = 3
c = 7
(a * b %/% c) != ((a * b) %/% c)

#!# / is of the same priority as *
a = 7
b = 6
d = 4
(a * b / d) != (a * (b / d))
(a / b * d) != (a / (b * d))

#! * and / are both left justified
#!# * and / is left justified cannot be determined alone, they are associative
a = 6
b = 10
d = 2
a * b / d == 30

#! * has greater priority than +
a = 10
b = 3
c = 7
(a * b + c) != ((a * b) + c)

#!# + is of the same priority as -
a = 7
b = 6
d = 4
(a + b - d) != (a + (b - d))
(a - b + d) != (a - (b + d))

#! + and - are left justified
#!# * and / is left justified cannot be determined alone
#!ttt 
a = 10
b = 6
d = 7
a + b - d ==  9
a - b + d == 11

#! justification of relational operators is irrelevant
#!g O = ( < # <= # == # != # >= # > )
#!e  unexpected '@O'
a = 1
b = 2
d = 3
a @O b @O d

#! priority of relational operators cannot be determined
#!g O = ( < # <= # == # != # >= # > )
#!g W = ( < # <= # == # != # >= # > )
#!e  unexpected '@W'
a = 1
b = 2
d = 3
a @O b @W d

#! + has greater priority than <
a = 7
b = 8
d = 30
e = 23
(a + b < d + e) != (a + (b < d) + e)

#! + has greater priority than <=
a = 7
b = 8
d = 30
e = 23
(a + b <= d + e) != (a + (b <= d) + e)

#! + has greater priority than ==
a = 10
b = 7
d = 9
e = 78
(a + b == d + e) != (a + (b == d) + e)

#! + has greater priority than !=
a = 1
b = 2
d = 3
e = 4
(a + b != d + e) != (a + (b != d) + e)

#! + has greater priority than >=
a = 7
b = 8
d = 30
e = 23
(a + b >= d + e) != (a + (b >= d) + e)

#! + has greater priority than >
a = 7
b = 8
d = 30
e = 23
(a + b > d + e) != (a + (b > d) + e)

#! < has greater priority than negation
a = 7
b = 8
(! a < b) != ((!a) < b)

#! <= has greater priority than negation
a = 7
b = 8
(! a <= b) != ((!a) <= b)

#! == has greater priority than negation
a = 7
b = 8
! a == b

#! != has greater priority than negation
a = 7
b = 8
(! a != b) != ((!a) != b)

#! >= has greater priority than negation
a = 7
b = 8
(! a >= b) != ((!a) >= b)

#! > has greater priority than negation
a = 7
b = 8
(! a > b) != ((!a) > b)

#! negation has greater priority than &
a = FALSE
b = FALSE
(! a & b) != ( ! (a & b))

#! negation has greater priority than & on raw
a = as.raw(0xc1)
b = as.raw(0x1f)
(! a & b) != ( ! (a & b))

#! & is left associative
#!t "F1" "F2" TRUE
f1 <- function() {
  print("F1")
  TRUE
}
f2 <- function() {
  print("F2")
  TRUE
}
f1() & f2()

#! && is left associative
#!t "F1" "F2" TRUE
f1 <- function() {
  print("F1")
  TRUE
}
f2 <- function() {
  print("F2")
  TRUE
}
f1() && f2()

#! & and && are of the same priority
#!t "F1" "F2" "F3" TRUE "F1" "F2" "F3" TRUE
f1 <- function() {
  print("F1")
  TRUE
}
f2 <- function() {
  print("F2")
  TRUE
}
f3 <- function() {
  print("F3")
  TRUE
}
f1() && f2() & f3()
f1() & f2() && f3()

#! & has greater priority than |
a = TRUE
b = TRUE
d = FALSE
(a | b & d) != ((a | b) & d)

#! & has greater priority than | on raw
a = as.raw(0xc1)
b = as.raw(0x1f)
d = as.raw(0x23)
(a | b & d) != ((a | b) & d)

#! | is left associative
#!t "F1" "F2" TRUE
f1 <- function() {
  print("F1")
  TRUE
}
f2 <- function() {
  print("F2")
  FALSE
}
f1() | f2()

#! || is left associative
#!t "F1" "F2" TRUE
f1 <- function() {
  print("F1")
  FALSE
}
f2 <- function() {
  print("F2")
  TRUE
}
f1() || f2()

#! | and || are of the same priority
#!t "F1" "F2" "F3" TRUE "F1" "F2" "F3" TRUE
f1 <- function() {
  print("F1")
  FALSE
}
f2 <- function() {
  print("F2")
  FALSE
}
f3 <- function() {
  print("F3")
  TRUE
}
f1() | f2() || f3()
f1() || f2() | f3()

#! | has greater priority than -> assignment
#!e could not find function "|<-"
a = FALSE
c = TRUE
FALSE -> a | c

#! | has greater priority than -> assignment
c = TRUE
(FALSE -> a) | c

#! | has greater priority than ->> assignment
#!e object 'a' not found
a = FALSE
c = TRUE
FALSE ->> a | c

#! | has greater priority than ->> assignment
c = TRUE
(FALSE ->> a) | c

#! -> is left justified 
#!# in fact it must be
#!t "d" "b" "a" 8
'->' <- function(x,y) {
  print(deparse(substitute(x)))
  y
}
'<-' <- function(x,y) { # this is needed because of the translation of -> to <-
  print(deparse(substitute(x)))
  y
}
8 -> a -> b -> d

#! ->> is left justified 
#!# in fact it must be
#!t "d" "b" "a" 8
'->>' <- function(x,y) {
  print(deparse(substitute(x)))
  y
}
'<<-' <- function(x,y) { # this is needed because of the translation of ->> to <<-
  print(deparse(substitute(x)))
  y
}
8 ->> a ->> b ->> d

#! -> has greater priority than <-
#!t "a" "b" 7 "a" "b" 7 "b" "a" 7
'->' <- function(x,y) {
  print(deparse(substitute(x)))
  y
}
'<-' <- function(x,y) {
  print(deparse(substitute(x)))
  y
}
a <- 7 -> b
a <- (7 -> b)
(a <- 7) -> b

#! -> has greater priority than <<-
#!t "a" "b" 7 "a" "b" 7 "b" "a" 7
'->' <- function(x,y) {
  print(deparse(substitute(x)))
  y
}
'<<-' <- function(x,y) {
  print(deparse(substitute(x)))
  y
}
'<-' <- function(x,y) { # this is needed because of the translation of -> to <-
  print(deparse(substitute(x)))
  y
}
a <<- 7 -> b
a <<- (7 -> b)
(a <<- 7) -> b

#! <- is right justified 
#!# in fact it must be
#!t "a" "b" "d" 8
'<-' <- function(x,y) {
  print(deparse(substitute(x)))
  y
}
a <- b <- d <- 8

#! <<- is right justified 
#!# in fact it must be
#!t "a" "b" "d" 8
'<<-' <- function(x,y) {
  print(deparse(substitute(x)))
  y
}
a <<- b <<- d <<- 8

#! <- has greater priority than =
#!t 7
a = b <- 7
a

#! <- has greater priority than =
#!e object 'a' not found
b = 6
(a = b) <- 7

#! <<- has greater priority than =
#!t 7
a = b <<- 7
a

#! <<- has greater priority than =
#!e object 'a' not found
(a = b) <<- 7

#! = is right justified 
#!# in fact it must be
#!t "a" "b" "d" 8
'=' <- function(x,y) {
  print(deparse(substitute(x)))
  y
}
a = b = d = 8
