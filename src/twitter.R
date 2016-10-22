print ("Load twitterR library")

library(twitteR)
library(laply)

print ("twitterR loaded successfully")

#Assigning the twitter access keys to the local vaiables

consumer_key <- ""       #add your key
consumer_secret <- ""     #add your consumer secret
access_token <- ""        #add accesses token 
access_secret <- ""       #add your access secret

setup_twitter_oauth(consumer_key, consumer_secret, access_token, access_secret)

print ("twitter account connected")

# Run Twitter Search. Format is searchTwitter("Search Terms", n=100, lang="en", geocode="lat,lng", also accepts since and until).

tweets.data <- searchTwitter("The Magnificent Seven", n=15, lang="en", since="2016-09-01")

# tweets.data

class(tweets.data)
length(tweets.data)

# to test print selected tweet  
tweet1 = tweets.data[[1]]
#to print more than one tweet
# tweets.data[c(1,2)]
class(tweet1)
tweet1$screenName
tweet1$created
tweet1$text

# read positive words
positive.words = scan("data\\positivewords.txt", what=character(), comment.char=';')
class(positive.words)  
positive.words

# read negitive words
negative.words = scan("data\\negativewords.txt", what=character(), comment.char=';')
class(negative.words)
negative.words

# split the tweets text only from the returned text data. 
tweets.text = sapply(tweets.data, function(t) t$getText() )
tweets.text

# TODO 
# the tweet text to be analysed goes here

# Use it in the reports