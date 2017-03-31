#Pavages needed for twitteR
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
