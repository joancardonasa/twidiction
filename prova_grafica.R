setwd("C:/Users/Joan/Desktop/TFG")

library(forecast)
library(lmtest)
library(ggplot2)

#data <- read.csv("dataset.csv")
data <- read.csv("data_apple.csv")

day <- data$day
positive <- data$pos # data$positive if it's the original dataset.csv
djia <- data$Close

clod <- diff(djia)
posd <- diff(positive)

clodnorm <- (clod - mean(clod))/sd(clod)
posdnorm <- (posd - mean(posd))/sd(posd)

clodnorm_p <- clodnorm[8:59]
posdnorm_p <- posdnorm[1:52]

clodnorm_p2 <- clodnorm[17:59]
posdnorm_p2 <- posdnorm[1:44]

clodnorm_p3 <- clodnorm[9:59]
posdnorm_p3 <- posdnorm[1:51]

par(mfrow=c(1,1))

#plot(clodnorm_p2, type = 'l',ylim = c(-3,3), xlim = c(0,44))
#par(new = T)
#plot(posdnorm_p2, type='l', col = "red", xlim = c(0,44), ylim = c(-3,3),ylab='', xlab ='')

#plot(clodnorm_p[40:52], type = 'l',ylim = c(-3,3), xlim = c(0,12))
#par(new = T)
#plot(posdnorm_p[40:52], type='l', col = "red", xlim = c(0,12), ylim = c(-3,3),ylab='', xlab ='')

## Aixi queda perfecte

#plot(clodnorm_p[40:52], type = 'l',ylim = c(-3,3), xlim = c(0,12))
#par(new = T)
#plot(posdnorm_p[40:52], type='l', col = "red", xlim = c(0,12), ylim = c(-3,3),ylab='', xlab ='')

# MILLOR REPRESENTACIÓ
#plot(clodnorm_p2[23:36], type = 'l',ylim = c(-3,3), xlim = c(0,13))
#par(new = T)
#plot(posdnorm_p2[23:36], type='l', col = "red", xlim = c(0,13), ylim = c(-3,3),ylab='', xlab ='')

# APPLE DATA ----------------------

#plot(clodnorm_p3, type = 'l',ylim = c(-3,3), xlim = c(0,44))
#par(new = T)
#plot(posdnorm_p3, type='l', col = "red", xlim = c(0,44), ylim = c(-3,3),ylab='', xlab ='')

# Millor repreentacio per apple iphone:
plot(clodnorm_p3[34:45], type = 'l',ylim = c(-3,3), xlim = c(0,11))
par(new = T)
plot(posdnorm_p3[34:45], type='l', col = "red", xlim = c(0,11), ylim = c(-3,3),ylab='', xlab ='')


