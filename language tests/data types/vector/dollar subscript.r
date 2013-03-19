#!# dollar subscript for vectors, R language manual p 18

#! $ subscription read does not work on vectors
#!e $ operator is invalid for atomic vectors
a = c(a=1, b=2, c=3)
a$a

#! $ in update mode typecasts LHS to list
#!w Coercing LHS to a list
a = c(a=1, b=2, c=3)
a$a = 7
a[[1]] == 7

#! $ in update mode typecasts LHS to list when applying new value
#!w Coercing LHS to a list
a = c(a=1, b=2, c=3)
a$d = 7
a[[4]] == 7

#! $ update with quotes works too
#!w Coercing LHS to a list
a = c(a=1, b=2, c=3)
a$"d" = 7
a[[4]] == 7
