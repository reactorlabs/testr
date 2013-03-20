#!# Any tests that appear to be problematic should be put also here, in comments indicating why, and where they came
#!# from (where I suggest they will be failing as they are not part of the language tests root)

#! default partial matching exact arg is NA
#!# it is actually TRUE in current gnu-r even though manual says NA
#!# from data types/array/subscript.r
#!w  partial match of 'x' to 'x1'
#!w  partial match of 't' to 't1'
#!w  partial match of 'l' to 'l1' 
#!o TRUE
a = array(1:8, c(2,2,2), dimnames=list(c("x1","y1"), c("w1","t1"), c("k1","l1")))
a[["x","t","l"]] == 3

#! partial matching exact default value is NA
#!# but it is not, default value for gnur is TRUE, lang spec says otherwise
#!# data types/list/subscript.r
a = list(foo=1, bar=2, foobar=3)
a[["b"]] == 2

#! out olf bounds read in integer indices is error
#!e subscript out of bounds
#!# this is inconsistent with upate beyond bounds increasing the structure and null being rerturned for named args
#!# data types/list/subscript.r
a = list(1,2,3)
is.null(a[[10]])

#! partial matching by default is NA and does partial matching with a warning produced (R Lang ref p-19)
#!o 2
#!# gnu-r has exact to TRUE by default instead of NA specified by the documentation
#!# data types/vector/subscript character.r
#!w partial match of 'b' to 'bar'
a = c(foo = 1, bar = 2, foobar = 3)
a[["b"]]

#! non-existing negative indices does not work with scalars
#!e attempt to select less than one element
#!# TODO this is interesting because [-2] will work and will return a single element
#!# data types/vector/subscript numeric
a = 2
a[[-2]]

#! update to [0] DOES change type of the primary vector
#!# data types/vector/subset integer
#!t "double"
a = c(1L,2L,3L)
a[0] = 2.4
typeof(a)

#! [] with empty indices returns the object keeping only names
#!# vector/subset integer
#!d keeps all arguments in R
#!t TRUE "a" "b" "c"
a = c(a=1, b=2, c=3)
attributes(a)$xyz = 67
length(attributes(a[])) == 1
attributes(a[])$names

#! empty indices drops all but dim and dimnames
#!d but retains all attributes in arrays 
#!t TRUE FALSE FALSE
a = array(1,c(2,2,2), dimnames=list(c("a","b"),c("c","d"), c("e","f")))
attributes(a)$xyz = "haha"
b = a[]
is.null(attributes(b)$xyz)
is.null(attributes(b)$dim)
is.null(attributes(b)$dimnames)

#! 0 as a single index produces a vector of size 0 and corresponding type and preserves the dim and names
#!# array/subset numeric
#!d dim and dimnames are dropped, but if vector they are not
#!g T =    (array(TRUE, c(3,3,3)) # array(1L, c(3,3,3)) # array(1,c(3,3,3)) # array(1.1,c(3,3,3)) # array(1+1i, c(3,3,3)) # array(1.1+1.1i, c(3,3,3)) # array("foo",c(3,3,3)) )
#!g V(T) = ("logical"             # "integer"           # "double"          # "double"            # "complex"             # "complex"                 # "character")
#!t 0 @V TRUE TRUE TRUE 
a = @T
dimnames(a) = list(c("a","b","c"), c("d","e","f"), c("g","h","i"))
attributes(a)$xyz = 67
b = a[0]
length(b)
typeof(b)
length(attributes(b)) == 0
length(attributes(b)[["dimnames"]]) == 0
typeof(attributes(b)[["dimnames"]]) == "list"

#! warning is produced if the lhs cannot be recycled completely
#!# this is error, but is warning for vector!!
#!# array/subset numeric
#!e number of items to replace is not a multiple of replacement length
a = array(1,c(2,2,2))
a[1:2,1:2,1] = c(2,3,4)
as.vector(a)

#! warning is produced if lhs is larger than replacement, extra elements are ignored
#!# this is error, but is warning for vector!!
#!e number of items to replace is not a multiple of replacement length
a = array(1,c(2,2,2))
a[1,2,1] = c(10,11,12,13,14,15)
a

#! error is produced if the lhs cannot be recycled completely
#!# array/subset character.r
#!# is only warning for vectors
#!e number of items to replace is not a multiple of replacement length
a = array(1:8, c(2,2,2), dimnames=list(c("a","b"),c("c","d"),c("e","f")))
a[c("a","b"),"c",] = c(10,11,12)
as.vector(a)

#! update with larger rhs produces a warning
#!# array/subset matrix -- is error for others
#!w number of items to replace is not a multiple of replacement length
#!o 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 -1 17 18 19 -2 21 22 23 24 25 26 27
a = array(1:27, c(3,3,3))
a[matrix(1:3,2,3)] = c(-1,-2, -3)
as.vector(a)

#! update with larger rhs produces a warning
#!# array/subset matrix -- is error for others
#!w number of items to replace is not a multiple of replacement length
#!o 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 -1 17 18 19 -2 21 22 23 24 25 26 27
a = array(1:27, c(3,3,3))
a[matrix(1:3,10,3)] = c(-1,-2, -3, -2)
as.vector(a)

#! empty indices drops all but dim and dimnames
#!# data types/matrix/subset numeric.r
#!# but retains all attributes in arrays 
#!t TRUE FALSE FALSE
a = matrix(1,2,2, dimnames=list(c("a","b"),c("c","d")))
attributes(a)$xyz = "haha"
b = a[]
is.null(attributes(b)$xyz)
is.null(attributes(b)$dim)
is.null(attributes(b)$dimnames)

#! 0 as a single index produces a vector of size 0 and corresponding type and preserves the dim and names
#!# data types/matrix/subset numeric
#!# dim and dimnames are dropped, but if vector they are not
#!g T =    (matrix(TRUE, 3,3) # matrix(1L, 3,3) # matrix(1,3,3) # matrix(1.1,3,3) # matrix(1+1i, 3,3) # matrix(1.1+1.1i, 3,3) # matrix("foo",3,3) )
#!g V(T) = ("logical"         # "integer"       # "double"      # "double"        # "complex"         # "complex"             # "character")
#!t 0 @V TRUE TRUE TRUE 
a = @T
dimnames(a) = list(c("a","b","c"), c("d","e","f"))
attributes(a)$xyz = 67
b = a[0]
length(b)
typeof(b)
length(attributes(b)) == 0
length(attributes(b)[["dimnames"]]) == 0
typeof(attributes(b)[["dimnames"]]) == "list"
