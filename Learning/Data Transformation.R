# Data Transformation
library(nycflights13)
library(tidyverse)
# Tips:这里的所有函数都会返回一个新的数据框
# 每个函数的的第一个参数都是操作对象数据框

# fliter 筛选
flights_m1d1 <- filter(flights, month == 1, day == 1)
  # 该函数会忽略无效值的行，使用is.na(x)和|来保留缺省值
  filter(flights, is.na(month) | month > 1)
  # 注意使用"=="表示相等
  # 对以上整行加圆括号则会输出结果
  # 注意近似数，观察下面两个例子
  sqrt(2) ^ 2 == 2
  near(sqrt(2) ^2, 2)
  # 筛选出平均每天多于1架的目的地
  popular_dests <- flights %>% 
    group_by(dest) %>% 
    filter(n() > 365)
  
  # 使用逻辑表达式
  flights_m11_m12 <- filter(flights, month == 11 | month == 12)
  #Wrong!
  filter(flights, month == (11 | 12))
  #Right(Another method)
  filter(flights, month %in% c(11, 12)) # 在month中寻找11和12
  # 更多的逻辑在Others文件中


# arrange 排序
flights_arranged_date <- arrange(flights, year, month, day)
  # 缺省值总会被放在后面
  # desc 降序
  arrange(flights, desc(dep_delay))

  
# select 选择特定的列
select(flights, year, month, day)
select(flights, starts_with("dep"))
select(flights, -(year:day)) # 删除某些列
select(flights, -year, -month, -day) # 和上等价
  # 一些可以使用在select()中的函数
  starts_with("abc") # abc开头的名字
  ends_with("xyz") 
  contains("ijk")
  matches("(.)\\1") # 满足正则表达式的内容，参见Others:regular expressions
  num_range("x", 1:3) # matches x1 x2 x3
  # 列简单排序 everything
  select(flights, time_hour, air_time, everything())
    # 这个操作把提到的两列前置，everything表示保留其余所有的

  
# rename重命名列
rename(flights, tail_num = tailnum)
  # 等式左边为修改后的名字，右边为修改前的名字


# mutate 添加新列
mutate(flights, gain = dep_delay - arr_delay, 
       speed = distance / air_time * 60)
  # 总会把新列添加在最后
  # transmutate 只产生新列而不保留旧列
  transmute(flights, gain = dep_delay - arr_delay, hours = air_time / 60,
            gain_per_hour = gain / hours)


# 分类汇总
  # summaries 分组
  by_day <- group_by(flights, year, month, day)
  summarise(by_day, delay = mean(dep_delay, na.rm = TRUE))
    # 上述代码输出每日平均延误时间
    # 删除分组  
  ungroup(by_day)
    # 单独使用自动汇总
  by_day <- group_by(flights, year, month, day)
  (per_day   <- summarise(daily, flights = n()))
  (per_month <- summarise(per_day, flights = sum(flights)))
  # 注意上式的输出，自动按组汇总
  
  # 一个实例。探究距离和到达延误时间的关系
  by_dest <- group_by(flights, dest) # 按目的地分组
  delay <- summarise(by_dest,
                     count = n(),
                     dist = mean(distance, na.rm = TRUE),
                     delay = mean(arr_delay, na.rm = TRUE))
    # 得到按目的地分组的平均延误时间和航班数
  delay <- filter(delay, count > 20, dest != "HNL")
    # 画图
  ggplot(data = delay, mapping = aes(x = dist, y = delay)) +
    geom_point(aes(size = count), alpha = 1/3) +
    geom_smooth(se = FALSE) # se 置信区间，默认为T
  # 上个实例的简化。利用管道传参
  delays <- flights %>% 
    group_by(dest) %>% 
    summarise(
      count = n(),
      dist = mean(distance, na.rm = TRUE),
      delay = mean(arr_delay, na.rm = TRUE)
    ) %>% 
    filter(count > 20, dest != "HNL")
  
  # 计数
    # 建议在做任何汇总时都进行计数
  delays <- flights %>% 
    group_by(tailnum) %>% 
    summarise(
      delay = mean(arr_delay)
    )
  #> `summarise()` ungrouping output (override with `.groups` argument)
  ggplot(data = delays, mapping = aes(x = delay)) + 
    geom_freqpoly(binwidth = 10)
  
    # 用另一种图的表达
  delays <- flights %>% 
    group_by(tailnum) %>% 
    summarise(
      delay = mean(arr_delay, na.rm = TRUE),
      n = n()
    )
  #> `summarise()` ungrouping output (override with `.groups` argument)
  ggplot(data = delays, mapping = aes(x = n, y = delay)) + 
    geom_point(alpha = 1/10)
    # 去除较小的组，简化代码
  delays %>% # 这是上述代码中的delays
    filter(n > 25, !is.na(tailnum)) %>% # 上面的代码中没有缺省值筛选
    ggplot(mapping = aes(x = n, y = delay)) + 
    geom_point(alpha = 1/10)

  # 另一个数据的例子
  library(Lahman)
  batting <- as_tibble(Lahman::Batting)

  batters <- batting %>% 
    group_by(playerID) %>% 
    summarise(
      ba = sum(H, na.rm = TRUE) / sum(AB, na.rm = TRUE),
      ab = sum(AB, na.rm = TRUE), 
      n = n()
    )
  max(batters$n)
  
  batters %>% 
    filter(ab > 100) %>% # 如果无该项，则会有很多击球数过少的数据
    ggplot(mapping = aes(x = ab, y = ba)) +
      geom_point(alpha = 1/10) + 
      geom_smooth(se = FALSE)



# 一些有用的汇总函数
  sd()  # 标准差
  IQR() # 四分位数
  mad() # 绝对中位差：原数据减去中位数后得到的数据的中位数乘1.4826.
        # 是标准差的一种估计
  quantile()  # 分位数，第二参数为0-1的数或向量，
  first()
  nth(x, n, ...)
  last()
  # 一个例子，得到每天最早和最晚的到达航班
  not_cancelled %>% 
    group_by(year, month, day) %>% 
    mutate(r = min_rank(desc(dep_time))) %>%  # range返回最大最小值
    filter(r %in% range(r))
  n() # 计数，缺省值计入
  n_distinct() # 不重复计数
  sum(!is.na()) # 非缺省值计数
  count() # 自动分类计数，利用wt参数也可以进行汇总
    # 一个例子
    count(flights, month) # dplyr
    # 另一个例子
    count(diamonds, cut_width(carat, 0.5))  # ggplot2 # 分组
  
  
