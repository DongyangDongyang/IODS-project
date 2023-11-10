# Author: Dongyang Yu
# Date: 2023-11-07
# Description: This script is for Assignment 2, data wrangling
# Data source: http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt



# read the data into memory
lrn14 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)

# Look at the structure of the data
str(lrn14)
# Look at the dimensions of the data
dimesions <- dim(lrn14)
dimensions
# The data have 183 observations and 60 variables, namely, 183 rows and 60 columns
# For the types of data, most of them are integer except the variable "gender" are character
# We can also check the name of variables and the first few values of each variable in the structure function

# divide each number in a vector
c(1,2,3,4,5) / 2

# print the "Attitude" column vector of the lrn14 data
lrn14$Attitude

# divide each number in the column vector
lrn14$Attitude / 10

# create column 'attitude' by scaling the column "Attitude"
lrn14$attitude <- lrn14$Attitude / 10

# Access the dplyr library
library(dplyr)

# questions related to deep, surface and strategic learning
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")

# select the columns related to deep learning 
deep_columns <- select(lrn14, one_of(deep_questions))
# and create column 'deep' by averaging
lrn14$deep <- rowMeans(deep_columns)

# select the columns related to surface learning 
surface_columns <- select(lrn14, one_of(surface_questions))
# and create column 'surf' by averaging
lrn14$surf <- rowMeans(surface_columns)

# select the columns related to strategic learning 
strategic_columns <- select(lrn14, one_of(strategic_questions))

# and create column 'stra' by averaging
lrn14$stra <- rowMeans(strategic_columns)

# choose a handful of columns to keep
keep_columns <- c("gender","Age","attitude", "deep", "stra", "surf", "Points")

# select the 'keep_columns' to create a new dataset
learning2014 <- select(lrn14, one_of(keep_columns))

# see the structure of the new dataset
str(learning2014)

# change column name "Points" to "points"
learning2014 <- learning2014 %>% 
  rename(points = Points)

# select rows where points is greater than zero
learning2014 <- learning2014 %>% 
  filter(points > 0)

# Look at the dimensions of the data
str(learning2014)

# Load the readr package (if not already loaded)
library(readr)

# Specify the file path to save the dataset in the 'data' folder
file_path <- "data/learning2014.csv"

# Save the dataset as a CSV file
write_csv(learning2014, file_path)

# Read the dataset from the 'data' folder
read_data <- read_csv(file_path)

# Check the structure
str(read_data)

# View the first few rows
head(read_data)







