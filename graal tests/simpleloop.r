#! simple test
#!g SIZE = (10 # 100 # 1000 # 10000 # 100000 # 1000000 # 10000000 # 100000000 # 1000000000)
f <- function() {
  t = _timerStart()
  for (i in 1:@SIZE) {
   {} {} {} {} {} {} {} {} {} {} {} {} {} {} {} {}
  }
  t
}
f()
_timerEnd(f(),"tmr")
