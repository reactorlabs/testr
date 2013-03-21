#! logical subsetting on dimensions is possible on arrays too

#! logical subsetting on dimensions is too possible
#!ttt
a = array(1:27,c(3,3,3))
a[c(TRUE,FALSE,TRUE),,c(TRUE,FALSE,FALSE)] == a[c(1,3),,1]

#! smaller logical vector is recycled
#!t 4 13 22 6 15 24
a = array(1:27,c(3,3,3))
a[c(TRUE,FALSE), c(FALSE, TRUE), TRUE] 

#! single NA is interpretted as logical NA
#!t NA NA NA NA NA NA
a = array(1:27,c(3,3,3))
a[NA,c(1,2),2]

#! NA in logical vector is interpreted as normal NA
#!t 10 NA
a = array(1:27,c(3,3,3))
a[1,c(TRUE,NA, FALSE),2]

#! single NA is boolean NA for the vector-like selection
#!t NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA
a = array(1:27,c(3,3,3))
a[NA]

#! single NA is boolean NA for the vector-like selection, resulting type is vector
a = array(1:27,c(3,3,3))
is.null(dim(a[NA]))
