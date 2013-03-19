#!# non integer subsets are treated as integers, R language reference p 17 

#! double is truncated
#!t 1 2 3
a = c(1,2,3,4)
a[c(1.1, 2.9, 3.5)]

#! complex does not work
#!e invalid subscript type 'complex'
a = c(1,2,3,4)
a[c(1+0i)]

#! raw does not work
#!e invalid subscript type 'raw'
a = c(1,2,3,4)
a[as.raw(c(1,2))]