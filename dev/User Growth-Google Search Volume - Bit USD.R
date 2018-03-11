#R 3.3 Verified


#use the excel
library(ggplot2)
library(readxl)
library(grid)
library(gridExtra)
#Load Data

color1 = '#0168bb'
color2 = '#9196aa'
color3 = '#2e5785'
color4 = '#474a54'

#Set working directory for indata file
setwd("~/Dropbox/NorthWestern/Predict 455 - Winter 2018/Predict455FinalProject/indata")

bitcoinuser_googletrend <- read_excel("bitcoinmultiTimeline.xlsx", sheet = 'bitcoinmultiTimeline',
                                      col_types = c("date", "numeric"))

#view
View(bitcoinuser_googletrend)

#plot
#Create Plots

p1 = ggplot(bitcoinuser_googletrend, aes(Month))+
  
  geom_line(aes(y = `BTC USD: (Worldwide)`, colour = color4))+
  theme(panel.background = element_blank(),legend.position="none")   +
  xlab("Observation Date") + ylab("Bitcoin USD Search Volume")+
  ylim(0,100)
p1

require(grid)

