#!# mostly from help() to relational operators

#!# NA handling -------------------------------------------------------------------------------------------------------

#! NA with relational operator results in NA
#!g T = (FALSE # -3L # 0.5 # as.raw(0))
#!g O = ( < # <= # == # != # >= # > )
#!g V = ( NA # NaN)
#!t NA
@V @O @T

#! NA or NaN with complex number is not allowed
#!e invalid comparison with complex values
#!g O = ( < # <= # >= # > )
#!g V = ( NA # NaN)
@V @O (2+3i)

#! NA or NaN with complex number and == and != is NA
#!t NA
#!g O = ( == # != )
#!g V = ( NA # NaN)
@V @O (2+3i)

#! even NA compared to NA is NA
#!g O = ( < # <= # == # != # >= # > )
#!g T = ( NA # NaN )
#!g V = ( NA # NaN )
#!t NA
@T @O @V

#! Na cannot be compared with string -- result is always NA
#!g O = ( < # <= # == # != # >= # > )
#!t NA
NA @O "foo"

#! NaN can be compared with string
#!t "logical"
#!g O = ( < # <= # == # != # >= # > )
typeof(NaN @O "foo")

#! NaN and string comarisons are lexicographical
#!g T = ( < # <=)
#!t TRUE FALSE
"foo" @T NaN
"zaza" @T NaN

#! NaN and string comarisons are lexicographical
#!g T = ( > # >= )
#!t FALSE TRUE
"foo" @T NaN
"zaza" @T "NaN"

#! NaN is identical to "NaN"
#!ttt
"NaN" == NaN
"foo" != NaN

#! comparison of NA and NaN (any) is always NA
#!g O = ( < # <= # == # != # >= # > )
#!t NA NA
NA @O NaN
NaN @O NA

#!# a result of an relational operator is always logical --------------------------------------------------------------

#! result types of non-complex relations
#!g T = (FALSE # -3L # 0.5 # "foo" # as.raw(0))
#!g V = (TRUE # 1L # 1.5 # "muhuhu" # as.raw(67))
#!g O = ( < # <= # == # != # >= # > )
#!t "logical"
typeof(@V @O @T)

#! complex and string can be compared
#!t "logical"
#!g O = ( < # <= # == # != # >= # > )
typeof("foo" @O (2+3i))

#! == and != can be used with complex numbers too (lhs)
#!g T = (FALSE # -3L # 0.5 # "foo" # as.raw(0))
#!g O = ( == # != )
#!t "logical"
typeof((2+3i) @O @T)

#! == and != can be used with complex numbers too (rhs)
#!g T = (FALSE # -3L # 0.5 # "foo" # as.raw(0))
#!g O = ( == # != )
#!t "logical"
typeof(@T @O (2+3i))

#! comparison with complex numbers is not allowed
#!e invalid comparison with complex values
#!g T = (TRUE # 1L # 3 # 3.2 # as.raw(0))
#!g O = ( < # <= # >= # > )
(@T) @O (2+3i)

#! comparison of two complex numbers is not allowed
#!e invalid comparison with complex values
#!g O = ( < # <= # >= # > )
(3+3i) @O (4+7i)

#!# equality ----------------------------------------------------------------------------------------------------------

#! on all types equality works
#!g T1 = (TRUE # FALSE # 0L # -1L # 2L # 3 # 4.1 # (2+3i) # "foo" # as.raw(10))
@T1 == @T1

#! on all types equality works
#!g T1 = (TRUE # FALSE # 0L # -1L # 2L # 3 # 4.1 # (2+3i) # "foo" # as.raw(10))
#!g T2(T1) = (FALSE # TRUE # 1L # -2L # 0L # 4 # 4.2 # (2+4i) # "bar" # as.raw(100))
#!t FALSE
@T1 == @T2

#! equality works for all types with typecasts for 1 (true)
#!g T = (TRUE # 1L # 1 # 1.0 # 1+0i # as.raw(1)) 
#!g V = (TRUE # 1L # 1 # 1.0 # 1+0i # as.raw(1)) 
#!t TRUE TRUE
@T == @V
@V == @T

