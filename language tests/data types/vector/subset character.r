#!# character vectors in subset operator

#! scalar works well
a = c(a=1, b=2, c=3)
a["a"] == 1

#! if single dimension only, names are used if present for vector-like indexing
#t a c f 1 3 6
a = array(1:27, c(3,3,3))
names(a) = c("a","b","c","d","e","f","g","h","i","j","k","l")
a[c("a","c","f")]

#! if single dimension only, names not present, but character indexed returns NAs
#t NA NA NA
a = array(1:27, c(3,3,3))
a[c("a","c","f")]

#! character vectors return the proper elements
#ttt
a = c(a=1, b=2, c=3)
b = a[c("a","b")]
b[1] == 1
b[2] == 2

#! name not present returns NA
#!ttt
a = c(a=1,b=2)
a["c"] == NA
b = a[c("c","d")]
b[1] == NA
b[2] == NA

# empty string matches no element when names enabled, typeof is preserved
#!g T = (c(a = TRUE, b=FALSE) # c(a=1,b=2) # c(a=1.1, b=2.2) # c(a=1+1i, b=2+2i) # c(a="aa", b="bb"))
#!ttt
a = @T
b = a[""]
length(b) == 1
b[1] == NA
typeof(b) == typeof(a)

#! numbers are not typecasted from characters when no names are present
#!t NA NA
a = c(1,2,3)
a[c("1","2")]

#! character [] returns the object keeping names but not other arguments
#!ttt
a = c(a=1, b=2, c=3)
attributes(a)$xyz = 67
attrs = attributes(a[c("a","b")]) 
length(attrs) == 1
! is.null(attrs$names)
is.null(attrs$xyz)

#! names left are only those used in the subset
#!t TRUE TRUE TRUE "a" "b"
a = c(a=1, b=2, c=3)
attributes(a)$xyz = 67
attrs = attributes(a[c("a","b")]) 
length(attrs) == 1
! is.null(attrs$names)
is.null(attrs$xyz)
attrs$names

#! names are also multiplied if same name selected twice
#!t "a" "a" "c" 1 1 3
a = c(a=1, b=2, c=3)
b = a[c("a","a","c")]
names(b)
names(b) = NULL
b

#!# update ------------------------------------------------------------------------------------------------------------

#! update to nonexistent name extends the vector
#!t "a" "b" "c" "d" 1 2 3 4
a = c(a=1, b=2, c=3)
a["d"] = 4
names(a)
names(a) = NULL
a

#! multiple update to same element leaves only the last one
#!t 12 2 3
a = c(a=1, b=2, c=3)
a[c("a","a","a")] = c(10, 11, 12)
names(a) = NULL
a

#! update with multiple columns of same name chosen updates only the first one
#!t 10 2 3 
a = c(a=1, a=2, b=3)
a["a"] = 10
names(a) = NULL
a

#! update with multiple columns of same name chosen and multiple values updates only the first one
#!w number of items to replace is not a multiple of replacement length
#!o 10 2 3 
a = c(a=1, a=2, b=3)
a["a"] = c(10,11)
names(a) = NULL
a

#! update with multiple same name columns selected more than once only changes the first appearance
#!t 10 2 3
a = c(a=1,a=2,b=3)
a[c("a","a")] = 10
a

#! update with multiple same name columns selected more than once only changes the first appearance, latest element is used from rhs
#!t 11 2 3
a = c(a=1,a=2,b=3)
a[c("a","a")] = c(10,11)
a

#! smaller vectors are recycled during vector update
#!t 1 2 1 2 1 2 1 2 1 2 
a = c(a=1,b=2,c=3,d=4,e=5,f=6,g=7,h=8,i=9,j=10)
a[c("a","b","c","d","e","f","g","h","i","j")] = c(1,2)
names(a) = NULL # get rid of names for prettyprinting
a

#! scalar is the extreme case 
#!t 11 11 11 11 11 11 11 11 11 11
a = c(a=1,b=2,c=3,d=4,e=5,f=6,g=7,h=8,i=9,j=10)
a[c("a","b","c","d","e","f","g","h","i","j")] = 11
names(a) = NULL # get rid of names for prettyprinting
a

