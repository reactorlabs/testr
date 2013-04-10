#! logical operators (from R help)

#!# attributes in logical operators expressions -----------------------------------------------------------------------

#! custom attributes are not preserved by and or or long or short versions (lhs)
#!g O = ( && # || # & # | )
#!ttt
a = c(1,2,3,4)
attributes(a) = list(haha=56)
is.null(attributes(a @O TRUE))
is.null(attributes(a @O FALSE))

#! custom attributes are not preserved by and or or long or short versions (rhs)
#!g O = ( && # || # & # | )
#!ttt
a = c(1,2,3,4)
attributes(a) = list(haha=56)
is.null(attributes(TRUE @O a))
is.null(attributes(FALSE @O a))

#! custom attributes are not preserved by !
a = c(1,2,3,4)
attributes(a) = list(haha=56)
is.null(attributes(!a))

#! custom attributes are not preserved by xor (lhs)
#!ttt
a = c(1,2,3,4)
attributes(a) = list(haha=56)
is.null(attributes(xor(a, TRUE)))
is.null(attributes(xor(a, FALSE)))

#! custom attributes are not preserved by xor (rhs)
#!ttt
a = c(1,2,3,4)
attributes(a) = list(haha=56)
is.null(attributes(xor(TRUE,a)))
is.null(attributes(xor(FALSE,a)))

#!# names attribute ---------------------------------------------------------------------------------------------------

#! names attribute is preserved by & and | if the same for both operands
#!g O = ( & # | )
#!t "a" "b" "c"
a = c(a =1, b = 2, c = 3)
b = c(a =1, b = 2, c = 3)
names(a @O b)

#! names attribute is preserved by xor if the same for both operands
#!t "a" "b" "c"
a = c(a =1, b = 2, c = 3)
b = c(a =1, b = 2, c = 3)
names(xor(a,b))

#! names attribute is preserved by !
#!t "a" "b" "c"
a = c(a =1, b = 2, c = 3)
names(!a)

#! names attribute is not preserved for && and ||
#!g O = ( && # || )
#!t NULL
a = c(a =1, b = 2, c = 3)
b = c(a =1, b = 2, c = 3)
names(a @O b)

#! if the names are not for whole vector, they are still preserved for the result for & and | 
#!g O = ( & # | )
#!t "a" "b" ""
a = c(a=1, b=2, 3)
b = c(a=1, b=2, 3)
names(a @O b)

#! if the names are not for whole vector, they are still preserved for the result for xor
#!t "a" "b" ""
a = c(a=1, b=2, 3)
b = c(a=1, b=2, 3)
names(xor(a,b))

#! if the names are not for whole vector, they are still preserved for the result for !
#!t "a" "b" ""
a = c(a=1, b=2, 3)
names(!a)

#! if names present in both vectors, names from first vector are used for & and |
#!g O = ( & # | )
#!t "a" "b" ""
a = c(a=1, b=2, 3)
b = c(a=1, b=2, c=3)
names(a @O b)

#! if names present in both vectors, names from first vector are used for xor
#!t "a" "b" ""
a = c(a=1, b=2, 3)
b = c(a=1, b=2, c=3)
names(xor(a,b))

# if names not present in first argument, names from second are used for & and |
#!g O = ( & # | )
#!t "a" "b" "c"
a = c(1, 2, 3)
b = c(a=1, b=2, c=3)
names(a @O b)

# if names not present in first argument, names from second are used for xor
#!t "a" "b" "c"
a = c(1, 2, 3)
b = c(a=1, b=2, c=3)
names(xor(a,b))

#!# dim attribute -----------------------------------------------------------------------------------------------------

#! dim attribute is not preserved by && and ||
#!g O = ( && # || )
a = array(1,c(3,3,3))
b = array(1,c(3,3,3))
is.null(dim(a @O b))

#! dim attribute is preserved by & and | if both dimensions are the same
#!g O = ( & # | )
#!t 3 3 3
a = array(1,c(3,3,3))
b = array(1,c(3,3,3))
dim(a @O b)

#! dim attribute is preserved by xor if both dimensions are the same
#!t 3 3 3
a = array(1,c(3,3,3))
b = array(1,c(3,3,3))
dim(xor(a,b))

#! dim attribute is preserved by !
#!t 3 3 3
a = array(1,c(3,3,3))
dim(!a)

#! if dim present only in the first argument, it is preserved for & and |
#!g O = ( & # | )
#!t 3 3 3
a = array(1, c(3,3,3))
b = c(1,2,3)
dim(a @O b)

#! if dim present only in the first argument, it is preserved for xor
#!t 3 3 3
a = array(1, c(3,3,3))
b = c(1,2,3)
dim(xor(a,b))

#! if dim present only in the second argument, it is preserved for & and |
#!g O = ( & # | )
#!t 3 3 3
a = array(1, c(3,3,3))
b = c(1,2,3)
dim(b @O a)

