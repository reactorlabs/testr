#! arithmetic operators are commutative for NA and NaN
#!g OP = (+ # - # * # /)
#!t NA NA
NA @OP NaN
NaN @OP NA