# 高级数据结构
# 列表， 类比Python中的字典
goods <- list(name = "Cookie, Cake", price = 4.00, outdate = F)
# 如不指定标签名，则以[[1]]、[[2]]等命名
goods

temp <- vector(mode = "list") # 另一种创建list的途径
temp[["name"]] <- "Cookie"
temp


# list索引
goods$name
goods[["name"]]
goods[[1]]

# 采用单引号的返回一个单列表而不是列表内的值
goods["name"]
goods[1]

# 双方框一次只能引用一个列表
goods[[1:3]] # 错误
goods[1:3] # 返回goods内前三个单列表

# 索引某个具体的元素
goods[["name"]][1]


# 列表元素的增删
goods$producer <- "A Company" # 增加一个数据标签并初始化，必须赋值而不能为空标签
goods[["producer"]] <- "A Company"  # 等价

goods$producer <- NULL # 赋NULL即为删除标签。其他索引方式等价

colnames(goods$name) <- "names"

c(list(A = 1, C = "C"), list(new = "NEW")) # 拼接列表


# 列表与向量转化
unlist(goods) # 保留原列名，均输出为字符串
c(goods, recursive = T) # 同上
unnames(goods)
names(goods) <- NULL# 两种方法去掉名称


# 列表运算lapply & sapply
temp <- list(1:10, -2:-9)
lapply(temp, mean) # 分别计算两个单列表的均值，输出两个列表，分别有单元素均值
sapply(temp, mean) # lapply函数的封装，输出单列表
sapply(temp, mean, simplifu = F, USE.NAMES = F) # 此时该式与lapply等价


# 列表递归
# 普通向量的元素是原子型的数据，而列表是递归型的向量，列表的元素可以是列表
# Example
a1 <- list(name = "Cookie", price = 4.0, outdate = F)
a2 <- list(name = "Milk", price = 2.0, outdate = T)
warehouse <- list(a1, a2) # 此时存在列表的嵌套


# Data Frame数据框
# 数据框创建
male <- c(124, 88, 200)
female <- c(108, 56, 221)
degree <- c("low", "middle", "high")
myopia <- data.frame(degree, male, female)
# 如创建时无名称，则以元素内容为名称
# 如不等长，则会重复补齐
str(myopia) # 查看数据框内部结构

# 数据框索引，与列表基本一致
myopia$degree
myopia[["degree"]]
mypoia[[1]] # 完全等价
mypoia[1, ] # 矩阵形式索引，结果与上基本相同
view(names) # 在新页面中打开数据框显示全部数据

# 提取子数据框
sub <- myopia[2:3, 1:2] # 保留列名和行名

sub <- myopia[2:3, 1] # 只取某一列是得到向量
sub <- myopia[2:3, 1, drop = F] # 此时得到dataframe

sub <- myopia[1:2] #只指定一个维度，返回列，且始终为dataframe

sub <- myopia["male", "famale"] # 使用列名访问

# 筛选提取
sub <- myopia[myopia$male > 100,]
sub <- myopia[male > 100,] # 等价. 但如果male被定义了其他值，则会出现问题

# 数据框添加, 可以类比列表的添加
rbind()
cbind()

students$sex <- c(...) # 直接添加

# 数据框合并
# 基于两个表的同一属性进行合并
merge(student1, student2) # sutdent 1和2有一个相同属性names。则可以合并
# 如果两个表中代表相同属性的列名不同，使用by.x/by.y参数
merge(student1, student2, by.x = "names", by.y = "na")
# all.x/all.y/all参数，默认为FALSE。代表合并结果中只保留两列表中都存在的元素
  # 如all.x为TRUE，则返回的结果会包含所有student1中的成员，
  # 对应的student2有而1没有的会取值为NA
  # all参数即代表all.x & all.y均F or T

# 需要注意重名问题


# 因子 factor
# R中的变量可归结为名义、有序、连续。前两种被称为因子
# 因子的创建
ssample <- c("BJ", "SH", "CQ", "SH")
sf <- factor(ssample)
sf
# level 水平：可以理解为不重复的元素
str(sf)
unclass(sf)
# 转化成1 3 2 3。每个数字代表不同的元素，并且按照字母顺序排列
# 如果对于有序性向量，保留原来的顺序，使用参数order = T
assessment <- c("weak", "good", "limited", "fair")
assessment1 <- factor(assessment, order = T, 
                      levels = c("good", "fair", "limited", "weak"))
assessment1
# order = T时，levels有序,如无指定顺序则自动按首字母顺序。

# Factor中插入Levels
sample <- c(12, 15, 7, 10)
fasample <- factor(sample, levels = c(7, 10, 12, 15, 100))
length(fasample)
# 当元素并不包含所有的levels时也需要手动插入，
# length表示元素个数而非levels个数
# 不能添加非levels的元素，否则会报错


# Factor常用函数

tapply(X,INDEX,FUN)
# X:原子型对象，不能输数据框。  
# INDEX:因子或因子列表，如不是因子则使用as.factor()强制转换,也可以省略
# tapply的作用是将X根据因子水平进行分组，然后在每组数据上应用函数
wt <- c(46, 39, 35, 42, 43, 43)
group <- c("A", "B", "C", "A", "B", "C") # 与wt长度必须相同
tapply(wt, as.factor(group), mean)
# INDEX二维情况, 生成类似频数表
wt <- c(46, 39, 35, 42, 43, 43, 42, 44, 36, 40, 39, 38)
diet <- c("A", "B", "C", "A", "B", "C", "A", "B", "C", "A", "B", "C")
gender <- c("M", "M", "M", "M", "M", "M", "F", "F", "F", "F", "F", "F")
tapply(wt, list(as.factor(diet), as.factor(gender)), mean)

split(x,f)
# x:待处理的数据，可以是向量或数据框    f:因子或因子列表，同上INDEX
# 用于形成分组
wt <- c(46, 39, 35, 42, 43, 43, 42, 44, 36, 40, 39, 38)
diet <- c("A", "B", "C", "A", "B", "C", "A", "B", "C", "A", "B", "C")
gender <- c("M", "M", "M", "M", "M", "M", "F", "F", "F", "F", "F", "F")
split(wt, list(diet, gender))

by()
# 类似tapply，但是可以用于数据框和矩阵、
male <- c(124, 88, 200)
female <- c(108, 56, 221)
degree <- c("low", "middle", "high")
myopia <- data.frame(degree, male, female)
by(myopia, myopia$degree, function(frame) frame[,2] + frame[,3])
# by()可以自定义函数，而tapply不能


# 表的创建
table()
利用因子创建一个频数表
table(list(diet, gender)) #使用上上例数据
table(diet, gender)
# 可以创建三维乃至更高维的表，不过不便于查看


# 表中元素的访问和矩阵基本一致
# 修改
dh_tab[2,2]*4 # 返回单个数字
dh_tab[,1]*2 # 返回该列和左侧的列名
dh_tab/3


# 表中变量的边际值
# 边际值：某一个特定变量的取值不变时，其他所有变量求和得到的结果。边际分布？
apply(dh_tab, 1, sum) # 按行取
addmargins(dehtab) # 在原表基础上添加总计的一行和一列
# 三维时均可使用，对于apply，将1更改成具体的维度名