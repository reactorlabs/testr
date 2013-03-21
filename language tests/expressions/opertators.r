#!# R language operators, R language reference page 11

#! unary minus for numeric and logical values
#!g T =    (TRUE # 1L # 2.1 # 3+2i)
#!g V(T) = (-1 # -1 # -2.1 # -3-2i)
#!t @V
a = @T
-a

#! unary minus does not work with string 
#!e invalid argument to unary operator
-"foo"

#! unary minus does not work with raw
#!e invalid argument to unary operator
- as.raw(3)

#! unary plus for numeric and logical values
#!g T =    (TRUE # 1L # 2.1 # 3+2i)
#!g V(T) = (TRUE # 1  # 2.1 # 3+2i)
#!t @V
a = @T
+a

#! unary plus does not work with string 
#!e invalid argument to unary operator
+"foo"

#! unary plus does not work with raw
#!e invalid argument to unary operator
+ as.raw(3)

#! unary not for numeric and logical values
#!g T =    (TRUE  # 1L    # 2.1   # 3+2i  # FALSE # 0L   # 0    # 0+0i)
#!g V(T) = (FALSE # FALSE # FALSE # FALSE # TRUE  # TRUE # TRUE # TRUE)
#!t @V
a = @T
!a

#! unary not does not work with string 
#!e invalid argument type
!"foo"

#! unary not does work with raw
#!t fc
! as.raw(3)

!# binary minus -------------------------------------------------------------------------------------------------------

#! binary minus operator with logical
#!g T =    (TRUE # 1L # 2.1 # 3+2i # FALSE # 0L # 0 # 0+0i)
#!g V(T) = (0    # 0  # 1.1 # 2+2i # 1 # 1 # 1 # 1+0i)
#!t @V
TRUE - @T

# binary minus operator with logical - result type
#!g T =    (TRUE      # 1L        # 2.1      # 3+2i)
#!g V(T) = ("integer" # "integer" # "double" # "complex")
#!t @V
typeof(TRUE - @T)

#! binary minus operator with integer
#!g T =    (TRUE # 1L   # 2.1 # 3+2i)
#!g V(T) = (3  # 3  # 1.9 # 1+2i)
#!t @V
4L - @T

#! binary minus operator with integer - result type
#!g T =    (TRUE      #  1L       # 2.1      # 3+2i)
#!g V(T) = ("integer" # "integer" # "double" # "complex")
#!t @V
typeof(4L - @T)

#! binary minus operator with double
#!g T =    (TRUE # 1L   # 2.1 # 3+2i)
#!g V(T) = (3.5  # 3.5  # 2.4 # 1.5+2i)
#!t @V
4.5 - @T

#! binary minus operator with double - result type
#!g T =    (TRUE     # 1L       # 2.1      # 3+2i)
#!g V(T) = ("double" # "double" # "double" # "complex")
#!t @V
typeof(4.5 - @T)

#! binary minus operator with complex
#!g T =    (TRUE # 1L   # 2.1 # 3+2i)
#!g V(T) = (3+4i  # 3+4i  # 1.9+4i # 1+6i)
#!t @V
4+4i - @T

#! binary minus operator with complex - result type
#!g T =    (TRUE     # 1L       # 2.1      # 3+2i)
#!t "complex"
typeof(4+4i - @T)

#! binary minus operator does not work with raw or string
#!e non-numeric argument to binary operator
#!g T =    (TRUE     # 1L       # 2.1      # 3+2i)
#!g V = ( as.raw(3) # "foo")
@T - @V

#! binary minus operator is not commutative
#!g T =    (TRUE # 1L # 2.1 # 3+2i)
#!g V =    (10L # 4 # 5+2i)
(@V - @T) != (@T - @V) 

#! binary plus --------------------------------------------------------------------------------------------------------

#! binary plus operator with logical
#!g T =    (TRUE # 1L # 2.1 # 3+2i)
#!g V(T) = (2    # 2  # 3.1 # 4+2i)
#!t @V
TRUE + @T

# binary plus operator with logical - result type
#!g T =    (TRUE      # 1L        # 2.1      # 3+2i)
#!g V(T) = ("integer" # "integer" # "double" # "complex")
#!t @V
typeof(TRUE + @T)

#! binary plus operator with integer
#!g T =    (TRUE # 1L   # 2.1 # 3+2i)
#!g V(T) = (5    # 5    # 6.1 # 7+2i)
#!t @V
4L + @T

#! binary plus operator with integer - result type
#!g T =    (TRUE      #  1L       # 2.1      # 3+2i)
#!g V(T) = ("integer" # "integer" # "double" # "complex")
#!t @V
typeof(4L + @T)

#! binary plua operator with double
#!g T =    (TRUE # 1L   # 2.1 # 3+2i)
#!g V(T) = (5.5  # 5.5  # 6.6 # 7.5+2i)
#!t @V
4.5 + @T

#! binary plus operator with double - result type
#!g T =    (TRUE     # 1L       # 2.1      # 3+2i)
#!g V(T) = ("double" # "double" # "double" # "complex")
#!t @V
typeof(4.5 + @T)

#! binary plus operator with complex
#!g T =    (TRUE  # 1L   # 2.1 # 3+2i)
#!g V(T) = (5+4i  # 5+4i # 6.1+4i # 7+6i)
#!t @V
4+4i + @T

#! binary plus operator with complex - result type
#!g T =    (TRUE     # 1L       # 2.1      # 3+2i)
#!t "complex"
typeof(4+4i + @T)

