#! logical operators (from R help)


#!# unary operator ! --------------------------------------------------------------------------------------------------

#! ! works elementwise on the whole vector
#!t FALSE TRUE FALSE
a = c(TRUE, FALSE, TRUE)
!a

#! ! NA is NA
#!t NA
! NA

#! ! NaN is NA
#!t NA
! NaN

#! logical, integer, double and complex values can be used with operator !
#!g T1 = ( TRUE # FALSE # 0L # 3L # -2L # 2.1 # -3.2 # 2+3i)
#!t 1
a = @T1
length(!a)

#! string values cannot be used with operator !
#!e invalid argument type
! "foo"

#! operator ! can be used on raw vectors
#!t fc
a = as.raw(3)
!a

#! operator ! can be used on raw vectors of size > 1
#!t 4
a = as.raw(c(1,4,5,3))
length(!a)

#! operator ! on raw vectors works bitwise
#!t fe fc f7
a = as.raw(c(1,3,8))
!a

#! operator ! on non raw vectors works elementwise
#!t FALSE TRUE FALSE
a = c(1,0,8)
!a

#!# operator && -------------------------------------------------------------------------------------------------------

#! && and does shortcircuit
#!t "f1" "f2" FALSE
f1 = function() {
  print("f1")
  TRUE
}
f2 = function() {
  print("f2")
  FALSE
}
f3 = function() {
  print("f3")
  TRUE
}
f1() && f2() && f3()

#! && only takes into account first elements
#!t TRUE
a = c(TRUE, FALSE, TRUE)
b = c(TRUE, TRUE, FALSE)
a && b

#! && does not produce warnings when different argument sizes
#!t TRUE
a = c(TRUE, FALSE, TRUE)
b = c(TRUE, TRUE)
a && b

#! NA && TRUE is NA
#!t NA
NA && TRUE

#! NA && FALSE is FALSE
#!t FALSE
NA && FALSE

#! NaN && TRUE is NA
#!t NA
NaN && TRUE

#! NaN && FALSE is FALSE
#!t FALSE
NaN && FALSE

#! logical, integer, double and complex values can be used with operator &&
#!g T1 = ( TRUE # FALSE # 0L # 3L # -2L # 2.1 # -3.2 # 2+3i)
#!g T2 = ( TRUE # FALSE # 0L # 3L # -2L # 2.1 # -3.2 # 2+3i)
#!t 1
a = @T1
b = @T2
length(a && b)

#! raw or string values cannot be used with other types be used with operator && - lhs
#!g T1 = ( TRUE # 1L # 3L # -2L # 2.1 # -3.2 # 2+3i)
#!g T2 = ( as.raw(10) # "foo")
#!e invalid 'x' type in 'x && y'
a = @T2
a && @T1

#! raw or string values cannot be used with other types be used with operator && - rhs
#!g T1 = ( TRUE # 1L # 3L # -2L # 2.1 # -3.2 # 2+3i)
#!g T2 = ( as.raw(10) # "foo")
#!e invalid 'y' type in 'x && y'
a = @T2
@T1 && a

#! && cannot be used with strings
#!e invalid 'x' type in 'x && y'
"foo" && "bar"

#! && cannot be used with raw vectors
#!e invalid 'x' type in 'x && y'
as.raw(3) && as.raw(5)

#! && for unambiguous results with shortcircuiting raw and string values "can" be used
#!g T = (as.raw(10) # "foo")
length(FALSE && @T) == 1

#!# operator & --------------------------------------------------------------------------------------------------------

#! & and does not shortcircuit
#!t "f1" "f2" "f3" FALSE
f1 = function() {
  print("f1")
  TRUE
}
f2 = function() {
  print("f2")
  FALSE
}
f3 = function() {
  print("f3")
  TRUE
}
f1() & f2() & f3()

#! & works elementwise on the whole vector
#!t TRUE FALSE FALSE
a = c(TRUE, FALSE, TRUE)
b = c(TRUE, TRUE, FALSE)
a & b

