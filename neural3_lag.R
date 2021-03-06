# Neural 3: with lag incorporated and without additional features or for iteration

doit <- function(x) {(x - min(x, na.rm=TRUE))/(max(x,na.rm=TRUE) -
                                                 min(x, na.rm=TRUE))} # I should try substracting the mean

setwd("C:/Users/Joan/Desktop/TFG")
library(dplyr)
#data <- read.csv("dataset.csv")
#data <- select(data, positive, negative,Close)

data <- read.csv("data_apple.csv")
data <- select(data, pos, neg, Close)

y <- as.numeric(data$Close[2:length(data$Close)] > data$Close[1:(length(data$Close) - 1)])

output <- vector(length = 59)
output[1] <- 1 # del 16/2 al 17/2 subi� 300 $
output[2:59] <- y

# subsetting:

lag_1 <- 13
lag_2 <- 2

## _____________LAG #1 days____________________________________________

subset_twitter <- slice(data, 1:(59-lag_1)) 
subset_twitter <- select(subset_twitter, pos, neg)

subset_djia <- slice(data, (lag_1+1):59)
subset_djia <- select(subset_djia, Close)

subset_1 <- cbind(subset_twitter, subset_djia) # amb lag de 16 dies...
y_1 <- output[(lag_1+1):59]

## _____________LAG #2 days_____________________________________________

subset_twitter_2 <- slice(data, 1:(59-lag_2)) 
subset_twitter_2 <- select(subset_twitter_2, pos, neg)

subset_djia_2 <- slice(data, (lag_2+1):59)
subset_djia_2 <- select(subset_djia_2, Close)

subset_2 <- cbind(subset_twitter_2, subset_djia_2) # amb lag de 7 dies...
y_2 <- output[(lag_2+1):59]

## _________END SUBSETTING_____________________________________________

normed_1 <- as.data.frame(lapply(subset_1, doit)) 
normed_2 <- as.data.frame(lapply(subset_2, doit)) 

normed_1 <- cbind(normed_1, y_1)
normed_2 <- cbind(normed_2, y_2)

remove(subset_twitter, subset_twitter_2, subset_djia_2, subset_djia, output, y, doit, data, subset_1, subset_2,y_1,y_2)

normed_1 <- tbl_df(normed_1)
normed_2 <- tbl_df(normed_2)

# in order to eliminate the indicated columns:
normed_2 <- select(normed_2, -neg)
normed_1 <- select(normed_1, -neg)

#train_1 <- normed_1[1:35,]
#train_2 <- normed_2[1:42,]

#test_1 <- normed_1[36:43,1:7]
#test_2 <- normed_2[43:52,1:7]

#ans_1 <- normed_1[36:43,8]
#ans_2 <- normed_2[43:52,8]

# ara tornem a implementar les xarxes neuronals fetes servir anteriorment

v <- 3 # 3 si es positiu o negtiu, 4 si es both

library(neuralnet)

k <- 32
kk <- 46
#l <- 1
var <- length(((k+1):kk))
summa <- 0
i <- 1

  train <- normed_2[(1:k),1:v] #feature dataset
  test <- normed_2[((k+1):kk),1:(v-1)]
  answers <- normed_2[((k+1):kk),v]
  
  # do the algorithm
  
  net <- neuralnet(y_2 ~ pos + Close, train, 
                   hidden = 7, 
                   lifesign = "minimal", 
                   linear.output = FALSE, threshold = 0.1) # this trains the model
  
  
  
  results <- compute(net, test)
  
  results_fin <- data.frame(actual = answers, prediction = results$net.result)
  
  # cada iteraci� de les 39 t� 5 proves -> 39 * 5 = 195. La suma d'encerts es divideix entre 195
  # ara 49 *2 
  
  results_fin$prediction <- round(results_fin$prediction)
  
  summa <- sum(results_fin[,1] == results_fin[,2])
  


print(summa/var)
detach(package:neuralnet)
detach(package:dplyr)