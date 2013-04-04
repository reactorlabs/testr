#!# subscript operator to arrays, R lang ref p 17 onwards

#! empty subscript is not valid even for small enough arrays
#!e invalid subscript type 'symbol'
a = array(1,c(1,1,1))
a[[,,]]

#! empty subscript is not valid even for small enough arrays 2
#!e invalid subscript type 'symbol'
a = array(1,c(3,2,1))
a[[2,1,]]

#! exact subscript works on arrays
a = array(1:8,c(2,2,2))
a[[1,2,1]] == 3

#! exact subscript works in update
#!t 1 2 67 4 5 6 7 8
a = array(1:8, c(2, 2,2))
a[[1,2,1]] = 67
as.vector(a)

#! only positional argument matching is used
a = array(1:8,c(2,2,2))
a[[i = 1, j = 2,1]] == a[[j = 1, i = 2,1]]

#! subscript discards all attributes
a = array(c(a=1,b=2,c=3,d=4,5,6,7,8), c(2,2,2), dimnames=list(c("x","y"), c("w","t"), c("k","l")))
attributes(a)$xyz = 67
is.null(attributes(a[[1,2,1]]))

#! subscipt to named dimensions works on read
a = array(1:8, c(2,2,2), dimnames=list(c("x","y"), c("w","t"), c("k","l")))
a[["x","t","l"]] == 7

#! subscipt to named dimensions works on update
#!t 1 2 3 4 5 6 78 8
a = array(1:8, c(2,2,2), dimnames=list(c("x","y"), c("w","t"), c("k","l")))
a[["x","t","l"]] = 78
as.vector(a)

#! subscript to named dimensions can still use numbers
#!t 1 2 3 4 5 6 78 8
a = array(1:8, c(2,2,2), dimnames=list(c("x","y"), c("w","t"), c("k","l")))
a[[1,2,2]] = 78
as.vector(a)

#! subscript dimensions cannot be supplied in a vector
#!e attempt to select more than one element
a = array(1:8,c(2,2,2))
a[[c(1,2,1)]]

#! subscript to array using only single dimension works as on vector
a = array(1:8,c(2,2,2))
a[[3]] == 3

#! subscript to array using only single dimension with names does not work on matrix from named vector 
#!e subscript out of bounds
a = matrix(c(a=1,b=2,c=3,d=4),c(2,2,1))
a[["c"]] == 3

#! drop FALSE passes but produces not a different result
a = array(1:8,c(2,2,2))
is.null(dim(a[[1,2,1,drop=FALSE]]))

#! out of bounds read is an error
#!e subscript out of bounds
a = array(1,c(2,2,2))
a[[3,3,3]]

#! out of bounds update is an error
#!e [[ ]] subscript out of bounds
a = array(1,c(2,2,2))
a[[3,3,3]] = 2


#!# -------------------------------------------------------------------------------------------------------------------
#!# partial matching
#!# -------------------------------------------------------------------------------------------------------------------

#! partial matching with exact being NA works and produces warnings
#!w  partial match of 'x' to 'x1'
#!w  partial match of 't' to 't1'
#!w  partial match of 'l' to 'l1' 
#!o TRUE
a = array(1:8, c(2,2,2), dimnames=list(c("x1","y1"), c("w1","t1"), c("k1","l1")))
a[["x","t", "l", exact = NA]] == 7

#! partial matching with exact being FALSE works with no warnings
a = array(1:8, c(2,2,2), dimnames=list(c("x1","y1"), c("w1","t1"), c("k1","l1")))
a[["x","t","l", exact = FALSE]] == 7

#! partial matching with exact being TRUE does not work
#!e subscript out of bounds
a = array(1:8, c(2,2,2), dimnames=list(c("x1","y1"), c("w1","t1"), c("k1","l1")))
a[["x","t","l", exact = TRUE]] == 7

#! default partial matching exact arg is NA
#!dt it is actually TRUE in current gnu-r even though manual says NA
#!w  partial match of 'x' to 'x1'
#!w  partial match of 't' to 't1'
#!w  partial match of 'l' to 'l1' 
#!o TRUE
a = array(1:8, c(2,2,2), dimnames=list(c("x1","y1"), c("w1","t1"), c("k1","l1")))
a[["x","t","l"]] == 3

#! partial matching does not work on write
#!e [[ ]] improper number of subscripts
a = array(1:8, c(2,2,2), dimnames=list(c("x1","y1"), c("w1","t1"), c("k1","l1")))
a[["x","y","l", exact = FALSE]] = 78

#!# -------------------------------------------------------------------------------------------------------------------
#!# matrix update changes the type of matrix
#!# -------------------------------------------------------------------------------------------------------------------

#! logical array gets updated to higher types
#!g T =    (3L      # 3       # 4.5       # 2+3i                # "foo")
#!g V(T) = (0 3 0 1 # 0 3 0 1 # 0 4.5 0 1 # 0+0i 2+3i 0+0i 1+0i # "FALSE" "foo" "FALSE" "TRUE")    
#!t @V
a = array(c(FALSE,TRUE,FALSE,TRUE),c(1,2,2))
a[1,2,1] = @T
as.vector(a)

#! integer array gets updated to higher types
#!g T =    (3       # 4.5         # 2+3i                # "foo")
#!g V(T) = (1 3 3 4 # 1 4.5 3 4 # 1+0i 2+3i 3+0i 4+0i # "1" "foo" "3" "4")    
#!t @V
a = array(c(1L,2L,3L,4L),c(1,2,2))
a[1,2,1] = @T
as.vector(a)

#! double array gets updated to higher types
#!g T =    (2+3i                      # "foo")
#!g V(T) = (1.1+0i 2+3i 3.3+0i 4.4+0i # "1.1" "foo" "3.3" "4.4")    
#!t @V
a = array(c(1.1,2.2,3.3,4.4),c(1,2,2))
a[1,2,1] = @T
as.vector(a)

#! complex gets updated to srtring
#!t "1+1i" "foo" "3+3i" "4+4i"
a = array(c(1+1i, 2+2i, 3+3i, 4+4i),c(1,2,2))
a[1,2,1] = "foo"
as.vector(a)
