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






# Salla Veijonaho, 23.11.2020
# Exercise 5: Data wrangling

#Just in case there is something wrong with the data wrangling I did last week, I'll read the ready made data for this part.
human1 <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human1.txt", sep = ",")

#Checking the data
dim(human1)
str(human1)

#The data includes 195 obs. of 19 variables.
#The data combines several indicators from most countries in the world.
#The variables measure phenomena related to health & knowledge and gender empowerment
#The orginal data from: http://hdr.undp.org/en/content/human-development-index-hdi

#Mutating GNI variable
library(stringr)

# looking at the structure of the GNI column in 'human'
str(human1$GNI)

# removing the commas from GNI and print out a numeric version of it
str_replace(human1$GNI, pattern=",", replace ="") %>% as.numeric

#Excluding unneeded variables
library(dplyr)

keep <- c("Country", "Edu2.FM", "Labo.FM", "Life.Exp", "Edu.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F")
human1 <- select(human1, one_of(keep))
complete.cases(human1)

#Removing all rows with missing values 

# Printing out the data along with a completeness indicator as the last column
data.frame(human1[-1], comp = complete.cases(human1))

# filtering out all rows with NA values
human_ <- filter(human1, complete.cases(human1))

#checking that everything is ok
data.frame(human_[-1], comp = complete.cases(human_))

#Removing the observations which relate to regions instead of countries.

#Checking out the last 10 obs. in the data set
tail(human1, 10)

#looks like the last 7 obs. are not countries and they need to be removed.
last <- nrow(human1) - 7
human_ <- human1[1:last, ]

# adding countries as row names
rownames(human1) <- human1$Country

#removing country name column from the data
human_ <- select(human1, -Country)

#Checking the data before saving
dim(human_)

#Saving the new data set by over writing the odl one.
write.table(human_, file = "human.csv", sep = ",")

