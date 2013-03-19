#!# R Language Reference, page 13, help("if")

#! if clause is evaluated on TRUE
if (TRUE) {
    TRUE
} else {
    FALSE
}

#! else clause is evaluated on FALSE
if (FALSE) {
    FALSE
} else {
    TRUE
}

#! only if clause can be present
if (TRUE)
    TRUE

#! numeric scalars work too (nonzero as TRUE
#!g T = (4L # 7.1 # 2+3i)
if (@T) TRUE else FALSE

#! numbers work on zeroes as false
#!g T = (0L # 0 # 0+0i)
if (@T) FALSE else TRUE

#! other than vectors cannot be used in if statements
#!e argument is of length zero
#!g T = (list() # frame())
if (@T) TRUE

#! if argument cannot be interpreted as logical, if does not work
#!e argument is not interpretable as logical
#!g T = (c # f # "haha")
f <- function() { }
if (@T) TRUE

#! when argument is vector, only first index is used and warning produced
#!w the condition has length > 1 and only the first element will be used
#!o TRUE TRUE
a = c(FALSE, TRUE, TRUE)
if (a) FALSE else TRUE
a = c(TRUE, FALSE, FALSE)
if (a) TRUE else FALSE

#! if statements also return variable
#!# in fact all these tests rely on this
a = 5
a = if (a==5) 3 else 4
a == 3

#! if statement works if we do not count on it returning a variable
#!t 4
a = 3
if (TRUE) a = 4 else a = 5
a 
