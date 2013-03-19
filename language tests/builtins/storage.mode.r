#!# R Language Reference, page 2, help("mode")

#! argument to storage.mode is required
#!e argument "x" is missing, with no default
storage.mode()

#! storage mode for vectors works properly
#!g VALUE =       (NULL   # TRUE      # FALSE     # 1L        # 7.1      # 2+3i      # "haha"      #list()  # raw())
#!g TYPE(VALUE) = ("NULL" # "logical" # "logical" # "integer" # "double" # "complex" # "character" # "list" # "raw")
#!t @TYPE
storage.mode(@VALUE)

