#!# behavior of subsets by R - works on them as integer, does not use the strings - R lang ref p 17, 18

#! when indexing by factor only its integers are used
#!t 10 11 12 13
f = factor(c(1,2,3,4),labels=c("a","b","c","d"))
a = c(d=1, c=2, b=3, a=4)
a[f] = c(10,11,12,13)
names(a) = NULL
a