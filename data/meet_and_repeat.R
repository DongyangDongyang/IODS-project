
library(dplyr)
library(tidyr)

# Read data (Task 1)
BPRS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", sep =" ", header = T)
RATS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", header = TRUE, sep = '\t')

# Explore BPRS data
str(BPRS)
dim(BPRS)
colnames(BPRS)
summary(BPRS)
# BPRS data has 40 observations and 11 variables. The data are all integer.

# Explore RATS data
str(RATS)
dim(RATS)
colnames(RATS)
summary(RATS)
# RATS data set has 16 observations and 13 variables. The data are int.

# Convert categorical variables to factors (Task 2)
# Factor variables treatment and subject
BPRS$treatment <- factor(BPRS$treatment)
BPRS$subject <- factor(BPRS$subject)

# Factor variables ID and Group
RATS <- RATS %>%
  mutate(ID = factor(ID),
         group = factor(Group))

# Convert the data sets to long form. Add a week variable to BPRS and a Time variable to RATS (Task 3)
# Convert to long form (BPRS)
BPRSL <-  pivot_longer(BPRS, cols = -c(treatment, subject),
                       names_to = "weeks", values_to = "bprs") %>%
  arrange(weeks)

# Convert to long form (RATS)
RATSL <- pivot_longer(RATS, cols = -c(ID, Group), 
                      names_to = "WD",
                      values_to = "weight") %>% 
         mutate(Time = as.integer(substr(WD, 3, 4))) %>%
         arrange(Time)

# Check new data sets (Task4)
# Check BPRSL
colnames(BPRSL)
View(BPRSL)
str(BPRSL)
dim(BPRSL)
summary(BPRSL)
# BPRSL has 360 observations and 4 variables, treatment, subject, weeks and bprs.

#Check RATSL
colnames(RATSL)
View(RATSL)
str(RATSL)
dim(RATSL)
summary(RATSL)
# RATSL has 176 observations and 5 variables, ID, Group, WD, weight and Time.