#! equality with string is the string representation of the value (1)
#!g T =    (TRUE # 1L # 1 # 1.0 # 1+0i # as.raw(1)) 
#!g V(T) = ("TRUE" # "1" # "1" # "1" # "1+0i" # "01") 
#!t TRUE TRUE
@T == @V
@V == @T

#! equality works for all types with typecasts for 0 (false)
#!g T = (FALSE # 0L # 0 # 0.0 # 0+0i # as.raw(0)) 
#!g V = (FALSE # 0L # 0 # 0.0 # 0+0i # as.raw(0)) 
#!t TRUE TRUE
@T == @V
@V == @T

#! equality with string is the string representation of the value (1)
#!g T =    (FALSE # 0L # 0 # 0.0 # 0+0i # as.raw(0)) 
#!g V(T) = ("FALSE" # "0" # "0" # "0" # "0+0i" # "00") 
#!t TRUE TRUE
@T == @V
@V == @T

#! equality is false for different types
#!g T = (FALSE # 0L # 0 # 0.0 # 0+0i # as.raw(0)) 
#!g V = (TRUE # 1L # 1 # 1.0 # 1+0i # as.raw(1)) 
#!t FALSE FALSE
@T == @V
@V == @T

#! equality is false also for string comparisons
#!g T = (FALSE # 0L # 0 # 0.0 # 0+0i # as.raw(0)) 
#!g V = ("TRUE" # "1" # 01 # 1+0i) 
#!t FALSE FALSE
@T == @V
@V == @T

#! empty string is not equal to true or false or NA
#!t FALSE FALSE NA FALSE FALSE NA
"" == FALSE
"" == TRUE
"" == NA
FALSE == ""
TRUE == ""
NA == ""

#!# inequality --------------------------------------------------------------------------------------------------------

#! on all types inequality works
#!g T1 =     (TRUE # FALSE # 0L # -1L # 2L # 3 # 4.1 # (2+3i) # "foo" # as.raw(10))
#!g T2(T1) = (FALSE # TRUE # 1L # 1L  # 3L # 4 # 5.1 # (3+2i) # "bar" # as.raw(11))
@T1 != @T2

#! on all types inequality works
#!g T1 =     (TRUE # FALSE # 0L # -1L # 2L # 3 # 4.1 # (2+3i) # "foo" # as.raw(10))
#!t FALSE
@T1 != @T1

#! inequality works for all types with typecasts
#!g T = (TRUE # 1L # 1 # 1.0 # 1+0i # as.raw(1)) 
#!g V = (FALSE # 0L # 0 # 0.0 # 0+0i # as.raw(0)) 
#!t TRUE TRUE
@T != @V
@V != @T

#! inequality with string works for all strings including the empty one
#!g T = (TRUE # 1L # 1 # 1.0 # 1+0i # as.raw(1)) 
#!g V = ("FALSE" # "0" # "0+0i" # "00") 
#!t TRUE TRUE
@T != @V
@V != @T

#! empty string is not equal to any logical or NA
#!ttt
"" != TRUE
"" != FALSE
"" != NA
TRUE != ""
FALSE != ""
NA != ""

#!# less than ---------------------------------------------------------------------------------------------------------

#! less than works for numbers in multiple conversions
#!# does not work for complex values, already tested in the output type tests for ROs
#!g T1 = (FALSE # -1L # 0L # 0.1)
#!g T2 = (TRUE # 3L # 0.2)
#!t TRUE FALSE
@T1 < @T2
@T2 < @T1

#! on strings < works lexicographically
#!ttt
"a" < "b"
"a" < "aa"
"ab " < "ac"

#! on strings < works lexicographically
#!t FALSE FALSE FALSE
"b" < "a"
"aa" < "a"
"ac " < "ab"

#! empty string is smaller than any string
#!g T = ("a" # " " # "0" # "1" # "-1")
"" < @T

#! number and string is also compared lexicographically
#!t TRUE FALSE
"11" < 2
2 < "11"

#! negative numbers are smaller than positive numbers when string comparison is used
#!t TRUE FALSE TRUE FALSE
"-1" < 1
1 < "-1"
-1 < "1"
"1" < -1

