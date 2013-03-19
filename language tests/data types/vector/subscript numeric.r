#!# subscript to vectors [[ ]], R Language Reference, page 17 onwards

#!# -----------------------------------------------------------------------------------------------
#!# numbered subscripts -- read
#!# -----------------------------------------------------------------------------------------------

#! fails with multiple elements to select
#!e attempt to select more than one element
a = c(1,2,3,4,5,6,7)
a[[c(1,2)]]

#! fails for 0th index
#!e attempt to select less than one element
a = c(1,2,3,4,5,6,7)
a[[0]]

#! with numeric index does not work on out of bounds indices
#!e subscript out of bounds
a = c(1,2,3,4,5,6,7)
a[[70]]

#! empty [[ ]] is not supported for vectors of size  1
#!e invalid subscript type 'symbol'
a = 1
a[[]]

#! empty [[ ]] is not supported for vectors of size > 1
#!e invalid subscript type 'symbol'
a = c(1,2,3)
a[[]]

#! non-existing negative indices does not work with scalars
#!e attempt to select less than one element
#!# TODO this is interesting because [-2] will work and will return a single element
a = 2
a[[-2]]

#! negative number works on vectors of size 2
a = c(3,4)
a[[-2]] == 3

#! negative number does not work vectors > 2
#!e attempt to select more than one element
a = c(3,4,5)
a[[-2]]

#! different types can be used as subscripts
#!g IDX = (3L # 3 # 3.1 # 3.8)
a = c(1,2,3,4,5,6,7,8)
a[[@IDX]] == 3

#! logical TRUE can be used as subscript 1
a = c(1,2,3)
a[[TRUE]] == 1

#! logical FALSE cannot be used as subscript
#!e attempt to select less than one element
a = c(1,2,3,4,5,6,7)
a[[FALSE]]

#! complex number cannot be used as subscript
#!e invalid subscript type 'complex'
a = c(1,2,3,4)
a[[2+2i]]

#! raw number cannot be used as subscript
#!e invalid subscript type 'raw'
s = raw(1)
a = c(1,2,3)
a[[s]]

#! string cannot be used as subscipt if vector has no names
#!e subscript out of bounds
a = c(1,2,3)
a[["1"]]

#! numeric subscript on vector does not preserve names attribute
a = c(a=1, b=2, c=3)
is.null(names(a[[1]]))

#! subscript drops all atrributes
a = c(1,2,4)
attributes(a) <- list(name = "foo", otherAttr = "bar")
is.null(attributes(a[[1]]))

#! NA cannot be used in subscript
#!e subscript out of bounds
a = c(1, 2, 3)
a[[NA]]

#! null cannot be used in subscript
#!e attempt to select less than one element
a = c(1,2,3)
a[[NULL]]

#!# -----------------------------------------------------------------------------------------------
#!# numbered subscripts write
#!# -----------------------------------------------------------------------------------------------

#! logical vectors can be changed
#!t FALSE TRUE FALSE
a = c(TRUE, TRUE, FALSE)
a[[1]] = FALSE
a

#! integer vectors can be changed
#!t 1 2 3
a = c(2, 2, 3)
a[[1]] = 1
a

#! double vectors can be changed
#!t 1.1 2.2 3.3
a = c(1.2, 2.2, 3.3)
a[[1]] = 1.1
a

#! complex vctors can be changed
#!t 1+3i 2+2i 3+1i
a = c(2+1i, 2+2i, 3+1i)
a[[1]] = 1+3i
a

#! string vectors can be changed
#!t "first" "second" "third"
a = c("to be changed", "second", "third")
a[[1]] = "first"
a

#! raw vectors can be changed
#!t 07 00 00
a = raw(3)
a[[1]] = as.raw(7)
a

#! logical vector updated to higher type changes its type
#!g V =    (1L  # 1   # 3.1   # 2+3i      # "foo")
#!g R(V) = (1 1 # 1 1 # 3.1 1 # 2+3i 1+0i # "foo" "TRUE")
#!t @R
a = c(FALSE, TRUE)  
a[[1]] = @V
a

#! raw cannot be inserted to boolean vector
#!e incompatible types (from raw to logical) in subassignment type fix
a = c(TRUE, FALSE)
a[[1]] = as.raw(7)

#! integer vector will convert logical updates
#!t 0 2 3
a = c(1L, 2L, 3L)
a[[1]] = FALSE
a

#! integer vector updated to higher type changes its type
#!g V =    (3.1   # 2+3i      # "foo")
#!g R(V) = (3.1 1 # 2+3i 1+0i # "foo" "1")
#!t @R
a = c(10, 1)  
a[[1]] = @V
a

#! raw cannot be inserted to integer vector
#!e incompatible types (from raw to integer) in subassignment type fix
a = c(1L, 2L)
a[[1]] = as.raw(7)

#! double vector will convert integer and logical updates
#!g T =    (TRUE  # FALSE # 1     # 2L)
#!g V(T) = (1 2.7 # 0 2.7 # 1 2.7 # 2 2.7) 
#!t @V
a = c(1.5, 2.7)
a[[1]] = @T
a

#! double vector updated to higher type changes its type
#!g V =    (2+3i        # "foo")
#!g R(V) = (2+3i 1.1+0i # "foo" "1.1")
#!t @R
a = c(10, 1.1)  
a[[1]] = @V
a

#! raw cannot be inserted to double vector
#!e incompatible types (from raw to double) in subassignment type fix
a = c(1.1, 2.2)
a[[1]] = as.raw(7)

#! complex vector will convert double, integer and logical updates
#!g T =    (TRUE      # FALSE     # 1         # 2L        # 3.1)
#!g V(T) = (1+0i 2+2i # 0+0i 2+2i # 1+0i 2+2i # 2+0i 2+2i # 3.1+0i 2+2i) 
#!t @V
a = c(1+1i, 2+2i)
a[[1]] = @T
a

#! complex vector updated to string changes its type
#!t "foo" "2+3i"
a = c(1+2i, 2+3i)  
a[[1]] = "foo"
a

#! raw cannot be inserted to complex vector
#!e incompatible types (from raw to complex) in subassignment type fix
a = c(1.1+2i, 2.2+3i)
a[[1]] = as.raw(7)

#! updating out of bounds enlarges vector
#!t 1 2 3 67
a = c(1,2,3)
a[[4]] = 67
a

#! updating out of bounds enlarges vector and fills with NA
#!t 1 2 3 NA 67
a = c(1,2,3)
a[[5]] = 67
a

