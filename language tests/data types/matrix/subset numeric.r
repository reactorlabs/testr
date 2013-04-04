#!# p 19 R Lang Reference

#! more dimensions produce error
#!e incorrect number of dimensions
a = matrix(1, 2,2)
a[1,1,1]

#! using single dimension fails back to vector subset
#!t 2 3
a = matrix(c(1,2,3,4), 2,2)
a[c(2,3)]

#! using single dimension fails back to vector subset
a = matrix(c(1,2,3,4), 2,2)
is.null(dim(a[c(2,3)]))

#! empty indices drops all but dim and dimnames
#!dt but retains all attributes in matrices 
#!t TRUE FALSE FALSE
a = matrix(1,2,2, dimnames=list(c("a","b"),c("c","d")))
attributes(a)$xyz = "haha"
b = a[]
is.null(attributes(b)$xyz)
is.null(attributes(b)$dim)
is.null(attributes(b)$dimnames)

#! all attributes are preserved by []
#!t FALSE FALSE FALSE 3 2 2 "a" "b" "c" "d"
a = matrix(1,2,2, dimnames=list(c("a","b"),c("c","d")))
attributes(a)$xyz = "haha"
b = a[]
b = attributes(b)
is.null(b$xyz)
is.null(b$dim)
is.null(b$dim)
length(b)
b$dim
b$dimnames[[1]]
b$dimnames[[2]]

#! [] with indices returns the object keeping dimnames and dim but not other arguments
#!ttt
a = matrix(1, 3,3, dimnames=list(c("a","b","c"), c("c","d","e")))
attributes(a)$xyz = 67
attrs = attributes(a[c(1,2),c(1,2)]) 
length(attrs) == 2
! is.null(attrs$dimnames)
! is.null(attrs$dim)
is.null(attrs$xyz)

#! NAs in indices produce NA
#!t 1 1 NA NA
a = matrix(1, 3,3)
a[c(1,NA),c(1,2)]

#! only NA copies whole dimension (logical NA)
#!t NA NA NA NA NA NA NA NA NA
a = matrix(1, 3,3)
a[NA,NA]


#! single element can be chosen
#!t 4
a = matrix(1:9, 3,3)
a[1,2] 

#! 0 as index produces dimension of length 0 making everything length 0
#!g T =    (matrix(TRUE, 3,3) # matrix(1L, 3,3) # matrix(1,3,3) # matrix(1.1,3,3) # matrix(1+1i, 3,3) # matrix(1.1+1.1i, 3,3) # matrix("foo",3,3) )
#!t 0 
a = @T
length(a[0])


#! 0 as a single index produces a vector of size 0 and corresponding type
#!g T =    (matrix(TRUE, 3,3) # matrix(1L, 3,3) # matrix(1,3,3) # matrix(1.1,3,3) # matrix(1+1i, 3,3) # matrix(1.1+1.1i, 3,3) # matrix("foo",3,3) )
#!g V(T) = ("logical"         # "integer"       # "double"      # "double"        # "complex"         # "complex"             # "character")
#!t 0 @V
a = @T
b = a[0]
length(b)
typeof(b)

#! 0 as a single index produces a vector of size 0 and corresponding type and preserves the dim and names
#!dt dim and dimnames are dropped, but if vector they are not
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


#! 0 as a single index produces a vector of size 0 and corresponding type and DOES NOT preserve dim and dimnames empty arguments
#!# this is weird, because for vectors names are kept, but empty, why not dim and dimnames
#!g T =    (matrix(TRUE, 3,3) # matrix(1L, 3,3) # matrix(1,3,3) # matrix(1.1,3,3) # matrix(1+1i, 3,3) # matrix(1.1+1.1i, 3,3) # matrix("foo",3,3) )
#!g V(T) = ("logical"         # "integer"       # "double"      # "double"        # "complex"         # "complex"             # "character")
#!t 0 @V TRUE TRUE
a = @T
dimnames(a) = list(c("a","b","c"), c("d","e","f"))
attributes(a)$xyz = 67
b = a[0]
length(b)
typeof(b)
length(attributes(b)) == 0
is.null(attributes(b)[["dimnames"]])

#! NULL behaves like integer(0)
#!g T =    (matrix(TRUE, 3,3) # matrix(1L, 3,3) # matrix(1,3,3) # matrix(1.1,3,3) # matrix(1+1i, 3,3) # matrix(1.1+1.1i, 3,3) # matrix("foo",3,3) )
#!g V(T) = ("logical"         # "integer"       # "double"      # "double"        # "complex"         # "complex"             # "character")
#!t 0 @V
a = @T
names(a) = c("a","b","c")
attributes(a)$xyz = 67
b = a[NULL]
length(b)
typeof(b)

#! indices of different signs are not allowed
#!e only 0's may be mixed with negative subscripts
a = matrix(1,3,3)
a[c(1,-2),c(1,2)] 

#! indices of different signs in different dimensions are allowed
#!t 1 4 3 6
a = matrix(1:27,3,3)
a[c(-2),c(1,2)] 

#! single index can be selected multiple times
#!t 1 4 1 4 1 4
a = matrix(1:9, 3,3)
a[c(1,1,1),c(1,2)]

