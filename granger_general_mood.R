# General mood - Dow Jones Industrial Average data:

setwd("C:/Users/Joan/Desktop/TFG")

library(forecast)
library(lmtest)
library(ggplot2)

data <- read.csv("dataset.csv") # General mood data

djia <- data$Close # Read data into vectors
negative <- data$negative
positive <- data$positive

both <- positive + negative

negative_n <- (negative - mean(negative))/(sd(negative)) # Normalize vectors
positive_n <- (positive - mean(positive))/(sd(positive))
djia_n <- (djia - mean(djia))/(sd(djia))

both_n <- (both - mean(both))/(sd(both))

rm(djia, positive, negative, both) # Remove unnecessary data from workspace

ddjia_n <- diff(djia_n) # We differentiate the vectors in order to obtain stationarity
dpositive_n <- diff(positive_n)
dnegative_n <- diff(negative_n)

dboth_n <- diff(both_n)

# Experiments over Positive mood values: --------
grangertest(ddjia_n ~  dpositive_n, order=16)
# lag = 16 days, p-value = 0.06447

grangertest(ddjia_n ~ positive_n[1:58], order=7)
# lag = 7 days, p-value = 0.08078

#Experiments over Negative mood values ----------
grangertest(ddjia_n ~  dnegative_n, order=15)
# lag = 15 days, p-value = 0.0789

grangertest(ddjia_n ~ negative_n[1:58], order=12)
# lag = 12 days, p-value = 0.0764

# Experiments over both combined: ---------------
grangertest(ddjia_n ~  dboth_n, order=6)
# lag = 6 days, p-value = 0.06296

grangertest(ddjia_n ~ both_n[1:58], order=5)
# lag = 5 days, p-value = 0.003241...By far the best value yet

grangertest(ddjia_n ~ both_n[1:58], order=6)
# lag = 6 days, p-value = 0.004175...Second best

# 7: 0.007075
# 8: 0.007862
# 9: 0.01537
# 10: 0.04448...

vector_1 <- vector()
vector_2 <- vector()
vector_11 <- vector()
vector_22 <- vector()
vector_111 <- vector()
vector_222 <- vector()
for(i in 1:18){
  p_val <- grangertest(ddjia_n ~  dpositive_n, order=i) 
  vector_1[i] <- p_val[2,4]
  r_val <- grangertest(ddjia_n ~ positive_n[1:58], order=i)
  vector_2[i] <- r_val[2,4]
  
  pp_val <- grangertest(ddjia_n ~  dnegative_n, order=i) 
  vector_11[i] <- pp_val[2,4]
  rr_val <- grangertest(ddjia_n ~ negative_n[1:58], order=i)
  vector_22[i] <- rr_val[2,4]
  
  ppp_val <- grangertest(ddjia_n ~  dboth_n, order=i) 
  vector_111[i] <- ppp_val[2,4]
  rrr_val <- grangertest(ddjia_n ~ both_n[1:58], order=i)
  vector_222[i] <- rrr_val[2,4]
}

par(mfrow=c(3,1))

plot(vector_1, type = 'l',ylim = c(0,1), xlim = c(0,18), ylab = 'p-value', xlab = 'Lag', main = 'Prediction significance between positive mood & DJIA closing values')
par(new = T)
plot(vector_2, type = 'l',ylim = c(0,1), xlim = c(0,18), col = "red", ylab = '', xlab = '')

plot(vector_11, type = 'l',ylim = c(0,1), xlim = c(0,18), ylab = 'p-value', xlab = 'Lag', main = 'Prediction significance between negative mood & DJIA closing values')
par(new = T)
plot(vector_22, type = 'l',ylim = c(0,1), xlim = c(0,18), col = "red", ylab = '', xlab = '')

plot(vector_111, type = 'l',ylim = c(0,1), xlim = c(0,18), ylab = 'p-value', xlab = 'Lag', main = 'Prediction significance between overall mood & DJIA closing values')
par(new = T)
plot(vector_222, type = 'l',ylim = c(0,1), xlim = c(0,18), col = "red", ylab = '', xlab = '')
# make width: 800 and height: 1000


