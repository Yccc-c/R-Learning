# 例9
library(Rglpk)
obj <- c(0.9, 1.4, 1.9, 
         0.45, 0.95, 1.45, 
         -0.05, 0.45, 0.95)
mat <- matrix(c(1, 0, 0, -0.4, 0.2, 0, 0, 0, 
                0, 1, 0, 0.6, 0.2, 0, 0, 0, 
                0, 0, 1, 0.6, -0.8, 0, 0, 0, 
                1, 0, 0, 0, 0, -0.7, 0.5, 0, 
                0, 1, 0, 0, 0, 0.3, 0.5, 0, 
                0, 0, 1, 0, 0, 0.3, -0.5, 0, 
                1, 0, 0, 0, 0, 0, 0, 0.6, 
                0, 1, 0, 0, 0, 0, 0, 0.6, 
                0, 0, 1, 0, 0, 0, 0, -0.4), nrow = 8)
dir <- c("<=", "<=", "<=", "<=", ">=", "<=", ">=", ">=")
rhs <- c(2000, 2500, 1200, 0, 0, 0, 0, 0)
types <- rep("C", 9)

res1 <- Rglpk_solve_LP(obj, mat, dir, rhs, types=types, max=T)
prod1 <- sum(res1$solution[1:3])
prod2 <- sum(res1$solution[4:6])
prod3 <- sum(res1$solution[7:9])
cat("甲种", prod1, "kg", "\n",
    "乙种", prod2, "kg", "\n",
    "丙种", prod3, "kg", "\n", 
    "可获利", res1$optimum, "元")


# 例10
obj <- c(0.39, 0.31, 0.4, 0.43, 0.35, 0.45, 
         0.67, 0.9, 
         0.73)
mat <- matrix(c(5, 0, 6, 0, 0, 
                5, 0, 0, 4, 0, 
                5, 0, 0, 0, 7, 
                0, 7, 6, 0, 0, 
                0, 7, 0, 4, 0, 
                0, 7, 0, 0, 7, 
                10, 0, 8, 0, 0, 
                0, 9, 8, 0, 0, 
                0, 12, 0, 11, 0), nrow=5)
dir <- rep("<=", 5)
rhs <- c(6000, 10000, 4000, 7000, 4000)
types <- rep("C", 9)
res2 <- Rglpk_solve_LP(obj, mat, dir, rhs, types=types, max=T)
prod1 <- sum(res2$solution[1:6])
prod2 <- sum(res2$solution[7:8])
prod3 <- sum(res2$solution[9])
cat("产品1", prod1, "件", "\n",
    "产品2", prod2, "件", "\n",
    "产品3", prod3, "件", 
    "可获利", res2$optimum, "元")


# 例11
obj <- rep(1, 7)
mat <- matrix(c(rep(1, 3), rep(0, 7)), nrow=9, ncol=7)
dir <- rep(">=", 9)
rhs <- c(26, 50, 34, 40, 38, 50, 46, 36, 26)
types <- rep("C", 9)
res3 <- Rglpk_solve_LP(obj, mat, dir, rhs, types=types, max=F)
cat("最佳的人员安排为", res3$solution, "\n", 
    "共需总人数为", res3$optimum*(7/6), "人")