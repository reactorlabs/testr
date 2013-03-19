#!# R Language Reference, page 2, help("mode")

#! argument to mode is required
#!e argument "x" is missing, with no default
mode()

#! mode for vectors works properly
#!g VALUE =       (NULL   # TRUE      # FALSE     # 1L        # 7.1       # 2+3i      # "haha"      # list() # raw())
#!g TYPE(VALUE) = ("NULL" # "logical" # "logical" # "numeric" # "numeric" # "complex" # "character" # "list" # "raw")
#!t @TYPE
mode(@VALUE)

