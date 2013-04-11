#!# arithmetic operators, from R help mostly

#!# more complex tests of specific values are not necessary as almost everything apart from 0 is TRUE and this is tested by conversion methods

#!# arithmetic operators and data types -------------------------------------------------------------------------------

#! vector can be used for unary -
a = c(1,2,3,4,5)
b = -a
TRUE

#! operator unary - works element wise on vectors
#!t 5
a = c(1,2,3,4,5)
length(-a)

#! operator unary - works on matrices
a = matrix(1,3,3)
b = -a
TRUE

#! operator unary - works on matrices elementwise
#!t 9
a = matrix(1,3,3)
length(!a)

#! operator unary - works on arrays
a = array(1,c(2,2,2))
b = -a
TRUE

#! operator unary - works on arrays elementwise
#!t 8
a = array(1,c(2,2,2))
length(-a)

#! operator unary - cannot be used with lists
#!e invalid argument to unary operator
a = list(1,2,3,4)
-a

#! vector can be used for binary arithmetic operators
#!g O = ( + # - # * # / # %% # %/% # ^ )
a = c(1,2,3,4,5)
b = c(1,2,3,4,5)
a = a @O b
TRUE

#! binary arithmetic operators work on vectors elementwise
#!g O = ( + # - # * # / # %% # %/% # ^ )
#!t 5
a = c(1,2,3,4,5)
b = c(1,2,3,4,5)
length(a @O b)

#! smaller vector gets recycled
#!g O = ( + # - # * # / # %% # %/% # ^ )
#!g T(O) = ( 15 33 # 9 27 # 36 90 # 4 10 # 0 0 # 4 10 # 1728 27000)
#!t @T
a = c(12,30)
b = c(3)
a @O b

#! warning is produced if larger vector is not multiple of smaller
#!g O = ( + # - # * # / # %% # %/% # ^ )
#!w longer object length is not a multiple of shorter object length
#!o 5
a = c(1,2,3,4,5)
b = c(1,2,3)
length(a @O b)

#! matrix can be used for binary arithmetic operators
#!g O = ( + # - # * # / # %% # %/% # ^ )
a = matrix(1,2,2)
b = matrix(1,2,2)
a = a @O b
TRUE

#! matrix can be used for binary arithmetic operators, works elementwise
#!g O = ( + # - # * # / # %% # %/% # ^ )
#!t 4
a = matrix(1,2,2)
b = matrix(1,2,2)
length(a @O b)

#! matrices of different dimensions cannot be used
#!g O = ( + # - # * # / # %% # %/% # ^ )
#!e non-conformable arrays
a = matrix(1,2,2)
b = matrix(1,4,2)
a @O b

#! array can be used for binary arithmetic operators
#!g O = ( + # - # * # / # %% # %/% # ^ )
a = array(1,c(2,2,2))
b = array(1,c(2,2,2))
a = a @O b
TRUE

#! arrays can be used for binary arithmetic operators, works elementwise
#!g O = ( + # - # * # / # %% # %/% # ^ )
#!t 8
a = array(1,c(2,2,2))
b = array(1,c(2,2,2))
length(a @O b)

#! arrays of different number of dimensions cannot be used for binary arithmetic operatirs
#!g O = ( + # - # * # / # %% # %/% # ^ )
#!e non-conformable arrays
a = array(1,c(2,2,2))
b = array(1,c(2,2,2,2))
a @O b

#! arrays of different dimensions cannot be used for arithmetic operators
#!g O = ( + # - # * # / # %% # %/% # ^ )
#!e non-conformable arrays
a = array(1,c(2,2,2))
b = array(1,c(2,4,2))
a @O b

#!# to observe the result of vector+ array, see propagation of dim attribute later in this file

#! arrays and vectors can be used for binary operators (array lhs)
#!g O = ( + # - # * # / # %% # %/% # ^ )
#!t 8
a = array(1,c(2,2,2))
b = c(1,2)
length(a @O b)

#! arrays and vectors can be used for binary operators (array rhs)
#!g O = ( + # - # * # / # %% # %/% # ^ )
#!t 8
a = array(1,c(2,2,2))
b = c(1,2)
length(a @O b)

#! lists cannot be used for arithmetic operators
#!g O = ( + # - # * # / # %% # %/% # ^ )
#!e non-numeric argument to binary operator
a = list(1,2,3)
b = list(3,4,5)
a @O b

#! lists and vectors cannot be used for binary operators (list lhs)
#!g O = ( + # - # * # / # %% # %/% # ^ )
#!e non-numeric argument to binary operator
a = list(1,2,3)
b = c(1,2,3)
a @O b

#! lists and vectors cannot be used for binary operators (list rhs)
#!g O = ( + # - # * # / # %% # %/% # ^ )
#!e non-numeric argument to binary operator
a = list(1,2,3)
b = c(1,2,3)
b @O a

#!# user attributes ---------------------------------------------------------------------------------------------------

#! custom attributes are preserved by unary minus
#!t 56
a = c(1,2,3,4)
attributes(a) = list(haha=56)
attributes(-a)$haha

#! custom attributes are preserved by binary arithmetics if the same and unified if value is the same
#!g O = ( + # - # * # / # %% # %/% # ^ )
#!t 56 1
a = c(1,2,3,4)
b = c(1,2,3,4)
attributes(a) = list(haha=56)
attributes(b) = list(haha=56)
attributes(a @O b)$haha
length(attributes(a @O b))

