library(ggplot2)
library(readxl)
library(grid)
library(gridExtra)
#Load Data

color1 = '#0168bb'
color2 = '#9196aa'
color3 = '#2e5785'
color4 = '#474a54'

setwd("~/Dropbox/NorthWestern/Predict 455 - Winter 2018/Predict455FinalProject/indata")
df1 <- read_excel("BTC-USD.xls", sheet = 'BTC-USD',
                  col_types = c("date", "numeric"))

#Create Plots
p1 = ggplot(df1, aes(Date))+
  geom_line(aes(y = Price, colour = color1)) + 
  theme(panel.background = element_blank(),legend.position="none")   +
  xlab("Observation Date") + ylab("Price (USD)")+
  ylim(0,20000)
p1
require(grid)

p1 = p1+ggtitle("Bitcoin Price, 2011-2018")
p1
grid.text("Bitcoin", x = unit(0.95, "npc"), y = unit(0.65, "npc"))