#! operator & on vectors recycles the smaller one
#!t 4
a = c(1,2,3,4)
b = c(1,2)
length(a & b)

#! operator & on vectors recycles the smaller one for raw vectors
#!t 4
a = as.raw(c(1,2,3,4))
b = as.raw(c(1,2))
length(a & b)

#! operator & produces a warning if larger vector not multiple of smaller one
#!w longer object length is not a multiple of shorter object length
#!o 4
a = c(1,2,3,4)
b = c(1,2,3)
length(a & b)

#! operator & produces a warning if larger vector not multiple of smaller one for raw vectors
#!w longer object length is not a multiple of shorter object length
#!o 4
a = as.raw(c(1,2,3,4))
b = as.raw(c(1,2,3))
length(a & b)

#! NA & TRUE is NA
#!t NA
NA & TRUE

#! NA & FALSE is FALSE
#!t FALSE
NA & FALSE

#! NaN & TRUE is NA
#!t NA
NaN & TRUE

#! NaN & FALSE is FALSE
#!t FALSE
NaN & FALSE

#! logical, integer, double and complex values can be used with operator &
#!g T1 = ( TRUE # FALSE # 0L # 3L # -2L # 2.1 # -3.2 # 2+3i)
#!g T2 = ( TRUE # FALSE # 0L # 3L # -2L # 2.1 # -3.2 # 2+3i)
#!t 1
a = @T1
b = @T2
length(a & b)

#! raw or string values cannot be used with other types be used with operator & - lhs
#!g T1 = ( TRUE # 1L # 3L # -2L # 2.1 # -3.2 # 2+3i)
#!g T2 = ( as.raw(10) # "foo")
#!e operations are possible only for numeric, logical or complex types
a = @T2
a & @T1

#! raw or string values cannot be used with other types be used with operator & - rhs
#!g T1 = ( TRUE # 1L # 3L # -2L # 2.1 # -3.2 # 2+3i)
#!g T2 = ( as.raw(10) # "foo")
#!e operations are possible only for numeric, logical or complex types
a = @T2
@T1 & a

#! & cannot be used with strings
#!e  operations are possible only for numeric, logical or complex types
"foo" & "bar"

#! & for unambiguous results with string values does not work either
#!e operations are possible only for numeric, logical or complex types
FALSE & "foo"

#! & can be used on raw vectors
#!t 01
a = as.raw(3)
b = as.raw(5)
a & b

#! & can be used on raw vectors of size > 1
#!t 4
a = as.raw(c(1,4,5,3))
b = as.raw(c(1,2,3,5))
length(a & b)

#! & on raw vectors works bitwise
#!t 01 02 00
a = as.raw(c(1,3,8))
b = as.raw(c(1,6,0))
a & b

#! & on non raw vectors works elementwise
#!t TRUE TRUE FALSE
a = c(1,3,8)
b = c(1,6,0)
a & b

#!# operator || -------------------------------------------------------------------------------------------------------

#! || or does shortcircuit
#!t "f1" "f2" TRUE
f1 = function() {
  print("f1")
  FALSE
}
f2 = function() {
  print("f2")
  TRUE
}
f3 = function() {
  print("f3")
  TRUE
}
f1() || f2() || f3()

#! || only takes into account first elements
#!t TRUE
a = c(TRUE, FALSE, FALSE)
b = c(TRUE, TRUE, FALSE)
a || b

#! || does not produce warnings when different argument sizes
#!t TRUE
a = c(TRUE, FALSE, TRUE)
b = c(TRUE, TRUE)
a || b

#! NA || TRUE is TRUE
#!t TRUE
NA || TRUE

#! NA || FALSE is NA
#!t NA
NA || FALSE

#! NaN || TRUE is TRUE
#!t TRUE
NaN || TRUE

#! NaN || FALSE is NA
#!t NA
NaN || FALSE

