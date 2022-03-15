# Data types
value <- "Language"
x <- 3L    # 使用L表示整型，否则默认双精度double
xode(value)
typeof(value)
xode(x)
typeof(x)    # 显示更详细的类型，例如double、integer
str(x)


# Create vectors
x <- 1:10-1
cat(x)
x <- (1:10)-1
cat(x)
x <- 1:(10-1)
cat(x)

x <- seq(1, 10, by=0.5)    # 等价于seq(frox=1, to=10, by=0.5)
cat(x)
x <- seq(10, 100, length=5)    # 输出5个包括首末的数，并平分区间
cat(x)
x <- rep(1:4, tixes=2, length=10, each=2)    # tixes总循环次数,each每个元素重复
cat(x)                                       # length过大会令tixes失效
x <- c(1, 4, 2, 45, 3)    # 无规律向量
cat(x)
# R语言没有指针的概念,需要修改或添加元素是只能重新赋值


# 索引
x <- seq(1, 10)
x[c(2, 4)]   # 输出x中索引为2 4的两个元素。注意R语言中索引从1开始。可以重复索引
x[c(-2 ,-4)]    # 删除其绝对值代表的索引
x[1:length(x)-3]    # 删除后两个元素

any(x>9)    # 或
all(x>=1)   # 且


# 向量的筛选
x <- c(-1, 1, -2, 4, -5, 9)
x < 0    # 展示逻辑结果向量
y <- x[x<0]    # 根据逻辑结果筛选
cat(y)
x[x<0] <- 0    # 将小于0的数变为0，该操作会改变原向量

x <- c(-1, -2, 0, NA, 2)
x[x>=0]    # 保留NA
subset(x, x>=0)    # 不保留NA
which(x<0 & x!=-1)    # 输出满足条件的向量


# Create matrix
x <- matrix(c(1, 2, 3, 4, 5, 6), nrow = 2, ncol =3)    # 数量不足则循环补齐
x <- matrix(c(1, 2, 3, 4, 5, 6), nrow = 2)    # 指定了元素后可以省略
# 以上均默认按列补齐
# 按行补齐需要设置"byrow = 2"

x <- matrix(nrow = 2, ncol = 3)
x[1,1] <- 1; x[1,2] <- 2; x[1:3] <- 3    # 分别赋值


# 矩阵索引
x[1,2]
x[,2:3]
x[-2,]
x[c(1, 3),] <- matrix(c(0, 9, 0, 9, 0, 9), nrow = 2)
# 采用行列命名的方法索引
colnames(x) <- c("Math", "Physics", "Chemistry")
colnames(x)[1]  # 对第一列命名
names(x) # 用法类似，主要用于对data.frame的列命名
dimnames(x)[[2]] # 与上个完全相同。如果2→1，则为对行命名
      # 单个索引:
dimnames(x)[[2]][1:3] # 第1到3列的列标签


# 矩阵计算
# 向量与矩阵运算时，向量不能长于矩阵，否则出错。短于时循环补齐
# 注意自动按列顺序运算
# 矩阵乘法"%*%"
# Some Useful functions
t(x) # 转置
rowSums(x)    
colSums(x)    # 利用这两个函数可方便地求解每个元素在其行和列的占比


# 修改行列
# For example
new_col <- c(0, 0, 0, 0)
x <- matrix(rep(1:4, times = 3), nrow = 4)
new_x <- cbind(new_col, x)    # 也有rbind()
new_x    # 第一列保留了原来的名字


# 行列调用函数
x = matrix(1:9, nrow = 3)
apply(x, 2, max)    # 第二个参数为dimcode，1代表对行应用函数，2代表对列调用
                    # 第三个参数为函数，不需要加括号
                    # 如函数需要其他参数，用逗号分隔加在函数后面
                    # 应始终将函数定义中表示矩阵的参数放在第一位，或显式传参
# apply函数始终输出行向量，需要用到转置函数t()
# 一个自定义函数的apply运用实例
outlier_value <- function(method_opt, matrix_row){
  if(method_opt == 1)
    return(max(matrix_row))
  if(method_opt == 0)
    return(min(matrix_row))
}

apply(x, 1, outlier_value, method_opt = 1)


# 矩阵筛选
x[x[,3]%%3 == 0,]
    # 选取x中第三列能够被3整除的行
    # 为了让得到的结果是一个矩阵，可改成如下
x[x[,3]%%3 == 0, ,drop = FALSE]