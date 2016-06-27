
# required libraries

setwd("C:/Users/Joan/Desktop/TFG")

library(twitteR)
library(ROAuth)

# twitter connection parameters 20/02/16

consumer_key <- "qJkWXILL8Pm9sCsU4zmeo2pDP"

consumer_secret <- "KLUXY8fI0tvhVW0FJXfEOt2uQYEdgXHHRRjCzV6iAwR5wUbnVM"

access_token <- "701046523312914432-Bzldu4PTB1e3XgBkd4E90uCCyuye5Ja"

at_secret <- "1guXQg7a4E18hKxiimIAZAZo1VsrlG8Azvmsk2MClKItU"

code <- "a" # TO BE CHANGED EVERY DAY _____________________________________________!!!!_______________

setup_twitter_oauth(consumer_key, consumer_secret, access_token, at_secret)

# search steps

string_im <- "orlando"
string_i_am <- "mateen"
string_feel <- "shooting"
string_makes <- "pulse"

m <- 2000
#geo <- "40.412078,-3.707571,800km" # madrid, toda españa

today <- Sys.Date() 
yesterday <- today -1

today <- as.character(today)
yesterday <- as.character(yesterday)

# english tweets

a_im <- searchTwitter(string_im, m, lang="en", since = yesterday, until = today, geocode = NULL) 
a_i_am <- searchTwitter(string_i_am, m, lang="en", since = yesterday, until = today, geocode = NULL) 
a_feel <- searchTwitter(string_feel, m, lang="en", since = yesterday, until = today, geocode = NULL) 
a_makes <- searchTwitter(string_makes, m, lang="en", since = yesterday, until = today, geocode = NULL) 


# GENERATE CSV'S with tweets



# english tweets
dir.create(paste("orlando_tweets/", code, sep = ""))

l_feel_df <- twListToDF(a_feel)
write.csv(l_feel_df, file = paste("english_tweets/",code,"/",code,"_feel.csv", sep = ""))

l_i_am_df <- twListToDF(a_i_am)
write.csv(l_i_am_df, file = paste("english_tweets/",code,"/",code,"_iam.csv", sep = ""))

l_im_df <- twListToDF(a_im)
write.csv(l_im_df, file = paste("english_tweets/",code,"/",code,"_im.csv", sep = ""))

l_makes_df <- twListToDF(a_makes)
write.csv(l_makes_df, file = paste("english_tweets/",code,"/",code,"_makes.csv", sep = ""))




