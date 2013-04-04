#!# arithmetic operators, from R help mostly

#!# operator + --------------------------------------------------------------------------------------------------------

#! operator + is commutative for NA and NaN values
#!t NA NA
NA + NaN
NaN + NA

#! operator + is commutative for numeric types
#!g T1 = ( TRUE # 3L # -4L # 2 # 3.1 # -6.7 # 2+3i # -2-3i)
#!g T2 = ( FALSE # TRUE # -2L # 5L # 7 # 3.1 # -2.5 # 4+8i # -3+2i)
(@T1) + (@T2) == (@T2) + (@T1) 

