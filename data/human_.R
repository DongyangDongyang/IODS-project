# Author: Dongyang Yu
# Date: 2023-11-28
# Description: This script is for Assignment 5, data wrangling
# The 'human' dataset originates from the United Nations Development Programme, https://hdr.undp.org/data-center/human-development-index#/indicies/HDI


# Explore the data (Task 1)
# read data
library(readr)
human <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/human1.csv")

# the structure and dimensions of data
str(human)
dim(human)
# Human data set has 195 observations and 19 variables. All variables except "Country" are numeric type.

# Exclude unneeded variables (Taks 2)

library(dplyr)

# columns to keep
keep <- c("Country", "Edu2.FM", "Labo.FM", "Life.Exp", "Edu.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F")

# select the 'keep' columns
human <- select(human, one_of(keep))

# print out a completeness indicator of the 'human' data
comp <- complete.cases(human)

# Remove missing values (Task 3)

# filter out all rows with NA values
human_ <- filter(human, comp) 
human <- filter(human, complete.cases(human))

# Exclude observations (Task 4)

# look at the last 10 observations of human
tail(human, 10)

# define the last indice we want to keep
last <- nrow(human) - 7

# choose everything until the last 7 observations
human_ <- human[1:last,]
str(human_)
# human_ data set has 155 observations and 9 variables.