#! custom attributes are preserved by binary arithmetics if different and their union is in result
#!g O = ( + # - # * # / # %% # %/% # ^ )
#!t 2 56 78
a = c(1,2,3,4)
b = c(1,2,3,4)
attributes(a) = list(haha=56)
attributes(b) = list(habubu=78)
length(attributes(a @O b))
attributes(a @O b)$haha
attributes(a @O b)$habubu

#! when attribute names are the same and values differ, values from left argument are used for binary arithmetics
#!g O = ( + # - # * # / # %% # %/% # ^ )
#!t 1 56
a = c(1,2,3,4)
b = c(1,2,3,4)
attributes(a) = list(haha=56)
attributes(b) = list(haha=78)
length(attributes(a @O b))
attributes(a @O b)$haha

#!# names attribute ---------------------------------------------------------------------------------------------------

#! names attribute is preserved by unary -
#!t "a" "b" "c"
a = c(a =1, b = 2, c = 3)
names(-a)

#! if the names are not for whole vector, they are still preserved for the result for unary minus
#!t "a" "b" ""
a = c(a=1, b=2, 3)
names(-a)

#! names attribute is preserved by binary arithmetics if  the same for both operands
#!g O = ( + # - # * # / # %% # %/% # ^ )
#!t "a" "b" "c"
a = c(a =1, b = 2, c = 3)
b = c(a =1, b = 2, c = 3)
names(a @O b)

#! if the names are not for whole vector, they are still preserved for the result for binary arithmetics
#!g O = ( + # - # * # / # %% # %/% # ^ )
#!t "a" "b" ""
a = c(a=1, b=2, 3)
b = c(a=1, b=2, 3)
names(a @O b)

#! if names present in both vectors, names from first vector are used for binary arithmetics
#!g O = ( + # - # * # / # %% # %/% # ^ )
#!t "a" "b" ""
a = c(a=1, b=2, 3)
b = c(a=1, b=2, c=3)
names(a @O b)

# if names not present in first argument, names from second are used for binary arithmetics
#!g O = ( + # - # * # / # %% # %/% # ^ )
#!t "a" "b" "c"
a = c(1, 2, 3)
b = c(a=1, b=2, c=3)
names(a @O b)

#!# dim attribute -----------------------------------------------------------------------------------------------------

#! dim attribute is preserved by unary -
#!t 1 2 3
a = array(1,c(1,2,3))
dim(-a)

#! dim attribute is preserved by binary arithmetics
#!g O = ( + # - # * # / # %% # %/% # ^ )
#!t 1 2 3
a = array(1,c(1,2,3))
b = array(1,c(1,2,3))
dim(a @O b)

# if dim not present in first argument, dim from second are used for binary arithmetics
#!g O = ( + # - # * # / # %% # %/% # ^ )
#!t 1 2 3
a = c(1, 2, 3)
b = array(1,c(1,2,3))
dim(a @O b)

# if dim not present in second argument, dim from first are used for binary arithmetics
#!g O = ( + # - # * # / # %% # %/% # ^ )
#!t 1 2 3
a = c(1, 2, 3)
b = array(1,c(1,2,3))
dim(b @O a)

#! when dim argument is present in left argument, names from right argument are not used
#!g O = ( + # - # * # / # %% # %/% # ^ )
a = c(a=1, b=2, c=3)
b = array(1,c(1,2,3))
is.null(names(b @O a))

#! when dim argument is present in right argument, names from left argument are not used
#!g O = ( + # - # * # / # %% # %/% # ^ )
a = c(a=1, b=2, c=3)
b = array(1,c(1,2,3))
is.null(names(a @O b))

#! dimnames attribute -------------------------------------------------------------------------------------------------

#! dimnames attribute is preserved by unary minus
#!t "a" "b" "c" "d" "e" "f"
a = array(1,c(2,2,2), dimnames=list(c("a","b"), c("c","d"), c("e","f")))
a = dimnames(-a)
a[[1]]
a[[2]]
a[[3]]

#! dimnames attribute is preserved by binary arithmetics if both dimensions are the same
#!g O = ( + # - # * # / # %% # %/% # ^ )
#!t "a" "b" "c" "d" "e" "f"
a = array(1,c(2,2,2), dimnames=list(c("a","b"), c("c","d"), c("e","f")))
b = array(1,c(2,2,2), dimnames=list(c("a","b"), c("c","d"), c("e","f")))
a = dimnames(a @O b)
a[[1]]
a[[2]]
a[[3]]

#! if dimnames for arguments differ, the first dimnames are used for binary arithmetics
#!g O = ( + # - # * # / # %% # %/% # ^ )
#!t "a" "b" "c" "d" "e" "f"
a = array(1,c(2,2,2), dimnames=list(c("a","b"), c("c","d"), c("e","f")))
b = array(1,c(2,2,2), dimnames=list(c("A","B"), c("C","D"), c("E","F")))
a = dimnames(a @O b)
a[[1]]
a[[2]]
a[[3]]

#! if first dimnames are missing, second argument's dimnames are used for resulr for binary arithmetics
#!g O = ( + # - # * # / # %% # %/% # ^ )
#!t "a" "b" "c" "d" "e" "f"
a = array(1,c(2,2,2))
b = array(1,c(2,2,2), dimnames=list(c("a","b"), c("c","d"), c("e","f")))
a = dimnames(a @O b)
a[[1]]
a[[2]]
a[[3]]

#!# operator unary - -------------------------------------------------------------------------------------------------

#! -0 and 0 are the same
a = -0
b = 0
a == b

#! negative 0 is different from positive 0 in operations 
a = -0
b = 0
(5 / a) != ( 5 / b)

