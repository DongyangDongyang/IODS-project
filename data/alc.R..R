# Author: Dongyang Yu
# Date: 2023-11-20
# Description: This script is for Assignment 3, data wrangling



# set the working directory
setwd("D:\\做一个合格的博士\\Courses\\Open Data\\IODS-project\\data")

# read two csv files 
student_mat <- read.csv("student-mat.csv")
student_por <- read.csv("student-por.csv")

# structure of the data
str(student_mat)
str(student_por)

# Dataset student_mat has 396 observations and 1 variable.Dataset student_por has 649 observations and 1 variable. 
# we can check the name of varibales and first few values of variables.

# dimensions of the data
dim(student_mat)
dim(student_por)
# Dataset student_mat has 396 observations and 1 variable.Dataset student_por has 649 observations and 1 variable.
# The type of two data set variables are both character.

# access the dplyr package
library(dplyr)

# give the columns that vary in the two data sets
free_cols <- c("failures","paid","absences","G1","G2","G3")

# the rest of the columns are common identifiers used for joining the data sets
join_cols <- setdiff(colnames(por), free_cols)

# join the two data sets by the selected identifiers
math_por <- inner_join(math, por, by = join_cols, suffix = c(".math", ".por"))

# look at the column names of the joined data set
colnames(math_por)

# glimpse at the joined data set
glimpse(math_por)
str(math_por)
dim(math_por)
# Joined data set has 370 observations and 39 variables.The data type now are characters or integers. 


### 3.3 Get rid of the duplicate records in the joined data set
# print out the column names of 'math_por'
colnames(math_por)

# create a new data frame with only the joined columns
alc <- select(math_por, all_of(colnames(join_cols)))

# print out the columns not used for joining (those that varied in the two data sets)
cat("Columns not used for joining:", free_cols, "\n")

# for every column name not used for joining...
for(col_name in free_cols) {
  # select two columns from 'math_por' with the same original name
  two_cols <- select(math_por, starts_with(col_name))
  # select the first column vector of those two columns
  first_col <- select(two_cols, 1)[[1]]
  
  # then, enter the if-else structure!
  # if that first column vector is numeric...
  if(is.numeric(first_col)) {
    # take a rounded average of each row of the two columns and
    # add the resulting vector to the alc data frame
    alc[col_name] <- round(rowMeans(two_cols))
  } else { # else (if the first column vector was not numeric)...
    # add the first column vector to the alc data frame
    alc[col_name] <- first_col
  }
}

# glimpse at the new combined data
glimpse(alc)

### creat a new column alc_use
# access the tidyverse packages dplyr and ggplot2
library(dplyr); library(ggplot2)

# define a new column alc_use by combining weekday and weekend alcohol use
alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)

# define a new logical column 'high_use'
alc <- mutate(alc, high_use = alc_use > 2)

# glimpse at the alc data
glimpse(alc)

# Load the readr package (if not already loaded)
library(readr)

# set the working directory
setwd("D:\\做一个合格的博士\\Courses\\Open Data\\IODS-project\\data")

# save the joined and modified data
write_csv(alc, "alc.csv")

