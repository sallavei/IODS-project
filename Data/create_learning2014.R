# Salla Veijonaho, 2.11.2020
# Exercise 2: Data wrangling



#Phase 2

# reading the data
data <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)

# Looking at the dimensions of the data
dim(data)

# Looking at the structure of the data
str(data)

# Comments on phase 2: My explorations show that there are 183 ods. and 60 variables in the data. 56 of the variables are measured with 1 to 5 Likert-scales. Age, attitude and Points variables are measured with running numbers and gender is written down with characters.



#Phase 3

#installing and opening the needed tool package.
install.packages("dplyr")
library(dplyr)

#creating sum variables out of attitude, deep, stra and surf

# questions related to deep, surface and strategic learning
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30", "D06",  "D15", "D23", "D31")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")
attitude_questions <- c("Da","Db","Dc","Dd","De","Df","Dg","Dh","Di","Dj")

# selecting the columns related to deep learning and create column 'deep' by averaging
deep_columns <- select(data, one_of(deep_questions))
data$deep <- rowMeans(deep_columns)

# selecting the columns related to surface learning and create column 'surf' by averaging
surface_columns <- select(data, one_of(surface_questions))
data$surf <- rowMeans(surface_columns)

# selecting the columns related to strategic learning and create column 'stra' by averaging
strategic_columns <- select(data, one_of(strategic_questions))
data$stra <- rowMeans(strategic_columns)

# selecting the columns related to strategic learning and create column 'attitude' by averaging
attitude_columns <- select(data, one_of(attitude_questions))
data$attitude <- rowMeans(strategic_columns)

# choosing a handful of columns to keep
keep_columns <- c("gender","Age","attitude","deep","stra","surf","Points")

# selecting the 'keep_columns' to create a new dataset
learning2014 <- select(data, one_of(keep_columns))

#Excluding observations where the exam points variable is zero
learning2014 <- filter(learning2014, Points > 0)
learning2014 <- filter(learning2014, surf > 0)
learning2014 <- filter(learning2014, deep > 0)
learning2014 <- filter(learning2014, attitude > 0)

# checking the structure of the new dataset
str(learning2014)



#Phase 4

#setting the working directory
WD <- getwd("C:/LocalData/sallavei/IODS-project")
setwd(WD)

#Creating csv-file out of the new data set
WD2 <- getwd("C:/LocalData/sallavei/IODS-project/Data")
setwd(WD2)
write.csv(learning2014, file = "learning2014.csv")

#reading learning2014.csv
library(readr)
learning2014 <- read_csv("learning2014.csv")
View(learning2014)