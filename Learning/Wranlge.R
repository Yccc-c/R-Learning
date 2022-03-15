
library(tibble)
library(tidyverse)


# tibble
as.tibble() # 强制转换
# 手动创建tibble
x <- tibble(
  x = 1:5, 
  y = 1, 
  z = x ^ 2 + y
) # tibble的列名可以是非法列名，例如符号开头，均为符号等等

tribble(  # 也可以利用该方法创建
  ~x, ~y, ~z,
  #--|--|---- # 直观
  "a", 2, 3.6,
  "b", 1, 8.5
)

# 控制输出
print(n = 10, width = Inf)  # 10行，所有列

# 与data frame的区别
  







































