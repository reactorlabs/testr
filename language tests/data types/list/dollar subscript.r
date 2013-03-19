#!# $ operator for subscription on lists (R lang ref pag 17 onwards)

#! $ operator cannot be used with numbers
#!e unexpected numeric constant in "a$2"
a = list(a=1, b=2, c=3)
a$2

#! $ operator can be used with strings
a = list(a=1, b=2, c=3)
a$"b" == 2

#! $ operator drops all attributes
a = list(a=1, b=2, c=3)
is.null(attributes(a$b))

#! $ operator works for reading on lists
a = list(a=1, b=2, c=3)
a$b == 2

#! out of bounds read produces null
a = list(a=1)
is.null(a$b)

#! update access works
a = list(a=1, b=2)
a$b = 3
a[[2]] == 3

#! update access out of bounds extends the list
a = list(a=1)
a$b = 2
length(a) == 2
a[[2]] = 2

#! partial matching works on read with no warnings
a = list(aa=13, bb=2)
a$a == 13

#! partial matching does not kick in when indices are ambiguous
a = list(aa=13, aab = 12)
is.null(a$a)

#! partial matching on update creates new value
#!ttt
a = list(aa=1, b=2)
a$a = 7
a$aa == 1
a$a == 7

#! on recursive lists, the $ operator can be concatenated
a = list(a=1, b=2, c = list (d=3, e=4))
a$c$e == 4

#! recursive concatenated subscription works on write too
a = list(a=1, b=2, c = list (d=3, e=4))
a$c$e = 78
a$c[[2]] == 78




