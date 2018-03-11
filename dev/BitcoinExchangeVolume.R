# R 3.3 Verified
# Data Dictionary: BitcoinExchangeVolumes

library(Quandl)

Quandl("BCHAIN/NTRAN")


transWK = Quandl(c("BCHAIN/NTRAN",'BCHARTS/BITSTAMPUSD','BCHAIN/TRVOU'), collapse='week')

transWK$weeklyTransactions000 = transWK$`BCHAIN.NTRAN - Value` /1000

ggplot(data=transWK, aes(x=Date, y=transWK$weeklyTransactions000)) +
  geom_line(colour = color2) + 
  theme(panel.background = element_blank()) + 
  xlab("Date") + ylab("'000 of Transactions ") +
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


                              