# Create the dataset used for training purposes: (Combination of corpus_clean.R & score.R)

library(stringi)

library(tm)

k <- length(day_n_sc) + 1

setwd("C:/Users/Joan/Desktop/TFG")

  neg <- read.csv("neg_wor.txt")
  
  pos <- read.csv("pos_wor.txt")
  
  colnames(pos) <- "words"
  
  colnames(neg) <- "words"
  
  neg_wor <- as.character(neg$words)
  
  pos_wor <- as.character(pos$words)

setwd("../TFG/english_tweets")

  days <- dir()
  
  #day_p_sc <- vector()
  
  #day_n_sc <- vector()
  
  #for(i in 1:length(days)){
  
      wdir <- paste("C:/Users/Joan/Desktop/TFG/english_tweets/", days[k], sep = "")
    
      setwd(wdir) # every working directory of each day
    
      source('../../corpus_clean.R') # this will return a vector called tweets of length = 40000 in each iteration
      
      n_tw <- length(tweets) 
      
      neg_sco <- vector()
      
      pos_sco <- vector()
      
      for(j in 1:n_tw){
        
        neg_sco[j] <- sum(as.numeric(stri_detect_fixed(tweets[j], neg_wor)))
        
        pos_sco[j] <- sum(as.numeric(stri_detect_fixed(tweets[j], pos_wor)))
        
      }
      
      day_n_sc[k] <- sum(neg_sco)
      
      day_p_sc[k] <- sum(pos_sco)
      
    
 # }