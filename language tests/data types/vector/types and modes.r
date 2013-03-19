#!# R Language Reference page 3
#!# TODO at the moment this is the same test (almost) as are the tests in builtins. Where should they be put better?
#!# or should hypertext be considered for the tests? 

#! typeof for basic vector types works properly
#!g VALUE =       (TRUE      # FALSE     # 1L        # 2.3      # 3+2i      # "haha"      # raw())
#!g TYPE(VALUE) = ("logical" # "logical" # "integer" # "double" # "complex" # "character" # "raw")
#!t @TYPE
typeof(@VALUE)

#! mode for basic vector types works properly
#!g VALUE =       (TRUE      # FALSE     # 1L        # 2.3       # 3+2i      # "haha"      # raw())
#!g TYPE(VALUE) = ("logical" # "logical" # "numeric" # "numeric" # "complex" # "character" # "raw")
#!t @TYPE
mode(@VALUE)

#! storage.mode for basic vector types works properly
#!g VALUE =       (TRUE      # FALSE     # 1L        # 2.3      # 3+2i      # "haha"      # raw())
#!g TYPE(VALUE) = ("logical" # "logical" # "integer" # "double" # "complex" # "character" # "raw")
#!t @TYPE
storage.mode(@VALUE)