# Data: http://eclr.humanities.manchester.ac.uk/index.php/R_Analysis

setwd("/Users/sejin/Documents/R/Analysis")
mydata <- read.csv("mroz.csv", na.strings = ".")

# Summary stats for all variables in dataset
summary(mydata)
cor(mydata)

# Dealing with Missing values
cor(mydata[c("educ", "wage")])
cor(mydata[c("educ", "wage")], use = "complete")

# Summary stats for selected variables
## Option 1
summary(mydata[c("hours", "husage")])
cor(mydata[c("educ", "motheduc", "fatheduc")])

## Option 2 using subsets
mydata.sub0 <- subset(mydata, select = c("hours", "husage"))
summary(mydata.sub0)
cor(mydata.sub0)

# Using subsets of data
mydata.sub1 <- subset(mydata, hours > 0)
cor(mydata.sub1[c("educ", "wage")])

mydata.sub1 <- subset(mydata, hours > 0, select = c("educ", "wage"))
cor(mydata.sub1)

# More summary stats
## Categorical variables
library(mosaic)
tally(~kidslt6, data = mydata, margins = TRUE)
tally(~kidslt6, data = mydata, margins = TRUE, format = "perc")
tally(~kidslt6, data = mydata, margins = TRUE, format = "prop")

## Contingency tables
tally(~kidsge6 + kidslt6, data = mydata, margins = TRUE)

## Conditional table
tally(~kidsge6 | educ >= 16, data = mydata, margins = TRUE, format = "prop")

## Continuous vaiables
mean(~wage, data = mydata, na.rm=TRUE)

favstats(~wage, data = mydata)
favstats(~educ, data = mydata)

### Apply this to several variables
mydata.sub2 <- subset(mydata, select = c("hours", "husage", "wage", "huswage"))
dfapply(mydata.sub2, favstats)                      

