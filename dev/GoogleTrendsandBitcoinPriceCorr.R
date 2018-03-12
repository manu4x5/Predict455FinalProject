#R 3.3 verified
# Data Dictionary: GoogleTrendandBitcoinPriceCorr

#Packages
library(ggplot2)
library(readxl)
library(grid)
library(gridExtra)

#Load Data

color1 = '#0168bb'
color2 = '#9196aa'
color3 = '#2e5785'
color4 = '#474a54'

#Set To Location of indata folder on local machine.
setwd("~/Dropbox/NorthWestern/Predict 455 - Winter 2018/Predict455FinalProject/indata")

coindesk_googletrend <- read_excel("coindesk_googletrend.xlsx", sheet = 'coindesk-USD-close_data',
                                   col_types = c("date", "numeric", "numeric", 
                                                 "numeric"))

#View(coindesk_googletrend)
coindesk_googletrend= coindesk_googletrend[complete.cases(coindesk_googletrend), ]

maxAveragePriceTrend = max(coindesk_googletrend$`Average Close Price`)
coindesk_googletrend$AverageClosePriceNormal =( as.double(coindesk_googletrend$`Average Close Price`)
          / maxAveragePriceTrend * 100)

#Create Plots
p1 = ggplot(coindesk_googletrend, aes(Date))+
  geom_line(aes(y = AverageClosePriceNormal, colour = color1)) + 
  geom_line(aes(y = `Google Trend`, colour = color2))+
  theme(panel.background = element_blank(),legend.position="none")   +
  xlab("Year") + ylab("Normalize Relative Value")+
  ylim(0,100)
p1

p1 = ggplot(coindesk_googletrend, aes(Date))+
  geom_line(aes(y = AverageClosePriceNormal, colour = color1)) + 
  geom_line(aes(y = `Google Trend`, colour = color2))+
theme(panel.background = element_blank(),legend.position="none")+
  theme(
        panel.grid.major.y = element_line(color="black", size = .02))+
  xlab("Year") + ylab("Normalize Relative Value")+
  ylim(0,100)
p1



require(grid)


p1 = p1+ggtitle("Bitcoin Relative Value versus Google Trends -- 0-100 Scale")
p1
grid.text("Bitcoin", x = unit(.95, "npc"), y = unit(.65, "npc"))
grid.text("GoogleTrend", x = unit(0.91, "npc"), y = unit(0.25, "npc"))


#Correlations
cor(coindesk_googletrend$`Google Trend`, coindesk_googletrend$`Average Close Price` )


#Granger Test
library(lmtest)
grangertest(coindesk_googletrend$`Google Trend`~
            coindesk_googletrend$`Average Close Price`,
           )

grangertest(coindesk_googletrend$`Average Close Price` ~
              coindesk_googletrend$`Google Trend`, 
            )


