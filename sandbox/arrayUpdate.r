#!# -------------------------------------------------------------------------------------------------------------------
#!# array builtin
#!# -------------------------------------------------------------------------------------------------------------------

#! properties of default call to matrix builtin
#!tt 5
a = matrix()
length(a) == 1
length(dim(a)) == 2
dim(a)[1] == 1
dim(a)[2] == 1
is.null(dimnames(a))

#! properties of default call to array builtin
#!tt 4
a = array()
length(a) == 1
length(dim(a)) == 1
dim(a)[1] == 1
is.null(dimnames(a))

#! negative length vectors are not allowed as dimensions
#!e
array(dim = c(-2,2))

#! zero dimension array has length 0
a = array(1,c(1,0,1))
length(a) == 0

#! double dimensions are rounded
#!t 1 1 2 4 5
a = array(1, c(1.1, 1.6, 2.3, 4.1, 5))
dim(a)

#!# -------------------------------------------------------------------------------------------------------------------
#!# array simple read tests
#!# -------------------------------------------------------------------------------------------------------------------

#! simple array read
#!tt 4
a = array(1:27, c(3, 3, 3))
a[1,1,1] == 1
a[3,3,3] == 27
a[1,2,3] == 22
a[3,2,1] == 6


#! empty selectors reads the whole array
#!tt 3
a = array(1:27, c(3,3,3))
b = a[,,]; d = dim(b)
d[1] == 3
d[2] == 3
d[3] == 3

#! dimensions of 1 are dropped
#!tt 3
a = array(1,c(3,3,3));
a = dim(a[,1,]);
length(a) == 2
a[1] == 3
a[2] == 3

#! when all dimensions are dropped, dim is null
a = array(1,c(3,3,3))
is.null(dim(a[1,1,1]))

#! last dimension is dropped
a = array(1,c(3,3,3))
is.null(dim(a[1,1,]))

#! dimensions of 1 are not dropped when requested
#!tt 4
a = array(1,c(3,3,3))
a = dim(a[1,1,1, drop = FALSE])
length(a) == 3
a[1] == 1
a[2] == 1
a[3] == 1

#! fallback to one dimensional read
#!tt 4
a = array(1:27, c(3,3,3))
a[1] == 1
a[27] == 27
a[22] == 22
a[6] == 6

#! error when different dimensions given
#!e
a = array(1,c(3,3,3))
a[2,2]


#!# -------------------------------------------------------------------------------------------------------------------
#!# subset and selection tests
#!# -------------------------------------------------------------------------------------------------------------------


#! subset operator works for arrays
array(1,c(3,3,3))[1,1,1] == 1

#! selection operator works for arrays
array(1,c(3,3,3))[[1,1,1]] == 1

#! selection on multiple elements fails in arrays
#!e
array(1,c(3,3,3))[[,,]]


#! selection on multiple elements fails in arrays
#!e
array(1,c(3,3,3))[[c(1,2),1,1]];

#!# -------------------------------------------------------------------------------------------------------------------
#!# mtrix subset and selection
#!# -------------------------------------------------------------------------------------------------------------------

#! subset operator works for matrices
matrix(1,3,3)[1,1] == 1

#! selection operator works for arrays
matrix(1,3,3)[[1,1]] == 1

#! selection on multiple elements fails in matrices with empty selector
#!e
matrix(1,3,3)[[,]];

#! selection on multiple elements fails in matrices
#!e
matrix(1,3,3)[[c(1,2),1]];


#!# -------------------------------------------------------------------------------------------------------------------
#!# array update
#!# -------------------------------------------------------------------------------------------------------------------

#! update to matrix works
a = matrix(1,2,2)
a[1,2] = 3
a[1,2] == 3

#! update to an array works
a = array(1,c(3,3,3))
a[1,2,3] = 3
a[1,2,3] == 3

#! update returns the rhs
a = array(1,c(3,3,3))
(a[1,2,3] = 3) == 3

#! update of shared object does the copy
#!tt 2
a = array(1,c(3,3,3))
b = a
b[1,2,3] = 3
a[1,2,3] == 1
b[1,2,3] == 3

#!# -------------------------------------------------------------------------------------------------------------------
#!# lhs copy during array update
#!# -------------------------------------------------------------------------------------------------------------------

#! logical gets updated to higher level type if rhs requires
#!g T = (3, 3.1, 2+3i, "test")
#!g W(T) = (1, 1.0, 1+0i, "TRUE")
#!t @W @T
a = array(TRUE,c(2,2))
a[1,2] = @T
a[1,]

#! integer gets updated to higher level type if rhs requires
#!g T = (3.1, 2+3i, "test")
#!g W(T) = (1.0, 1+0i, "1")
#!t @W @T
a = array(1,c(2,2))
a[1,2] = @T
a[1,]

#! double gets updated to higher level type if rhs requires
#!g T = (2.0+3i, "test")
#!g W(T) = (1.1+0i, "1.1")
#!t @W @T
a = array(1.1,c(2,2))
a[1,2] = @T
a[1,]

#! complex gets updated to string if rhs requires
#!t 2+3i 3+2i
a = array(2+3i, c(2,2))
a[1,2] = 3+2i
a[1,]

#!# -------------------------------------------------------------------------------------------------------------------
#!# Multi-dimensional update
#!# -------------------------------------------------------------------------------------------------------------------

#! update matrix by vector, rows
#!tt 3
a = matrix(1,3,3)
a[1,] = c(3,4,5)
a[1,1] == 3
a[1,2] == 4
a[1,3] == 5

#! update matrix by vector, cols
#!tt 3
a = matrix(1,3,3)
a[,1] = c(3,4,5)
a[1,1] == 3
a[2,1] == 4
a[3,1] == 5

#! update array by vector, dim 3
#!tt 3
a = array(1,c(3,3,3));
a[1,1,] = c(3,4,5)
a[1,1,1] == 3 
a[1,1,2] == 4
a[1,1,3] == 5

#! update array by vector, dim 3
#!t 3 4 5
a = array(1,c(3,3,3));
a[1,1,] = c(3,4,5)
a[1,1,]

#! update array by vector, dim 2
#!tt 3
a = array(1,c(3,3,3));
a[1,,1] = c(3,4,5)
a[1,1,1] == 3
a[1,2,1] == 4
a[1,3,1] == 5

#! update array by vector, dim 1
#!tt 3
a = array(1,c(3,3,3))
a[,1,1] = c(3,4,5)
a[1,1,1] == 3
a[2,1,1] == 4
a[3,1,1] == 5

#! update array by matrix
#!tt 3
a = array(1,c(3,3,3))
a[1,,] = matrix(1:9,3,3)
a[1,1,1] == 1
a[1,3,1] == 3
a[1,3,3] == 9