#! in integers, 0 and -0 are the same
a = -0L
b = 0L
(5 / a) == ( 5 / b)

#! unary - has no effect on NA
#!t NA NA
a = -NA
b = NA
a
b

#! unary - has no effect on NaN
#!t NaN NaN
a = -NaN
b = NaN
a
b

#!# operator + --------------------------------------------------------------------------------------------------------

#! operator + of two logicals or integers is an integer
#!g T1 = (TRUE # 2L)
#!g T2 = (TRUE # 4L)
#!t "integer"
a = @T1
b = @T2
typeof(a + b)

#! operator + of at least one double and logical integer or double is double
#!g T = (TRUE # 2L # 3)
#!t "double" "double"
a = @T
typeof(a + 3.2)
typeof(1.5 + a)

#! operator + with any side being complex returns complex
#!g T = (TRUE # 2L # -3 # 2.1)
#!t "complex" "complex"
mode((2+3i) + @T)
mode(@T + (2+3i))

#! operator + with numeric and logical is numeric
#!g T = (TRUE # 2L # -3 # 2.1)
#!t "numeric" "numeric"
mode((3) + @T)
mode(@T + (3))

#! operator + with two logicals is still numeric
#!g T1 = ( TRUE # FALSE)
#!g T2 = ( TRUE # FALSE)
#!t "numeric"
mode(@T1 + @T2)

#! operator +: NA + anything is always NA
#!g T = (NA # NaN # TRUE # 2L # 2.1 # 2+3i)
#!t NA NA
NA + (@T)
(@T) + NA

#! operator +: NA + anything is numeric mode, or complex if complex 
#!g T =    (NA # NaN # 2L # 2.1 # 2+3i)
#!g V(T) = ("numeric" # "numeric" # "numeric" # "numeric" # "complex")
#!t @V @V
mode(NA + (@T))
mode((@T) + NA)

#! operator +: NaN + any number is always NaN
#!g T = ( TRUE # 3L # -4L # 2 # 3.1 # -6.7)
#!t NaN NaN
NaN + (@T)
(@T) + NaN

#! operator +: NaN + any number is always numeric mode
#!g T = ( TRUE # 3L # -4L # 2 # 3.1 # -6.7)
#!t "numeric" "numeric"
mode(NaN + (@T))
mode((@T) + NaN)

#! operator +: NaN + complex is NaN
#!g T = ( 2+3i # -2-3i )
#!t NaN NaN
#!dt
#!# It is actually NA 
NaN + (@T)
(@T) + NaN

#! operator +: NaN + complex is complex mode
#!g T = ( 2+3i # -2-3i )
#!t "complex" "complex"
mode(NaN + (@T))
mode((@T) + NaN)

#! operator + is commutative for numeric types
#!g T1 = ( TRUE # 3L # -4L # 2 # 3.1 # -6.7 # 2+3i # -2-3i)
#!g T2 = ( FALSE # TRUE # -2L # 5L # 7 # 3.1 # -2.5 # 4+8i # -3+2i)
(@T1) + (@T2) == (@T2) + (@T1)

#! operator + does not work on strings or raw types with any other types from left
#!e non-numeric argument to binary operator
#!g T1 = ("foo" # as.raw(45))
#!g T2 = ( TRUE # 3L # -4L # 2 # 3.1 # -6.7 # 2+3i # -2-3i # as.raw(10) # "bar")
@T2 + @T1

#! operator + does not work on strings or raw types with any other types from right
#!e non-numeric argument to binary operator
#!g T1 = ("foo" # as.raw(45))
#!g T2 = ( TRUE # 3L # -4L # 2 # 3.1 # -6.7 # 2+3i # -2-3i # as.raw(10) # "bar")
@T1 + @T2

#!# operator + cancelling complex part remains complex mode
#!t "complex"
a = 2+3i
b = 4-3i
a = a + b
mode(a)

#! Inf + Inf is Inf
#!t Inf
a = Inf
b = Inf
a + b

#! Inf + -Inf is NaN
#!t NaN NaN
a = Inf
b = -Inf
a + b
b + a

#! NA + Inf is NA
#!g T = ( Inf # -Inf)
#!t NA NA
a = NA
b = @T
a + b
b + a

#! NaN + Inf is NaN
#!g T = ( Inf # -Inf)
#!t NaN NaN
a = NaN
b = @T
a + b
b + a

#! Inf + any number is Inf
#!g T = ( -300 # 300 )
#!t Inf
a = Inf
b = @T
a + b

#!# operator - --------------------------------------------------------------------------------------------------------

#! operator - of two logicals or integers is an integer
#!g T1 = (TRUE # 2L)
#!g T2 = (TRUE # 4L)
#!t "integer"
a = @T1
b = @T2
typeof(a - b)

#! operator - of at least one double and logical integer or double is double
#!g T = (TRUE # 2L # 3)
#!t "double" "double"
a = @T
typeof(a - 3.2)
typeof(1.5 - a)

#! operator - with any side being complex returns complex
#!g T = (TRUE # 2L # -3 # 2.1)
#!t "complex" "complex"
mode((2+3i) - @T)
mode(@T - (2+3i))

#! operator - with numeric and logical is numeric
#!g T = (TRUE # 2L # -3 # 2.1)
#!t "numeric" "numeric"
mode((3) - @T)
mode(@T - (3))

#! operator - with two logicals is still numeric
#!g T1 = ( TRUE # FALSE)
#!g T2 = ( TRUE # FALSE)
#!t "numeric"
mode(@T1 - @T2)

