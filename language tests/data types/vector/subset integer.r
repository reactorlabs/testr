#!# integer subsets to vectors, R language reference, p 17 onwards

#! [] with empty indices returns the object keeping only names
#!dt 
#!t TRUE "a" "b" "c"
a = c(a=1, b=2, c=3)
attributes(a)$xyz = 67
length(attributes(a[])) == 1
attributes(a[])$names

#! [] with empty indices returns the object keeping all attributes
a = c(a=1, b=2, c=3)
attributes(a)$xyz = 67
length(attributes(a[])) == 2

#! [] with indices returns the object keeping names but not other arguments
#!ttt
a = c(a=1, b=2, c=3)
attributes(a)$xyz = 67
attrs = attributes(a[1:2]) 
length(attrs) == 1
! is.null(attrs$names)
is.null(attrs$xyz)

#! NAs in indices produce NA
#!t 1 NA
a = c(1,2,3)
a[c(1,NA)]

#! single integer works
a = c(1,2,3)
a[2] == 2

#! integer vector works
#!ttt
a = c(1,2,3)
b = a[c(1,3)]
length(b) == 2
b[[1]] == 1
b[[2]] == 3

#! 0 as a single index produces a vector of size 0
#!g T =    (c(TRUE, FALSE, TRUE) # c(1L, 2L, 3L) # c(1, 2, 3) # c(1.1, 1.2, 1.3) # c(1+1i,2+2i, 3+3i) # c(1.1+1.1i, 2.2+2.2i) # c("foo", "bar") # as.raw(c(1,2,3)) )
#!t 0 
a = @T
length(a[0])

#! 0 as a single index produces a vector of size 0 and corresponding type
#!g T =    (c(TRUE, FALSE, TRUE) # c(1L, 2L, 3L) # c(1, 2, 3) # c(1.1, 1.2, 1.3) # c(1+1i,2+2i, 3+3i) # c(1.1+1.1i, 2.2+2.2i) # c("foo", "bar") # as.raw(c(1,2,3)) )
#!g V(T) = ("logical"            # "integer"     # "double"  # "double"        # "complex"          # "complex"             # "character"       # "raw")
#!t 0 @V
a = @T
b = a[0]
length(b)
typeof(b)

#! 0 as a single index produces a vector of size 0 and corresponding type and preserves the names which are empty and no other attributes
#!g T =    (c(TRUE, FALSE, TRUE) # c(1L, 2L, 3L) # c(1, 2, 3) # c(1.1, 1.2, 1.3) # c(1+1i,2+2i, 3+3i) # c(1.1+1.1i, 2.2+2.2i,3.3+3.3i) # c("foo", "bar","c") # as.raw(c(1,2,3)) )
#!g V(T) = ("logical"            # "integer"     # "double"  # "double"        # "complex"          # "complex"                      # "character"         # "raw")
#!t 0 @V TRUE TRUE TRUE 
a = @T
names(a) = c("a","b","c")
attributes(a)$xyz = 67
b = a[0]
length(b)
typeof(b)
length(attributes(b)) == 1
length(attributes(b)$names) == 0
typeof(attributes(b)$names) == "character"

#! integer(0) behaves like 0
#!g T =    (c(TRUE, FALSE, TRUE) # c(1L, 2L, 3L) # c(1, 2, 3) # c(1.1, 1.2, 1.3) # c(1+1i,2+2i, 3+3i) # c(1.1+1.1i, 2.2+2.2i,3.3+3.3i) # c("foo", "bar","c") # as.raw(c(1,2,3)) )
#!g V(T) = ("logical"            # "integer"     # "double"  # "double"        # "complex"          # "complex"                      # "character"         # "raw")
#!t 0 @V TRUE TRUE TRUE 
a = @T
names(a) = c("a","b","c")
attributes(a)$xyz = 67
b = a[integer(0)]
length(b)
typeof(b)
length(attributes(b)) == 1
length(attributes(b)$names) == 0
typeof(attributes(b)$names) == "character"


#! NULL behaves like integer(0)
#!g T =    (c(TRUE, FALSE, TRUE) # c(1L, 2L, 3L) # c(1, 2, 3) # c(1.1, 1.2, 1.3) # c(1+1i,2+2i, 3+3i) # c(1.1+1.1i, 2.2+2.2i,3.3+3.3i) # c("foo", "bar","c") # as.raw(c(1,2,3)) )
#!g V(T) = ("logical"            # "integer"     # "double"  # "double"        # "complex"          # "complex"                      # "character"         # "raw")
#!t 0 @V TRUE TRUE TRUE 
a = @T
names(a) = c("a","b","c")
attributes(a)$xyz = 67
b = a[NULL]
length(b)
typeof(b)
length(attributes(b)) == 1
length(attributes(b)$names) == 0
typeof(attributes(b)$names) == "character"

