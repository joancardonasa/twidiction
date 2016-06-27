# Join two datasets and make the FINAL DATASET

library(dplyr)
setwd("C:/Users/Joan/Desktop/TFG")

twitter <- read.table("twitter.csv", header = T, sep = ";")
twitter_iphone <- read.csv("dataset_apple.csv", header = T, sep = ";")

djia <- read.table("djia.csv", header = T, sep = ",")
apple <- read.table("table_djia_apple.csv", header = T, sep = ",")

## -- DJIA stock

djia$Date <- as.Date(djia$Date,"%m/%d/%Y")
djia$Date <- format(djia$Date, "%d/%m/%y")

twitter$Date <- as.Date(twitter$Date,"%d/%m/%Y")
twitter$Date <- format(twitter$Date, "%d/%m/%y")

twitter$Date <- as.character(twitter$Date)
djia$Date <- as.character(djia$Date)

data <- full_join(twitter, djia, by = "Date")

# -- Apple stock

apple$Date <- as.Date(apple$Date, "%Y-%m-%d")
apple$Date <- format(apple$Date, "%d/%m/%y")

twitter_iphone$Date <- as.Date(twitter_iphone$Date,"%d/%m/%Y")
twitter_iphone$Date <- format(twitter_iphone$Date, "%d/%m/%y")

twitter_iphone$Date <- as.character(twitter_iphone$Date)
apple$Date <- as.character(apple$Date)

data_apple <- full_join(twitter_iphone, apple, by = "Date")


# for approximating NA values:

data_warner[n,6:11] <- data_warner[n-1,6:11]+data_warner[n+2,6:11]
data_warner[n+1,6:11] <- data_warner[n,6:11]+data_warner[n+2,6:11]