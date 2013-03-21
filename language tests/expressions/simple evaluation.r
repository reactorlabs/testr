#!# simple evaluation of expressions, R language reference, page 10

#! constants are evaluated to constant vectors of length(1), names == NULL
#!g T =    (TRUE # FALSE # 0L # 3L # -7L # 2.1 # 0.5 # 1+1i # 1.1+1i # 2+2.1i # 3.1+2.3i # "foo")
#!g V(T) = (TRUE # FALSE # 0  # 3  # -7  # 2.1 # 0.5 # 1+1i # 1.1+1i # 2+2.1i # 3.1+2.3i # "foo")
#!t TRUE TRUE @V
is.null(names(@T))
length(@T) == 1
@T

#! L suffix specifies the type to be of integer
a = 1L
typeof(a) == "integer"

#! L suffix cannot be used with complex numbers on complex part
#!e unexpected symbol in "a = 2+2iL"
a = 2+2iL

#! L suffix can be used with complex numbers on real part
#!t 2+2i
a = 2L+2i
a

#! L suffix works on engineering notation numbers too
#!t TRUE 1000
a = 1e3L
typeof(a) == "integer"
a
#! L suffix works on base-N numbers too
#!o TRUE 255
a = 0xffL
typeof(a) == "integer"
a

#! L suffix used on doubles produces warning and creates double
#!w integer literal 1.1L contains decimal; using numeric value 
#!o "double"
a = 1.1L
typeof(a)

#! for an unnecessary decimal point warning is created, but integer produced
#!w integer literal 1.L contains unnecessary decimal point 
#!o TRUE 1
a = 1.L
typeof(a) == "integer"
a

#!# Symbol evaluation -------------------------------------------------------------------------------------------------

#!# Function calls ----------------------------------------------------------------------------------------------------

#!# Operators ---------------------------------------------------------------------------------------------------------