#! binary plus operator does not work with raw or string
#!e non-numeric argument to binary operator
#!g T =    (TRUE     # 1L       # 2.1      # 3+2i)
#!g V = ( as.raw(3) # "foo")
@T + @V

#! binary minus operator is commutative
#!g T =    (TRUE # 1L # 2.1 # 3+2i)
#!g V =    (10L # 4 # 5+2i)
(@V + @T) == (@T + @V) 

#! binary multiplication ----------------------------------------------------------------------------------------------

#! binary mul operator with logical
#!g T =    (TRUE # 1L # 2.1 # 3+2i)
#!g V(T) = (1    # 1  # 2.1 # 3+2i)
#!t @V
TRUE * @T

# binary mul operator with logical - result type
#!g T =    (TRUE      # 1L        # 2.1      # 3+2i)
#!g V(T) = ("integer" # "integer" # "double" # "complex")
#!t @V
typeof(TRUE * @T)

#! binary mul operator with integer
#!g T =    (TRUE # 1L   # 2.1 # 3+2i)
#!g V(T) = (2    # 2    # 4.2 # 6+2i)
#!t @V
2L * @T

#! binary mul operator with integer - result type
#!g T =    (TRUE      #  1L       # 2.1      # 3+2i)
#!g V(T) = ("integer" # "integer" # "double" # "complex")
#!t @V
typeof(2L * @T)

#! binary mul operator with double
#!g T =    (TRUE # 1L   # 2.1 # 3+2i # (3+2i))
#!g V(T) = (2.5  # 2.5  # 5.25 # 7.5+2i # 7.5+5i)
#!t @V
2.5 * @T

#! binary mul operator with double - result type
#!g T =    (TRUE     # 1L       # 2.1      # 3+2i)
#!g V(T) = ("double" # "double" # "double" # "complex")
#!t @V
typeof(2.5 * @T)

#! binary mul operator with complex
#!g T =    (TRUE  # 1L   # 2.1 # 3+2i # (3+2i))
#!g V(T) = (4+4i  # 4+4i # 8.4+8.4i # 12+14i # 4+20i)
#!t @V
(4+4i) * @T

#! binary mul operator with complex - result type
#!g T =    (TRUE     # 1L       # 2.1      # 3+2i)
#!t "complex"
typeof(4+4i * @T)

#! binary mul operator does not work with raw or string
#!e non-numeric argument to binary operator
#!g T =    (TRUE     # 1L       # 2.1      # 3+2i)
#!g V = ( as.raw(3) # "foo")
@T * @V

#! binary mul operator is commutative
#!g T =    (TRUE # 1L # 2.1 # 3+2i)
#!g V =    (10L # 4 # 5+2i)
((@V) * (@T)) == ((@T) * (@V))

!# binary division ----------------------------------------------------------------------------------------------------

#! binary div operator with logical
#!g T =    (TRUE # 1L # 2.1       # 2+2i   # (2+2i))
#!g V(T) = (1    # 1  # 0.4761905 # 0.5+2i # 0.25-0.25i)
#!t @V
TRUE / @T

# binary div operator with logical - result type
#!g T =    (TRUE      # 1L        # 2.1      # 3+2i)
#!g V(T) = ("double" # "double" # "double" # "complex")
#!t @V
typeof(TRUE / @T)

#! binary div operator with integer
#!g T =    (TRUE # 1L # 2.1       # 2+2i   # (2+2i))
#!g V(T) = (2    # 2  # 0.952381  # 1+2i # 0.5-0.5i)
#!t @V
2L / @T

#! binary div operator with integer - result type
#!g T =    (TRUE      #  1L       # 2.1      # 3+2i)
#!g V(T) = ("double" # "double" # "double" # "complex")
#!t @V
typeof(2L / @T)

#! binary div operator with double
#!g T =    (TRUE # 1L   # 2.1 # 3+2i   # (3+2i))
#!g V(T) = (10.5  # 10.5  # 5 # 3.5+2i # 2.423077-1.615385i)
#!t @V
10.5 / @T

#! binary div operator with double - result type
#!g T =    (TRUE     # 1L       # 2.1      # 3+2i)
#!g V(T) = ("double" # "double" # "double" # "complex")
#!t @V
typeof(10.5 / @T)

#! binary div operator with complex
#!g T =    (TRUE # 1L     # 2.1         # 3+2i        # (3+2i))
#!g V(T) = (4+4i  # 4+4i  # 4+1.904762i # 4+3.333333i # 4.615385+0.923077i)
#!t @V
4+4i / @T

#! binary div operator with complex - result type
#!g T =    (TRUE     # 1L       # 2.1      # 3+2i)
#!t "complex"
typeof(4+4i / @T)

#! binary div operator does not work with raw or string
#!e non-numeric argument to binary operator
#!g T =    (TRUE     # 1L       # 2.1      # 3+2i)
#!g V = ( as.raw(3) # "foo")
@T - @V

#! binary div operator is not commutative
#!g T =    (TRUE # 1L # 2.1 # 3+2i)
#!g V =    (10L # 4 # 5+2i)
(@V - @T) != (@T - @V) 

#! division by zero is not INF
#!g V = (FALSE # 0L # 0 # 0+0i)
#!g T(V) = (Inf # Inf # Inf # Inf+0i)
#!t @T
67 / @V

#! division by zero in pure complex numebers is Nan+Inf
#!t NaN+Infi
67+2i / 0+0i

