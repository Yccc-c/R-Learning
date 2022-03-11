# 数据输入/输出
data()    # 查看系统提供的所有数据集，参量为数据集名时则进行加载
mode()    # 输出数据类型
names()   # 输出列名
dim()     # 输出维数
read.csv()# 读取csv文件，可修改参量sep以采用不同的符号。\t表示Tab
read.delim("clipboard")   # 读取粘贴板。复制Excel后可用该函数导入
# 举例
data.excel = read.delim("clipboard")

# RODBC Package
library(RODBC)
salary = odbcConnectExcel2007("C:/Users/_Ycc_/Desktop/12月助理工资.xlsx")
sqlTables(salary)
data_salary = sqlFetch(salary, "Sheet1")
close(salary) # 或者odbcCloseAll()  必须断开连接否则源文件不可打开

# readxl Package
library(readxl)
salary <- read_excel("Path", sheet = )  # sheet参数可为数字，即表示第几个sheet


# 显示变量
trees$Girth      # 可以赋值给另一个变量
attach(trees)
detach(trees)    # 使用attach后即可通过列名直接索引该列，使用detach后反之


# 读取网页    Error
library(XML)
baseURL <- "http://data.worldbank.org/indicator/NY.GDP.PCAP.CD/countries/
1W?display=default"
baseURL <- gsub("\\n","", baseURL)    # 替换掉回车符
table = readHTMLTable(baseURL, header = TRUE, which = 1)
table = table[, 1:5]
names(table) = c("countries", "2011", "2012", "2013", "2014")


# 数据的保存      append??
car = file("C:/Users/_Ycc_/Desktop/car.txt")
cat("Hello World!", "\"Alpha Romeo\" 9.5 1242 38500", file = car, sep = "\n", 
    append = T)

cat("你好，世界!", "\"Alpha Romeo\" 9.5 1242 38500", file = car, sep = ",", 
    append = T)
close(car)

data = cars
write.csv(data, file = "C:/Users/_Ycc_/Desktop/cars.csv", col.names = T,
            quote = F)


# 简单预处理
sum()    prod() # 乘积     
max()  min()    range()# 返回取值范围，即返回最大值和最小值
length()   mean()    median()     
var()    sd()    cov(x,y)   cor(x, y) # 方差 标准差 协方差 相关系数
pmin(x, y, ...)   pmax(x, y, ...) # 返回的向量中第i个元素是x[i],y[i]...的最小值
cumsum()    cumprod() # 返回的向量中第i个元素是x[1]~x[i]之和或积
round(x, n)  # 四舍五入，保留n位
sort()     order() # 排序，默认升序
unique()   # x中重复的元素只取一个
table()    # 统计完全相同的数据个数   输入两个参数时即得到交叉频数表


# 数据处理
tapply(x, y, fun)   # x y是数据框内的两列
tapply(warpbreaks$breaks, warpbreaks$tension, mean) 
      # 计算不同tension的breaks均值

# 缺省值处理
air_data <- airquality[, 1:4]
is.na(air_data) # 得到和原data.frame维数相同的逻辑值data.frame, NA记为True

complete.cases(air_data) # 分行判断该行内是否有NA，如有则为False，与is.na相反
complete.cases(air_data$Ozone) # 查找该列是否有缺省值

aggr(airquality, las = 1, numbers = T)# VIM 包中函数，缺省值画图
       # las控制作图数字的方向，numbers控制右图是否显示数字

# 删除缺省值
air_data <- airquality[complete.cases(airquality),] # 保留无缺省值的行
air_data <- airquality[(!is.na(airquality$Ozone)) 
                       & (!is.na(airquality$Solar.R)),] # 等价
air_data <- na.omit((airquality)) # 一步到位

airquality$Ozone[is.na(airquality$Ozone)] <- 
  median(airquality$Ozone[!is.na(airquality$Ozone)]) # 用中位数替换缺省值
