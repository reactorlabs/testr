#!# R Language Reference, page 2, help("typeof")


#! argument to typeof is required
#!e argument "x" is missing, with no default
typeof()

#! correct behavior of different arithmetic types
#!g VALUE =       (NULL   # TRUE      # FALSE     # 1L        # 7.1      # 2+3i      # "haha"      # list() # raw())
#!g TYPE(VALUE) = ("NULL" # "logical" # "logical" # "integer" # "double" # "complex" # "character" # "list" # "raw")
#!t @TYPE
typeof(@VALUE)

#! type of written integer is double
#!t "double"
typeof(6)

#! correct types for language objects - closure
#!t "closure"
typeof(array)

#!# missing type tests: (language reference, p. 2)
#!# symbol
#!# pairlist
#!# environment
#!# promise
#!# language
#!# special
#!# builtin
#!# char ***
#!# ... ***
#!# any (no instance of this type)
#!# expression
#!# bytecode ***
#!# externalptr
#!# weakref
#!# S4
#!# *** = users cannot easily get hold of these objects
