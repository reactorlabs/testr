#! Test name
#!w Coercing LHS to a list
#!o 7
a = matrix(1,2,2)
a = c(a = 1, b = 2, c = 3)
a$a = 7
a$a

#!
a = 1
a == 1

#! some other test
#!t 1 2
a = c(1,2)
a


#!
#!e object 'xyz' not found
a = 2
xyz

#! single generic test
#!g T = (1, 2, 3, 4, 5, 1L, 2+3i, 4+7i)
a = @T
a == @T

#! multiple independent generics test
#!g T = (1,2,3)
#!g W = (4,5,6)
a = @T * @W
a == @T * @W

#! dependent generic test
#!g T = (1,2,3,4)
#!g W(T) = (2,3,4,5)
a = @T + 1
a == @W