#! logical, integer, double and complex values can be used with operator ||
#!g T1 = ( TRUE # FALSE # 0L # 3L # -2L # 2.1 # -3.2 # 2+3i)
#!g T2 = ( TRUE # FALSE # 0L # 3L # -2L # 2.1 # -3.2 # 2+3i)
#!t 1
a = @T1
b = @T2
length(a || b)

#! raw or string values cannot be used with other types be used with operator || - lhs
#!g T1 = ( FALSE # 0L # 0 # 0.0 # 0+0i)
#!g T2 = ( as.raw(10) # "foo")
#!e invalid 'x' type in 'x || y'
a = @T2
a || @T1

#! raw or string values cannot be used with other types be used with operator || - rhs
#!g T1 = ( FALSE # 0L # 0 # 0.0 # 0+0i)
#!g T2 = ( as.raw(10) # "foo")
#!e invalid 'y' type in 'x || y'
a = @T2
@T1 || a

#! || cannot be used with strings
#!e invalid 'x' type in 'x || y'
"foo" || "bar"

#! || cannot be used with raw vectors
#!e invalid 'x' type in 'x || y'
as.raw(3) || as.raw(5)

#! || for unambiguous results with shortcircuiting raw and string values "can" be used
#!g T = (as.raw(10) # "foo")
length(TRUE || @T) == 1

#!# operator | --------------------------------------------------------------------------------------------------------

#! | or does not shortcircuit
#!t "f1" "f2" "f3" TRUE
f1 = function() {
  print("f1")
  FALSE
}
f2 = function() {
  print("f2")
  TRUE
}
f3 = function() {
  print("f3")
  TRUE
}
f1() | f2() | f3()

#! | works elementwise on the whole vector
#!t TRUE FALSE TRUE
a = c(TRUE, FALSE, TRUE)
b = c(TRUE, FALSE, FALSE)
a | b

#! operator | on vectors recycles the smaller one
#!t 4
a = c(1,2,3,4)
b = c(1,2)
length(a | b)

#! operator | on vectors recycles the smaller one for raw vectors
#!t 4
a = as.raw(c(1,2,3,4))
b = as.raw(c(1,2))
length(a | b)

#! operator | produces a warning if larger vector not multiple of smaller one
#!w longer object length is not a multiple of shorter object length
#!o 4
a = c(1,2,3,4)
b = c(1,2,3)
length(a | b)

#! operator | produces a warning if larger vector not multiple of smaller one for raw vectors
#!w longer object length is not a multiple of shorter object length
#!o 4
a = as.raw(c(1,2,3,4))
b = as.raw(c(1,2,3))
length(a | b)

#! NA | TRUE is TRUE
#!t TRUE
NA | TRUE

#! NA | FALSE is NA
#!t NA
NA | FALSE

#! NaN & TRUE is TRUE
#!t TRUE
NaN | TRUE

#! NaN & FALSE is NA
#!t NA
NaN | FALSE

#! logical, integer, double and complex values can be used with operator |
#!g T1 = ( TRUE # FALSE # 0L # 3L # -2L # 2.1 # -3.2 # 2+3i)
#!g T2 = ( TRUE # FALSE # 0L # 3L # -2L # 2.1 # -3.2 # 2+3i)
#!t 1
a = @T1
b = @T2
length(a | b)

#! raw or string values cannot be used with other types be used with operator | - lhs
#!g T1 = ( TRUE # 1L # 3L # -2L # 2.1 # -3.2 # 2+3i)
#!g T2 = ( as.raw(10) # "foo")
#!e operations are possible only for numeric, logical or complex types
a = @T2
a | @T1

#! raw or string values cannot be used with other types be used with operator | - rhs
#!g T1 = ( TRUE # 1L # 3L # -2L # 2.1 # -3.2 # 2+3i)
#!g T2 = ( as.raw(10) # "foo")
#!e operations are possible only for numeric, logical or complex types
a = @T2
@T1 | a

