# First neural net

#library(neuralnet)
setwd("C:/Users/Joan/Desktop/TFG")
library(dplyr)
data <- read.csv("dataset.csv")

data <- select(data, positive, negative, neutral, Open, High, Low, Close)# SELECT TAMBE ES DE NEURAL NET!!!!

y <- as.numeric(data$Close[2:length(data$Close)] > data$Close[1:(length(data$Close) - 1)])



#data$y <- 1:59
#data$y[2:59] <- y # output variable

data <- scale(data) # normalization
# m = 59, n = 7 + 1 output

output <- vector(length = 59)
output[1] <- 1 # del 16/2 al 17/2 subió 300
output[2:59] <- y

data <- cbind(data, output)

summa <- 0

var <- 39 #39 iterations

k <- 15
l <- 4

# Primero intento, sin hacer el lag de 16 dias
library(neuralnet)
for(i in 1:var){
  train <- data[(i):(i+k),1:8] #feature dataset
  test <- data[(i+k+1):(i+k+1+l),1:7]
  answers <- data[(i+k+1):(i+k+1+l),8]
  
  # do the algorithm
  
  net <- neuralnet(output ~ positive + negative + neutral + Open + High + Low + Close, train, 
                   hidden = 7, 
                   lifesign = "minimal", 
                   linear.output = FALSE, threshold = 0.1) # this trains the model
  

  
  results <- compute(net, test)
  
  results_fin <- data.frame(actual = answers, prediction = results$net.result)
  
  # cada iteració de les 39 té 5 proves -> 39 * 5 = 195. La suma d'encerts es divideix entre 195
  # ara 49 *2 
  
  results_fin$prediction <- round(results_fin$prediction)
  
  summa <- summa + sum(results_fin[,1] == results_fin[,2])
  
}

detach(package:neuralnet)
detach(package:dplyr)

print(summa/195)
# summa/195 = 0,67