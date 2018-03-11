library(jsonlite)
library(lubridate)
library(ggplot2)

#Inspiration
# https://itnext.io/predicting-the-price-of-cryptocurrencies-using-fuzzy-time-series-in-r-577cba57d43c


dataset.btc <- fromJSON("https://min-api.cryptocompare.com/data/histoday?fsym=BTC&tsym=USD&limit=1000")
# Other API Paths can be sourced: https://min-api.cryptocompare.com/
tail(dataset.btc$Data)


df = as.data.frame(dataset.btc$Data)
df$Date = as.Date(as.POSIXct(df$time, origin="1970-01-01"))

#Basic Plot
ggplot(data=df, aes(x=Date, y=close)) +
  geom_line() + 
  theme(panel.background = element_blank())
