# Model SVR apple iteratiu:

library(e1071)
library(dplyr)

setwd("C:/Users/Joan/Desktop/TFG") # PER CASA
#setwd("C:/Users/jcardons/Desktop/TFG_fe") # PER FEINA

data <- read.csv("data_apple.csv")

data <- select(data, X, pos, neg, Open, High, Low, Close)
data <- tbl_df(data)

data_twitter <- data[1:43,2:3]
data_stock <- data[17:59,4:7]
data <- cbind(data_twitter, data_stock)
data <- tbl_df(data)

remove(data_stock, data_twitter)

answers <- as.matrix(data[5:43,6]) # 

# We'll train on 4 days, and test on the next

var <- 39
vector_test <- vector()

for(i in 1:var){ # 
  x_tr <- as.matrix(data[(i:(i+3)),1:5]) # 4 = i+3
  y_tr <- as.matrix(data[(i:(i+3)),6])
  
  model <- svm(x_tr, y_tr)
  
  x_tst <- as.matrix(data[(i+4),1:5]) # 5 i+4
  
  y_tst <- as.matrix(predict(model, x_tst))
  vector_test[i] <- y_tst
}

## Plot system


plot(x = 1:43, data$Close, type = "l", xlim=c(0,43), ylim=c(100,115), xlab = "Day", ylab="AAPL Stock Price")
par(new = T)
plot(x = 5:43, vector_test, type = "l", xlim=c(0,43), col = 'red',ylim=c(100,115), xlab = "", ylab="")

legend(30,115, # places a legend at the appropriate place 
       
       c('Actual','Predicted'), # puts text in the legend
       
       lty=c(1,1), # gives the legend appropriate symbols (lines)
       
       lwd=c(2.5,2.5),col=c('black','red')) # gives the legend lines the correct color and width

at <- data$Close[5:43]
ft <- vector_test

mape <- 1/(length(5:43))*(sum(abs((at - ft)/at)))