#! warning is produced if the lhs cannot be recycled completely
#!w number of items to replace is not a multiple of replacement length
#!o 4 5 6 4 5 
a = c(a=1,b=2,c=3,d=4,e=5)
a[c("a","b","c","d")] = c(4,5,6)
names(a) = NULL # get rid of names for prettyprinting
a

#! warning is produced if lhs is larger than replacement, extra elements are ignored
#!w number of items to replace is not a multiple of replacement length
#!o 10 11 12 4 5
a = c(a=1,b=2,c=3,d=4,e=5)
a[c("a","b","c")] = c(10,11,12,13,14,15)
names(a) = NULL # get rid of names for prettyprinting
a

#! update to a logical vector accomodates more general types too
#!g T =    (c(1L,2L) # c(1,2)  # c(1.1, 2.2) # c(1+1i, 2+2i)       # c(1.1+1.1i,2.2+2.2i)        # c("a", "b"))
#!g V(T) = (1 1 2 0  # 1 1 2 0 # 1 1.1 2.2 0 # 1+0i 1+1i 2+2i 0+0i # 1+0i 1.1+1.1i 2.2+2.2i 0+0i # "TRUE" "a" "b" "FALSE")
#!t @V
a = c(a=TRUE, b=TRUE, c=FALSE, d=FALSE)
a[c("b","c")] = @T
names(a) = NULL # get rid of names for prettyprinting
a

#! update to a logical vector accomodates more general types too and changes its type accordingly
#!g T =    (c(1L,2L)  # c(1,2)   # c(1.1, 2.2) # c(1+1i, 2+2i)       # c(1.1+1.1i,2.2+2.2i)        # c("a", "b"))
#!g V(T) = (1 1 2 0   # 1 1 2 0  # 1 1.1 2.2 0 # 1+0i 1+1i 2+2i 0+0i # 1+0i 1.1+1.1i 2.2+2.2i 0+0i # "TRUE" "a" "b" "FALSE")
#!g X(T) = ("integer" # "double" # "double"    # "complex"           # "complex"                   # "character") 
#!t @X @V
a = c(a=TRUE, b=TRUE, c=FALSE, d=FALSE)
a[c("b","c")] = @T
names(a) = NULL # get rid of names for prettyprinting
typeof(a)
a

#! raw type cannot be inserted to logical
#!e incompatible types (from raw to logical) in subassignment type fix
a = c(a=TRUE, b=TRUE, c=FALSE, d=FALSE)
a[c("b","c")] = as.raw(c(1,2))

#! update to an integer vector accomodates more general types too
#!g T =    (c(1,2)  # c(1.1, 2.2) # c(1+1i, 2+2i)       # c(1.1+1.1i,2.2+2.2i)        # c("a", "b"))
#!g V(T) = (1 1 2 0 # 1 1.1 2.2 0 # 1+0i 1+1i 2+2i 0+0i # 1+0i 1.1+1.1i 2.2+2.2i 0+0i # "1" "a" "b" "0")
#!t @V
a = c(a=1L, b=1L, c=0L, d=0L)
a[c("b","c")] = @T
names(a) = NULL # get rid of names for prettyprinting
a

#! update to an integer vector accomodates more general types too and changes its type accordingly
#!g T =    (c(1,2)   # c(1.1, 2.2) # c(1+1i, 2+2i)       # c(1.1+1.1i,2.2+2.2i)        # c("a", "b"))
#!g V(T) = (1 1 2 0  # 1 1.1 2.2 0 # 1+0i 1+1i 2+2i 0+0i # 1+0i 1.1+1.1i 2.2+2.2i 0+0i # "1" "a" "b" "0")
#!g X(T) = ("double" # "double"    # "complex"           # "complex"                   # "character") 
#!t @X @V
a = c(a=1L, b=1L, c=0L, d=0L)
a[c("b","c")] = @T
names(a) = NULL # get rid of names for prettyprinting
typeof(a)
a

#! logical can be inserted to integer and will be upcasted
#!t TRUE 1 1 0 4
a = c(a=1L, b=2L, c=3L, d=4L)
a[c("b","c")] = c(TRUE, FALSE)
names(a) = NULL # get rid of names for prettyprinting
typeof(a) == "integer"
a

#! raw type cannot be inserted to integer
#!e incompatible types (from raw to integer) in subassignment type fix
a = c(a=1L, b=2L, c=3L, d=4L)
a[c("b","c")] = as.raw(c(1,2))

