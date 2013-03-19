#!# R language reference, page 19 onwards

#! subsetting array using larger than matrix is like subsetting using vector
#!t 1 2 3 4 5 6 7 8
a = array(1:27, c(3,3,3))
a[array(1:8,c(2,2,2))]

#! subsetting matrix by matrix where cols != dim is like a vector
#!t 1 2
a = matrix(1:10,2,5)
a[matrix(c(1,2),2,1)]

#! subsetting matrix by matrix with cols = dim works like selection
#!t 3
a = matrix(1:10,2,5)
a[matrix(c(1,2),1,2)]

#! subsetting matrix by matrix returns the elements
#!t 1 4
a = matrix(1:10,2,5)
a[matrix(c(1,2,1,2),2,2)]

#! subsetting array by matrix works
#!t 16 20
a = array(1:27, c(3,3,3))
a[matrix(1:3,2,3)]

#! subsetting array by matrix with wrong dimensions is like an array
#!t 1 2 3 1 2 3
a = array(1:27, c(3,3,3))
a[matrix(1:3,3,2)]

#! negative values in matrix indexing are not allowed
#!e negative values are not allowed in a matrix subscript
a = array(1:27, c(3,3,3))
a[matrix(c(-1,2,3),2,3)]

#! NA's are allowed and produce NA result
#!t NA NA
a = array(1:27, c(3,3,3))
a[matrix(c(NA,2,3),2,3)]

#! dimnames can be part of the matrix selection
#!t 1 23
a = array(1:27, c(3,3,3), dimnames=list(c("a","b","c"), c("d","e","f"), c("g","h","i")))
a[matrix(c("a","d","g","b","e","i"),2,3, byrow = TRUE)]

#! invalid dimnames are subscript out of bounds
#!e subscript out of bounds
a = array(1:27, c(3,3,3), dimnames=list(c("a","b","c"), c("d","e","f"), c("g","h","i")))
a[matrix(c("a","d","g","b","e","k"),2,3, byrow = TRUE)]

#! names are ignoref if indexing matrix has proper structure
#!e subscript out of bounds
a = array(1:27, c(3,3,3))
names(a) = c("a","b","c","d","e","f","g","h","i","j","k","l")
a[matrix(c("a","b","c","d","e","f"), 2,3)]

#! on incorrect matrix dimensions, names are used as if single vector only
#!t a b c d e f 1 2 3 4 5 6 
a = array(1:27, c(3,3,3))
names(a) = c("a","b","c","d","e","f","g","h","i","j","k","l")
a[matrix(c("a","b","c","d","e","f"), 3,2)]

#!# -------------------------------------------------------------------------------------------------------------------
#!# update
#!# -------------------------------------------------------------------------------------------------------------------

#! update using subsetting array using larger than matrix is like subsetting using vector
#!t -1 -2 -3 -4 -5 -6 -7 -8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27
a = array(1:27, c(3,3,3))
a[array(1:8,c(2,2,2))] = c(-1,-2,-3,-4,-5,-6,-7,-8)
as.vector(a)

#! update using subsetting matrix by matrix where cols != dim is like a vector
#!t -1 -2 3 4 5 6 7 8 9 10
a = matrix(1:10,2,5)
a[matrix(c(1,2),2,1)] = c(-1,-2)
as.vector(a)

#! update using subsetting matrix by matrix with cols = dim works like selection
#!t 1 2 -1 4 5 6 7 8 9 10
a = matrix(1:10,2,5)
a[matrix(c(1,2),1,2)] = -1
as.vector(a)

#! update using subsetting matrix by matrix returns the elements
#!t -1 2 3 -2 5 6 7 8 9 10
a = matrix(1:10,2,5)
a[matrix(c(1,2,1,2),2,2)] = c(-1,-2)
as.vector(a)

#! update using subsetting array by matrix works
#!t 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 -1 17 18 19 -2 21 22 23 24 25 26 27
a = array(1:27, c(3,3,3))
a[matrix(1:3,2,3)] = c(-1,-2)
as.vector(a)

#! update using subsetting array by matrix with wrong dimensions is like an array
#!t -1 -2 -3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27
a = array(1:27, c(3,3,3))
a[matrix(1:3,3,2)] = c(-1,-2,-3)
as.vector(a)

#! update with larger rhs produces a warning
#!w number of items to replace is not a multiple of replacement length
#!o 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 -1 17 18 19 -2 21 22 23 24 25 26 27
a = array(1:27, c(3,3,3))
a[matrix(1:3,2,3)] = c(-1,-2, -3)
as.vector(a)

#! update with larger rhs produces a warning
#!w number of items to replace is not a multiple of replacement length
#!o 1 2 3 4 5 6 7 -2 9 10 11 -1 13 14 15 16 17 18 19 20 21 -2 23 24 25 26 27
a = array(1:27, c(3,3,3))
a[matrix(1:3,10,3)] = c(-1,-2, -3, -2)
as.vector(a)

