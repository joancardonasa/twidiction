## Polarity: Script that counts positive & negative words ina tweet (based on neg_wor.txt, pos_wor.txt)
##           and assigns a score to each tweet (negative or positive)

## !! To be executed only after cleaning a day's tweets (after executing corpus_clean.R)

library(stringi)

setwd("C:/Users/Joan/Desktop/TFG")

neg <- read.csv("neg_wor.txt")

pos <- read.csv("pos_wor.txt")

colnames(pos) <- "words"

colnames(neg) <- "words"

neg_wor <- as.character(neg$words)

pos_wor <- as.character(pos$words)

n_tw <- length(tweets) 

# I 

neg_sco <- vector()

pos_sco <- vector()

sco_2 <-vector()

for(i in 1:n_tw){
  
   neg_sco[i] <- sum(as.numeric(stri_detect_fixed(tweets[i], neg_wor))) # 1st way to compute score
   
   pos_sco[i] <- sum(as.numeric(stri_detect_fixed(tweets[i], pos_wor)))
   
   if(pos_sco[i] > neg_sco[i]){ #2nd way to compute score. We label each tweet as positive, negative, or neutral
                                # and the sum of each positive/negative/neutral is that score 
     sco_2[i] <- 1
   }else if(pos_sco[i] < neg_sco[i]){
     sco_2[i] <- -1
   } else {
     sco_2[i] <- 0
   }
  
}
# (The script only compute the score for one day)
# The first way of computing the score is to sum the total of pos and neg words: the positive score will be 
# the sum of positive words, while the negative score will be the sum of he negative words

# the second way is by using the if iteration:

p2_score <- sum(sco_2 == 1)/n_tw # for every day
n2_score <- sum(sco_2 == -1)/n_tw
neutral_score <- sum(sco_2 == 0)/n_tw

FINAL_vec <- c(p2_score, n2_score, neutral_score)

# each day now contains two vectors of length = number_tweets

# we can sum them to see the total positive and negative score for that day

# sum(neg_sco)

# sum(pos_sco)

# we could use these two variables on the training dataset with the DJIA closing values or get the total
# "mood": pos_sco - neg_sco

# I'll do both, to see which one gives us better performance

# Nevertheless, I'm biased to believe we'll always get more negative scores because of the fact that there are 
# 2000 more words in neg_wor than in pos_wor

# Example:

# 17/2: pos_sco: 43795; neg_sco: 58232
# 18/2: pos_sco: 41903; neg_sco: 56003
# 19/2: pos_sco: 54717; neg_sco: 59222

# ...

# 31/3: pos_sco: 23001; neg_sco: 26720
