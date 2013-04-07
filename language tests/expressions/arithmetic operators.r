#!# arithmetic operators, from R help mostly

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
