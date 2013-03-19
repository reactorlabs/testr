#!# this file deals with updating vectors with different types and the effects of such update on the LHS

#! when updating by a list, type changes to list
#!t "list"
a = c(1,2,3)
a[c(1,2)] = list(z=5,q="ha")
typeof(a)

#! update by list does not propagate list's names
a = c(1,2,3)
a[c(1,2)] = list(z=5,q="ha")
is.null(names(a))

#! update that in fact does not change the vector still changes the type 
#!t "list"
a = c(1,2,3)
a[0] = list(z=5, q="ha")
typeof(a)

#! update by matrix does not change the type
#!t TRUE 4 3 2 1
a = c(1,2,3,4)
a[c(1,2,3,4)] = matrix(c(4,3,2,1), 2,2)
is.null(dim(a))
a

#! update by array does not change the type
#!t TRUE 4 3 2 1
a = c(1,2,3,4)
a[c(1,2,3,4)] = array(c(4,3,2,1), c(1,2,2))
is.null(dim(a))
a



