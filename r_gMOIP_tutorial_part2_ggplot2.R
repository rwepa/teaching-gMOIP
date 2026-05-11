# File     : r_gMOIP_tutorial_part2_ggplot2.R
# Title    : gMOIP套件最大獲利範例_ggplot2套件運用
# Author   : Ming-Chang Lee
# Date     : 2026.05.12
# Email    : alan9956@gmail.com
# RWEPA    : http://rwepa.blogspot.tw/
# GitHub   : https://github.com/rwepa

# 大綱 -----
# 1.ggplot2 套件簡介
# 2.匯出圖檔
# 3.gMOIP + ggplot2 應用
# 4.結論

# 1.ggplot2 套件簡介 -----

# 安裝 ggplot2 套件
# install.packages("ggplot2")

# 載入 ggplot2 套件
library(ggplot2)

# 載入汽車資料集
data(mtcars) # 32*11

# mtcars 線上說明
?mtcars

# 11個欄位說明
# mpg  英哩/加侖
# cyl  汽缸數
# disp 排氣量 (立方英吋)
# hp   總馬力
# drat 後軸速比
# wt   重量 (千磅)
# qsec 四分之一英哩加速時間
# vs   引擎 (0 = V 型，1 = 直列式)
# am   變速箱 (0 = 自動，1 = 手排)
# gear 前進擋數
# carb 化油器數量

# 基礎散布圖
ggplot(mtcars, aes(x=wt, y=mpg)) +
  geom_point()

# 基礎散布圖 + 顏色 + 大小
ggplot(mtcars,
       aes(x=wt, y=mpg, color = factor(cyl), size = hp)) +
  geom_point()

# 繪圖風格 theme_minimal
ggplot(mtcars,
       aes(x=wt, y=mpg, color = factor(cyl), size = hp)) +
  geom_point() +
  theme_minimal()

# 繪圖風格 theme_classic
ggplot(mtcars,
       aes(x=wt, y=mpg, color = factor(cyl), size = hp)) +
  geom_point() +
  theme_classic()

# Facet 分面(群組)分析
ggplot(mtcars,
       aes(x=hp, y=qsec, color = factor(cyl))) +
  geom_point() +
  facet_wrap(~ gear) # 以 gear 為群組

# 內建統計功能，例：迴歸分析
ggplot(mtcars, aes(x=hp, y=qsec)) +
  geom_point() +
  facet_wrap(~ gear) + 
  geom_smooth(method = "lm") # lm: linear model 迴歸分析

# 盒鬚圖(箱型圖)
ggplot(mtcars, aes(hp)) +
  geom_boxplot()

# 整合範例
ggplot(mtcars, aes(x = wt, y = mpg, color = factor(cyl))) +
  geom_point(size = 3) +
  geom_smooth(formula = y ~ x, method = "lm") +
  labs(
    title = "車重與油耗分析,依汽缸數為群組@RWEPA",
    x = "車重(千磅)",
    y = "油耗(英哩/加侖)") +
  theme(
    plot.title = element_text(
      hjust = 0.5,  # 水平置中
      size = 16,    # 字型大小
      face = "bold" # 粗體字型
    )
  ) +
  annotate(
    "segment",
    x = 3.3,
    xend = 2.5,
    y = 30,
    yend = 28,
    arrow = arrow()  # 加箭頭
  ) +
  annotate(
    "text",          # 加文字
    x = 4,
    y = 31,
    label = "高油耗(省油區)",
    size = 6
  )

# 2.匯出圖檔 -----

# 目前工作目錄
getwd()

# 輸出為 PNG 檔案
ggsave("scatter_plot.png")

# mac 中文字型 plot:
# https://rwepa.blogspot.com/2013/11/mac-plot.html

# 3.gMOIP + ggplot2 應用 -----

# 載入 gMOIP 套件-線性規劃
library(gMOIP)

# materials: https://github.com/rwepa/teaching-gMOIP/blob/main/r_gMOIP_tutorial_part2.pdf

# 最大化問題:
# 決策變數（Decision Variables）：
#   D = 玻璃門的生產數量 
#   W = 木框窗戶的生產數量
# 目標函數（Objective Function）：
#   利潤 (Profit, P) 最大化 P = 300D + 500W
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

# 繪製凸集(Convex set)-加入最佳值,最佳解+極點(Extreme Point)
# 最佳解 D=2, W=6, 最大獲利3600
plotPolytope(
  A,
  b,
  obj,
  crit = "max",
  plotOptimum = TRUE,
  labels = "coord"
)

# 練習加入"標題-學號姓名", 文字", "箭頭"
# end
