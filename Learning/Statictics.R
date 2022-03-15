# An introduction about Statistics knowledge of R
# 偏态&峰态系数 
library("moment")
skewness(x) 
kurtosis(x)

# 概率分布
beta    # \beta分布
f       # F分布
chisq   # 卡方分布
t       # t分布
binom   # 二项式分布
geom    # 几何分布
hyper   # 超几何分布
norm    # 正态分布
pois    # 泊松分布
unif    # 均匀分布

pnorm(q=1.96, mean=0, sd=1) # 单侧p分位值
qnorm(p=0.975, mean=0, sd=1) # 单侧2.5%分位数
dnorm(x, mean, sd) # x为横轴坐标，可为向量。输出对应点的密度函数的值

# 数据统计
summary(vector) # 列出向量的极值、四分位值、均值
fivenum(vector) # 箱线图的五个统计量
  # 逐次累加 cum- 。 也可参见RcppRoll Package
  cumsum()
  cumprod()
  cummin()
  cummax()
  cummean() # dplyr Package
  # 排序
  min_rank(x) # 从小至大排序，得到序号，NA保留于原位置
    # 相同值排名相同，序号间断（按实际个数排序），忽略NA
  min_rank(desc(x)) # 从大至小排序，得到序号，
  row_number(y) # 相同值排名不同
  dense_rank(y) # 相同值排名相同，序号不间断

# 图表
stem(vector) # 茎叶图