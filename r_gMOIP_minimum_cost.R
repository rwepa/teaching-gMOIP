# File     : r_gMOIP_minimum_cost.R
# Title    : gMOIP套件最小化成本範例
# Author   : Ming-Chang Lee
# Date     : 2026.05.10
# Email    : alan9956@gmail.com
# RWEPA    : http://rwepa.blogspot.tw/
# GitHub   : https://github.com/rwepa

# 載入套件
library(gMOIP)

# 最小化問題:
# 決策變數（Decision Variables）：
#   TV = 電視廣告的單位數量 
#   PM = 平面媒體廣告的單位數量
# 目標函數（Objective Function）：
#   成本 (Cost, C) 最小化 C = TV + 2PM
# 受限滿足最小銷售量限制條件：
#        PM ≥ 3
# 3TV + 2PM ≥ 18
# -TV + 4PM ≥ 4
# TV ≥ 0, PM ≥ 0, TV, PM 皆為整數

# 建立限制條件矩陣,左右乘以負號改為小於或等於之限制式.
#        -PM ≤ -3
# -3TV - 2PM ≤ -18
#   TV - 4PM ≤ -4

A <- matrix(c(0, -1, -3, -2, 1, -4), ncol=2, byrow = TRUE)
A

# 建立限制條件,左右乘以負號.
b <- c(-3, -18, -4)
b

# 建立目標函數, 目標函數不用左右乘以負號, 只要預設值 crit = "max" 修改為 crit = "min"
obj <- c(1, 2)
obj

# 繪製凸集(Convex set)-加入最佳值,最佳解+極點(Extreme Point)
plotPolytope(
  A,
  b,
  obj,
  type = rep("i", ncol(A)), # i: 整數integer
  crit = "min",
  plotOptimum = TRUE,
  labels = "coord"
)
# end
