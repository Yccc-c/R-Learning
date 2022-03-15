# 条件选择语句
if(length(x) == 0) {    # if语句中的花括号不可省略
  cat("Empty vector!\n")
} else {             # 可以对花括号换行
  m = mean(x)
  s = sum(x)
}

# 简单的if语句可以写在一行
# if-else语句会返回最后的赋值
x <- -5
y <- if (x >= 0) sqrt(x) else NA

# ifelse。是一个独立的函数
ifelse(x >= 0, sqrt(x), NA)
#另一个例子
x <- 1:10
y <- ifelse(x%%2 == 0, 0, 1)    # 自动遍历向量


# 循环结构
# While
i <- 0
while (i <= 5) {
  cat(i,"")
  i = i + 1
}

# Repeat
repeat{
  cat(i,"")
  i <- i + 1
  if(i > 5){
    cat("\n")
    break    # next用于结束当前循环，类似continue ×
  }
} 

# For
for(i in 1:5){
  cat(i,"")
}


# 算数与逻辑
# %%取模    %/%整除
# &处理向量间的逻辑运算，得到的是逻辑向量
# &&处理标量间的逻辑运算，得到的是单个向量
# 如果使用&&处理向量，则只会判断两向量第一个元素间的逻辑关系


# 函数
# 函数的定义 略
# 返回值，如果没有return，则会返回最后一个执行的语句
    # 因此可以在结尾直接写需要返回的函数名


# 绘图