#! update to an double vector accomodates more general types too
#!g T =    (c(1+1i, 2+2i)       # c(1.1+1.1i,2.2+2.2i)        # c("a", "b"))
#!g V(T) = (1+0i 1+1i 2+2i 0+0i # 1+0i 1.1+1.1i 2.2+2.2i 0+0i # "1" "a" "b" "0")
#!t @V
a = c(a=1L, b=1L, c=0L, d=0L)
a[c("b","c")] = @T
names(a) = NULL # get rid of names for prettyprinting
a

#! update to an double vector accomodates more general types too and changes its type accordingly
#!g T =    (c(1+1i, 2+2i)       # c(1.1+1.1i,2.2+2.2i)        # c("a", "b"))
#!g V(T) = (1+0i 1+1i 2+2i 0+0i # 1+0i 1.1+1.1i 2.2+2.2i 0+0i # "1" "a" "b" "0")
#!g X(T) = ("complex"           # "complex"                   # "character") 
#!t @X @V
a = c(a=1, b=1.2, c=1.4, d=0)
a[c("b","c")] = @T
names(a) = NULL # get rid of names for prettyprinting
typeof(a)
a

#! lesser types can be inserted to double and will be upcasted
#!g T =    (c(TRUE, FALSE) # c(1L, 2L))
#!g V(T) = (1.1 1 0 4.4    # 1.1 1 2 4.4) 
#!t TRUE @V
a = c(a=1.1, b=2.2, c=3.3, d=4.4)
a[c("b","c")] = @T
names(a) = NULL # get rid of names for prettyprinting
typeof(a) == "double"
a

#! raw type cannot be inserted to double
#!e incompatible types (from raw to double) in subassignment type fix
a = c(a=1.1, b=2.2, c=3.3, d=4.4)
a[c("b","c")] = as.raw(c(1,2))

#! update to an complex vector accomodates more general types too
#!t "1+1i" "a" "b" "4+4i"
a = c(a=1+1i, b=2+2i, c=3+3i, d=4+4i)
a[c("b","c")] = c("a","b")
names(a) = NULL # get rid of names for prettyprinting
a

#! update to an complex vector accomodates more general types too and changes its type accordingly
#!t "character" "1+1i" "a" "b" "4+4i"
a = c(a=1+1i, b=2+2i, c=3+3i, d=4+4i)
a[c("b","c")] = c("a","b")
names(a) = NULL # get rid of names for prettyprinting
typeof(a)
a

#! lesser types can be inserted to complex and will be upcasted
#!g T =    (c(TRUE, FALSE)          # c(1L, 2L)               # c(1.1, 2.2))
#!g V(T) = (1.1+1i 1+0i 0+0i 4.4+1i # 1.1+1i 1+0i 2+0i 4.4+1i # 1.1+1i 1.1+0i 2.2+0i 4.4+1i)
#!t TRUE @V
a = c(a=1.1+1i, b=2.2+1i, c=3.3+1i, d=4.4+1i)
a[c("b","c")] = @T
names(a) = NULL # get rid of names for prettyprinting
typeof(a) == "complex"
a

#! raw type cannot be inserted to complex
#!e incompatible types (from raw to complex) in subassignment type fix
a = c(a=1.1+1i, b=2.2+1i, c=3.3+1i, d=4.4+1i)
a[c("b","c")] = as.raw(c(1,2))

#! lesser types can be inserted to character and will be upcasted
#!g T =    (c(TRUE, FALSE)         # c(1L, 2L)       # c(1.1, 2.2)         # c(1+1i, 2+2i))
#!g V(T) = ("a" "TRUE" "FALSE" "d" # "a" "1" "2" "d" # "a" "1.1" "2.2" "d" # "a" "1+1i" "2+2i" "d")
#!t TRUE @V
a = c(a="a", b="b", c="c", d="d")
a[c("b","c")] = @T
names(a) = NULL # get rid of names for prettyprinting
typeof(a) == "character"
a

#! raw type cannot be inserted to character
#!e incompatible types (from raw to character) in subassignment type fix
a = c(a="a",b="b",c="c",d="d")
a[c("b","c")] = as.raw(c(1,2))


