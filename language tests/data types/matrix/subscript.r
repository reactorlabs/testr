#!# subscript operator to matrices, R lang ref p 17 onwards

#! empty subscript is not valid even for small enough matrices
#!e invalid subscript type 'symbol'
a = matrix(1,1,1)
a[[,]]

#! empty subscript is not valid even for small enough matrices 2
#!e invalid subscript type 'symbol'
a = matrix(1,3,1)
a[[2,]]

#! exact subscript works on matrices
a = matrix(1:9,3,3)
a[[1,2]] == 4

#! exact subscript works in update
#!t 1 67 2 4
a = matrix(1:4, 2, 2)
a[[1,2]] = 67
a

#! only positional argument matching is used
a = matrix(1:4,2,2)
a[[i = 1, j = 2]] == a[[j = 1, i = 2]]

#! subscript discards all attributes
a = matrix(c(a=1,b=2,c=3,d=4), 2, 2, dimnames=list(c("x","y"), c("w","t")))
attributes(a)$xyz = 67
is.null(attributes(a[[1,2]]))

#! subscipt to named dimensions works on read
a = matrix(1:4, 2, 2, dimnames=list(c("x","y"), c("w","t")))
a[["x","t"]] == 3

#! subscipt to named dimensions works on update
#!t w t x 1 7 y 2 4
a = matrix(1:4, 2, 2, dimnames=list(c("x","y"), c("w","t")))
a[["x","t"]] = 7
a

#! subscript to named dimensions can still use numbers
#!t w t x 1 7 y 2 4
a = matrix(1:4, 2, 2, dimnames=list(c("x","y"), c("w","t")))
a[[1,2]] = 7
a

#! subscript dimensions cannot be supplied in a vector
#!e attempt to select more than one element
a = matrix(1:4,2,2)
a[[c(1,2)]]

#! subscript to matrix using only single dimension works as on vector
a = matrix(1:4,2,2)
a[[3]] == 3

#! subscript to matrix using only single dimension with names does not work on matrix from named vector 
#!e subscript out of bounds
a = matrix(c(a=1,b=2,c=3,d=4),2,2)
a[["c"]] == 3

#! drop FALSE passes but produces not a different result
a = matrix(1:4,2,2)
is.null(dim(a[[1,2,drop=FALSE]]))

#! out of bounds read is an error
#!e subscript out of bounds
a = matrix(1,2,2)
a[[3,3]]

#! out of bounds update is an error
#!e [[ ]] subscript out of bounds
a = matrix(1,2,2)
a[[3,3]] = 2

#!# -------------------------------------------------------------------------------------------------------------------
#!# partial matching
#!# -------------------------------------------------------------------------------------------------------------------

#! partial matching with exact being NA works and produces warnings
#!w  partial match of 'x' to 'x1'
#!w  partial match of 't' to 't1'
#!o TRUE
a = matrix(1:4, 2, 2, dimnames=list(c("x1","y1"), c("w1","t1")))
a[["x","t", exact = NA]] == 3

#! partial matching with exact being FALSE works with no warnings
a = matrix(1:4, 2, 2, dimnames=list(c("x1","y1"), c("w1","t1")))
a[["x","t", exact = FALSE]] == 3

#! partial matching with exact being TRUE does not work
#!e subscript out of bounds
a = matrix(1:4, 2, 2, dimnames=list(c("x1","y1"), c("w1","t1")))
a[["x","t", exact = TRUE]] == 3

#! default partial matching exact arg is NA
#!dt it is actually TRUE in current gnu-r even though manual says NA
#!w  partial match of 'x' to 'x1'
#!w  partial match of 't' to 't1'
#!o TRUE
a = matrix(1:4, 2, 2, dimnames=list(c("x1","y1"), c("w1","t1")))
a[["x","t"]] == 3

#! partial matching does not work on write
#!e [[ ]] improper number of subscripts
a = matrix(1:4, 2,2, dimnames=list(c("x1","y1"), c("w1","t1")))
a[["x","y", exact = FALSE]] = 78

#!# -------------------------------------------------------------------------------------------------------------------
#!# matrix update changes the type of matrix
#!# -------------------------------------------------------------------------------------------------------------------

#! logical matrix gets updated to higher types
#!g T =    (3L      # 3       # 4.5       # 2+3i                # "foo")
#!g V(T) = (0 3 1 1 # 0 3 1 1 # 0 4.5 1 1 # 0+0i 2+3i 1+0i 1+0i # "FALSE" "foo" "TRUE" "TRUE")    
#!t @V
a = matrix(c(FALSE,TRUE,FALSE,TRUE),2,2)
a[1,2] = @T
a

#! integer matrix gets updated to higher types
#!g T =    (3       # 4.5       # 2+3i                # "foo")
#!g V(T) = (1 3 2 4 # 1 4.5 2 4 # 1+0i 2+3i 2+0i 4+0i # "1" "foo" "2" "4")    
#!t @V
a = matrix(c(1L,2L,3L,4L),2,2)
a[1,2] = @T
a

#! double matrix gets updated to higher types
#!g T =    (2+3i                      # "foo")
#!g V(T) = (1.1+0i 2+3i 2.2+0i 4.4+0i # "1.1" "foo" "2.2" "4.4")    
#!t @V
a = matrix(c(1.1,2.2,3.3,4.4),2,2)
a[1,2] = @T
a

#! complex gets updated to srtring
#!t "1+1i" "foo" "2+2i" "4+4i"
a = matrix(c(1+1i, 2+2i, 3+3i, 4+4i),2,2)
a[1,2] = "foo"
a

