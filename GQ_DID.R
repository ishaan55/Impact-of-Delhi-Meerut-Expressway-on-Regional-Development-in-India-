rm(list = ls())

directory <- "/Users/derpboy77/Desktop/SURGE" 
setwd(directory)

library(rio)
library(dplyr)
library(tidyr)
library(stargazer)

data<-rio::import("India-2005--full-data-.dta")
data_2002<-rio::import("India2002_M_clean.dta")
a <- rio::import("India-2022-full-data.dta")

onGQ_cities <- c(1,2,3,5,7,20,36,15,19,34,22,9,10,37,11,17,30,18,13)
offGQ_cities <- c(25,23,4,6,33,26,8,27,31,14,32,35,40,12,28,29,24,21)
nodal_cities <- c(7,10,3,5,19,20,36,37,30)

considered_cities = c(onGQ_cities, offGQ_cities)

df <- data %>% filter(code3 %in% considered_cities)
df_2002 <- data_2002 %>% filter(code3 %in% considered_cities)

df <- df %>% 
  mutate(
    onGQ = case_when(
      code3 %in% onGQ_cities ~ 1,
      TRUE ~ 0
    ),
    offGQ = case_when(
      code3 %in% offGQ_cities ~ 1,
      TRUE ~ 0
    ),
    Distance_from_GQ = case_when(
      code3 == 25 ~ 541,
      code3 == 23 ~ 355,
      code3 == 4 ~ 238,
      code3 == 6 ~ 533,
      code3 == 33 ~ 340,
      code3 == 25 ~ 541,
      code3 == 26 ~ 118,
      code3 == 8 ~ 267,
      code3 == 27 ~ 415,
      code3 == 31 ~ 364,
      code3 == 14 ~ 77,
      code3 == 32 ~ 305,
      code3 == 35 ~ 444,
      code3 == 40 ~ 347,
      code3 == 12 ~ 139,
      code3 == 28 ~ 747,
      code3 == 29 ~ 185,
      code3 == 24 ~ 392,
      code3 == 21 ~ 85,
      TRUE ~ 0
    )
  )

df_2002 <- df_2002 %>% 
  mutate(
    onGQ = case_when(
      code3 %in% onGQ_cities ~ 1,
      TRUE ~ 0
    ),
    offGQ = case_when(
      code3 %in% offGQ_cities ~ 1,
      TRUE ~ 0
    ),
    Distance_from_GQ = case_when(
      code3 == 25 ~ 541,
      code3 == 23 ~ 355,
      code3 == 4 ~ 238,
      code3 == 6 ~ 533,
      code3 == 33 ~ 340,
      code3 == 25 ~ 541,
      code3 == 26 ~ 118,
      code3 == 8 ~ 267,
      code3 == 27 ~ 415,
      code3 == 31 ~ 364,
      code3 == 14 ~ 77,
      code3 == 32 ~ 305,
      code3 == 35 ~ 444,
      code3 == 40 ~ 347,
      code3 == 12 ~ 139,
      code3 == 28 ~ 747,
      code3 == 29 ~ 185,
      code3 == 24 ~ 392,
      code3 == 21 ~ 85,
      TRUE ~ 0
    )
  )

industries <- 1:15

df <- filter(df, code2 %in% industries)


df %>% filter(code2 == 15) %>% nrow()


df_fil <- df %>% select(code1, code2, code3, r3_3, r3_1a1, r11_5ac,onGQ, offGQ, Distance_from_GQ)
df_fil <- drop_na(df_fil)

df_fil_2002 <- df_2002 %>% select(code1, code2, code3, q3191, q3121, q907c, onGQ, offGQ, Distance_from_GQ)
df_fil_2002 <- drop_na(df_fil_2002)

df_fil <- df_fil %>% mutate(Post = 1)
df_fil_2002 <- df_fil_2002 %>% mutate(Post = 0)

df_fil_2002 <- df_fil_2002 %>% rename(r3_3 = q3191)
df_fil_2002 <- df_fil_2002 %>% rename(r3_1a1 = q3121)
df_fil_2002 <- df_fil_2002 %>% rename(r11_5ac = q907c)

mean(df_fil[df_fil$onGQ == 1, "r3_3"])
mean(df_fil_2002[df_fil_2002$onGQ == 1, "r3_3"])

mean(df_fil[df_fil$offGQ == 1, "r3_3"])
mean(df_fil_2002[df_fil_2002$offGQ == 1, "r3_3"])

mean(df_fil[df_fil$onGQ == 1, "r3_1a1"])
mean(df_fil_2002[df_fil_2002$onGQ == 1, "r3_1a1"])

mean(df_fil[df_fil$offGQ == 1, "r3_1a1"])
mean(df_fil_2002[df_fil_2002$offGQ == 1, "r3_1a1"])


df_full <- bind_rows(df_fil, df_fil_2002)
df_full_non_nodal <- df_full %>% filter(!(code3 %in% nodal_cities))

gm1 <- lm(r3_3~onGQ+Post+onGQ*Post, df_full)
gm1_1 <- lm(r3_3~onGQ+Post+onGQ*Post, df_full_non_nodal)

stargazer(gm1, gm1_1, type="text")

gm2 <- lm(r3_1a1~onGQ+Post+onGQ*Post, df_full)
gm2_1 <- lm(r3_1a1~onGQ+Post+onGQ*Post, df_full_non_nodal)
stargazer(gm2, gm2_1, type="text")


gm3 <- lm(r11_5ac~onGQ+Post+onGQ*Post, df_full)
gm3_1 <- lm(r11_5ac~onGQ+Post+onGQ*Post, df_full_non_nodal)
stargazer(gm3, gm3_1, type="text")

mean(df_full_non_nodal[df_full_non_nodal$Post == 1 & df_full_non_nodal$onGQ == 1, "r11_5ac"])

install.packages("Hmisc")
library(Hmisc)

labels_df <- data.frame(
  Column = names(a),
  Label = sapply(a, function(x) label(x))
)
print(labels_df)



# r3_1a1 / q3121 - No. of years in business with main input supplier
# r3_3 / q3191 - No. of years in business with input
# r11_5ac / q907c - transportation as obstacle