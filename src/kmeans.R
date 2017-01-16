install.packages("gdata")
install.packages("xlsx")

require(gdata)
library(xlsx)

avghhincome = read.xls ("/Users/Prasoona/R/avghhincome.xlsx", sheet = 1, header = TRUE)
summary(avghhincome)

avghhincome[0] <- NULL

data.class( avghhincome )
avghhincome

summary(avghhincome)
head(avghhincome)
plot(avghhincome)

#kmeans for the centers=2
avghhincome.2means <- kmeans(avghhincome, centers=2)
avghhincome.2means$centers

avghhincome.2means$cluster

#kmeans for the centers=3
avghhincome.3means <- kmeans(avghhincome, centers=3)
avghhincome.3means$centers

#kmeans for the centers=4
avghhincome.4means <- kmeans(avghhincome, centers=4)
avghhincome.4means$centers

clusvect <- avghhincome.4means$cluster

# Append clustering vector variable clusvect as a third column of variable avghincome. 
avghhincome$cluster <- clusvect
avghhincome

# Write the data in avghincome to an external file
write.table (avghhincome, "/Users/Prasoona/R/u2a2_prasoona.xlsx",  sep="\t")

#kmeans for centers=5
avghhincome.5means <- kmeans(avghhincome, centers=5)
avghhincome.5means$centers
