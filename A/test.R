require(twitteR)
require(RCurl)
require(plyr)
require(reshape2)
require(stringr)
require(car)
setwd("/Users/plucarelli/Documents/RMDS");

# setup
source("credentials.R")
setup_twitter_oauth(consumer_key, consumer_secret, access_token, access_secret)

tweetsA <- searchTwitter("#trump", n=1000, lang="en", resultType="recent") #1000 recent tweets about Donald Trump, in English (I think that 1500 tweets is max) 
tweetsB <- searchTwitter("#obama", n=1000, lang="en", resultType="recent") #1000 recent tweets about Hillary Clinton 
tweetsC <- searchTwitter("#gandhi", n=1000, lang="en", resultType="recent") #1000 recent tweets about Bernie Sanders

tweetsA.text <- laply(tweetsA, function(t)t$getText())
tweetsB.text <- laply(tweetsB, function(t)t$getText())
tweetsC.text <- laply(tweetsC, function(t)t$getText())

pos <- scan('positive-words.txt', what = 'character', comment.char=';') 
neg <- scan('negative-words.txt', what = 'character', comment.char=';')

source("sentiment3.R") 

analysisA <- score.sentiment(tweetsA.text, pos, neg)
analysisB <- score.sentiment(tweetsB.text, pos, neg)
analysisC <- score.sentiment(tweetsC.text, pos, neg)

sem<-data.frame(analysisA$score, analysisB$score, analysisC$score)
semFrame <- melt(sem, measured=c(analysisA.score,analysisB.score, analysisC.score )) 
names(semFrame) <- c("Candidate", "score") 

leveneTest(semFrame$score, semFrame$Candidate, center=mean)