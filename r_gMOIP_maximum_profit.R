# File     : r_gMOIP_maximum_profit.R
# Title    : gMOIP套件最大獲利範例
# Author   : Ming-Chang Lee
# Date     : 2026.04.21
# Email    : alan9956@gmail.com
# RWEPA    : http://rwepa.blogspot.tw/
# GitHub   : https://github.com/rwepa

# gMOIP CRAN:
# https://cran.r-project.org/web/packages/gMOIP/index.html

# 安裝 gMOIP 套件
install.packages("gMOIP")

# R 套件安裝目錄
.libPaths()

# 載入套件
library(gMOIP)

# materials: https://github.com/rwepa/teaching-gMOIP/blob/main/r_gMOIP_tutorial.pdf

# 最大化問題:
# 決策變數（Decision Variables）：
#   D = 玻璃門的生產數量 
#   W = 木框窗戶的生產數量
# 目標函數（Objective Function）：
#   利潤 (P) 最大化 P = 300D + 500W
# 受限於三間工廠產能時間限制條件：
# D       <= 4
#      2W <= 12
# 3D + 2W <= 18
# D ≥ 0, W ≥ 0, D, W 皆為整數

# 建立限制條件矩陣
A <- matrix(c(1, 0, 0, 2, 3, 2), ncol=2, byrow = TRUE)
A

# 建立限制條件
b <- c(4, 12, 18)
b

# 建立目標函數
obj <- c(300, 500)
obj

# 繪製凸集(Convex set)線上說明
?plotPolytope

# case 1. 繪製凸集(Convex set)
plotPolytope(
  A,
  b,
  obj
)

# case 2. 繪製凸集(Convex set)-加入最佳值
plotPolytope(
  A,
  b,
  obj,
  plotOptimum = TRUE
)

# case 3. 繪製凸集(Convex set)-加入最佳值,最佳解+極點(Extreme Point)
plotPolytope(
  A,
  b,
  obj,
  crit = "max",
  plotOptimum = TRUE,
  labels = "coord"
)
# end