#! indices of different signs are not allowed
#!e only 0's may be mixed with negative subscripts
a = c(1,2,3,4,5)
a[c(1,-2)] 

#! positive indices select the appropriate elements
#!g T =    (c(TRUE, FALSE, TRUE) # c(1L, 2L, 3L) # c(1, 2, 3) # c(1.1, 1.2, 1.3) # c(1+1i,2+2i, 3+3i) # c(1.1+1.1i, 2.2+2.2i,3.3+3.3i) # c("foo", "bar","c") # as.raw(c(1,2,3)) )
#!g V(T) = (TRUE TRUE            # 1 3           # 1 3        # 1.1 1.3          # 1+1i 3+3i          # 1.1+1.1i 3.3+3.3i              # "foo" "c"           # 01 03) 
#!t TRUE @V
a = @T
b = a[c(1,3)]
length(b) == 2
b

#! single index can be selected multiple times
#!t 1 1 1 4 4 6
a = c(1,2,3,4,5,6)
a[c(1,1,1,4,4,6)]

#! positive indices appear in the order they were presented
#!t "c" "b" "a"
a = c("a","b","c")
a[c(3,2,1)]

#! zeros with positive indices have no effect
#!g T =    (c(0,1,2,3) # c(1,0,2,3) # c(1,2,0,3) # c(1,2,3,0))
#!g S =    (c(TRUE, FALSE, TRUE) # c(1L, 2L, 3L) # c(1, 2, 3) # c(1.1, 1.2, 1.3) # c(1+1i,2+2i, 3+3i) # c(1.1+1.1i, 2.2+2.2i,3.3+3.3i) # c("foo", "bar","c") # as.raw(c(1,2,3)) )
#!g V(S) = (TRUE FALSE TRUE      # 1 2 3         # 1 2 3      # 1.1 1.2 1.3      # 1+1i 2+2i 3+3i     # 1.1+1.1i 2.2+2.2i 3.3+3.3i     # "foo" "bar" "c"     # 01 02 03 )
#!t 3 @V
a = @S
b = a[@T]
length(b)
b

#! out of bounds indices return NA
#!t NA NA 1
a = c(1,2,3)
a[c(8,7,1)]

#! negative index deselects the specific element
#!g T =    (c(TRUE, FALSE, TRUE) # c(1L, 2L, 3L) # c(1, 2, 3) # c(1.1, 1.2, 1.3) # c(1+1i,2+2i, 3+3i) # c(1.1+1.1i, 2.2+2.2i,3.3+3.3i) # c("foo", "bar","c") # as.raw(c(1,2,3)) )
#!g V(T) = (TRUE TRUE            # 1 3           # 1 3        # 1.1 1.3          # 1+1i 3+3i          # 1.1+1.1i 3.3+3.3i              # "foo" "c"           # 01 03) 
#!t TRUE @V
a = @T
b = a[-2]
length(b) == 2
b

# negative index can be selected multiple times with no additional effect
#!t 2 3 
a = c(1,2,3)
a[c(-1,-1,-1)]

# negative indices always display remaining values in order they were created
#!g V = (c(-1, -3, -5) # c(-1, -5, -3) # c(-3, -1, -5) # c(-3, -5, -1) # c(-5, -1, -3) # c(-5, -3, -1))
#!g T =    (c(1,2,3,4,5,6) # c(1.1, 2.2, 3.3, 4.4, 5.5, 6.6) # c("a", "b", "c", "d", "e", "f"))
#!g R(T) = (2 4 6          # 2.2 4.4 6.6                     # "b" "d" "f")
#!t 3 @R
a = @T
b = a[@V]
length(b)
b 

# zeroes have no effect within negative indices
#!g V = (c(0, -1, -3, -5) # c(-1, 0, -5, -3) # c(-3, -1, 0, -5) # c(-3, -5, -1, 0) # c(0, -5, -1, -3, 0) # c(0, 0, -5,0,0 -3, -1, 0, 0))
#!g T =    (c(1,2,3,4,5,6) # c(1.1, 2.2, 3.3, 4.4, 5.5, 6.6) # c("a", "b", "c", "d", "e", "f"))
#!g R(T) = (2 4 6          # 2.2 4.4 6.6                     # "b" "d" "f")
#!t 3 @R
a = @T
b = a[@V]
length(b)
b 

# negative indices out of bounds have no effect
#!g V = (c(-1, -7, -3, -5) # c(-10, -1, -5, -3) # c(-3, -1, -5, -20))
#!g T =    (c(1,2,3,4,5,6) # c(1.1, 2.2, 3.3, 4.4, 5.5, 6.6) # c("a", "b", "c", "d", "e", "f"))
#!g R(T) = (2 4 6          # 2.2 4.4 6.6                     # "b" "d" "f")
#!t 3 @R
a = @T
b = a[@V]
length(b)
b 

