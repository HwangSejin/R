# Go to http://apps.twitter.com
# Register Application Programe Interface(API) using my Twitter account

api_key <- 'xxx'
api_secret <- 'xxx'
access_token <- 'xxx'
access_token_secret <- 'xxx'

# Load library
library(twitteR)
setup_twitter_oauth(api_key, api_secret, access_token, access_token_secret)

# Getting Tweets
tweets <- searchTwitter('$aapl', n=10, lang = 'en')
tweets
tweetsdf <- twListToDF(tweets)
write.csv(tweetsdf, file='~/Desktop/apple.csv', row.names=F)
head(apple)

# Trend Locations
trend <- availableTrendLocations()
head(trend)
trend

# Getting trends
world <- getTrends(1)
world
boston <- getTrends(2367105)
head(boston)

singapore <- getTrends(20070458)
head(singapore)

# User timeline
t <- getUser('realDonaldTrump')
t
userTimeline(t, n=2)
