#Packages needed for twitteR
install.packages(c("devtools", "rjson", "bit64", "httr"))
library(devtools)
install_github("geoffjentry/twitteR").
library(twitteR)

#using the api gather tweets from a specific time with a specific key word
api_key<- "your_api_key"
api_secret<- "your_api_secret"
access_token<- "your_access_token"
access_token_secret<- "your_access_token_secret"
setup_twitter_oauth(api_key,api_secret,access_token,access_token_secret)
Tweets = searchTwitter("***key-word***", since='***2014-09-29***')

#return data frame with name, country & woeid.
Locs <- availableTrendLocations()
# Where woeid is a numerical identification code describing a location ID

# Filter the data frame for Delhi (India) and extract the woeid of the same
LocsIndia = subset(Locs, country == "India")
woeidDelhi = subset(LocsIndia, name == "Delhi")$woeid

# getTrends takes a specified woeid and returns the trending topics associated with that woeid
trends = getTrends(woeid=woeidDelhi)

#parameter n is number of searches, no date is last week
Meru_tweets = searchTwitter("MeruCabs", n=2000, lang="en")
Ola_tweets = searchTwitter("OlaCabs", n=2000, lang="en")
TaxiForSure_tweets = searchTwitter("TaxiForSure", n=2000, lang="en")
Uber_tweets = searchTwitter("Uber_Delhi", n=2000, lang="en")

#Not all equal to n.
>length(Meru_tweets)
[1] 393
>length(Ola_tweets)
[1] 984
> length(TaxiForSure_tweets)
[1] 720
> length(Uber_tweets)
[1] 2000


#clean the data algorithm
MeruTweets <- sapply(Meru_tweets, function(x) x$getText())
OlaTweets = sapply(Ola_tweets, function(x) x$getText())
TaxiForSureTweets = sapply(TaxiForSure_tweets,
function(x) x$getText())
UberTweets = sapply(Uber_tweets, function(x) x$getText())

catch.error = function(x)
   {
# let us create a missing value for test purpose
y = NA
# Try to catch that error (NA) we just created
catch_error = tryCatch(tolower(x), error=function(e) e)
# if not an error
if (!inherits(catch_error, "error"))
y = tolower(x)
# check result if error exists, otherwise the function works fine.
return(y) 
}

cleanTweets<- function(tweet){
# Clean the tweet for sentiment analysis
#  remove html links, which are not required for sentiment analysis
tweet = gsub("(f|ht)(tp)(s?)(://)(.*)[.|/](.*)", " ", tweet)
# First we will remove retweet entities from the stored tweets (text)
tweet = gsub("(RT|via)((?:\\b\\W*@\\w+)+)", " ", tweet)
# Then remove all "#Hashtag"
tweet = gsub("#\\w+", " ", tweet)
# Then remove all "@people"
 tweet = gsub("@\\w+", " ", tweet)
# Then remove all the punctuation
tweet = gsub("[[:punct:]]", " ", tweet)
# Then remove numbers, we need only text for analytics
tweet = gsub("[[:digit:]]", " ", tweet)
# finally, we remove unnecessary spaces (white spaces, tabs etc)
tweet = gsub("[ \t]{2,}", " ", tweet)
tweet = gsub("^\\s+|\\s+$", "", tweet)
# if anything else, you feel, should be removed, you can. For example "slang words" etc using the above function and methods.
# Next we'll convert all the word in lower case. This makes uniform pattern.
tweet = catch.error(tweet)
tweet 
}

cleanTweetsAndRemoveNAs<- function(Tweets) { TweetsCleaned = sapply(Tweets, cleanTweets)
# Remove the "NA" tweets from this tweet list TweetsCleaned = TweetsCleaned[!is.na(TweetsCleaned)]
names(TweetsCleaned) = NULL
# Remove the repetitive tweets from this tweet list
TweetsCleaned = unique(TweetsCleaned)
TweetsCleaned
   }

MeruTweetsCleaned = cleanTweetsAndRemoveNAs(MeruTweets)
OlaTweetsCleaned = cleanTweetsAndRemoveNAs(OlaTweets)
TaxiForSureTweetsCleaned <- cleanTweetsAndRemoveNAs(TaxiForSureTweets)
UberTweetsCleaned = cleanTweetsAndRemoveNAs(UberTweets)


opinion.lexicon.pos =scan('opinion-lexicon-English/positive-words.txt', what='character', comment.char=';')