#!# -------------------------------------------------------------------------------------------------------------------
#!# update
#!# -------------------------------------------------------------------------------------------------------------------

#! scalar update to [0] is allowed but has no effect
#!t 1 2 3
a = c(1,2,3)
a[0] = 7
a

#! vector update to [0] is allowed but has no effect
#!t 1 2 3
a = c(1,2,3)
a[0] = c(7, 8)
a

#! update to [0] DOES change type of the primary vector
#!t "double"
a = c(1L,2L,3L)
a[0] = 2.4
typeof(a)

#! multiple update to same index preserves only the last value written
#!t 3 2 3
a = c(1, 2, 3)
a[c(1,1,1)] = c(1,2,3)
a

#! update to outside bounds increases the vector
#!t 1 2 3 4 5
a = c(1, 2, 3)
a[c(4,5)] = c(4,5)
a

#! update to outside bounds increases the vector filling it with NAs
#!t 1 2 3 NA NA 4 5
a = c(1, 2, 3)
a[c(6,7)] = c(4,5)
a

#! update to negative indices outside bounds has no effect
#!t 3 4 5 6
a = c(1,2,3)
a[-4] = c(4,5,6)
length(a)
a

#! smaller vectors are recycled during vector update
#!t 1 2 1 2 1 2 1 2 1 2 
a = c(1,2,3,4,5,6,7,8,9,10)
a[c(1,2,3,4,5,6,7,8,9,10)] = c(1,2)
a

#! scalar is the extreme case 
#!t 11 11 11 11 11 11 11 11 11 11
a = c(1,2,3,4,5,6,7,8,9.10)
a[c(1,2,3,4,5,6,7,8,9,10)] = 11
a

#! warning is produced if the lhs cannot be recycled completely
#!w number of items to replace is not a multiple of replacement length
#!o 4 5 6 4 5 
a = c(1,2,3,4,5)
a[c(1,2,3,4)] = c(4,5,6)
a

#! warning is produced if lhs is larger than replacement, extra elements are ignored
#!w number of items to replace is not a multiple of replacement length
#!o 10 11 12 4 5
a = c(1,2,3,4,5)
a[c(1,2,3)] = c(10,11,12,13,14,15)
a

#! update to a logical vector accomodates more general types too
#!g T =    (c(1L,2L) # c(1,2)  # c(1.1, 2.2) # c(1+1i, 2+2i)       # c(1.1+1.1i,2.2+2.2i)        # c("a", "b"))
#!g V(T) = (1 1 2 0  # 1 1 2 0 # 1 1.1 2.2 0 # 1+0i 1+1i 2+2i 0+0i # 1+0i 1.1+1.1i 2.2+2.2i 0+0i # "TRUE" "a" "b" "FALSE")
#!t @V
a = c(TRUE, TRUE, FALSE, FALSE)
a[c(2,3)] = @T
a

#! update to a logical vector accomodates more general types too and changes its type accordingly
#!g T =    (c(1L,2L)  # c(1,2)   # c(1.1, 2.2) # c(1+1i, 2+2i)       # c(1.1+1.1i,2.2+2.2i)        # c("a", "b"))
#!g V(T) = (1 1 2 0   # 1 1 2 0  # 1 1.1 2.2 0 # 1+0i 1+1i 2+2i 0+0i # 1+0i 1.1+1.1i 2.2+2.2i 0+0i # "TRUE" "a" "b" "FALSE")
#!g X(T) = ("integer" # "double" # "double"    # "complex"           # "complex"                   # "character") 
#!t @X @V
a = c(TRUE, TRUE, FALSE, FALSE)
a[c(2,3)] = @T
typeof(a)
a

#! raw type cannot be inserted to logical
#!e incompatible types (from raw to logical) in subassignment type fix
a = c(TRUE, TRUE, FALSE, FALSE)
a[c(2,3)] = as.raw(c(1,2))

#! update to an integer vector accomodates more general types too
#!g T =    (c(1,2)  # c(1.1, 2.2) # c(1+1i, 2+2i)       # c(1.1+1.1i,2.2+2.2i)        # c("a", "b"))
#!g V(T) = (1 1 2 0 # 1 1.1 2.2 0 # 1+0i 1+1i 2+2i 0+0i # 1+0i 1.1+1.1i 2.2+2.2i 0+0i # "1" "a" "b" "0")
#!t @V
a = c(1L, 1L, 0L, 0L)
a[c(2,3)] = @T
a