#! operator -: NA - anything is always NA
#!g T = (NA # NaN # TRUE # 2L # 2.1 # 2+3i)
#!t NA NA
NA - (@T)
(@T) - NA

#! operator -: NA - anything is numeric mode, or complex if complex 
#!g T =    (NA # NaN # 2L # 2.1 # 2+3i)
#!g V(T) = ("numeric" # "numeric" # "numeric" # "numeric" # "complex")
#!t @V @V
mode(NA - (@T))
mode((@T) - NA)

#! operator -: NaN - any number is always NaN
#!g T = ( TRUE # 3L # -4L # 2 # 3.1 # -6.7)
#!t NaN NaN
NaN - (@T)
(@T) - NaN

#! operator -: NaN - any number is always numeric mode
#!g T = ( TRUE # 3L # -4L # 2 # 3.1 # -6.7)
#!t "numeric" "numeric"
mode(NaN - (@T))
mode((@T) - NaN)

#! operator -: NaN - complex is NaN
#!g T = ( 2+3i # -2-3i )
#!t NaN NaN
#!dt
#!# It is actually NA 
NaN - (@T)
(@T) - NaN

#! operator -: NaN - complex is complex mode
#!g T = ( 2+3i # -2-3i )
#!t "complex" "complex"
mode(NaN - (@T))
mode((@T) - NaN)

#! operator - does not work on strings or raw types with any other types from left
#!e non-numeric argument to binary operator
#!g T1 = ("foo" # as.raw(45))
#!g T2 = ( TRUE # 3L # -4L # 2 # 3.1 # -6.7 # 2+3i # -2-3i # as.raw(10) # "bar")
@T2 - @T1

#! operator - does not work on strings or raw types with any other types from right
#!e non-numeric argument to binary operator
#!g T1 = ("foo" # as.raw(45))
#!g T2 = ( TRUE # 3L # -4L # 2 # 3.1 # -6.7 # 2+3i # -2-3i # as.raw(10) # "bar")
@T1 - @T2

#!# operator - cancelling complex part remains complex mode
#!t "complex"
a = 2+3i
b = 4+3i
a = a + b
mode(a)

#! Inf - Inf is NaN
#!t NaN NaN
a = Inf
b = -Inf
a + b
b + a

#! Inf - (-Inf) is Inf
#!t Inf
a = Inf
b = -Inf
a - b

#! NA - Inf is NA
#!g T = ( Inf # -Inf)
#!t NA NA
a = NA
b = @T
a - b
b - a

#! NaN - Inf is NaN
#!g T = ( Inf # -Inf)
#!t NaN NaN
a = NaN
b = @T
a - b
b - a

#! Inf - any number is Inf
#!g T = ( -300 # 300 )
#!t Inf
a = Inf
b = @T
a - b

#! any number - Inf is -Inf
#!g T = ( -300 # 300 )
#!t -Inf
a = @T
b = Inf
a - b

#!# operator * --------------------------------------------------------------------------------------------------------

#! operator * of two logicals or integers is an integer
#!g T1 = (TRUE # 2L)
#!g T2 = (TRUE # 4L)
#!t "integer"
a = @T1
b = @T2
typeof(a * b)

#! operator * of at least one double and logical integer or double is double
#!g T = (TRUE # 2L # 3)
#!t "double" "double"
a = @T
typeof(a * 3.2)
typeof(1.5 * a)

#! NA * 0 is NA
#!t NA
a = NA
a * 0

#! NaN * 0 is NaN
#!t NaN
a = NaN
a * 0

#! NaN * 0 in integers is NA
#!t NA
a = as.integer(NaN)
a * 0L

#! operator * with any side being complex returns complex
#!g T = (TRUE # 2L # -3 # 2.1)
#!t "complex" "complex"
mode((2+3i) * @T)
mode(@T * (2+3i))

#! operator * with numeric and logical is numeric
#!g T = (TRUE # 2L # -3 # 2.1)
#!t "numeric" "numeric"
mode((3) * @T)
mode(@T * (3))

#! operator * with two logicals is still numeric
#!g T1 = ( TRUE # FALSE)
#!g T2 = ( TRUE # FALSE)
#!t "numeric"
mode(@T1 * @T2)

#! operator +: NA * anything is always NA
#!g T = (NA # NaN # TRUE # 2L # 2.1 # 2+3i)
#!t NA NA
NA * (@T)
(@T) * NA

#! operator *: NA * anything is numeric mode, or complex if complex 
#!g T =    (NA # NaN # 2L # 2.1 # 2+3i)
#!g V(T) = ("numeric" # "numeric" # "numeric" # "numeric" # "complex")
#!t @V @V
mode(NA * (@T))
mode((@T) * NA)

#! operator *: NaN * any number is always NaN
#!g T = ( TRUE # 3L # -4L # 2 # 3.1 # -6.7)
#!t NaN NaN
NaN * (@T)
(@T) * NaN

#! operator *: NaN * any number is always numeric mode
#!g T = ( TRUE # 3L # -4L # 2 # 3.1 # -6.7)
#!t "numeric" "numeric"
mode(NaN * (@T))
mode((@T) * NaN)

#! operator *: NaN * complex is NaN
#!g T = ( 2+3i # -2-3i )
#!t NaN NaN
#!dt
#!# It is actually NA 
NaN * (@T)
(@T) * NaN

#! operator *: NaN * complex is complex mode
#!g T = ( 2+3i # -2-3i )
#!t "complex" "complex"
mode(NaN * (@T))
mode((@T) * NaN)

