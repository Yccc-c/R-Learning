library("ggplot2")
# 一个基本结构
ggplot(data = <DATA>) + 
  <GEOM_FUNCTION>(
    mapping = aes(<MAPPINGS>),
    stat = <STAT>, 
    position = <POSITION>
  ) +
  <COORDINATE_FUNCTION> +
  <FACET_FUNCTION>


ggplot(data = mpg) + 
  geom_point(mapping = aes(x=displ, y=hwy)) # 点阵图
ggplot(data = mpg) + 
  geom_smooth(mapping = aes(x = displ, y = hwy)) # 拟合曲线
  # 分类
  geom_smooth(mapping = aes(x = displ, y = hwy, linetype=drv)) 
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut)) # 条形图


# 整体美化
ggplot(data = mpg) + 
  geom_point(mapping = aes(x=displ, y=hwy), color="blue")
# 根据class分类可视化
ggplot(data = mpg) + 
  # 颜色分类
  geom_point(mapping = aes(x=displ, y=hwy, color=class))
  # 大小分类
  geom_point(mapping = aes(x=displ, y=hwy, size=class))
  # 深度分类
  geom_point(mapping = aes(x=displ, y=hwy, alpha=class))
  # 形状分类。注意只有六个默认形状，多余的变量将不予绘制
  geom_point(mapping = aes(x=displ, y=hwy, shape=class)) 


# 噪点显示更详尽的分布
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy), position = "jitter")
  # 下方等价
ggplot(data = mpg) + 
  geom_jitter(mapping = aes(x = displ, y = hwy))


# 分类画图
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_wrap(~ class, nrow = 2)
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_grid(drv ~ cyl)
  # 仅在横轴分面
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(.~cyl)

# 叠加绘制
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + # 加号非常重要
  geom_smooth(mapping = aes(x = displ, y = hwy))
  # 或者这样
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()
  # 不同的层(layer)使用不同的样式
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point(mapping = aes(color = class)) + 
  geom_smooth()
  # 也可以用不同的数据
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point(mapping = aes(color = class)) + 
  geom_smooth(data = filter(mpg, class == "subcompact"), se = FALSE)
    # se表示置信区间的显示


# 条形图
demo <- tribble(
  ~cut,         ~freq,
  "Fair",       1610,
  "Good",       4906,
  "Very Good",  12082,
  "Premium",    13791,
  "Ideal",      21551
)


# 条形图计算
ggplot(data = demo) +
  geom_bar(mapping = aes(x = cut, y = freq), stat = "identity")
  # 默认y值为计数，这里定义了y的值，从而按值输出条形高度

ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, y = stat(prop), group = 1))
  # 这是一个比例柱状图

ggplot(data = diamonds) + 
  stat_summary(mapping = aes(x = cut, y = depth), 
               fun.min = "min", fun.max = "max", fun = "median")
  # 展示了cut和depth的关系，展示极值和中值

#条形图美化
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, colour = cut))
  # 仅边框颜色
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = cut))
  # 填充颜色
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity))
  # 每个条内分类填充
ggplot(data = diamonds, mapping = aes(x = cut, fill = clarity)) + 
  geom_bar(alpha = 1/5, position = "identity")
  # 将每个分类从堆叠的方式改为均在0处对齐，alpha指不透明度
ggplot(data = diamonds, mapping = aes(x = cut, colour = clarity)) + 
  geom_bar(fill = NA, position = "identity")
  # 不填充的版本
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity), position = "fill")
  # 堆叠方式，但总高相同，用于比较比例
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity), position = "dodge")
  # 每个大单位显示各个分类的小条形图


# 坐标系 coordinate system
  # xy轴颠倒，请观察以下两个例子
ggplot(data = mpg, mapping = aes(x = class, y = hwy)) + 
  geom_boxplot()
ggplot(data = mpg, mapping = aes(x = class, y = hwy)) + 
  geom_boxplot() +
  coord_flip()
  # 设置合适的长宽比，请观察以下两个例子
nz <- map_data("cn") # 一个包含地图的

ggplot(nz, aes(long, lat, group = group)) +
  geom_polygon(fill = "white", colour = "black")

ggplot(nz, aes(long, lat, group = group)) +
  geom_polygon(fill = "white", colour = "black") +
  coord_quickmap()
  # 极坐标
bar <- ggplot(data = diamonds) + 
  geom_bar(
    mapping = aes(x = cut, fill = cut), 
    show.legend = FALSE,
    width = 1
  ) + 
  theme(aspect.ratio = 1) +
  labs(x = NULL, y = NULL)

bar + coord_flip() # 更换坐标轴
bar + coord_polar() # 使用极坐标


  
  
  
  
  
  
  