#! if dim present only in the second argument, it is preserved for xor
#!t 3 3 3
a = array(1, c(3,3,3))
b = c(1,2,3)
dim(xor(b,a))

#!# dimnames attribute ------------------------------------------------------------------------------------------------

#! dimnames attribute is not preserved by && and ||
#!g O = ( && # || )
a = array(1,c(2,2,2), dimnames=list(c("a","b"), c("c","d"), c("e","f")))
b = array(1,c(2,2,2), dimnames=list(c("a","b"), c("c","d"), c("e","f")))
is.null(dimnames(a @O b))

#! dimnames attribute is preserved by & and | if both dimensions are the same
#!g O = ( & # | )
#!t "a" "b" "c" "d" "e" "f"
a = array(1,c(2,2,2), dimnames=list(c("a","b"), c("c","d"), c("e","f")))
b = array(1,c(2,2,2), dimnames=list(c("a","b"), c("c","d"), c("e","f")))
a = dimnames(a @O b)
a[[1]]
a[[2]]
a[[3]]

#! dimnames attribute is preserved by xor if both dimensions are the same
#!t "a" "b" "c" "d" "e" "f"
a = array(1,c(2,2,2), dimnames=list(c("a","b"), c("c","d"), c("e","f")))
b = array(1,c(2,2,2), dimnames=list(c("a","b"), c("c","d"), c("e","f")))
a = dimnames(xor(a,b))
a[[1]]
a[[2]]
a[[3]]

#! dimnames attribute is preserved by !
#!t "a" "b" "c" "d" "e" "f"
a = array(1,c(2,2,2), dimnames=list(c("a","b"), c("c","d"), c("e","f")))
a = dimnames(!a)
a[[1]]
a[[2]]
a[[3]]

#! if dimnames for arguments differ, the first dimnames are used for & and |
#!g O = ( & # | )
#!t "a" "b" "c" "d" "e" "f"
a = array(1,c(2,2,2), dimnames=list(c("a","b"), c("c","d"), c("e","f")))
b = array(1,c(2,2,2), dimnames=list(c("A","B"), c("C","D"), c("E","F")))
a = dimnames(a @O b)
a[[1]]
a[[2]]
a[[3]]

#! if dimnames for arguments differ, the first dimnames are used for xor
#!t "a" "b" "c" "d" "e" "f"
a = array(1,c(2,2,2), dimnames=list(c("a","b"), c("c","d"), c("e","f")))
b = array(1,c(2,2,2), dimnames=list(c("A","B"), c("C","D"), c("E","F")))
a = dimnames(xor(a,b))
a[[1]]
a[[2]]
a[[3]]

#! if first dimnames are missing, second argument's dimnames are used for resulr for & and |
#!g O = ( & # | )
#!t "a" "b" "c" "d" "e" "f"
a = array(1,c(2,2,2))
b = array(1,c(2,2,2), dimnames=list(c("a","b"), c("c","d"), c("e","f")))
a = dimnames(a @O b)
a[[1]]
a[[2]]
a[[3]]

#! if first dimnames are missing, second argument's dimnames are used for result for xor
#!t "a" "b" "c" "d" "e" "f"
a = array(1,c(2,2,2))
b = array(1,c(2,2,2), dimnames=list(c("a","b"), c("c","d"), c("e","f")))
a = dimnames(xor(a,b))
a[[1]]
a[[2]]
a[[3]]

#! if dimnames present only in the first argument, it is preserved for & and |
#!g O = ( & # | )
#!t "a" "b" "c" "d" "e" "f"
a = array(1,c(2,2,2), dimnames=list(c("a","b"), c("c","d"), c("e","f")))
b = array(1,c(2,2,2))
a = dimnames(a @O b)
a[[1]]
a[[2]]
a[[3]]

#! if dim present only in the first argument, it is preserved for xor
#!t "a" "b" "c" "d" "e" "f"
a = array(1,c(2,2,2), dimnames=list(c("a","b"), c("c","d"), c("e","f")))
b = array(1,c(2,2,2))
a = dimnames(xor(a,b))
a[[1]]
a[[2]]
a[[3]]

#! if second argument is not array, dimnames of the first are used for & and |
#!g O = ( & # | )
#!t "a" "b" "c" "d" "e" "f"
a = array(1,c(2,2,2), dimnames=list(c("a","b"), c("c","d"), c("e","f")))
b = c(1,2)
a = dimnames(a @O b)
a[[1]]
a[[2]]
a[[3]]

#! if second argument is not array, dimnames of the first are used for xor
#!t "a" "b" "c" "d" "e" "f"
a = array(1,c(2,2,2), dimnames=list(c("a","b"), c("c","d"), c("e","f")))
b = c(1,2)
a = dimnames(xor(a,b))
a[[1]]
a[[2]]
a[[3]]

#! if first argument is not array, dimnames of the second are used for & and |
#!g O = ( & # | )
#!t "a" "b" "c" "d" "e" "f"
a = array(1,c(2,2,2), dimnames=list(c("a","b"), c("c","d"), c("e","f")))
b = c(1,2)
a = dimnames(b @O a)
a[[1]]
a[[2]]
a[[3]]