#! operator * is commutative for numeric types
#!g T1 = ( TRUE # 3L # -4L # 2 # 3.1 # -6.7 # 2+3i # -2-3i)
#!g T2 = ( FALSE # TRUE # -2L # 5L # 7 # 3.1 # -2.5 # 4+8i # -3+2i)
(@T1) * (@T2) == (@T2) * (@T1)

#! operator * does not work on strings or raw types with any other types from left
#!e non-numeric argument to binary operator
#!g T1 = ("foo" # as.raw(45))
#!g T2 = ( TRUE # 3L # -4L # 2 # 3.1 # -6.7 # 2+3i # -2-3i # as.raw(10) # "bar")
@T2 * @T1

#! operator * does not work on strings or raw types with any other types from right
#!e non-numeric argument to binary operator
#!g T1 = ("foo" # as.raw(45))
#!g T2 = ( TRUE # 3L # -4L # 2 # 3.1 # -6.7 # 2+3i # -2-3i # as.raw(10) # "bar")
@T1 * @T2

#!# operator * cancelling complex part remains complex mode
#!t "complex"
a = 1i
b = 1i
a = a * b
mode(a)

#! Inf * Inf is Inf
#!t Inf
a = Inf
b = Inf
a * b

#! Inf * -Inf is -Inf
#!t -Inf -Inf
a = Inf
b = -Inf
a * b
b * a

#! -Inf * -Inf is Inf
#!t Inf
a = -Inf
b = -Inf
a * b

#! NA * Inf is NA
#!g T = ( Inf # -Inf)
#!t NA NA
a = NA
b = @T
a * b
b * a

#! NaN * Inf is NaN
#!g T = ( Inf # -Inf)
#!t NaN NaN
a = NaN
b = @T
a * b
b * a

#! 0 * Inf is NaN
#!g T = ( Inf # -Inf)
#!t NaN NaN
a = 0
b = @T
a * b
b * a

#! number * Inf is Inf
#!t Inf
a = 3
b = Inf
a * b

#! negative number * Inf is -Inf
#!t -Inf
a = -3
b = Inf
a * b

#! number * -Inf is -Inf
#!t -Inf
a = 3
b = -Inf
a * b

#! negative number * -Inf is Inf
#!t Inf
a = -3
b = -Inf
a * b

#!# operator / --------------------------------------------------------------------------------------------------------

#! operator / with any side being complex returns complex
#!g T = (TRUE # 2L # -3 # 2.1)
#!t "complex" "complex"
mode((2+3i) / @T)
mode(@T / (2+3i))

#! operator / with numeric and logical is numeric
#!g T = (TRUE # 2L # -3 # 2.1)
#!t "numeric" "numeric"
mode((3) / @T)
mode(@T / (3))

#! operator / with two logicals is still numeric
#!g T1 = ( TRUE # FALSE)
#!g T2 = ( TRUE # FALSE)
#!t "numeric"
mode(@T1 / @T2)

#! operator /: NA / anything is always NA
#!g T = (NA # NaN # TRUE # 2L # 2.1 # 2+3i)
#!t NA NA
NA / (@T)
(@T) / NA

#! operator /: NA / anything is numeric mode, or complex if complex 
#!g T =    (NA # NaN # 2L # 2.1 # 2+3i)
#!g V(T) = ("numeric" # "numeric" # "numeric" # "numeric" # "complex")
#!t @V @V
mode(NA / (@T))
mode((@T) / NA)

#! operator /: NaN / any number is always NaN
#!g T = ( TRUE # 3L # -4L # 2 # 3.1 # -6.7)
#!t NaN NaN
NaN / (@T)
(@T) / NaN

#! operator /: NaN / any number is always numeric mode
#!g T = ( TRUE # 3L # -4L # 2 # 3.1 # -6.7)
#!t "numeric" "numeric"
mode(NaN / (@T))
mode((@T) / NaN)

#! operator /: NaN / complex is NaN
#!g T = ( 2+3i # -2-3i )
#!t NaN NaN
#!dt
#!# It is actually NA 
NaN / (@T)
(@T) / NaN

#! operator /: NaN / complex is complex mode
#!g T = ( 2+3i # -2-3i )
#!t "complex" "complex"
mode(NaN / (@T))
mode((@T) / NaN)

#! operator / does not work on strings or raw types with any other types from left
#!e non-numeric argument to binary operator
#!g T1 = ("foo" # as.raw(45))
#!g T2 = ( TRUE # 3L # -4L # 2 # 3.1 # -6.7 # 2+3i # -2-3i # as.raw(10) # "bar")
@T2 / @T1

#! operator / does not work on strings or raw types with any other types from right
#!e non-numeric argument to binary operator
#!g T1 = ("foo" # as.raw(45))
#!g T2 = ( TRUE # 3L # -4L # 2 # 3.1 # -6.7 # 2+3i # -2-3i # as.raw(10) # "bar")
@T1 / @T2

#! operator / cancelling complex part remains complex mode
#!t "complex"
a = 2+2i
b = 4-4i
a = a / b
mode(a)

#! operator /: division by zero is Inf and retains the mode of the lhs (logical is numeric) if divided by numeric 0
#!g T = ( TRUE # 2L # 4.1)
#!g Z = ( FALSE # 0L # 0)
#!t Inf "numeric"
a = @T
b = @Z
a = a / b
a
mode(a)

#! operator /: division by zero is Inf and the type is always double or complex if divided by numeric 0
#!g T = ( TRUE # 2L # 4.1 )
#!g Z = ( FALSE # 0L # 0)
#!t Inf "double"
a = @T
b = @Z
a = a / b
a
typeof(a)

