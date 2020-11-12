#Author: Salla Veijonaho
#Date: 12.11.2020

# This script is for the data wrangling phase of exercise 3.

# Reading the datas:
setwd("~/IODS-project/Data")
mat_data <- read.csv("student-mat.csv", sep = ";", header = TRUE)
por_data <- read.csv("student-por.csv", sep = ";", header = TRUE)



# Joining the data sets using the variables "school", "sex", "age", "address", "famsize", "Pstatus", "Medu", "Fedu", "Mjob", "Fjob", "reason", "nursery","internet" as (student) identifiers.
library(dplyr)

join_by <- c("school","sex","age","address","famsize","Pstatus","Medu","Fedu","Mjob","Fjob","reason","nursery","internet")

math_por <- inner_join(mat_data, por_data, by = join_by, suffix = c(".math", ".por"))

# Checking that the joining went well
colnames(math_por)
glimpse(math_por)



# Combining the duplicated answers in the jointed data

# creating a new data frame with only the joined columns
alc <- select(math_por, one_of(join_by))

# columns that were not used for joining the data
notjoined_columns <- colnames(por_data)[!colnames(por_data) %in% join_by]

# printing out the columns not used for joining
notjoined_columns

# for every column name not used for joining...
for(column_name in notjoined_columns) {
  # selecting two columns from 'math_por' with the same original name
  two_columns <- select(math_por, starts_with(column_name))
  # selecting the first column vector of those two columns
  first_column <- select(two_columns, 1)[[1]]
  
  # if that first column  vector is numeric...
  if(is.numeric(first_column)) {
    # taking a rounded average of each row of the two columns and
    # adding the resulting vector to the alc data frame
    alc[column_name] <- round(rowMeans(two_columns))
  } else { # else if it's not numeric...
    # adding the first column vector to the alc data frame
    alc[column_name] <- first_column
  }
}

# glimpsing at the new combined data
glimpse(alc)

# Creating a new column for combined alcohol usage (based on averages of weekday and weekend alcohol consumption)
library(ggplot2)
alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)

# creating a new logical column 'high_use' which is TRUE for students for which 'alc_use' is greater than 2 (and FALSE otherwise).
alc <- mutate(alc, high_use = alc_use > 2)

# glimpsing at the modified data set to make sure everything is in order.
glimpse(alc)

# Saving the data
library(utils)
write.csv(alc, file = "alc.csv")





