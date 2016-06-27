vec <- c(letters, paste("z",letters, sep = ""), paste("zz", letters[1:7], sep = ""))

library(stringi)

library(tm)

datg <- data.frame()
#colnames(datg) <- c("pos", "neg", "neut")

for(q in 1:59){
  
  setwd(paste("C:/Users/Joan/Desktop/TFG/english_tweets/",vec[q], sep = "")) # change the last letter to change folder, one for each day
  
  files_dir <- dir() # should get 4 files every day
  
  df <- NULL
  
  for(j in 1:4){
    
    aux_df <- read.csv(files_dir[j])
    
    df <- rbind(df, aux_df) # Goes through the four files, concatenates them and generates a single dataframe
    
  }
  
  tweets_0 <- as.character(df$text)
  
  corpus <- Corpus(VectorSource(tweets_0)) # treat data like a corpus
  
  # to count characters in a string: nchar(tweets[1])
  
  # Cleaning process:
  
  corpus <- tm_map(corpus, removeNumbers) # these 2 work!!!
  
  corpus <- tm_map(corpus, removePunctuation)
  
  dataframe <- data.frame(text=unlist(sapply(corpus, `[`, "content")), stringsAsFactors=F)
  
  tweets <- dataframe$text
  
  tweets <- gsub("\n", "", tweets) # remove \n...it's full of them
  
  tweets <- gsub("http\\w+", "", tweets) # remove links
  
  tweets <- gsub("RT", "", tweets) # remove retweet factors
  
  tweets <- tolower(tweets) # transforms the whole text to lower case expressions
  
  # we will now generate the stopwords list. since we're dealing with tweets, people write pretty bad, so we'll add 
  # some of the same words twice but without apostrophes. Also, we eliminated punctuation so...we need it no matter what
  
  stopwords <- stopwords()
  
  stopwords_nopun <- removePunctuation(stopwords)
  
  stpw <- stopwords_nopun[stopwords_nopun != stopwords] 
  
  stopwords <- c(stopwords, stpw) # full list of stopwords, with and without apostrophes
  
  tweets <- removeWords(tweets, stopwords)# removes all the stopwords
  
  tweets <- stripWhitespace(tweets) # removes additional white spaces
  
  ## NEW ADDITION ON DAY 31/5 for doing the same process for Apple stocks related on the day of the iPhone SE launch
  tweets <- tweets[grep('batman', tweets[1:40000])]
  
  # PART 2 ------------ SCORE 
  
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
  datg <- rbind(datg,FINAL_vec)
  
}