#! operator /: division by negative zero is -Inf and retains the mode of the lhs (logical is numeric) if divided by numeric 0
#!g T = ( TRUE # 2L # 4.1 )
#!t -Inf "numeric"
a = @T
b = -0
a = a / b
a
mode(a)

#! operator /: division by negative zero is -Inf and the type is always double or complex if divided by numeric 0
#!g T = ( TRUE # 2L # 4.1)
#!t -Inf "double"
a = @T
b = -0
a = a / b
a
typeof(a)

#! operator /: division of real by complex zero is Inf + NanI for non completely negative complex zeros
#!g T = ( 0+0i # -0+0i # 0-0i # -0-0i)
#!t Inf+NaNi
a = 3
b = @T
a / b

#! operator /: division of real by complex zero is -Inf+NaNi for -0-0i
#!t -Inf+NaNi
a = 3
b = -0-0i
a / b

#! operator /: complex number divided by 0 is Inf+Infi
#!t Inf+Infi
a = 2+3i
b = 0
a / b
#! operator /: complex number divided by 0 is -Inf-Infi
#!t -Inf-Infi
a = 2+3i
b = -0
a / b

#! complex zero divided by zero or complex zero is always NaN+NaNi
#!g T = ( 0+0i # -0+0i # 0-0i # -0-0i)
#!g V = ( 0+0i # -0+0i # 0-0i # -0-0i # 0 # -0 # 0L)
#!t NaN+NaNi NaN+NaNi
a = @T
b = @V
a / b
b / a

#! 0 / 0 is NaN
#!g T1 = ( FALSE # 0L # 0) 
#!g T2 = ( FALSE # 0L # 0) 
#!t NaN
@T1 / @T2

#! Inf / Inf is NaN
#!t NaN NaN
a = Inf
b = -Inf
a / b
b / a

#! Inf / (-Inf) is Inf
#!t NaN NaN
a = Inf
b = -Inf
a / b
b / a

#! NA / Inf is NA
#!g T = ( Inf # -Inf)
#!t NA NA
a = NA
b = @T
a / b
b / a

#! NaN / Inf is NaN
#!g T = ( Inf # -Inf)
#!t NaN NaN
a = NaN
b = @T
a / b
b / a

#! Inf / number is Inf
#!t Inf
a = Inf
b = 3
a / b

#! Inf / negative number is Inf
#!t -Inf
a = Inf
b = -3
a / b

#! -Inf / number is Inf
#!t -Inf
a = -Inf
b = 3
a / b

#! -Inf / negative number is Inf
#!t Inf
a = -Inf
b = -3
a / b

#! number divided by Inf is 0
#!g T = ( 3 # -3)
#!t 0
a = @T
b = Inf
a / b

#! sign of the 0 is preserved 
#!t -Inf
a = 4 / -Inf
4 / a

#!# operator %/% ------------------------------------------------------------------------------------------------------

#! operator %/% with any side being complex is an unimplemented operation
#!g T = (TRUE # 2L # -3 # 2.1 # 2+3i # as.complex(NaN) # as.complex(NA))
#!e unimplemented complex operation
mode((2+3i) %/% @T)
mode(@T %/% (2+3i))

#! operator %/%: if both operands are integers or logicals, result is type integer
#!g T = ( TRUE # 1L)
#!g V = ( TRUE # 1L)
#!t "integer"
a = @T
b = @V
typeof(a %/% b)

#! operator %/%: if first operand is double, result is double
#!g T = (TRUE # 2L # 3)
#!t "double"
a = @T
typeof( 3.5  %/% a)

#! operator %/%: if second operand is double, result is double
#!g T = (TRUE # 2L # 3)
#!t "double"
a = @T
typeof( a %/% 1)

#! operator %/%: NA %/% anything is always NA
#!g T = (NA # NaN # TRUE # 2L # 2.1)
#!t NA NA
NA %/% (@T)
(@T) %/% NA

#! operator %/%: integer or logical NA %/% integer or logical is integer NA
#!g T =    (as.integer(NA) # as.logical(NA) # as.integer(NaN) # as.logical(NA) # 2L)
#!t "integer" "integer"
typeof(NA %/% (@T))
typeof((@T) %/% NA)

#! operator %/%: double NA %/% anything is always double
#!g T = (as.integer(NA) # as.logical(NA) # as.integer(NaN) # as.logical(NaN) # 1L # 2 # 3.1)
#!t "double" "double"
typeof(as.double(NA) %/% (@T))
typeof((@T) %/% as.double(NA))

#! operator %/%: NaN %/% anything is always NaN
#!g T = (NaN # TRUE # 2L # 2.1)
#!t NaN NaN
NaN %/% (@T)
(@T) %/% NaN

#! operator %/%: double NaN %/% anything is always double
#!g T = (as.integer(NaN) # as.logical(NaN) # 1L # 2 # 3.1)
#!t "double" "double"
typeof(as.double(NaN) %/% (@T))
typeof((@T) %/% as.double(NaN))

#! operator %/% does not work on strings or raw types with any other types from left
#!e non-numeric argument to binary operator
#!g T1 = ("foo" # as.raw(45))
#!g T2 = ( TRUE # 3L # -4L # 2 # 3.1 # -6.7 # 2+3i # -2-3i # as.raw(10) # "bar")
@T2 %/% @T1

#! operator %/% does not work on strings or raw types with any other types from right
#!e non-numeric argument to binary operator
#!g T1 = ("foo" # as.raw(45))
#!g T2 = ( TRUE # 3L # -4L # 2 # 3.1 # -6.7 # 2+3i # -2-3i # as.raw(10) # "bar")
@T1 %/% @T2

