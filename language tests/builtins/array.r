#!# Array builtin, 

#! an empty call to array builtin produces an array of dim 1
a = array()
dim(a) == 1

#! an empty call to array builtin produces an array of length 1
a = array()
length(a) == 1

#! an empty call to array builtin produces a single NA value
#!t NA
a = array()
a

#! an empty call to array builtin produces an array of type logical
#!t "logical"
a = array()
typeof(a)

#! does not preserve names attribute
a = c(a=1,b=2,c=3,d=4,e=5,f=6,g=7,h=8)
a = array(a, c(2,2,2))
is.null(names(a))

#! default value is NA when dim is present
#!t NA NA
a =array(dim=2)
a

#! default dim is the length of data
a= array(1:9)
dim(a) == 9

#! default dimnames is NULL
a = array(1, c(2,2,2))
is.null(dimnames(a))

#! warning is given if length(dim) is 0
#!w use of 0-length dim is deprecated
#!o NULL 1
a = array(1, vector())
dim(a)
a

#! array preserves the type information from the vector it is given
#!g T =    (TRUE      #  1L       # 1        # 1.1      # 2+2i      # "foo")
#!g V(T) = ("logical" # "integer" # "double" # "double" # "complex" # "character")
#!t @V
a = array(@T, c(3,3,3))
typeof(a)