#! R language definition, page 20

#! empty subset copies the whole list
#!ttt 
a = list(a=1,b=2,c=3)
b = a[]
a[[1]] == b$a
a[[2]] == b$b
a[[3]] == b$c
length(a) == length(b)

#! empty subset copies the whole list keeping names arguments
#!ttt 
a = list(a=1,b=2,c=3)
b = a[]
!is.null(names(b))
names(a)[[1]] == names(b)[[1]]
names(a)[[2]] == names(b)[[2]]
names(a)[[3]] == names(b)[[3]]
length(names(a)) == length(names(b))

#! empty subset does propagate other arguments
#!ttt
a = list(a=1,b=2,c=3)
attributes(a)$xyz = 67
b = a[]
!is.null(names(b))
!is.null(attributes(b)$xyz)

#! 0 as single index produces a list of length 0
#!t list()
a = list(1,2,3)
a[0]

#! 0 as single index produces a list of length 0 (named if original is named)
#!t named list()
a = list(a=1,b=2,c=3)
a[0]

#! logical vectors can be used and work in the same way as they do for vectors 
#!t 2 1 3
a = list(a=1, b=2, c=3)
b = a[c(TRUE, FALSE, TRUE)]
length(b)
b[[1]]
b[[2]]

#! single NA in index is logical vector NA
#!ttt
a= list(1, 2, 3)
b = a[NA]
length(b) == 3
is.null(b[[1]])
is.null(b[[2]])
is.null(b[[3]])
is.null(names(b))

#! single NA in index is logical vector NA, if names are present in original, they are NA in result
#!t TRUE TRUE TRUE TRUE NA NA NA
a= list(a=1, b=2, c=3)
b = a[NA]
length(b) == 3
is.null(b[[1]])
is.null(b[[2]])
is.null(b[[3]])
names(b)

#! single NA in index is logical vector NA, if names are present in original, they are NA in result, even for empty names 
#!t TRUE TRUE TRUE TRUE NA NA NA
a= list(a=1, 2, 3)
b = a[NA]
length(b) == 3
is.null(b[[1]])
is.null(b[[2]])
is.null(b[[3]])
names(b)

#! [ drops all attributes but names in character subset
#!t TRUE "a" "b"
a = list(a=1, b=2, c=3)
attributes(a)["xyz"] = 67
b = attributes(a[c("a","b")])
is.null(a$xyz)
as.vector(b$names)

#! [ drops all attributes but names in numeric subset
#!t TRUE "a" "b"
a = list(a=1, b=2, c=3)
attributes(a)["xyz"] = 67
b = attributes(a[c(1,2)])
is.null(a$xyz)
as.vector(b$names)

#! subset of a single element always returns list
#!t "list"
a = list(a=c(1,2), b = 6)
typeof(a["a"])

#! numeric subset works on lists with no names
#!t 2 56 "foo"
a = list(56, "foo", 1.1)
b = a[c(1,2)]
length(b)
b[[1]]
b[[2]]

#! numeric subset works even when names are present
#!t 2 56 "foo"
a = list(a=56, b="foo", c=1.1)
b = a[c(1,2)]
length(b)
b[[1]]
b[[2]]

#! numeric subset on named list preserves names
#!t 2 56 "foo"
a = list(a=56, b="foo", c=1.1)
b = a[c(1,2)]
length(b)
b[["a"]]
b[["b"]]

#! character subset works on named lists
#!t 2 56 "foo"
a = list(a=56, b="foo", c=1.1)
b = a[c("a","b")]
length(b)
b[["a"]]
b[["b"]]

#! negative numbers can be used in numeric list indices
#!t 2 1 3
a = list(a=1,b=2,c=3)
b = a[-2]
length(b)
b[["a"]]
b[["c"]]

#! negative and positive numbers cannot appear in same index
#!e only 0's may be mixed with negative subscripts
a = list(a=1,b=2,c=3)
a[c(-2,1)]

#! list cannot be indexed by list
#!e invalid subscript type 'list'
a = list(a=1, b=2, c=3)
a[list(a=1, b=2)]

#!# indexing recursive lists by matrix does not enter the recursion
a = list(a=list(1,2),3,4)
a[matrix(1,2,2)]
length(a) == 4
