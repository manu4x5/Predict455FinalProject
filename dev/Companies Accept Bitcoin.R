# R 3.4 Verfied

#Source:https://99bitcoins.com/who-accepts-bitcoins-payment-companies-stores-take-bitcoins/

# Load
library("tm")
library("SnowballC")
library("wordcloud")
library("RColorBrewer")

color1 = '#0168bb'
color2 = '#9196aa'
color3 = '#2e5785'
color4 = '#474a54'

setwd("~/Dropbox/NorthWestern/Predict 455 - Winter 2018/Predict455FinalProject/indata")

text <- readLines('Companies_Accept_Bitcoin.txt')
# Load the data as a corpus
docs <- Corpus(VectorSource(text))
inspect(docs)
toSpace <- content_transformer(function (x , pattern ) gsub(pattern, " ", x))
docs <- tm_map(docs, toSpace, "/")
docs <- tm_map(docs, toSpace, "@")
docs <- tm_map(docs, toSpace, "\\|")
# Convert the text to lower case
docs <- tm_map(docs, content_transformer(tolower))
# Remove numbers
docs <- tm_map(docs, removeNumbers)
# Remove english common stopwords
docs <- tm_map(docs, removeWords, stopwords("english"))
# Remove your own stop word
# specify your stopwords as a character vector
docs <- tm_map(docs, removeWords, c("blabla1", "blabla2")) 
# Remove punctuations
docs <- tm_map(docs, removePunctuation)
# Eliminate extra white spaces
docs <- tm_map(docs, stripWhitespace)
# Text stemming
# docs <- tm_map(docs, stemDocument)
dtm <- TermDocumentMatrix(docs)
m <- as.matrix(dtm)
v <- sort(rowSums(m),decreasing=TRUE)
d <- data.frame(word = names(v),freq=v)
head(d, 30)
set.seed(1234)
wordcloud(words = d$word, freq = d$freq, min.freq = 1,colors=color3, 
          rot.per = 0.0, # all horizontal text
          max.words=100, random.order=FALSE)