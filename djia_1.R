# required libraries

library(dplyr)
library(ggplot2)

setwd("C:/Users/Joan/Desktop/TFG")

djia <- read.csv("DJIA.csv") #DJIA values from 1/10/2015 to 31/12/2015
djia_change <- read.csv("DJIA_change.csv") # This would be done best by computing the values (differences)

djia$VALUE <- as.numeric(as.character(djia$VALUE))
djia_change$VALUE <- as.numeric(as.character(djia_change$VALUE))

djia$VAR <- djia_change$VALUE

rm(djia_change)

# Should fill in NA's by x + y/2...

# Should plot the values too