#! positive indices appear in the order they were presented
#!t 3 2 1
a = matrix(1:9, 3,3)
a[c(3,2,1),1]

#! zeros with positive indices have no effect
#!g T =    (c(0,1,2) # c(1,0,2) # c(1,2,0))
#!t 2 1 2
a = matrix(1:9, 3,3)
b = a[@T,1]
length(b)
b

#! out of bounds indices throw an exception
#!e subscript out of bounds
a = matrix(1:9, 3,3)
a[c(1,67),1]

#! negative index deselects the specific element
#!t 2 7 9
a = matrix(1:9, 3,3)
b = a[-2,c(-1,-2)]
length(b) 
b

# negative index can be selected multiple times with no additional effect
#!t 2 7 9
a = matrix(1:9, 3,3)
b = a[c(-2,-2),c(-1,-2)]
length(b) 
b

# negative indices always display remaining values in order they were created
#!g V = (c(-1, -3, -5) # c(-1, -5, -3) # c(-3, -1, -5) # c(-3, -5, -1) # c(-5, -1, -3) # c(-5, -3, -1))
#!t 2 2 4
a = matrix(1:20, 5,2)
b = a[@V,1]
length(b)
b 

# zeroes have no effect within negative indices
#!g V = (c(0, -1, -3, -5) # c(-1, 0, -5, -3) # c(-3, -1, 0, -5) # c(-3, -5, -1, 0) # c(0, -5, -1, -3, 0) # c(0, 0, -5,0,0 -3, -1, 0, 0))
#!t 2 2 4
a = matrix(1:10, 5,2)
b = a[@V,1]
length(b)
b 

# negative indices out of bounds have no effect
#!g V = (c(-1, -7, -3, -5) # c(-10, -1, -5, -3) # c(-3, -1, -5, -20))
#!t 2 2 4
a = matrix(1:10, 5,2)
b = a[@V,1]
length(b)
b 

#!# -------------------------------------------------------------------------------------------------------------------
#!# update
#!# -------------------------------------------------------------------------------------------------------------------

#! scalar update to [0] is allowed but has no effect
#!t 1 1 1 1
a = matrix(1, 2,2)
a[0,1] = 7
a

#! vector update to [0] is allowed but has no effect
#!t 1 1 1 1
a = matrix(1, 2,2)
a[0,c(1,2)] = c(7, 8)
a

#! update to [0] DOES change type of the primary vector
#!t "double"
a = matrix(1L, 3,3)
a[0,1] = 2.4
typeof(a)

#! multiple update to same index preserves only the last value written
#!t 3 1 1 1
a = matrix(1, 2,2)
a[c(1,1,1),1] = c(1,2,3)
a

#! update to outside bounds raises an error
#!e subscript out of bounds
a = matrix(1,3,3)
a[c(4,5),1] = c(4,5)

#! update to negative indices outside bounds has no effect
#!t 4 1 1 1 1 
a = matrix(1, 2,2)
a[c(-4,-2,-1),1] = c(4,5,6)
length(a)
a

#! smaller vectors are recycled during matrix update
#!t 1 2 1 2
a = matrix(1, 2,2)
a[1:2,1:2] = c(1,2)
as.vector(a)

#! scalar is the extreme case 
#!t 11 11 11 11
a = matrix(1, 2,2)
a[1:2,1:2] = 11
as.vector(a)

#! warning is produced if the lhs cannot be recycled completely
#!# this is error, but is warning for vector!!
#!e number of items to replace is not a multiple of replacement length
a = matrix(1,2,2)
a[1:2,1:2] = c(2,3,4)
as.vector(a)

#! warning is produced if lhs is larger than replacement, extra elements are ignored
#!# this is error, but is warning for vector!!
#!e number of items to replace is not a multiple of replacement length
a = matrix(1, 2,2)
a[1,2] = c(10,11,12,13,14,15)
a

#! NAs are not allowed in updates
#!e NAs are not allowed in subscripted assignments
a = matrix(1,2,2)
a[NA,1:2] = c(4,10)
a

#! matrix can be rhs, same order as if it were a vector
#!t 1 2 1 1 1 1 3 4 1
a = matrix(1,3,3)
a[1:2,c(1,3)] = matrix(1:4,2,2)
as.vector(a)

#!# -------------------------------------------------------------------------------------------------------------------
#!# drop argument
#!# -------------------------------------------------------------------------------------------------------------------

#! only one dimension drops dim completely (is a vector)
a = matrix(1,5,5)
is.null(dim(a[1,1:2, drop = TRUE]))

#! only one result drops dim completely
a = matrix(1,5,5)
is.null(dim(a[1,1, drop = TRUE]))

#! drop FALSE keeps the dimensions of 1
#!t 1 2
a = matrix(1,5,5)
dim(a[1,1:2, drop = FALSE])

#! drop FALSE keeps the dimensions of 1 even if result is length 1
#!t 1 1
a = matrix(1,5,5)
dim(a[1,1, drop = FALSE])

#! default drop value is TRUE
a = matrix(1,5,5)
is.null(dim(a[1,1:2]))


