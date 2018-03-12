# R 3.3 Verified
# Data Dictionary: BitcoinExchangeVolumes

library(Quandl)
library(ggplot2)

color1 = '#0168bb'
color2 = '#9196aa'
color3 = '#2e5785'
color4 = '#474a54'



Quandl("BCHAIN/NTRAN")
Quandl.api_key('qSmv3ELMxn26JLtCxzXT')


transWK = Quandl(c("BCHAIN/NTRAN",'BCHARTS/BITSTAMPUSD','BCHAIN/TRVOU'), collapse='week')

transWK$weeklyTransactions000 = transWK$`BCHAIN.NTRAN - Value` /1000

ggplot(data=transWK, aes(x=transWK$Date, y=transWK$weeklyTransactions000)) +
  geom_line(colour = color2) + 
  theme(panel.background = element_blank()) + 
  xlab("Year") + ylab("Thousands of Transactions ") +
  theme(panel.grid.major.y = element_line(color="black", size = .02))+
  ggtitle('Weekly Blockchain Transaction Count')


transD = Quandl(c("BCHAIN/NTRAN",'BCHARTS/BITSTAMPUSD','BCHAIN/TRVOU'), start_date="2016-01-01")
transD$`BCHAIN.TRVOU - Value` = transD$`BCHAIN.TRVOU - Value` / 1000000000

#Exchange Volume
ggplot(data=transD, aes(x=Date, y=transD$`BCHAIN.TRVOU - Value`)) +
  geom_line(colour = color1) + 
  theme(panel.background = element_blank()) + 
  xlab("Date") + ylab("USD Exchange Traded Volume ($B)") +
  ylim(0,6) + 
  ggtitle('Total USD Exchange Volume')

max(transD$`BCHAIN.TRVOU - Value`)



                              