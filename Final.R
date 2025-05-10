rm(list = ls())

directory <- "/Users/derpboy77/Desktop/SURGE" 
setwd(directory)

install.packages("nnet")
install.packages("censReg")
library(censReg)
library(nnet)

library(rio)
library(dplyr)
library(tidyr)
library(stargazer)

df_2022 <- rio::import("data_2022.xlsx")
df_2014 <- rio::import("data_2014.xlsx")

df_2022 <- df_2022 %>% select(idstd, Treatment, Post, d2, d30a, l2)
df_2014 <- df_2014 %>% select(idstd, Treatment, Post, d2, d30a, l2)

df_2022 <- drop_na(df_2022)
df_2014 <- drop_na(df_2014)

table(df_full$l2)

df_full <- bind_rows(df_2022, df_2014)

df_full <- df_full %>% filter(d2 != -9)
df_full <- df_full %>% filter(l2 != -9)
df_full <- df_full %>% filter(l2 != -7)

df_full$d2 <- (df_full$d2 - mean(df_full$d2))/sd(df_full$d2)

gm_1 <- lm(d2~Treatment+Post+Treatment*Post+l2, df_full)
stargazer(gm_1, type="text")

table(df_full$d30a)
df_full <- df_full %>% filter(d30a != -9)
df_full <- df_full %>% filter(d30a != -7)

gm_2 <- lm(d30a~Treatment+Post+Treatment*Post, df_full)
stargazer(gm_2, type="text")


gm_3 <- multinom(d30a~Treatment+Post+Treatment*Post, df_full)
stargazer(gm_3, type="text")

tobit_model <- censReg(
  d30a ~ Treatment+Post+Treatment*Post,  # Model formula
  left = 0,    # Lower bound
  right = 4,   # Upper bound
  data = df_full  # Data frame containing your variables
)

stargazer(tobit_model, type="text")

v <- exp(coef(gm_3))
v <- data.frame(v)
v[, 4]

data <- rio::import("Combined_2022_2014_With_City_Names.xlsx")
data <- data %>% 
  mutate(Treatment = ifelse(District %in% cities, 1, 0))
data$Treatment
rio::export(data, "Combined_2022_2014_With_City_Names_2.xlsx")
