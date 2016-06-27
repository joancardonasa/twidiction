library(e1071)
library(dplyr)
library(ggplot2)

setwd("C:/Users/Joan/Desktop/TFG")

data <- read.csv("data.csv")

data <- select(data, day, day_p_sc, day_n_sc, value)

data$day <- as.Date(data$day)

p <- ggplot(data, aes(day, value))
p <- p + geom_line(colour = "blue", size = 1.2)
print(p)

answers <- data[36:45,4] # this is what we want to predict

day <- data$day

x_tr <- as.matrix(data[1:35,2:3])
y_tr <- as.matrix(data[1:35,4])

model <- svm(x_tr, y_tr) # model with training data, svr

x_tst <- as.matrix(data[36:45,2:3])

y_tst <- as.vector(predict(model, x_tst))

y_test <- data$value 

k <- 00 # if we add 600 we get more or less good results

y_test[36:45] <- y_tst + k

p <- ggplot(data, aes(day, y = value, color = variable))
p <- p + geom_line(aes(y = value, col = "real"), size = 2) + geom_line(aes(y = y_test + 0, col = "predicted"), size = 1)
print(p)

aux_1 <- data$value[35:45]
aux_2 <- y_test[35:45]

vec_ten <- vector()

for(i in 1:length(aux_1)){
  if(aux_1[i+1] > aux_1[i]){
    vec_ten[i] <- 1
  } else {
    vec_ten[i] <- -1
  }
    
}
  
  