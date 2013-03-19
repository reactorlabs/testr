#! indexing array by character vectors - dimnames

#! single dimension produces NAs when names are null
#!t NA NA
a = array(1:8, c(2,2,2), dimnames=list(c("a","b"),c("c","d"),c("e","f")))
a[c("a","b")]

#! single dimension produces real values when names are present
#!t a b 2 1
a = array(1:8, c(2,2,2), dimnames=list(c("a","b"),c("c","d"),c("e","f")))
names(a) = c("b","a")
a[c("a","b")]

#! scalar works well
a = array(1:8, c(2,2,2), dimnames=list(c("a","b"),c("c","d"),c("e","f")))
a["a","c","e"] == 1

#! character vectors return the proper elements
#!t e f a 3 7 b 4 8
a = array(1:8, c(2,2,2), dimnames=list(c("a","b"),c("c","d"),c("e","f")))
b = a[c("a","b"),"d",c("e","f")]
b

#! name not present returns NA
#!e subscript out of bounds
a = array(1:8, c(2,2,2), dimnames=list(c("a","b"),c("c","d"),c("e","f")))
a["c","a","b"] == NA

#! names left are only those used in the subset
#!t TRUE TRUE TRUE 2 2 "a" "b" "e" "g"
a = array(1:8, c(2,2,3), dimnames=list(c("a","b"),c("c","d"),c("e","f","g")))
attributes(a)$xyz = 67
attrs = attributes(a[,"d",c("e","g")]) 
length(attrs) == 2
is.null(attrs$names)
is.null(attrs$xyz)
attrs[["dim"]]
attrs$dimnames[[1]]
attrs$dimnames[[2]]

#! names left are only those used in the subset
#!t TRUE TRUE TRUE 2 2 "a" "b" "e" "e"
a = array(1:8, c(2,2,3), dimnames=list(c("a","b"),c("c","d"),c("e","f","g")))
attributes(a)$xyz = 67
attrs = attributes(a[,"d",c("e","e")]) 
length(attrs) == 2
is.null(attrs$names)
is.null(attrs$xyz)
attrs[["dim"]]
attrs$dimnames[[1]]
attrs$dimnames[[2]]

#!# update ------------------------------------------------------------------------------------------------------------

#! update to nonexistent name throws an exception
#!e subscript out of bounds
a = array(1:8, c(2,2,2), dimnames=list(c("a","b"),c("c","d"),c("e","f")))
a["f","a","d"] = 5;

#! multiple update to same element leaves only the last one
#!t 12 2 3 4 5 6 7 8
a = array(1:8, c(2,2,2), dimnames=list(c("a","b"),c("c","d"),c("e","f")))
a[c("a","a","a"),"c","e"] = c(10,11,12)
as.vector(a)

#! complex update with same names
#!t 10 2 11 4 10 6 11 8
a = array(1:8, c(2,2,2), dimnames=list(c("a","b"),c("c","d"),c("e","f")))
a[c("a","a","a"),,] = c(10,11)
as.vector(a)

#! update with multiple columns of same name chosen updates only the first one
#!t 10 2 3 4 5 6 7 8
a = array(1:8, c(2,2,2), dimnames=list(c("a","a"),c("c","d"),c("e","f")))
a["a","c","e"] = 10
as.vector(a)

#! update with multiple columns of same name chosen and multiple values is an error
#!e number of items to replace is not a multiple of replacement length
a = array(1:8, c(2,2,2), dimnames=list(c("a","a"),c("c","d"),c("e","f")))
a["a","c","e"] = c(10,11)

#! update with multiple same name columns selected more than once only changes the first appearance
#!t 10 2 3 4 5 6 7 8
a = array(1:8, c(2,2,2), dimnames=list(c("a","a"),c("c","d"),c("e","f")))
a[c("a","a"),"c","e"] = 10
as.vector(a)

#! update with multiple same name columns selected more than once only changes the first appearance, latest element is used from rhs
#!t 11 2 3 4 5 6 7 8
a = array(1:8, c(2,2,2), dimnames=list(c("a","a"),c("c","d"),c("e","f")))
a[c("a","a"),"c","e"] = c(10,11)
as.vector(a)

#! smaller vectors are recycled during vector update
#!t 10 11 3 4 10 11 7 8
a = array(1:8, c(2,2,2), dimnames=list(c("a","b"),c("c","d"),c("e","f")))
a[c("a","b"),"c",] = c(10,11)
as.vector(a)

#! scalar is the extreme case 
#!t 0 0 0 0 0 0 0 0
a = array(1:8, c(2,2,2), dimnames=list(c("a","b"),c("c","d"),c("e","f")))
a[,,] = 0
as.vector(a)

#! error is produced if the lhs cannot be recycled completely
#!e number of items to replace is not a multiple of replacement length
a = array(1:8, c(2,2,2), dimnames=list(c("a","b"),c("c","d"),c("e","f")))
a[c("a","b"),"c",] = c(10,11,12)
as.vector(a)

#! warning is produced if lhs is larger than replacement, extra elements are ignored
#!e number of items to replace is not a multiple of replacement length
a = array(1:8, c(2,2,2), dimnames=list(c("a","b"),c("c","d"),c("e","f")))
a[c("a","b"),"c",] = c(10,11,12,13,14,15,16,17,18)
as.vector(a)

#!# -------------------------------------------------------------------------------------------------------------------
#!# drop 
#!# -------------------------------------------------------------------------------------------------------------------

#! when drop is selected and result is a vector, dimnames become names
#!t "a" "b" TRUE
a = array(1:8, c(2,2,2), dimnames=list(c("a","b"),c("c","d"),c("e","f")))
attrs = attributes(a[c("a","b"),"c","e"]) 
attrs[["names"]]
is.null(attrs$dimnames)

#! when drop is false and result is a vector dimnames are preserved
#!t TRUE "a" "b" "c" "e"
a = array(1:8, c(2,2,2), dimnames=list(c("a","b"),c("c","d"),c("e","f")))
attrs = attributes(a[c("a","b"),"c","e", drop = FALSE]) 
is.null(attrs$names)
attrs$dimnames[[1]]
attrs$dimnames[[2]]
attrs$dimnames[[3]]



