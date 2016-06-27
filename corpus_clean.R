# data cleaning for each day of tweets:

library(tm)
library(wordcloud)### code NOT TO BE EXECUTED WHEN USING create_data.R

# a: 17/2...
#setwd("C:/Users/Joan/Desktop/TFG/english_tweets/zk") # change the last letter to change folder, one for each day
setwd("C:/Users/Joan/Desktop/TFG/english_tweets/a") # 
files_dir <- dir() # should get 4 files every day

df <- NULL

for(i in 1:1){
  
  aux_df <- read.csv(files_dir[i])
  
  df <- rbind(df, aux_df) # Goes through the four files, concatenates them and generates a single dataframe
  
}

tweets_0 <- as.character(df$text)

corpus <- Corpus(VectorSource(tweets_0)) # treat data like a corpus

# to count characters in a string: nchar(tweets[1])

# Cleaning process:

corpus <- tm_map(corpus, removeNumbers) # these 2 work!!!

corpus <- tm_map(corpus, removePunctuation)
# --- try for wall street

# ---------------------------
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
#tweets <- tweets[grep('batman', tweets[1:40000])]

## We could now easily get the punctuations of + and - for every day comparing all the day's tweets with our 
## positive and negative word lists