#! update to an integer vector accomodates more general types too and changes its type accordingly
#!g T =    (c(1,2)   # c(1.1, 2.2) # c(1+1i, 2+2i)       # c(1.1+1.1i,2.2+2.2i)        # c("a", "b"))
#!g V(T) = (1 1 2 0  # 1 1.1 2.2 0 # 1+0i 1+1i 2+2i 0+0i # 1+0i 1.1+1.1i 2.2+2.2i 0+0i # "1" "a" "b" "0")
#!g X(T) = ("double" # "double"    # "complex"           # "complex"                   # "character") 
#!t @X @V
a = c(1L, 1L, 0L, 0L)
a[c(2,3)] = @T
typeof(a)
a

#! logical can be inserted to integer and will be upcasted
#!t TRUE 1 1 0 4
a = c(1L, 2L, 3L, 4L)
a[c(2,3)] = c(TRUE, FALSE)
typeof(a) == "integer"
a

#! raw type cannot be inserted to integer
#!e incompatible types (from raw to integer) in subassignment type fix
a = c(1L, 2L, 3L, 4L)
a[c(2,3)] = as.raw(c(1,2))

#! update to an double vector accomodates more general types too
#!g T =    (c(1+1i, 2+2i)       # c(1.1+1.1i,2.2+2.2i)        # c("a", "b"))
#!g V(T) = (1+0i 1+1i 2+2i 0+0i # 1+0i 1.1+1.1i 2.2+2.2i 0+0i # "1" "a" "b" "0")
#!t @V
a = c(1L, 1L, 0L, 0L)
a[c(2,3)] = @T
a

#! update to an double vector accomodates more general types too and changes its type accordingly
#!g T =    (c(1+1i, 2+2i)       # c(1.1+1.1i,2.2+2.2i)        # c("a", "b"))
#!g V(T) = (1+0i 1+1i 2+2i 0+0i # 1+0i 1.1+1.1i 2.2+2.2i 0+0i # "1" "a" "b" "0")
#!g X(T) = ("complex"           # "complex"                   # "character") 
#!t @X @V
a = c(1, 1.2, 1.4, 0)
a[c(2,3)] = @T
typeof(a)
a

#! lesser types can be inserted to double and will be upcasted
#!g T =    (c(TRUE, FALSE) # c(1L, 2L))
#!g V(T) = (1.1 1 0 4.4    # 1.1 1 2 4.4) 
#!t TRUE @V
a = c(1.1, 2.2, 3.3, 4.4)
a[c(2,3)] = @T
typeof(a) == "double"
a

#! raw type cannot be inserted to double
#!e incompatible types (from raw to double) in subassignment type fix
a = c(1.1, 2.2, 3.3, 4.4)
a[c(2,3)] = as.raw(c(1,2))

#! update to an complex vector accomodates more general types too
#!t "1+1i" "a" "b" "4+4i"
a = c(1+1i, 2+2i, 3+3i, 4+4i)
a[c(2,3)] = c("a","b")
a

#! update to an complex vector accomodates more general types too and changes its type accordingly
#!t "character" "1+1i" "a" "b" "4+4i"
a = c(1+1i, 2+2i, 3+3i, 4+4i)
a[c(2,3)] = c("a","b")
typeof(a)
a

#! lesser types can be inserted to complex and will be upcasted
#!g T =    (c(TRUE, FALSE)          # c(1L, 2L)               # c(1.1, 2.2))
#!g V(T) = (1.1+1i 1+0i 0+0i 4.4+1i # 1.1+1i 1+0i 2+0i 4.4+1i # 1.1+1i 1.1+0i 2.2+0i 4.4+1i)
#!t TRUE @V
a = c(1.1+1i, 2.2+1i, 3.3+1i, 4.4+1i)
a[c(2,3)] = @T
typeof(a) == "complex"
a

#! raw type cannot be inserted to complex
#!e incompatible types (from raw to complex) in subassignment type fix
a = c(1.1+1i, 2.2+1i, 3.3+1i, 4.4+1i)
a[c(2,3)] = as.raw(c(1,2))

#! lesser types can be inserted to character and will be upcasted
#!g T =    (c(TRUE, FALSE)         # c(1L, 2L)       # c(1.1, 2.2)         # c(1+1i, 2+2i))
#!g V(T) = ("a" "TRUE" "FALSE" "d" # "a" "1" "2" "d" # "a" "1.1" "2.2" "d" # "a" "1+1i" "2+2i" "d")
#!t TRUE @V
a = c("a", "b", "c", "d")
a[c(2,3)] = @T
typeof(a) == "character"
a

#! raw type cannot be inserted to character
#!e incompatible types (from raw to character) in subassignment type fix
a = c("a","b","c","d")
a[c(2,3)] = as.raw(c(1,2))

#! NAs are not allowed in updates
#!e NAs are not allowed in subscripted assignments
a = c(1,2,3)
a[c(1,NA)] = c(4,10)
a

