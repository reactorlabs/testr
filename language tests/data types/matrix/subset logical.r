#! logical subsetting on dimensions is possible on matrices too

#! logical subsetting on dimensions is too possible
#!ttt
a = matrix(1:9,3)
a[c(TRUE,FALSE,TRUE),] == a[c(1,3),]

#! smaller logical vector is recycled
#!t 1 4 7 3 6 9
a = matrix(1:9,3)
a[c(TRUE,FALSE), TRUE] 

#! single NA is interpretted as logical NA
#!t NA NA NA NA NA NA
a = matrix(1:9,3,3)
a[NA,c(1,2)]

#! NA in logical vector is interpreted as normal NA
#!t 4 NA
a = matrix(1:9,3,3)
a[c(TRUE,NA, FALSE),2]

#! single NA is boolean NA for the vector-like selection
#!t NA NA NA NA NA NA NA NA NA
a = matrix(1:9,3,3)
a[NA]

#! single NA is boolean NA for the vector-like selection, resulting type is vector
a = matrix(1:9,3,3)
is.null(dim(a[NA]))