#! operator %/% integer division produces NA if divided by zero
#!g T = ( TRUE # 3L )
#!g V = ( FALSE # 0L)
#!t NA "integer"
a = @T
b = @V
a = a %/% b
a
typeof(a)

#! operator %/%: division by zero is Inf double
#!g Z = ( FALSE # 0L # 0)
#!t Inf "double"
a = 4
b = @Z
a = a %/% b
a
typeof(a)

#! operator %/%: division by negative zero is -Inf double
#!g T = ( TRUE # 2L # 4.1)
#!t -Inf "double"
a = @T
b = -0
a = a %/% b
a
typeof(a)

#! 0 %/% 0 is NaN if result is double
#!g T = ( FALSE # 0L # 0)
#!t NaN NaN
a = @T
b = 0
a %/% b
b %/% a

#! 0 %/% 0 is NA if result is integer
#!g T1 = ( FALSE # 0L) 
#!g T2 = ( FALSE # 0L) 
#!t NA
@T1 %/% @T2

#! operator %/% works for real numbers too
#!t 2
a = 10
b = 3.6
a %/% b

#! Inf %/% Inf is NaN
#!t NaN NaN
a = Inf
b = -Inf
a %/% b
b %/% a

#! Inf %/% (-Inf) is Inf
#!t NaN NaN
a = Inf
b = -Inf
a %/% b
b %/% a

#! NA %/% Inf is NA
#!g T = ( Inf # -Inf)
#!t NA NA
a = NA
b = @T
a %/% b
b %/% a

#! NaN %/% Inf is NaN
#!g T = ( Inf # -Inf)
#!t NaN NaN
a = NaN
b = @T
a %/% b
b %/% a

#! Inf %/% number is NaN
#!t NaN
a = Inf
b = 3
a %/% b

#! Inf %/% negative number is NaN
#!t NaN
a = Inf
b = -3
a %/% b

#! -Inf %/% number is NaN
#!t NaN
a = -Inf
b = 3
a %/% b

#! -Inf %/% negative number is NaN
#!t NaN
a = -Inf
b = -3
a %/% b

#! number integer divided by Inf is 0
#!g T = ( 3 # -3)
#!t 0
a = @T
b = Inf
a / b

#!# operator %% -------------------------------------------------------------------------------------------------------

#! operator %% with any side being complex is an unimplemented operation
#!g T = (TRUE # 2L # -3 # 2.1 # 2+3i # as.complex(NaN) # as.complex(NA))
#!e unimplemented complex operation
mode((2+3i) %% @T)
mode(@T %% (2+3i))

#! operator %%: if both operands are integers or logicals, result is type integer
#!g T = ( TRUE # 10L)
#!g V = ( TRUE # 3L)
#!t "integer"
a = @T
b = @V
typeof(a %% b)

#! operator %%: if first operand is double, result is double
#!g T = (TRUE # 2L # 3)
#!t "double"
a = @T
typeof( 3.5  %% a)

#! operator %%: if second operand is double, result is double
#!g T = (TRUE # 2L # 3)
#!t "double"
a = @T
typeof( a %% 1)

#! operator %%: NA %% anything is always NA
#!g T = (NA # NaN # TRUE # 2L # 2.1)
#!t NA NA
NA %% (@T)
(@T) %% NA

#! operator %%: integer or logical NA %% integer or logical is integer NA
#!g T =    (as.integer(NA) # as.logical(NA) # as.integer(NaN) # as.logical(NA) # 2L)
#!t "integer" "integer"
typeof(NA %% (@T))
typeof((@T) %% NA)

#! operator %%: double NA %% anything is always double
#!g T = (as.integer(NA) # as.logical(NA) # as.integer(NaN) # as.logical(NaN) # 1L # 2 # 3.1)
#!t "double" "double"
typeof(as.double(NA) %% (@T))
typeof((@T) %% as.double(NA))

#! operator %%: NaN %% anything is always NaN
#!g T = (NaN # TRUE # 2L # 2.1)
#!t NaN NaN
NaN %% (@T)
(@T) %% NaN

#! operator %%: double NaN %% anything is always double
#!g T = (as.integer(NaN) # as.logical(NaN) # 1L # 2 # 3.1)
#!t "double" "double"
typeof(as.double(NaN) %% (@T))
typeof((@T) %% as.double(NaN))

#! operator %% does not work on strings or raw types with any other types from left
#!e non-numeric argument to binary operator
#!g T1 = ("foo" # as.raw(45))
#!g T2 = ( TRUE # 3L # -4L # 2 # 3.1 # -6.7 # 2+3i # -2-3i # as.raw(10) # "bar")
@T2 %% @T1

#! operator %% does not work on strings or raw types with any other types from right
#!e non-numeric argument to binary operator
#!g T1 = ("foo" # as.raw(45))
#!g T2 = ( TRUE # 3L # -4L # 2 # 3.1 # -6.7 # 2+3i # -2-3i # as.raw(10) # "bar")
@T1 %% @T2

#! operator %% integer modulo produces NA if divided by zero
#!g T = ( TRUE # 3L )
#!g V = ( FALSE # 0L)
#!t NA "integer"
a = @T
b = @V
a = a %% b
a
typeof(a)

#! operator %%: double modulo by zero is NaN 
#!g Z = ( FALSE # 0L # 0)
#!t NaN "double"
a = 4
b = @Z
a = a %% b
a
typeof(a)

#! operator %%: modulo by negative zero is NaN
#!g T = ( TRUE # 2L # 4.1 )
#!t NaN "double"
a = @T
b = -0
a = a %% b
a
typeof(a)

