# iPhone users mood - AAPL stock data:

setwd("C:/Users/Joan/Desktop/TFG")

library(forecast)
library(lmtest)
library(ggplot2)

data <- read.csv("data_apple.csv") # General mood data

aapl <- data$Close # Read data into vectors
negative <- data$neg
positive <- data$pos

both <- positive + negative

negative_n <- (negative - mean(negative))/(sd(negative)) # Normalize vectors
positive_n <- (positive - mean(positive))/(sd(positive))
aapl_n <- (aapl - mean(aapl))/(sd(aapl))

both_n <- (both - mean(both))/(sd(both))

rm(aapl, positive, negative, both) # Remove unnecessary data from workspace

daapl_n <- diff(aapl_n) # We differentiate the vectors in order to obtain stationarity
dpositive_n <- diff(positive_n)
dnegative_n <- diff(negative_n)

dboth_n <- diff(both_n)

# Experiments over Positive mood values: --------
grangertest(daapl_n ~  dpositive_n, order=18)
# lag = 18 days, p-value = 0.03499

grangertest(daapl_n ~ positive_n[1:58], order=8)
# lag = 8 days, p-value = 0.05355

#Experiments over Negative mood values ----------
grangertest(daapl_n ~  dnegative_n, order=13)
# lag = 13 days, p-value = 0.4436...awful

grangertest(daapl_n ~ negative_n[1:58], order=13)
# lag = 13 days, p-value = 0.2982...awful

# Experiments over both combined: ---------------
grangertest(daapl_n ~  dboth_n, order=13)
# lag = 13 days, p-value = 0.4235...

grangertest(daapl_n ~ both_n[1:58], order=2)
# lag = 2 days, p-value = 0.3588...

# Sembla que el stock de apple depen molt de les valoracions positives, pero no tant de les negatives o de la 
# combinació dels dos

vector_1 <- vector()
vector_2 <- vector()
vector_11 <- vector()
vector_22 <- vector()
vector_111 <- vector()
vector_222 <- vector()
for(i in 1:18){
  p_val <- grangertest(daapl_n ~  dpositive_n, order=i) 
  vector_1[i] <- p_val[2,4]
  r_val <- grangertest(daapl_n ~ positive_n[1:58], order=i)
  vector_2[i] <- r_val[2,4]
  
  pp_val <- grangertest(daapl_n ~  dnegative_n, order=i) 
  vector_11[i] <- pp_val[2,4]
  rr_val <- grangertest(daapl_n ~ negative_n[1:58], order=i)
  vector_22[i] <- rr_val[2,4]
  
  ppp_val <- grangertest(daapl_n ~  dboth_n, order=i) 
  vector_111[i] <- ppp_val[2,4]
  rrr_val <- grangertest(daapl_n ~ both_n[1:58], order=i)
  vector_222[i] <- rrr_val[2,4]
}

par(mfrow=c(3,1))

plot(vector_1, type = 'l',ylim = c(0,1), xlim = c(0,18), ylab = 'p-value', xlab = 'Lag', main = 'Prediction significance between positive mood & AAPL closing values')
par(new = T)
plot(vector_2, type = 'l',ylim = c(0,1), xlim = c(0,18), col = "red", ylab = '', xlab = '')

plot(vector_11, type = 'l',ylim = c(0,1), xlim = c(0,18), ylab = 'p-value', xlab = 'Lag', main = 'Prediction significance between negative mood & AAPL closing values')
par(new = T)
plot(vector_22, type = 'l',ylim = c(0,1), xlim = c(0,18), col = "red", ylab = '', xlab = '')

plot(vector_111, type = 'l',ylim = c(0,1), xlim = c(0,18), ylab = 'p-value', xlab = 'Lag', main = 'Prediction significance between overall mood & AAPL closing values')
par(new = T)
plot(vector_222, type = 'l',ylim = c(0,1), xlim = c(0,18), col = "red", ylab = '', xlab = '')
# make width: 800 and height: 1000
