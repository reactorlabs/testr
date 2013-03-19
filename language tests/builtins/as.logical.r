
#! 0 is FALSE
#!t FALSE
as.logical(0)

#! positive numbers are TRUE
#!tt 4
as.logical(2L)
as.logical(3.1)
as.logical(2+3i)
as.logical(3-2i)

#! negative numbers are TRUE
#!tt 4
as.logical(-2L)
as.logical(-3.1)
as.logical(-2+3i)
as.logical(-3-2i)

#! string is NA always
#!t NA NA
as.logical("haha")
as.logical("")