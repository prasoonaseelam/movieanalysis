library("plyr")
library(stringr)

tot.pos <- 0
tot.neg <- 0
tot.nut <- 0

pos.words.data  <- read.table("/opt/R/data/positivewords.txt", header = FALSE)
pos.words <- pos.words.data[, c(1)]

neg.words.data  <- read.table("/opt/R/data/negitivewords.txt", header = FALSE)
neg.words <- neg.words.data[, c(1)]

tweets.data  <- read.csv("/opt/R/data/olympus_has_fallen_6000.xls")
tweets.text <- tweets.data[, c(1)]

pos.words.lower = tolower(pos.words)
neg.words.lower = tolower(neg.words)

#function
findScoreSentiment = function(sentences, pos.words, neg.words, .progress='none')
{
  
  scores = laply(sentences, function(sentence, pos.words, neg.words) {
    
  sentence = gsub('[[:punct:]]', '', sentence)
  sentence = gsub('[[:cntrl:]]', '', sentence)
  sentence = gsub('\\d+', '', sentence)
  sentence = iconv(sentence,"WINDOWS-1252","UTF-8")
  sentence = tolower(sentence)
    
  
    # split into words. str_split is in the stringr package
    word.list = str_split(sentence, '\\s+')
    
    # sometimes a list() is one level of hierarchy too much
    words = unlist(word.list)
    
    # compare our words to the dictionaries of positive & negative terms
    pos.matches = match(words, pos.words)
    neg.matches = match(words, neg.words)
    
    # match() returns the position of the matched term or NA
    # we just want a TRUE/FALSE:
    
    pos.matches = !is.na(pos.matches)
    neg.matches = !is.na(neg.matches)
    
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
    
    return(score)
    
  }, pos.words, neg.words, .progress=.progress )
  
  scores.df = data.frame(scores)
  
  return(scores.df)
  
}

result = findScoreSentiment(tweets.text, pos.words.lower, neg.words.lower)

tot.pos
tot.neg
tot.nut
