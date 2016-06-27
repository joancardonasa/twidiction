library(e1071)
library(dplyr)

setwd("C:/Users/Joan/Desktop/TFG") # per casa
#setwd("C:/Users/jcardons/Desktop/TFG_fe")

data <- read.csv("data_apple.csv")

data <- select(data, X, pos, neg, Open, High, Low, Close)
data <- tbl_df(data)


data_twitter <- data[1:43,2:3]
data_stock <- data[17:59,4:7]
data <- cbind(data_twitter, data_stock)
data <- tbl_df(data)

answers <- as.matrix(data[36:43,6]) # this is what we want to predict


x_tr <- as.matrix(data[1:35,1:5])
y_tr <- as.matrix(data[1:35,6])

model <- svm(x_tr, y_tr) # model with training data, svr

x_tst <- as.matrix(data[36:43,1:5])

y_tst <- as.matrix(predict(model, x_tst))

answers_2 <- vector()
y_tst_2 <- vector()

answers_2[1] <- y_tr[35]
y_tst_2[1] <- y_tr[35]

answers_2[2:9] <- answers
y_tst_2[2:9] <- y_tst

plot(x = 1:35, y_tr[1:35,1], type = "l", xlim=c(0,43), ylim=c(100,115))
par(new = T)
plot(x = 35:43, answers_2, type = "l", xlim=c(0,43), col = 'blue',ylim=c(100,115))
par(new = T)
plot(x = 35:43, y_tst_2, type = "l", xlim=c(0,43), col = 'red',ylim=c(100,115))

