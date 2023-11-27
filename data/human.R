# Author: Dongyang Yu
# Date: 2023-11-25
# Description: This script is for Assignment 4, data wrangling


# read data set (Task 2)
library(readr)
hd <- read.csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/human_development.csv")

gii <- read.csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/gender_inequality.csv", na = "..")

# explore the data (Task 3)
str(hd)
dim(hd)
summary(hd)

# hd data set has 195 observations and 8 variables, the types of data are integer, numeric and character.
str(gii)
dim(gii)
summary(gii)
colnames(gii)
# gii data set has 195 observations and 10 variables, the tyeps of data are ineger, numeric and character.

# Rename the variable name (Task 4)
# rename hd data set variable name
new_names_hd <- c("HDI_rank", "Country", "HDI", "Life_exp", "Edu_exp", "Edu_mean", "GNI", "General_rank")
colnames(hd) <- new_names_hd

# rename gii data set varibale name
new_names_gii <- c("GII_rank", "Country", "GII", "Mat_mor", "Ado_birth", "Parli", "Edu2_F", "Edu2_M", "Labo_F", "Labo_M")
colnames(gii) <- new_names_gii

# Mutate data and create two new variables (Task 5)
library(dplyr)
gii <- gii %>%
  mutate(Edu2_FM = Edu2_F / Edu2_M,
         Labo_FM = Labo_F / Labo_M) 
gii

# Join together the two datasets using the variable Country as the identifier (Task 6)
human <- inner_join(hd, gii, by = "Country")
dim(human)
# The joined data has 19 variables and 195 observations.

# set the working directory
setwd("D:\\做一个合格的博士\\Courses\\Open Data\\IODS-project\\data")

# save the joined and modified data
write_csv(human, "human.csv")

