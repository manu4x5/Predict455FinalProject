#R3.3 Checkout Complete.
# Data Dictionary Name: CryptoCurrencyMarketCap

color1 = '#0168bb'
color2 = '#9196aa'
color3 = '#2e5785'
color4 = '#474a54'
color5 = '#3e4552'
color6 = '#787878'
color7 = '#555555'
color8 = '#2b71b1'
color9 ='#1d75b7'

#Inspiration: https://www.r-bloggers.com/analysing-cryptocurrency-market-in-r/


library(treemap)
library(coinmarketcapr)


plot_top_5_currencies()
market_today <- get_marketcap_ticker_all()

df1 <- na.omit(market_today[,c('id','market_cap_usd')])
df1$market_cap_usd <- as.numeric(df1$market_cap_usd)
df1$formatted_market_cap <-  paste0(df1$id,'\n','$',format(df1$market_cap_usd,big.mark = ',',scientific = F, trim = T))
treemap(df1, index = 'formatted_market_cap', vSize = 'market_cap_usd', 
        title = 'Cryptocurrency Market Current Capitalization', fontsize.labels=c(12, 8), 
        palette=c(color1,color2, color3, 
                  color4,color5, color6,
                  color7, color8, color9))#'RdYlGn')


df1$market_cap_prc = df1$market_cap_usd / sum(df1$market_cap_usd) * 100


