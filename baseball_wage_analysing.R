# Data : http://eclr.humanities.manchester.ac.uk/index.php/R
library(tidyverse)
mydata <- read.csv("/Users/sejin/Downloads/Mlb1.csv")

# To confirm that each player is only assigned one position we calculate the following;
temp <- rowSums(mydata[,c("frstbase", "scndbase", "shrtstop", "thrdbase", "outfield", "catcher")])
min(temp)
max(temp)

# To create two variables ("position" and "race) which summarise the respective information in one variable each
mydata$position <- "First Base"
mydata$position[mydata$scndbase == 1] <- "Second Base"
mydata$position[mydata$thrdbase == 1] <- "Third Base"
mydata$position[mydata$outfield == 1] <- "Outfield"
mydata$position[mydata$catcher == 1] <- "Catcher"
mydata$position <- as.factor(mydata$position)

mydata$race <- "White"
mydata$race[mydata$hispan == 1] <- "Hispanic"
mydata$race[mydata$black == 1] <- "Black"
mydata$race <- as.factor(mydata$race)

# Quick summary for "Salary" data frame
summary(mydata$salary)
summary(mydata$position)

max(mydata$salary)
median(mydata$salary)
mean(mydata$salary)
sd(mydata$salary)
var(mydata$salary)

# Pivot using group_by
mydata %>% group_by(position) %>% summarise(mean(salary))
mydata %>% group_by(position) %>% summarise(number = length(salary), avg.salary = mean(salary))

mydata %>% group_by(black) %>% summarise(length(salary), mean(salary))
mydata %>% group_by(hispan) %>% summarise(length(salary), mean(salary))
mydata %>% group_by(race) %>% summarise(length(salary), mean(salary))

# filter
mydata %>% filter(yrsallst == 0) %>% group_by(position) %>% summarise(number = length(salary), avg.salary = mean(salary))
mydata %>% filter(yrsallst > 0) %>% group_by(position) %>% summarise(number = length(salary), avg.salary = mean(salary))

# arrange
mydata %>% filter(yrsallst == 0) %>% group_by(position) %>% summarise(number = length(salary), avg.salary = mean(salary)) %>% arrange(avg.salary)

# Double Pivot 
mydata %>% group_by(position, race) %>% summarise(avg.salary = mean(salary))

# spread & arrange
mydata %>% group_by(position, race) %>% summarise(avg.salary = mean(salary)) %>% spread(race, avg.salary)

mydata$AS <- (mydata$yrsallst > 0) # as = all star
mydata %>% group_by(AS, position, race) %>% summarise (avg.salary = mean(salary)) %>% spread(race, avg.salary) %>% arrange(AS)