#!# greater than ------------------------------------------------------------------------------------------------------

#! greater than works for numbers in multiple conversions
#!# does not work for complex values, already tested in the output type tests for ROs
#!g T1 = (FALSE # -1L # 0L # 0.1)
#!g T2 = (TRUE # 3L # 0.2)
#!t TRUE FALSE
@T2 > @T1
@T1 > @T2

#! on strings > works lexicographically
#!t FALSE FALSE FALSE
"a" > "b"
"a" > "aa"
"ab " > "ac"

#! on strings > works lexicographically
#!ttt
"b" > "a"
"aa" > "a"
"ac " > "ab"

#! empty string is smaller than any string
#!g T = ("a" # " " # "0" # "1" # "-1")
@T > ""

#! number and string is also compared lexicographically
#!t TRUE FALSE
2 > "11"
"11" > 2

#! negative numbers are smaller than positive numbers when string comparison is used
#!t FALSE TRUE FALSE TRUE
"-1" > 1
1 > "-1"
-1 > "1"
"1" > -1

#!# less than or equal ------------------------------------------------------------------------------------------------

#! less than or equal works for numbers in multiple conversions
#!# does not work for complex values, already tested in the output type tests for ROs
#!g T1 = (FALSE # -1L # 0L # 0.1)
#!g T2 = (TRUE # 3L # 0.2)
@T1 <= @T2

#! less than or equal works on equal values too
#!g T = (FALSE # -1L # 0L # 0.1)
@T <= @T

#! reverse does not work for values not being the same
#!g T1 = (FALSE # -1L # 0L # 0.1)
#!g T2 = (TRUE # 3L # 0.2)
#!t FALSE
@T2 <= @T1

#! on strings <= works lexicographically
#!ttt
"a" <= "b"
"a" <= "aa"
"ab " <= "ac"
"a" <= "a"

#! on strings <= works lexicographically
#!t FALSE FALSE FALSE
"b" <= "a"
"aa" <= "a"
"ac " <= "ab"

#! empty string is smaller than any string and equal to itself
#!g T = ("a" # " " # "0" # "1" # "-1" # "")
"" <= @T

#! number and string is also compared lexicographically
#!t TRUE FALSE TRUE
"11" <= 2
2 <= "11"
11 <= "11"

#!# greater than or equal ------------------------------------------------------------------------------------------------

#! greater than or equal works for numbers in multiple conversions
#!# does not work for complex values, already tested in the output type tests for ROs
#!g T1 = (FALSE # -1L # 0L # 0.1)
#!g T2 = (TRUE # 3L # 0.2)
@T2 >= @T1

#! greater than or equal works on equal values too
#!g T = (FALSE # -1L # 0L # 0.1)
@T >= @T

#! reverse does not work for values not being the same
#!g T1 = (FALSE # -1L # 0L # 0.1)
#!g T2 = (TRUE # 3L # 0.2)
#!t FALSE
@T1 >= @T2

#! on strings >= works lexicographically
#!ttt
"b" >= "a"
"aa" >= "a"
"ac " >= "ab"
"a" >= "a"

#! on strings >= works lexicographically
#!t FALSE FALSE FALSE
"a" >= "b"
"a" >= "aa"
"ab " >= "ac"

#! empty string is smaller than any string and equal to itself
#!g T = ("a" # " " # "0" # "1" # "-1" # "")
@T >= ""

#! number and string is also compared lexicographically
#!t FALSE TRUE TRUE
"11" >= 2
2 >= "11"
11 >= "11"

#!# relational operators do no rounding -------------------------------------------------------------------------------

#! relational operators does not take rounding into account
#!t FALSE
x1 <- 0.5 - 0.3
x2 <- 0.3 - 0.1
x1 == x2
x1 < x2
x1 <= x2

#! relational operators does not take rounding into account
x1 <- 0.5 - 0.3
x2 <- 0.3 - 0.1
x1 != x2
x1 > x2
x1 >= x2

#!# relational operators on vectors -----------------------------------------------------------------------------------

