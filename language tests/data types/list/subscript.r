#!# subscript [[ ]] into a list, R language reference, p 17 onwards

#! basic read of simple list
a = list(a=1,b=2,c=3)
a[["a"]] == 1

#! basic update of simple list
a = list(a=1,b=2,c=3)
a[["b"]] = 7
a[["b"]] == 7

#! out olf bounds read in integer indices is error
#!e subscript out of bounds
#!# TODO this is inconsistent with upate beyond bounds increasing the structure
a = list(1,2,3)
is.null(a[[10]])

#! subscript of a single element discards list and returns the element only
#!t "double"
a = list(a=c(1.1,2.2), b = 6)
typeof(a[["a"]])

#! out of bounds read of string indices is NULL
a = list(1,2,3)
is.null(a[["d"]])

#! integers can be used as names too
#!tt 3
a = list(a=1,b=2,c=3)
a[[1]] == 1
a[[2]] == 2
a[[3]] == 3

#! writing to out of bounds extends list
#!tt 2
a = list(a=1, b=2, c=3)
a[[4]] = 78
length(a) == 4 
a[[4]]  == 78

#! writing out of bounds extends list by nulls
#!ttt
a = list(a=1, b=2, c=3)
a[[5]] = 78
length(a) == 5 
is.null(a[[4]])
a[[5]]  == 78

#! update out of bounds by string appends the string
a = list(a=1, b=2, 4, 5)
a[["d"]] = 7
a[[5]] == 7

#! non integer indices are converted to int
#!g T = (TRUE # 1 # 1L # 1.8 # 1.1)
a = list(7,5,4)
a[[@T]] == 7

#! complex indices to list produce an error
#!e invalid subscript type 'complex'
a = list(1, 2, 3)
a[[2+1i]]

#! [[ drops all attributes
#!ttt
a = list(a=1, b=2, c=3)
attributes(a)["xyz"] = 67
is.null(attributes(a[["a"]]))
is.null(attributes(a[[1]]))

#!# -------------------------------------------------------------------------------------------------------------------
#!# partial matching
#!# -------------------------------------------------------------------------------------------------------------------

#! partial matching works with exact FALSE without a warning
a = list(foo=1, bar=2, foobar=3)
a[["b", exact=FALSE]] == 2

#! partial matching works with exact FALSE without a warning
#!w partial match of 'b' to 'bar'
#!o TRUE
a = list(foo=1, bar=2, foobar=3)
a[["b", exact=NA]] == 2

#! partial matching does not work with exact TRUE
a = list(foo=1, bar=2, foobar=3)
is.null(a[["b", exact=TRUE]])

#! partial matching exact default value is NA
#!dt
#!# but it is not, default value for gnur is TRUE, lang spec says otherwise
a = list(foo=1, bar=2, foobar=3)
a[["b"]] == 2

#! partial matching works in recursive lists as well
#!w partial match of 'c' to 'cc'
#!w partial match of 'd' to 'dd'
#!o TRUE
a = list(aa=1, bb=2, cc=list(dd=3, ee=4, ff=5))
a[[c("c","d"), exact = NA]] == 3

#! partial matching on update does not work
#!e [[ ]] improper number of subscripts
a = list(aa=1, b=2)
a[["aa", exact = FALSE]] = 6

#!# -------------------------------------------------------------------------------------------------------------------
#!# recursive lists
#!# -------------------------------------------------------------------------------------------------------------------

#! recursive indices can be applied sequentially
a = list(a=1, b=2, c=list(d=3, e=4, c=5))
a[["c"]][["d"]] == 3

#! recursive indices can be applied sequentially even with numbers
a = list(a=1, b=2, c=list(d=3, e=4, c=5))
a[[3]][[1]] == 3

#! recursive indices cannot be passed as dimensions
#!e incorrect number of subscripts
a = list(a=1, b=2, c=list(d=3, e=4, c=5))
a[["c","d"]]

#! recursive indices cannot be passed as dimensions even with numbers
#!e incorrect number of subscripts
a = list(a=1, b=2, c=list(d=3, e=4, c=5))
a[[3,1]]

#! recursive indices can be supplied as vector
a = list(a=1, b=2, c=list(d=3, e=4, c=5))
a[[c("c","d")]] == 3

#! recursive indices can be supplied as vector of integers
a = list(a=1, b=2, c=list(d=3, e=4, c=5))
a[[c(3,1)]] == 3

#! vector can be part of the recursive indexing too when using numbers
a = list(a=1, b=2, c=c(1,2,3,4,5))
a[[c(3,3)]] == 3

#! vector can be part of the recursive indexing too when using strings
a = list(a=1, b=2, c=c(a=1,b=2,c=3))
a[[c("c","c")]] == 3

#! using list as a supplier for the dimensions is not allowed
#!e invalid subscript type 'list'
a = list(a=1,b=2,c=list(a=1,b=2))
a[[list("a","a")]] 

