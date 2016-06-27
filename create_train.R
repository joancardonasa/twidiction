# Sript that generates the data for the training model: First attempt m = 45

library(dplyr)
setwd("C:/Users/Joan/Desktop/TFG")

day_vector <- Sys.Date() - 48:4

data <- read.csv("train_pos_neg.csv")

data <- select(data, day_n_sc, day_p_sc)

data$day <- day_vector # we now have a dataset of 45 observations and 3 variables

# we need the output, the closing prices of DJIA

djia <- read.csv("DJIA.csv")

djia$DATE <- as.Date(djia$DATE)

colnames(djia) <- c("day", "value")

data <- full_join(data, djia, by = "day")

data$value <- as.numeric(as.character(data$value))

# as we can see, we don't have DJIA values for every day, so we must give an approximation:

# We'll use the one used in (Mittal, Goel) under the premise that the stock follows a concave function

# like: data$value[4] <- (data$value[3] + data$value[6])/2

for(i in 1:length(data$value)){
  
  if(is.na(data$value[i])){
    k <- sum(is.na(data$value[i:i+2])) ## gotta change this, it's not doing exactly what we want
    data$value[i] <- (data$value[i-1] + data$value[i+3])/2
  
  }
  
}



# let's prepare this data for the model:

data[1:11,1:2] <- data[1:11,1:2]/40000 # 40000 tweets

data[12:45,1:2] <- data[12:45,1:2]/20000 # 20000 tweets

write.csv(data, file = "data.csv")