#! relational operators work on vectors, produce the same length vector
#!g O = ( < # <= # == # != # >= # > )
#!t 3
a = c(1,2,3)
b = c(3,4,5)
length(a @O b)

#! correct values of the vectors for less than
#!t TRUE FALSE TRUE FALSE TRUE
a = c(10,13,1,8,7)
b = c(11,10,9,8,10)
a < b

#! correct values of the vectors for less than or equal
#!t TRUE FALSE TRUE TRUE TRUE
a = c(10,13,1,8,7)
b = c(11,10,9,8,10)
a <= b

#! correct values of the vectors for equal
#!t FALSE FALSE FALSE TRUE FALSE
a = c(10,13,1,8,7)
b = c(11,10,9,8,10)
a == b

#! correct values of the vectors for not equal
#!t TRUE TRUE TRUE FALSE TRUE
a = c(10,13,1,8,7)
b = c(11,10,9,8,10)
a != b

#! correct values of the vectors for greater than or equal
#!t FALSE TRUE FALSE TRUE FALSE
a = c(10,13,1,8,7)
b = c(11,10,9,8,10)
a >= b

#! correct values of the vectors for greater than
#!t FALSE TRUE FALSE TRUE FALSE
a = c(10,13,1,8,7)
b = c(11,10,9,8,10)
a >= b

#! smaller vector gets recycled (size only)
#!g O = ( < # <= # == # != # >= # > )
#!t 6
a = c(1,2,3,4,5,6)
b = c(1,3)
length(a @O b)

#! smaller vector gets recycled (size only), scalar being the extreme case
#!g O = ( < # <= # == # != # >= # > )
#!t 6
a = c(1,2,3,4,5,6)
b = 3
length(a @O b)

#! a warning is produced if the larger size is not divisible by the smaller one
#!g O = ( < # <= # == # != # >= # > )
#!w longer object length is not a multiple of shorter object length
#!o 5
a = c(1,2,3,4,5)
b = c(1,3)
length(a @O b)


#! smaller vector gets recycled less than
#!t FALSE TRUE FALSE FALSE FALSE FALSE
a = c(1,2,3,4,5,6)
b = c(1,3)
a < b

#! smaller vector gets recycled less than or equal
#!t TRUE FALSE TRUE FALSE FALSE FALSE
a = c(1,2,3,4,5,6)
b = c(3,1)
a <= b

#! smaller vector gets recycled equal
#!t FALSE FALSE TRUE FALSE FALSE FALSE
a = c(1,2,3,4,5,6)
b = c(3,1)
a == b

#! smaller vector gets recycled not equal
#!t TRUE TRUE FALSE TRUE TRUE TRUE
a = c(1,2,3,4,5,6)
b = c(3,1)
a != b

#! smaller vector gets recycled greater than or equal
#!t FALSE TRUE TRUE TRUE TRUE TRUE
a = c(1,2,3,4,5,6)
b = c(3,1)
a >= b

#! smaller vector gets recycled greater than
#!t FALSE TRUE FALSE TRUE TRUE TRUE
a = c(1,2,3,4,5,6)
b = c(3,1)
a > b

#! NA or NaN in single vector produces NA only in particular place
#!g O = ( < # <= # == # != # >= # > )
#!ttt
a = c(1,2,3,4,5,6)
b = c(1,NA,2,NaN,3,4)
a = a @O b
!is.na(a[1])
is.na(1[2])
!is.na(a[3])
is.na(1[4])
!is.na(a[5])
!is.na(a[6])

#!# relational operators on non vector types --------------------------------------------------------------------------

#! relational operators on matrices work as on vectors, dimension is left is the same
#!g O = ( < # <= # == # != # >= # > )
#!t 2 2 4 "logical"
a = matrix(c(1,2,3,4), 2, 2)
b = matrix(c(1,4,2,3), 2, 2)
a = a @O b
dim(a)
length(a)
typeof(a)

#! if dimensions are different, comparison does not work
#!e non-conformable arrays
#!g O = ( < # <= # == # != # >= # > )
a = matrix(c(1,2,3,4), 2, 2)
b = matrix(c(1,4,2,3), 1, 4)
a = a @O b

