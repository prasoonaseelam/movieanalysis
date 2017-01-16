library("plyr")
library(stringr)

tot.pos <- 0
tot.neg <- 0
tot.nut <- 0

#function
score.sentiment = function(sentences, pos.words, neg.words, .progress='none')
{

  scores = laply(sentences, function(sentence, pos.words, neg.words) {
    
    sentence = gsub('[[:punct:]]', '', sentence)
    
    sentence = gsub('[[:cntrl:]]', '', sentence)
    
    sentence = gsub('\\d+', '', sentence)
    
    sentence = tolower(sentence)
    
    # split into words. str_split is in the stringr package
    word.list = str_split(sentence, '\\s+')
    
    #print( word.list )
    
    # sometimes a list() is one level of hierarchy too much
    words = unlist(word.list)
    
    #print( sentence )
    #print( words )
    # compare our words to the dictionaries of positive & negative terms
    pos.matches = match(words, pos.words)
    neg.matches = match(words, neg.words)

    
    # match() returns the position of the matched term or NA
    # we just want a TRUE/FALSE:
    
    pos.matches = !is.na(pos.matches)
    neg.matches = !is.na(neg.matches)
    
    #Logic 1 
    finalscore <- (sum(pos.matches) - sum(neg.matches) )
    # and conveniently enough, TRUE/FALSE will be treated as 1/0 by sum():
    
    if( sum(pos.matches) > 0 ) {
     score = "Positive"
      assign("tot.pos", sum( tot.pos + 1 ) , envir = .GlobalEnv)
      } 
    else if( sum(neg.matches) > 0  ) {
       score = "Negitive"
        assign("tot.neg", sum( tot.neg + 1 ) , envir = .GlobalEnv)
     } 
    else {
       score = "Nutral"
        assign("tot.nut", sum( tot.nut + 1 ) , envir = .GlobalEnv)
      } 
    
    #Logic 2
    if( sum(neg.matches) > 0 ) {
      #score = "Negitive"
      #assign("tot.neg", sum( tot.neg + 1 ) , envir = .GlobalEnv)
      
    } else if( sum(pos.matches) > 0 ) {
      #score = "Positive"
      #assign("tot.pos", sum( tot.pos + 1 ) , envir = .GlobalEnv)
      
    } else {
      #score = "Nutral"
      #assign("tot.nut", sum( tot.nut + 1 ) , envir = .GlobalEnv)
    } 
    
    return(score)
    
  }, pos.words, neg.words, .progress=.progress )
  
  scores.df = data.frame(scores)
  
  return(scores.df)
  
}

pos.words.data  <- read.table("/Users/SKrishna/R/data/positivewords.txt", header = FALSE)
pos.words <- pos.words.data[, c(1)]

neg.words.data  <- read.table("/Users/SKrishna/R/data/negitivewords.txt", header = FALSE)
neg.words <- neg.words.data[, c(1)]

tweets.data  <- read.csv("/Users/SKrishna/R/data/the_lone_ranger_70.xls")
tweets.text <- tweets.data[, c(1)]

pos.words.lower = tolower(pos.words)
neg.words.lower = tolower(neg.words)

result = score.sentiment(tweets.text, pos.words.lower, neg.words.lower)

tot.pos
tot.neg
tot.nut