#! | cannot be used with strings
#!e  operations are possible only for numeric, logical or complex types
"foo" | "bar"

#! | for unambiguous results with string values does not work either
#!e operations are possible only for numeric, logical or complex types
TRUE | "foo"

#! | can be used on raw vectors
#!t 07
a = as.raw(3)
b = as.raw(5)
a | b

#! | can be used on raw vectors of size > 1
#!t 4
a = as.raw(c(1,4,5,3))
b = as.raw(c(1,2,3,5))
length(a | b)

#! | on raw vectors works bitwise
#!t 01 07 08
a = as.raw(c(1,3,8))
b = as.raw(c(1,6,0))
a | b

#! | on non raw vectors works elementwise
#!t TRUE FALSE TRUE
a = c(1,0,8)
b = c(1,0,0)
a | b

#!# operator xor ------------------------------------------------------------------------------------------------------

#! xor works elementwise on the whole vector
#!t FALSE FALSE TRUE
a = c(TRUE, FALSE, TRUE)
b = c(TRUE, FALSE, FALSE)
xor(a,b)

#! operator xor on vectors recycles the smaller one
#!t 4
a = c(1,2,3,4)
b = c(1,2)
length(xor(a,b))

#! operator xor on vectors recycles the smaller one for raw vectors
#!t 4
a = as.raw(c(1,2,3,4))
b = as.raw(c(1,2))
length(xor(a,b))

#! operator xor produces a warning if larger vector not multiple of smaller one
#!w longer object length is not a multiple of shorter object length
#!o 4
a = c(1,2,3,4)
b = c(1,2,3)
length(xor(a,b))

#! operator xor produces a warning if larger vector not multiple of smaller one for raw vectors
#!w longer object length is not a multiple of shorter object length
#!o 4
a = as.raw(c(1,2,3,4))
b = as.raw(c(1,2,3))
length(xor(a,b))

#! NA xor anything is NA
#!g T = (FALSE # TRUE)
#!t NA
xor(NA,@T)

#! NaN & anything is NA
#!g T = (FALSE # TRUE)
#!t NA
xor(NaN,@T)

#! logical, integer, double and complex values can be used with operator xor
#!g T1 = ( TRUE # FALSE # 0L # 3L # -2L # 2.1 # -3.2 # 2+3i)
#!g T2 = ( TRUE # FALSE # 0L # 3L # -2L # 2.1 # -3.2 # 2+3i)
#!t 1
a = @T1
b = @T2
length(xor(a,b))

#! raw or string values cannot be used with other types be used with operator xor - lhs
#!g T1 = ( TRUE # 1L # 3L # -2L # 2.1 # -3.2 # 2+3i)
#!g T2 = ( as.raw(10) # "foo")
#!e operations are possible only for numeric, logical or complex types
a = @T2
xor(a,@T1)

#! raw or string values cannot be used with other types be used with operator xor - rhs
#!g T1 = ( TRUE # 1L # 3L # -2L # 2.1 # -3.2 # 2+3i)
#!g T2 = ( as.raw(10) # "foo")
#!e operations are possible only for numeric, logical or complex types
a = @T2
xor(@T1,a)

#! xor cannot be used with strings
#!e operations are possible only for numeric, logical or complex types
xor("foo","bar")

#! xor can be used on raw vectors
#!t 06
a = as.raw(3)
b = as.raw(5)
xor(a,b)

#! xor can be used on raw vectors of size > 1
#!t 4
a = as.raw(c(1,4,5,3))
b = as.raw(c(1,2,3,5))
length(xor(a,b))

#! xor on raw vectors works bitwise
#!t 00 05 08
a = as.raw(c(1,3,8))
b = as.raw(c(1,6,0))
xor(a,b)

#! xor on non raw vectors works elementwise
#!t FALSE FALSE TRUE
a = c(1,0,8)
b = c(1,0,0)
xor(a,b)