#! relational operators on arrays work as on vectors, dimension is left is the same
#!g O = ( < # <= # == # != # >= # > )
#!t 2 2 2 8 "logical"
a = array(c(1,2,3,4,5,6,7,8), c(2, 2, 2))
b = array(c(1,4,2,3,6,8,7,5), c(2, 2, 2))
a = a @O b
dim(a)
length(a)
typeof(a)

#! if dimensions are different, comparison does not work
#!e non-conformable arrays
#!g O = ( < # <= # == # != # >= # > )
a = array(c(1,2,3,4,5,6,7,8), c(1, 2, 4))
b = array(c(1,4,2,3,6,8,7,5), c(2, 2, 2))
a = a @O b

#! if dimensions length is different, comparison does not work
#!e non-conformable arrays
#!g O = ( < # <= # == # != # >= # > )
a = array(c(1,2,3,4,5,6,7,8), c(2, 2, 2))
b = array(c(1,4,2,3), c(2, 2))
a = a @O b

#! if dimensions are different, comparison does not work
#!e non-conformable arrays
#!g O = ( < # <= # == # != # >= # > )
a = array(c(1,2,3,4,5,6,7,8), c(2, 2, 2))
b = array(c(1,4,2,3), c(2, 2))
a = a @O b

#! relational operators on lists with different value types are not allowed
#!g O = ( < # <= # == # != # >= # > )
#!e comparison of these types is not implemented
a = list(TRUE, 1, 3, "haha")
b = list(4, "foo", 10, NA)
a @O b

#! relational operators does not work two with lists where elements are of the same type
#!g O = ( < # <= # == # != # >= # > )
#!e comparison of these types is not implemented
a = list(1,2,3,4)
b = list(1,4,2,3)
a @O b

#! relational operators work with a vector and a list of same type (only atomic values size 1) regardles of position
#!g O = ( < # <= # == # != # >= # > )
#!t 5 "logical" 5 "logical"
a = c(1,2,3,4,5)
b = list(4,3,1,2,5)
d = a @O b
length(d)
typeof(d)
d = b @O a
length(d)
typeof(d)

#! if the list in comparison can be coerced, it is - coercion to string
#!g O =    ( < # <= # == # != # >= # > )
#!g R(O) = ( FALSE FALSE FALSE # FALSE FALSE TRUE # FALSE FALSE TRUE # TRUE TRUE FALSE # TRUE TRUE TRUE # TRUE TRUE FALSE)
#!t @R
a = c("2", "FALSE", "4+2i")
b = list(11,"bar",4+2i)
a @O b

#! coercion of strings to integers is also possible
#!g O =    ( < # <= # == # != # >= # > )
#!o 3
a = c(1,2,3)
b = list("3","4","5")
length(a @O b)

#! a warning is produced if NA's are introduced by the coercion
#!g O =    ( < # <= # == # != # >= # > )
#!w NAs introduced by coercion
#!o 3 TRUE TRUE TRUE
a = c(1,2,3)
b = list("3","4","foo")
a = (a @O b)
length(a)
!is.na(a[1])
!is.na(a[2])
is.na(a[3])

#! list can be recycled as well
#!g O = ( < # <= # == # != # >= # > )
#!t 6
a = c(1,2,3,4,5,6)
b = list(1,2)
length(a @O b)

#! vector in list comparison can be recycled as well
#!g O = ( < # <= # == # != # >= # > )
#!t 6
a = list(1,2,3,4,5,6)
b = c(1,2)
length(a @O b)

#! a warning is produced when list recycled is not the multiple of vector
#!g O = ( < # <= # == # != # >= # > )
#!w longer object length is not a multiple of shorter object length
#!o 5
a = c(1,2,3,4,5)
b = list(1,2)
length(a @O b)

#! a warning is produced when vector recycled is not the multiple of list
#!g O = ( < # <= # == # != # >= # > )
#!w longer object length is not a multiple of shorter object length
#!o 5
a = list(1,2,3,4,5)
b = c(1,2)
length(a @O b)
