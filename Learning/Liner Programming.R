# Liner Programming
# Rglpk Package Method

Rglpk_solve_LP(obj, mat, dir, rhs, bounds = NULL, types = NULL,
               max = FALSE,control = list(), ...)
# obj: 系数向量
# mat: 约束向量矩阵
# dir: 约束方向向量，以< > <= >= =作为元素的向量，< >按照<= >=处理
# rhs: 约束值
# bounds: 上下限约束，默认0到INF。ind表示索引，val表示索引位置位置数的范围
# types: 限定目标变量的类型，'B'代表0-1规划，'C'代表连续（默认），'I'代表整数，
# control: 
obj <- c(3, 1, 3)
mat <- matrix(c(-1, 0, 1, 2, 4, -3, 1, -3, 2), nrow = 3)
cat(mat)
dir <- rep("<=", 3)
rhs <- c(4, 2, 3)
types <- c("I", "C", "I")
max <- T
bounds <- list(lower = list(ind = c(1L, 3L), val = c(-Inf, 2)),
               upper = list(ind = c(1L, 2L), val = c(4,100)))

Rglpk_solve_LP(obj, mat, dir, rhs, bounds, types, max)
# Result:
# $optimum: 目标函数最优解
# $solution: 最优解


# LpSolve Package Method
# Used for Transport Problem
# Transport Prob:首列产地，首行销地，末列产量，末行销量。

lp.transport(costs.mat,direction="min",row.signs,row.rhs,
             col.signs,col.rhs,presolve=0,compute.sense=0,integers=1:(nc*nr))

# cost.mat: 运费矩阵
# direction: 取最大/最小值
# row.signs: 产量约束符号
# row.rhs: 产量约束向量
# col.signs: 销量约束符号
# col.signs: 销量约束向量
# presolve