#! 0 %% 0 is NaN if result is double
#!g T = ( FALSE # 0L # 0)
#!t NaN NaN
a = @T
b = 0
a %% b
b %% a

#! 0 %% 0 is NA if result is integer
#!g T1 = ( FALSE # 0L) 
#!g T2 = ( FALSE # 0L) 
#!t NA
@T1 %% @T2

#! operator %% works for real numbers too
#!t 2.8
a = 10
b = 3.6
a %% b

#! Inf %% any number is NaN
#!g T = ( 3 # -3 # 0)
#!t NaN
a = Inf
b = @T
a %% b

#! Inf %% Inf is NaN
#!g T = ( Inf # -Inf)
#!t NaN
a = Inf
b = @T
a %% b

#! NA %% Inf is NA
#!t NA
a = NA
b = Inf
a %% b

#! NaN %% Inf is NaN
#!t NaN
a = NaN
b = Inf
a %% b

#! Inf %% NA is NA
#!t NA
a = Inf
b = NA
a %% b

#! Inf %% NaN is NaN
#!t NaN
a = Inf
b = NaN
a %% b

#!# operator ^ --------------------------------------------------------------------------------------------------------

#! operator ^ with any side being complex returns complex
#!g T = (TRUE # 2L # -3 # 2.1)
#!t "complex" "complex"
mode((2+3i) ^ @T)
mode(@T ^ (2+3i))

#! operator ^ with numeric and logical is numeric
#!g T = (TRUE # 2L # -3 # 2.1)
#!t "numeric" "numeric"
mode((3) ^ @T)
mode(@T ^ (3))

#! operator ^ with two logicals is still numeric
#!g T1 = ( TRUE # FALSE)
#!g T2 = ( TRUE # FALSE)
#!t "numeric"
mode(@T1 ^ @T2)

#! operator ^ of integers doubles and logicals is always double
#!g T = (TRUE # 1L # 3 # 4.5)
#!g V = (TRUE # 3L # 1 # 6.7)
#!t "double"
a = @T
b = @V 
typeof(a ^ b)

#! operator ^: NA ^ anything is always NA
#!g T = (NA # NaN # 2L # 2.1)
#!t NA NA
NA ^ (@T)
(@T) ^ NA

#! operator ^: NaN ^ any number is always NaN
#!g T = ( 3L # -4L # 2 # 3.1 # -6.7)
#!t NaN NaN
NaN ^ (@T)
(@T) ^ NaN

#! operator ^: NaN ^ any number is always numeric mode
#!g T = ( TRUE # 3L # -4L # 2 # 3.1 # -6.7)
#!t "double" "double"
typeof(NaN ^ (@T))
typeof((@T) ^ NaN)

#! operator ^: NaN ^ complex is NaN
#!g T = ( 2+3i # -2-3i )
#!t NaN NaN
#!dt
#!# It is actually NA
NaN ^ (@T)
(@T) ^ NaN

#! operator ^: NaN ^ complex is complex mode
#!g T = ( 2+3i # -2-3i )
#!t "complex" "complex"
mode(NaN ^ (@T))
mode((@T) ^ NaN)

#! operator ^ does not work on strings or raw types with any other types from left
#!e non-numeric argument to binary operator
#!g T1 = ("foo" # as.raw(45))
#!g T2 = ( TRUE # 3L # -4L # 2 # 3.1 # -6.7 # 2+3i # -2-3i # as.raw(10) # "bar")
@T2 ^ @T1

#! operator ^ does not work on strings or raw types with any other types from right
#!e non-numeric argument to binary operator
#!g T1 = ("foo" # as.raw(45))
#!g T2 = ( TRUE # 3L # -4L # 2 # 3.1 # -6.7 # 2+3i # -2-3i # as.raw(10) # "bar")
@T1 ^ @T2

#! operator ^ cancelling complex part remains complex mode
#!t "complex"
a = 1i
b = 2
a = a ^ b
typeof(a)

#! anything to the power of 0 is 1
#!g T = ( 0L # 1L # TRUE # 3.4)
a = @T
a ^ 0 == 1

#! complex number to the power of 0 is complex 1
#!t 1+0i
a = 2+3i
a ^ 0 

#! NaN ^ 0 is 1
#!t 1
a = NaN
a ^ 0 

#! NA ^ 0 is 1
#!t 1
a = NA
a ^ 0 

#! one to the power of NA is 1
#!g T = (TRUE # 1L # 1)
#!t 1
a = 1
b = NA
a ^ b

#! complex one to the power of NA is NA
#!t NA
a = 1 + 0i
b = NA
a ^ b

#! one to the power of NaN is 1
#!g T = (TRUE # 1L # 1)
#!t 1
a = 1
b = NaN
a ^ b

#! complex one to the power of NaN is NA
#!t NA
a = 1 + 0i
b = NaN
a ^ b

#! positive number ^ Inf is Inf
#!t Inf
3 ^ Inf

#! negative number ^ Inf is NaN
#!t NaN
(-3) ^ Inf

#! Inf ^ positive number is Inf
#!t Inf
Inf ^ 3

#! Inf ^ negative number is 0
#!t 0
Inf ^ -3

#! 0 ^ Inf is 0
#!t 0
0 ^ Inf 

#! Inf ^ 0 is 1
#!t 1
Inf ^ 0

#! (-Inf) ^ 0 is 1
#!t 1
(-Inf) ^ 0

#! 1 ^ Inf is 1
#!t 1
1 ^ Inf
