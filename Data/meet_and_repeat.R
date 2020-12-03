# Salla Veijonaho, 3.12.2020
# Exercise 6: Data wrangling


#Reading the data sets
BPRS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", sep  =" ", header = T)
rats <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", header = T)

#Opening packages neede for this exercise
library(dplyr)
library(tidyr)

#Checking the data

#BPRS
colnames(BPRS)
str(BPRS)
summary(BPRS)

#There are 40 obs. of 11 variables. 
#The data set seems to contain information of some medical treatments.
#BPRS is brief word for  the brief psychiatric rating scale that assesses the level of 18 symptom constructs 
#The variables are named as treatment (every one belongs either treatment group 1 or 2), subject (patient ID) and week0-week8

#rats
colnames(rats)
str(rats)
summary(rats)

#there are 16 od. of 13 variables
#The data set contains information from a nutrition study conducted in three groups of rats.
#The groups were put on different diets, and each rats' body weight (grams) was recorded repeatedly over a 9-week period.

#Converting the categorical variables of both data sets to factors.
# The data BPRS is available

# Factor treatment & subject for BPRS
BPRS$treatment <- factor(BPRS$treatment)
BPRS$subject <- factor(BPRS$subject)

# Factor treatment & subject for rats
rats$ID <- factor(rats$ID)
rats$Group <- factor(rats$Group)

# Converting the data sets to long form.

# Adding a week variable to BPRS 
# Converting to long form
BPRSL <-  BPRS %>% gather(key = weeks, value = bprs, -treatment, -subject)

# Extracting the week number
BPRSL <-  BPRSL %>% mutate(week = as.integer(substr(weeks,5,5)))

# Taking a glimpse at the BPRSL data 
glimpse(BPRSL)
#There are #360 rows, 5 columns

# Adding a time variable to rats.
# Converting to long form
ratsl <-  rats %>% gather(key = WDs, value = rats, -ID, -Group)

# Extracting the week number
ratsl <-  ratsl %>% mutate(time = as.integer(substr(WDs,3,4)))

# Taking a glimpse at the ratsl data 
glimpse(ratsl)
#There are 176 rows, 5 columns

# Checking the data sets

str(BPRSL)
str(ratsl)

summary(BPRSL)
summary(ratsl)

# Thanks to log form, all the BPRS measurements are now in one column instead of separate columns for each week.
# The same thing with rats data in log form, the weight measurements in all time points are now in a same column.
# The new variables "weeks" and "time" tell us the time point of each measurements

#Saving the new data sets
write.table(BPRSL, file = "BPRSL.txt", sep="\t")
write.table(ratsl, file = "RATSL.txt", sep="\t")
