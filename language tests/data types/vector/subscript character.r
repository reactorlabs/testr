#!# character subscripts to named vectors, R Language Reference p 17, help("[[")

#!# -------------------------------------------------------------------------------------------------------------------
#!# read
#!# -------------------------------------------------------------------------------------------------------------------

#! using names works
a = c(a=1, b=2, c=3)
a[["a"]] == 1

#! using on named vectors works with numbers too
a = c(a=1, b=2, c=3)
a[[2]] == 2

#! not only literals are supported
a = c(a=1, b=2, c=3)
b = "c"
a[[b]] == 3

#! named subscript fails on multiple names
#!e attempt to select more than one element
a = c(a=1, b=2, c=3)
a[[c("a","b")]]

#! named subscript fails in name not found
#!e subscript out of bounds
a = c(a=1, b=2, c=3)
a[["d"]]

#! subscript on vector does not preserve names attribute
a = c(a=1, b=2, c=3)
is.null(names(a[["a"]]))

#!# -------------------------------------------------------------------------------------------------------------------
#!# update
#!# -------------------------------------------------------------------------------------------------------------------

#! updaing with non-existent name adds the name
#!t foo bar xyz 1 2 3
a = c(foo=1, bar = 2)
a[["xyz"]] = 3
a

#!# -------------------------------------------------------------------------------------------------------------------
#!# partial matching
#!# -------------------------------------------------------------------------------------------------------------------

#! by default partial matching is disabled
#!e subscript out of bounds
a = c(foo = 1, bar = 2, foobar = 3)
a[["b"]]

#! when enabled partial matching does not work if ambiguous
#!e subscript out of bounds
a = c(foo = 1, bar = 2, foobar = 3)
a[["f", exact = FALSE]]

#! when enabled partial matching does work if ambiguous
#!t 2
a = c(foo = 1, bar = 2, foobar = 3)
a[["b", exact = FALSE]]

#! partial matching does not work on update
#!e improper number of subscripts
a = c(foo = 1, bar = 2, foobar = 3)
a[["b", exact = FALSE]] <- 8

#! partial matching by default is NA and does partial matching with a warning produced (R Lang ref p-19)
#!o 2
#!dt 
#!w partial match of 'b' to 'bar'
a = c(foo = 1, bar = 2, foobar = 3)
a[["b"]]

#! partial matching if exact is NA works and produces a warning
#!o 2
#!w partial match of 'b' to 'bar'
a = c(foo = 1, bar = 2, foobar = 3)
a[["b", exact = NA]]

