#!# Array builtin, 

#! does not preserve names attribute
a = c(a=1,b=2,c=3,d=4,e=5,f=6,g=7,h=8)
a = array(a, c(2,2,2))
is.null(names(a))
