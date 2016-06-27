library(e1071)
library(dplyr)

setwd("C:/Users/Joan/Desktop/TFG") # PER CASA
#setwd("C:/Users/jcardons/Desktop/TFG_fe") # PER FEINA

data <- read.csv("dataset.csv")

data <- select(data, day, positive, negative, Open, High, Low, Close)
data <- tbl_df(data)

# Define the LAG

lag <- 16

data_twitter <- data[1:(59-lag),2:3]
data_stock <- data[(lag+1):59,4:7]
data <- cbind(data_twitter, data_stock)
data <- tbl_df(data)

answers <- as.matrix(data[(ceiling(0.8*(59-16))+1):(59-lag),6]) # this is what we want to predict


x_tr <- as.matrix(data[1:(ceiling(0.8*(59-16))),1:5])
y_tr <- as.matrix(data[1:(ceiling(0.8*(59-16))),6])

model <- svm(x_tr, y_tr) # model with training data, svr

x_tst <- as.matrix(data[36:(59-lag),1:5])

y_tst <- as.matrix(predict(model, x_tst))

answers_2 <- vector()
y_tst_2 <- vector()

answers_2[1] <- y_tr[ceiling(0.8*(59-16))]
y_tst_2[1] <- y_tr[ceiling(0.8*(59-16))]

answers_2[2:9] <- answers
y_tst_2[2:9] <- y_tst

plot(x = 1:35, y_tr[1:35,1], type = "l", xlim=c(0,43), ylim=c(16500,18000))
par(new = T)
plot(x = 35:43, answers_2, type = "l", xlim=c(0,43), col = 'blue',ylim=c(16500,18000))
par(new = T)
plot(x = 35:43, y_tst_2, type = "l", xlim=c(0,43), col = 'red',ylim=c(16500,18000))
  
  