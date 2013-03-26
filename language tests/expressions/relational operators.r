#!# mostly from help() to given operators

#!# NA handling -------------------------------------------------------------------------------------------------------

#! NA with relational operator results in NA
#!g T = (FALSE # -3L # 0.5 # as.raw(0))
#!g O = ( < # <= # == # != # >= # > )
#!g V = ( NA # NaN)
#!t NA
@V @O @T

#! NA or NaN with complex number is not allowed
#!e invalid comparison with complex values
#!g O = ( < # <= # >= # > )
#!g V = ( NA # NaN)
@V @O (2+3i)

#! NA or NaN with complex number and == and != is NA
#!t NA
#!g O = ( == # != )
#!g V = ( NA # NaN)
@V @O (2+3i)

#! even NA compared to NA is NA
#!g O = ( < # <= # == # != # >= # > )
#!g T = ( NA # NaN )
#!g V = ( NA # NaN )
#!t NA
@T @O @V

#! Na cannot be compared with string -- result is always NA
#!g O = ( < # <= # == # != # >= # > )
#!t NA
NA @O "foo"

#! NaN can be compared with string
#!t "logical"
#!g O = ( < # <= # == # != # >= # > )
typeof(NaN @O "foo")

#! NaN and string comarisons are lexicographical
#!g T = ( < # <=)
#!t TRUE FALSE
"foo" @T NaN
"zaza" @T NaN

#! NaN and string comarisons are lexicographical
#!g T = ( > # >= )
#!t FALSE TRUE
"foo" @T NaN
"zaza" @T "NaN"

#! NaN is identical to "NaN"
#!ttt
"NaN" == NaN
"foo" != NaN

#!# a result of an relational operator is always logical --------------------------------------------------------------

#! result types of non-complex relations
#!g T = (FALSE # -3L # 0.5 # "foo" # as.raw(0))
#!g V = (TRUE # 1L # 1.5 # "muhuhu" # as.raw(67))
#!g O = ( < # <= # == # != # >= # > )
#!t "logical"
typeof(@V @O @T)

#! complex and string can be compared
#!t "logical"
#!g O = ( < # <= # == # != # >= # > )
typeof("foo" @O (2+3i))

# == and != can be used with complex numbers too (lhs)
#!g T = (FALSE # -3L # 0.5 # "foo" # as.raw(0))
#!g O = ( == # != )
#!t "logical"
typeof((2+3i) @O @T)

# == and != can be used with complex numbers too (rhs)
#!g T = (FALSE # -3L # 0.5 # "foo" # as.raw(0))
#!g O = ( == # != )
#!t "logical"
typeof(@T @O (2+3i))

#! comparison with complex numbers is not allowed
#!e invalid comparison with complex values
#!g T = (TRUE # 1L # 3 # 3.2 # as.raw(0))
#!g O = ( < # <= # >= # > )
(@T) @O (2+3i)

#! comparison of two complex numbers is not allowed
#!e invalid comparison with complex values
#!g O = ( < # <= # >= # > )
(3+3i) @O (4+7i)

