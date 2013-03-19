#!# logical vectors as subset indices - p 17, 18 R specification


#! simple read selection
#!t 1 3
a = c(1,2,3,4)
a[c(TRUE, FALSE, TRUE, FALSE)]

#! if vector is smaller, it gets recycled
#!t 1 3
a = c(1,2,3,4)
a[c(TRUE, FALSE)]

#! if vector is longer, it gets extended with NAs
#!t 1 3 NA
a = c(1,2,3,4)
a[c(TRUE, FALSE, TRUE, FALSE, TRUE, FALSE)]

#! NA in boolean vector results in NA
#!t 1 NA 4
a = c(1,2,3,4)
a[c(TRUE, FALSE, NA)]

#! single NA is interpreted as logical vector and replicated to lhs length
#!# if it were integer, result would have been a single NA
#!t NA NA NA NA
a = c(1,2,3,4)
a[NA]

#!# update using logical ----------------------------------------------------------------------------------------------

#! longer logical vector increased the length of lhs
#!t 10 2 11 12
a = c(1,2,3)
a[c(TRUE, FALSE, TRUE, TRUE)] = c(10,11,12)
a

#! longer logical vector increased the length of lhs, missing false filled with NA
#!t 10 2 11 NA 12
a = c(1,2,3)
a[c(TRUE, FALSE, TRUE, FALSE, TRUE)] = c(10,11,12)
a

#! NA is not allowed in boolean vector subset
#!e NAs are not allowed in subscripted assignments
a = c(1,2,3)
a[c(TRUE, TRUE, NA)] = c(10,11,12)

#! update to a logical vector accomodates more general types too
#!g T =    (c(1L,2L) # c(1,2)  # c(1.1, 2.2) # c(1+1i, 2+2i)       # c(1.1+1.1i,2.2+2.2i)        # c("a", "b"))
#!g V(T) = (1 1 2 0  # 1 1 2 0 # 1 1.1 2.2 0 # 1+0i 1+1i 2+2i 0+0i # 1+0i 1.1+1.1i 2.2+2.2i 0+0i # "TRUE" "a" "b" "FALSE")
#!t @V
a = c(TRUE, TRUE, FALSE, FALSE)
a[c(FALSE, TRUE, TRUE, FALSE)] = @T
a

#! update to a logical vector accomodates more general types too and changes its type accordingly
#!g T =    (c(1L,2L)  # c(1,2)   # c(1.1, 2.2) # c(1+1i, 2+2i)       # c(1.1+1.1i,2.2+2.2i)        # c("a", "b"))
#!g V(T) = (1 1 2 0   # 1 1 2 0  # 1 1.1 2.2 0 # 1+0i 1+1i 2+2i 0+0i # 1+0i 1.1+1.1i 2.2+2.2i 0+0i # "TRUE" "a" "b" "FALSE")
#!g X(T) = ("integer" # "double" # "double"    # "complex"           # "complex"                   # "character") 
#!t @X @V
a = c(TRUE, TRUE, FALSE, FALSE)
a[c(FALSE, TRUE, TRUE, FALSE)] = @T
typeof(a)
a

#! raw type cannot be inserted to logical
#!e incompatible types (from raw to logical) in subassignment type fix
a = c(TRUE, TRUE, FALSE, FALSE)
a[c(FALSE, TRUE, TRUE, FALSE)] = as.raw(c(1,2))

#! update to an integer vector accomodates more general types too
#!g T =    (c(1,2)  # c(1.1, 2.2) # c(1+1i, 2+2i)       # c(1.1+1.1i,2.2+2.2i)        # c("a", "b"))
#!g V(T) = (1 1 2 0 # 1 1.1 2.2 0 # 1+0i 1+1i 2+2i 0+0i # 1+0i 1.1+1.1i 2.2+2.2i 0+0i # "1" "a" "b" "0")
#!t @V
a = c(1L, 1L, 0L, 0L)
a[c(FALSE, TRUE, TRUE, FALSE)] = @T
a

#! update to an integer vector accomodates more general types too and changes its type accordingly
#!g T =    (c(1,2)   # c(1.1, 2.2) # c(1+1i, 2+2i)       # c(1.1+1.1i,2.2+2.2i)        # c("a", "b"))
#!g V(T) = (1 1 2 0  # 1 1.1 2.2 0 # 1+0i 1+1i 2+2i 0+0i # 1+0i 1.1+1.1i 2.2+2.2i 0+0i # "1" "a" "b" "0")
#!g X(T) = ("double" # "double"    # "complex"           # "complex"                   # "character") 
#!t @X @V
a = c(1L, 1L, 0L, 0L)
a[c(FALSE, TRUE, TRUE, FALSE)] = @T
typeof(a)
a

