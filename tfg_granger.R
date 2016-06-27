setwd("C:/Users/Joan/Desktop/TFG")

library(forecast)
library(lmtest)
library(ggplot2)

#data <- read.csv("dataset.csv")
#data <- read.csv("data_apple.csv")

# for BvS:

#data <- read.csv("data_bvs.csv") sembla que no funciona...

#day <- data$day
positive <- data$pos # data$positive if it's the original dataset.csv
djia <- data$Close

positive_n <- (data$pos - mean(data$pos))/(sd(data$pos))
djia_n <- (data$Close - mean(data$Close))/(sd(data$Close))

attach(data)

par(mfrow=c(1,1))

plot.ts(djia_n)
plot.ts(positive_n)


ndiffs(djia_n, alpha=0.05, test='kpss') ## es 1: cal derivar

ndiffs(positive_n, alpha=0.05, test='kpss') ## no cal derivar: es 0

ddjia_n <- diff(djia_n) # per fer-los estacionaris

dpositive_n <- diff(positive_n)

plot.ts(ddjia_n)
par(new = T)
plot.ts(dpos_n)



#p <- ggplot(data, aes(1:8, y = positive_n[1:8], color = variable))
#p <- p + geom_line(aes(y = positive_n[1:8], col = "Twitter"), size = 2) + geom_line(aes(y = ddjia_n[8:15] , col = "DJIA"), size = 2)
#print(p)

#plot(1:52, dpos_n[1:52], type='l', xlim = c(0,60), ylim = c(-2,2), ylab='Twitter/DJIA normalizados', xlab ='Día') 
#par(new = T)
#plot(1:52, ddjia_n[8:59], type='l', col = "red", xlim = c(0,60), ylim = c(-2,2),ylab='', xlab ='') 

## PROVES GRANGER TEST

#grangertest(ddjia_n ~ positive[1:58], order=7)

# P-VALUE: 0,08078

#grangertest(ddjia_n ~  dpos_n, order=16)

# P-VALUE: 0,06447

