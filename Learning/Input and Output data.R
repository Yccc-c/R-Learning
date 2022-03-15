# 数据输入/输出
data()    # 查看系统提供的所有数据集，参量为数据集名时则进行加载
mode()    # 输出数据类型
names()   # 输出列名
dim()     # 输出维数
read_csv()# 读取csv文件，可修改参量sep以采用不同的符号。\t表示Tab [readr]
read_tsv()# tab分隔文件
read.delim("clipboard")   # 读取粘贴板。复制Excel后可用该函数导入 [readr]
# 举例
data.excel = read.delim("clipboard")

# readr Package
# read_csv() 该为readr函数，read.csv()为base函数。推荐前者
read_csv("a,b,c
1,2,3
4,5,6") # 行内输入，回车即换行
read.csv("a,b,c\n1,2,3\n4,5,6") # 等价
## read.csv自动将第一行作为标题行，使用skip = n来跳过某几行
## 使用comment = "#"来跳过所有以#开头的行
## 使用col_names = F来读取无标题行的数据，列名自动命名为x1 x2 ...
## 使用col_names = C("name", "sex", ...)来手动命名
## 使用na = "." 将所有的.变为NA


# Parsing a vector
x <- parse_logical(c("TRUE", "FALSE", "FALSE")) # [tidyparse]
x <- parse_date(c("2020-03-11", "2022-05-09"))
x <- parse_guess("2010-10-10") # 使用系统的猜测来解析
x <- parse_...

## number
### 使用,作为小数点
parse_double("1,23", locale = locale(decimal_mark = ",")) # vignette("locales")
### 数字前后有符号
parse_number("$100") # 该函数忽略非数字部分
### 使用分隔符
parse_number("$123,456,789") # 同上
parse_number("123.456.789", locale = locale(grouping_mark = "."))
### 科学计数法
  # R 可识别科学计数法。e.g. 10e5
  #一些欧洲地区的用法

## string
charToRaw("Hedlay") # 展示字符串的底层(underlying)表达
### 编码
x1 <- "El Ni\xf1o was particularly bad this year"
x2 <- "\x82\xb1\x82\xf1\x82\xc9\x82\xbf\x82\xcd"
parse_character(x1, locale = locale(encoding = "Latin1"))
parse_character(x2, locale = locale(encoding = "Shift-JIS"))
guess_encoding(charToRaw(x2)) # 寻找适合的编码

## factor


## Date&Time
### 标准格式
parse_datetime("2010-10-01T2010") # 该函数遵循 ISO8601
#> [1] "2010-10-01 20:10:00 UTC"
parse_datetime("20101010")
#> [1] "2010-10-10 UTC"

parse_date("2010-10-01") # 二者皆可，以上式为输出格式
parse_date("2010/10/01")

library(hms) # Base R doesn’t have a great built in class for time data.
parse_time("01:10 am")
#> 01:10:00
parse_time("20:10:01")
#> 20:10:01

### 自定义
  # %Y(4 digits)    %y(2 digits, 00-69 -> 2000-2069; 70-99 -> 1970-1999)
  # %m(2 digits)    %B("January")    %b("Jan")
  # %d(2 digits)    %e(optional leading space?)
  # %H(24H)    %I(12H, must use %p)    %p(am/pm)    %M(minitues)
  # %S(integer seconds)    %OS(real seconds)
  # %Z(Time Zone:)    %z(offset of UTC, e.g.:+0800)
  # %.(跳过一个非数字字符)    %*(跳过任意数量的非数字字符)
parse_date("01/02/15", "%m/%d/%y")
#> [1] "2015-01-02"
parse_date("1 janvier 2015", "%d %B %Y", locale = locale("fr"))
#> [1] "2015-01-01"

## 使用locale("zh")检查中国的规范
## vignette("locales")查看文档

# 读取文件原理
challenge <- read_csv(readr_example("challenge.csv")) # 一个示例文件[readr]

challenge <- read_csv(
  readr_example("challenge.csv"), 
  col_types = cols(
    x = col_double(),
    y = col_logical()
  )
)

challenge <- read_csv(
  readr_example("challenge.csv"), 
  col_types = cols(
    x = col_double(),
    y = col_date()
  )
)

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