#! if first argument is not array, dimnames of the second are used for xor
#!t "a" "b" "c" "d" "e" "f"
a = array(1,c(2,2,2), dimnames=list(c("a","b"), c("c","d"), c("e","f")))
b = c(1,2)
a = dimnames(xor(b,a))
a[[1]]
a[[2]]
a[[3]]

#!# logical operators and data types other than vectors ---------------------------------------------------------------

#!# matrices ----------------------------------------------------------------------------------------------------------

#! matrices can be used for unary !
a = matrix(1,2,2)
length(!a) == 4

#! matrices can be used for binary operator xor
a = matrix(1,2,2)
b = matrix(0,2,2)
length(xor(a,b)) == 4 

#! matrices can be used for binary logical operators (short versions)
#!g O = ( & # | )
a = matrix(1,2,2)
b = matrix(0,2,2)
length(a @O b) == 4 

#! matrices can be used for binary logical operators (long versions)
#!g O = ( && # ||)
a = matrix(1,2,2)
b = matrix(0,2,2)
length(a @O b) == 1

#! matrices and vectors can be combined for xor
a = matrix(1,2,2)
b = c(1,2,3,4)
length(xor(a,b)) == 4

#! matrices and vectors can be combined for binary logical operators (short versions)
#!g O = ( & # | )
a = matrix(1,2,2)
b = c(1,2,3,4)
length(a @O b) == 4 
length(b @O a) == 4 

#! matrices and vectors can be combined for binary logical operators (long versions)
#!g O = ( & # | )
a = matrix(1,2,2)
b = c(1,2,3,4)
length(a @O b) == 4 
length(b @O a) == 4 

#! matrices of different dimensions cannot be used for short operators (& and |)
#!g O = ( & # | )
#!e binary operation on non-conformable arrays
a = matrix(1, 2,2)
b = matrix(1, 4,2)
a @O b

#! matrices of different dimensions cannot be used for operator xor
#!e binary operation on non-conformable arrays
a = matrix(1, 2,2)
b = matrix(1, 4,2)
xor(a,b)

#! matrices of different dimensions can be used for long operators (&& and ||)
#!g O = ( && # || )
a = matrix(1, 2,2)
b = matrix(1, 4,2)
length(a @O b) == 1

#!# arrays ------------------------------------------------------------------------------------------------------------

#! arrays can be used for unary !
a = array(1,c(3,3,3))
length(!a) == 27

#! arrays can be used for binary operator xor
a = array(1,c(3,3,3))
b = array(0,c(3,3,3))
length(xor(a,b)) == 27

#! arrays can be used for binary logical operators (short versions)
#!g O = ( & # | )
a = array(1,c(3,3,3))
b = array(0,c(3,3,3))
length(a @O b) == 27 

#! arrays can be used for binary logical operators (long versions)
#!g O = ( && # ||)
a = array(1,c(3,3,3))
b = array(0,c(3,3,3))
length(a @O b) == 1

#! arrays and vectors can be combined for xor
a = array(1,c(2,2,2))
b = c(1,2,3,4)
length(xor(a,b)) == 8

#! arrays and vectors can be combined for binary logical operators (short versions)
#!g O = ( & # | )
a = array(1,c(2,2,2))
b = c(1,2,3,4)
length(a @O b) == 8 
length(b @O a) == 8 

#! arrays and vectors can be combined for binary logical operators (long versions)
#!g O = ( & # | )
a = array(1,c(2,2,2))
b = c(1,2,3,4)
length(a @O b) == 8 
length(b @O a) == 8 

#! arrays of different dimensions cannot be used for short operators (& and |)
#!g O = ( & # | )
#!e binary operation on non-conformable arrays
a = array(1, c(2,2,2))
b = array(1, c(4,2,2))
a @O b

#! arrays of different dimensions cannot be used for operator xor
#!e binary operation on non-conformable arrays
a = array(1, c(2,2,2))
b = array(1, c(4,2,2))
xor(a,b)

#! arrays of different dimensions can be used for long operators (&& and ||)
#!g O = ( && # || )
a = array(1, c(2,2,2))
b = array(1, c(4,2,2))
length(a @O b) == 1

#!# lists -------------------------------------------------------------------------------------------------------------

#! lists cannot be used for unary !
#!e invalid argument type
a = list(1,2,3)
!a

#! lists cannot be used for xor
#!e operations are possible only for numeric, logical or complex types
a = list(1,2,3)
b = list(1,2,3)
xor(a,b)

#! lists cannot be used for binary logical operators (long versions)
#!g O = ( && # || )
#!e invalid 'x' type in 'x @O y'
a = list(1,2,3)
b = list(1,2,3)
a @O b

#! lists cannot be used for binary logical operators (short versions)
#!g O = ( & # | )
#!e operations are possible only for numeric, logical or complex types
a = list(1,2,3)
b = list(1,2,3)
a @O b





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
