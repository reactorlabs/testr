#! indexing matrix by character vectors - dimnames

#! more dimensions produce error
#!e incorrect number of dimensions
a = matrix(1, 2,2, dimnames=list(c("a","b"), c("d","e")))
a["a","d","c"]

#! single dimension produces NAs when names are null
#!t NA NA
a = matrix(1:4, 2,2, dimnames=list(c("a","b"),c("c","d")))
a[c("a","b")]

#! single dimension produces real values when names are present
#!t a b 2 1
a = matrix(1:4, 2,2, dimnames=list(c("a","b"),c("c","d")))
names(a) = c("b","a")
a[c("a","b")]

#! scalar works well
a = matrix(1:4, 2,2, dimnames=list(c("a","b"),c("c","d")))
a["a","c"] == 1

#! character vectors return the proper elements
#!t a b 3 4
a = matrix(1:4, 2,2, dimnames=list(c("a","b"),c("c","d")))
b = a[c("a","b"),"d"]
b

#! name not present returns NA
#!e subscript out of bounds
a = matrix(1:4, 2,2, dimnames=list(c("a","b"),c("c","d")))
a["c","a"] == NA

#! if single dimension only, names are used if present for vector-like indexing
#!t a c f 1 3 6
a = matrix(1:9,3,3)
names(a) = c("a","b","c","d","e","f")
a[c("a","c","f")]

#! if single dimension only, names not present, but character indexed returns NAs
#!t NA NA NA
a = matrix(1:9, 3,3)
a[c("a","c","f")]

#! names left are only those used in the subset
#!t TRUE TRUE TRUE 2 2 "a" "b" "e" "g"
a = matrix(1:6, 2,3, dimnames=list(c("a","b"),c("e","f","g")))
attributes(a)$xyz = 67
attrs = attributes(a[,c("e","g")]) 
length(attrs) == 2
is.null(attrs$names)
is.null(attrs$xyz)
attrs[["dim"]]
attrs$dimnames[[1]]
attrs$dimnames[[2]]

#! names left are only those used in the subset
#!t TRUE TRUE TRUE 2 2 "a" "b" "e" "e"
a = matrix(1:6, 2,3, dimnames=list(c("a","b"),c("e","f","g")))
attributes(a)$xyz = 67
attrs = attributes(a[,c("e","e")]) 
length(attrs) == 2
is.null(attrs$names)
is.null(attrs$xyz)
attrs[["dim"]]
attrs$dimnames[[1]]
attrs$dimnames[[2]]

#!# update ------------------------------------------------------------------------------------------------------------

#! update to nonexistent name throws an exception
#!e subscript out of bounds
a = matrix(1:4, 2,2, dimnames=list(c("a","b"),c("c","d")))
a["f","a"] = 5;

#! multiple update to same element leaves only the last one
#!t 12 2 3 4
a = matrix(1:4, 2,2, dimnames=list(c("a","b"),c("c","d")))
a[c("a","a","a"),"c"] = c(10,11,12)
as.vector(a)

#! complex update with same names
#!t 10 2 11 4
a = matrix(1:4, 2,2, dimnames=list(c("a","b"),c("c","d")))
a[c("a","a","a"),] = c(10,11)
as.vector(a)

#! update with multiple columns of same name chosen updates only the first one
#!t 10 2 3 4
a = matrix(1:4, 2,2, dimnames=list(c("a","a"),c("c","d")))
a["a","c"] = 10
as.vector(a)

#! update with multiple columns of same name chosen and multiple values is an error
#!e number of items to replace is not a multiple of replacement length
a = matrix(1:4, 2,2, dimnames=list(c("a","a"),c("c","d")))
a["a","c"] = c(10,11)

#! update with multiple same name columns selected more than once only changes the first appearance
#!t 10 2 3 4
a = matrix(1:4, 2,2, dimnames=list(c("a","a"),c("c","d")))
a[c("a","a"),"c"] = 10
as.vector(a)

#! update with multiple same name columns selected more than once only changes the first appearance, latest element is used from rhs
#!t 11 2 3 4
a = matrix(1:4, 2,2, dimnames=list(c("a","a"),c("c","d")))
a[c("a","a"),"c"] = c(10,11)
as.vector(a)

#! smaller vectors are recycled during vector update
#!t 10 11 10 11
a = matrix(1:4, 2,2, dimnames=list(c("a","b"),c("c","d")))
a[c("a","b"),] = c(10,11)
as.vector(a)

#! scalar is the extreme case 
#!t 0 0 0 0
a = matrix(1:4, 2,2, dimnames=list(c("a","b"),c("c","d")))
a[,] = 0
as.vector(a)

#! error is produced if the lhs cannot be recycled completely
#!e number of items to replace is not a multiple of replacement length
a = matrix(1:4, 2,2, dimnames=list(c("a","b"),c("c","d")))
a[c("a","b"),] = c(10,11,12)
as.vector(a)

#! warning is produced if lhs is larger than replacement, extra elements are ignored
#!e number of items to replace is not a multiple of replacement length
a = matrix(1:4, 2,2, dimnames=list(c("a","b"),c("c","d")))
a[c("a","b"),"c"] = c(10,11,12,13,14,15,16,17,18)
as.vector(a)

#!# -------------------------------------------------------------------------------------------------------------------
#!# drop 
#!# -------------------------------------------------------------------------------------------------------------------

#! when drop is selected and result is a vector, dimnames become names
#!t "a" "b" TRUE
a = matrix(1:8, 2,2, dimnames=list(c("a","b"),c("c","d")))
attrs = attributes(a[c("a","b"),"c"]) 
attrs[["names"]]
is.null(attrs$dimnames)

#! when drop is false and result is a vector dimnames are preserved
#!t TRUE "a" "b" "c"
a = matrix(1:4, c(2,2,2), dimnames=list(c("a","b"),c("c","d")))
attrs = attributes(a[c("a","b"),"c", drop = FALSE]) 
is.null(attrs$names)
attrs$dimnames[[1]]
attrs$dimnames[[2]]



