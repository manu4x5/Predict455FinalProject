df2 <- read.csv(file="bitcoinity_data.csv", head=TRUE, colClasses=c("Time"="Date"))

###################

library(ggplot2)
library(readxl)
library(grid)
library(gridExtra)
#Load Data

color1 = '#0168bb'
color2 = '#9196aa'
color3 = '#2e5785'
color4 = '#474a54'
color5 = '#000000'
color6 = '#E69F00'
color7 = '#56B4E9'
color8 = '#009E73'
color9 =  '#F0E442'
color10 = '#0072B2'
color11 = '#D55E00'
color12 = '#CC79A7'
color13 = '#CC6600'
color14 = '#990OCC'
color15 = '#33FF99'
color16 = '#0000FF'

library(ggplot2)
setwd("~/Dropbox/NorthWestern/Predict 455 - Winter 2018/Predict455FinalProject/indata")
df2 <- read.csv("bitcoinity_data.csv", sheet = 'bitcoinity_data')


#Create Plots
p1 = ggplot(df2, aes(Time))+
  geom_line(aes(y = X50BTC.com, colour = color1)) + 
  geom_line(aes(y = AntPool, colour = color2)) + 
  geom_line(aes(y = BTC.Guild, colour = color3)) + 
  geom_line(aes(y = BTC.TOP, colour =  color4)) + 
  geom_line(aes(y = BTCC.Pool, colour = color5 )) + 
  geom_line(aes(y = BW.COM, colour = color6)) + 
  geom_line(aes(y = BitFury, colour = color7 )) + 
  geom_line(aes(y = BitMinter, colour = color8)) + 
  geom_line(aes(y = Eligius, colour = color9)) + 
  geom_line(aes(y = F2Pool, colour = color10)) + 
  geom_line(aes(y = SlushPool, colour = color11)) +
  geom_line(aes(y = Unknown, colour = color12)) + 
  geom_line(aes(y = SlushPool, colour = color13)) + 
  geom_line(aes(y = ViaBTC, colour = color14)) + 
  geom_line(aes(y = ghash.io, colour = color15)) + 
  geom_line(aes(y = others, colour = color16)) + 
  theme(panel.background = element_blank(),legend.position="none")   +
  ylim(0,8000000000000000000)
p1
require(grid)


p1 = p1+ggtitle("Production/ Mining Speed, 16 Competitors")
p1
grid.text("", x = unit(0.95, "npc"), y = unit(0.65, "npc"))

