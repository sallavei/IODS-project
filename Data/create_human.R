# Salla Veijonaho, 19.11.2020
# Exercise 4: Data wrangling

# Reading the data sets

hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/hd_gii_development.csv", stringsAsFactors = F)
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")


# Let's start with hd

# Looking at the dimensions of the data
dim(hd)
# Looking at the structure of the data
str(hd)
#summary of the data
summary(hd)

# There are 195 obs. of  8 variables.


#Next the same with gii

# Looking at the dimensions of the data
dim(gii)
# Looking at the structure of the data
str(gii)
#summary of the data
summary(gii)

#There are 195 obs. of  10 variables in gii data set


#Renaming the variables

colnames(hd)

# chaninge the name of the colums
colnames(hd)[1] <- "hdi.r"
colnames(hd)[2] <- "ctry"
colnames(hd)[3] <- "hdi"
colnames(hd)[4] <- "life.exp"
colnames(hd)[5] <- "exp.edu"
colnames(hd)[6] <- "m.edu"
colnames(hd)[7] <- "gni"
colnames(hd)[8] <- "gni.hdi"

#Renaming the variables

colnames(gii)

# changing the name of the colums
colnames(gii)[1] <- "gii.r"
colnames(gii)[2] <- "ctry"
colnames(gii)[3] <- "gii"
colnames(gii)[4] <- "mmr"
colnames(gii)[5] <- "b.rate"
colnames(gii)[6] <- "rep.parl"
colnames(gii)[7] <- "n.2edu.f"
colnames(gii)[8] <- "n.2edu.m"
colnames(gii)[9] <- "lfpr.f"
colnames(gii)[10] <- "lfpr.m"

#Mutating "Gender inequality" data and creating two new variables
# the ratio of female and male population in secondary education in each country
gii <- mutate(gii, fmedu = n.2edu.f / n.2edu.m)
# the ratio of labour force participation of females and males in each country
gii <- mutate(gii, fmlfp = lfpr.f / lfpr.m)


# joining the data sets
library(dplyr)
human <- inner_join(hd, gii, by = "ctry", suffix = c(".gii", ".hd"))
dim(human)
str(human)

# saving the data set as csv file 
write.table(human, file = "human.csv", sep = ",")