#! logical can be inserted to integer and will be upcasted
#!t TRUE 1 1 0 4
a = c(1L, 2L, 3L, 4L)
a[c(FALSE, TRUE, TRUE, FALSE)] = c(TRUE, FALSE)
typeof(a) == "integer"
a

#! raw type cannot be inserted to integer
#!e incompatible types (from raw to integer) in subassignment type fix
a = c(1L, 2L, 3L, 4L)
a[c(FALSE, TRUE, TRUE, FALSE)] = as.raw(c(1,2))

#! update to an double vector accomodates more general types too
#!g T =    (c(1+1i, 2+2i)       # c(1.1+1.1i,2.2+2.2i)        # c("a", "b"))
#!g V(T) = (1+0i 1+1i 2+2i 0+0i # 1+0i 1.1+1.1i 2.2+2.2i 0+0i # "1" "a" "b" "0")
#!t @V
a = c(1L, 1L, 0L, 0L)
a[c(FALSE, TRUE, TRUE, FALSE)] = @T
a

#! update to an double vector accomodates more general types too and changes its type accordingly
#!g T =    (c(1+1i, 2+2i)       # c(1.1+1.1i,2.2+2.2i)        # c("a", "b"))
#!g V(T) = (1+0i 1+1i 2+2i 0+0i # 1+0i 1.1+1.1i 2.2+2.2i 0+0i # "1" "a" "b" "0")
#!g X(T) = ("complex"           # "complex"                   # "character") 
#!t @X @V
a = c(1, 1.2, 1.4, 0)
a[c(FALSE, TRUE, TRUE, FALSE)] = @T
typeof(a)
a

#! lesser types can be inserted to double and will be upcasted
#!g T =    (c(TRUE, FALSE) # c(1L, 2L))
#!g V(T) = (1.1 1 0 4.4    # 1.1 1 2 4.4) 
#!t TRUE @V
a = c(1.1, 2.2, 3.3, 4.4)
a[c(FALSE, TRUE, TRUE, FALSE)] = @T
typeof(a) == "double"
a

#! raw type cannot be inserted to double
#!e incompatible types (from raw to double) in subassignment type fix
a = c(1.1, 2.2, 3.3, 4.4)
a[c(FALSE, TRUE, TRUE, FALSE)] = as.raw(c(1,2))

#! update to an complex vector accomodates more general types too
#!t "1+1i" "a" "b" "4+4i"
a = c(1+1i, 2+2i, 3+3i, 4+4i)
a[c(FALSE, TRUE, TRUE, FALSE)] = c("a","b")
a

#! update to an complex vector accomodates more general types too and changes its type accordingly
#!t "character" "1+1i" "a" "b" "4+4i"
a = c(1+1i, 2+2i, 3+3i, 4+4i)
a[c(FALSE, TRUE, TRUE, FALSE)] = c("a","b")
typeof(a)
a

#! lesser types can be inserted to complex and will be upcasted
#!g T =    (c(TRUE, FALSE)          # c(1L, 2L)               # c(1.1, 2.2))
#!g V(T) = (1.1+1i 1+0i 0+0i 4.4+1i # 1.1+1i 1+0i 2+0i 4.4+1i # 1.1+1i 1.1+0i 2.2+0i 4.4+1i)
#!t TRUE @V
a = c(1.1+1i, 2.2+1i, 3.3+1i, 4.4+1i)
a[c(FALSE, TRUE, TRUE, FALSE)] = @T
typeof(a) == "complex"
a

#! raw type cannot be inserted to complex
#!e incompatible types (from raw to complex) in subassignment type fix
a = c(1.1+1i, 2.2+1i, 3.3+1i, 4.4+1i)
a[c(FALSE, TRUE, TRUE, FALSE)] = as.raw(c(1,2))

#! lesser types can be inserted to character and will be upcasted
#!g T =    (c(TRUE, FALSE)         # c(1L, 2L)       # c(1.1, 2.2)         # c(1+1i, 2+2i))
#!g V(T) = ("a" "TRUE" "FALSE" "d" # "a" "1" "2" "d" # "a" "1.1" "2.2" "d" # "a" "1+1i" "2+2i" "d")
#!t TRUE @V
a = c("a", "b", "c", "d")
a[c(FALSE, TRUE, TRUE, FALSE)] = @T
typeof(a) == "character"
a

#! raw type cannot be inserted to character
#!e incompatible types (from raw to character) in subassignment type fix
a = c("a","b","c","d")
a[c(FALSE, TRUE, TRUE, FALSE)] = as.raw(c(1,2))
