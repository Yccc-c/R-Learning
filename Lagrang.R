data <- read.table('clipboard',header = T,sep = '\t')




function lagrange_basic(length, unknown_x, i){
  result1 <- 1               # result初始化为1
  for (j in 1:(length+1)){    # j为第i个插值基函数中的第j个因�?
    if(j == i){
      next
    }
  result1 <- (unknown_x - data$x[j])/(data$x[i] - data$x[j])*result1
  }
  return (result1)
}


function lagrange_sum(length, unknown_x){
  result1 <- 0              # 初始化result�?0
  for (i in 1:(length+1)){
    result1 = data$y[i] * lagrange_basic(length, unknown_x, i) + result1 
        # 插值基函数进行求和
    return (result1)
  }
}


cat("Please input the unknown 'x'")
x <- 1005     # 必须手动修改

result <- lagrange_sum(length(data$x), x)

cat("The result is ", result)

