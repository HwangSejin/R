library(ggplot2)
library(xts)
library(reshape2)

agg <- read.csv("AggInfl.csv", na.strings = "")
core <- read.csv("CoreInfl.csv", na.strings = "")
ener <- read.csv("EnergInfl.csv", na.strings = "")
food <- read.csv("FoodInfl.csv", na.strings = "")

head(agg)
str(agg)
#agg <- xts(x = agg[,-1], order.by = agg[,-1])

as.Date(agg[,1])

# xts needs subannual data so we associate the 1 Jan with each year
agg <- xts(agg[,-1], order.by=as.Date(paste0(agg[,1], "-01-01")))
core <- xts(core[,-1], order.by=as.Date(paste0(core[,1], "-01-01")))
ener <- xts(ener[,-1], order.by=as.Date(paste0(ener[,1], "-01-01")))
food <- xts(food[,-1], order.by=as.Date(paste0(food[,1], "-01-01")))

temp <- data.frame(index(agg), stack(as.data.frame(coredata(agg))))
temp

names(temp)[1] <- "Year"
names(temp)[2] <- "Infl"
names(temp)[3] <- "Country"

ggplot(temp, aes(x = Year, y = Infl, color = Country)) + geom_line()
ggplot(temp, aes(x = Year, y = Infl, color = Country)) + geom_point()

p1 <- ggplot(temp, aes(x = Year, y = Infl, color = Country)) + geom_line()
p1 <- p1 + ylim(-10, 30)
p1 <- p1 + ggtitle("(a) Aggrate Inflation")
p1

p1 <- p1 +
  theme(axis.title.x = element_blank(),
        axis.title.y = element_blank(),
        axis.text.x = element_text(color = "black", size = 15),
        axis.text.y = element_text(color = "black", size = 15),
        panel.background = element_rect(fill = "white"),
        panel.grid.minor = element_blank(),
        panel.grid.major = element_blank(),
        axis.line = element_line(colour = "black", size = 1),
        legend.position = "none",
        plot.title = element_text(lineheight = .8, face = "bold"))


p1 <- p1 +
  annotate("text", x=as.Date("1976-06-01"), y=24, label = "UK", frontface="bold", size=4)+
  annotate("text", x=as.Date("1992-09-01"), y=10, label = "SWE", frontface="bold", size=4)+
  annotate("text", x=as.Date("2004-06-01"), y=-1, label = "JAP", frontface="bold", size=4)+
  annotate("text", x=as.Date("1982-06-01"), y=20, label = "ITA", frontface="bold", size=4)
p1

temp <- data.frame(index(core),stack(as.data.frame(coredata(core))))
names(temp)[1] <- "Year"
names(temp)[2] <- "AggInf"
names(temp)[3] <- "Country"

p2 <- ggplot(temp,aes(x =Year, y=AggInf, color=Country)) + geom_line() +
  ggtitle("(b) Core Inflation") +
  ylim(-10, 30) +
  theme(axis.title.x=element_blank(),
        axis.title.y=element_blank(),
        axis.text.x=element_text(color = "black",size=15),
        axis.text.y=element_text(color="black",size=15),
        panel.background=element_rect(fill = "white"),
        panel.grid.minor = element_blank(),
        panel.grid.major = element_blank(),
        axis.line = element_line(colour = "black", size = 1),
        legend.position="none",
        plot.title = element_text(lineheight=.8, face="bold")) +
  annotate("text",x=as.Date("1976-06-01"),y=0,label="SWI",fontface="bold",size=4) + 
  annotate("text",x=as.Date("1982-05-01"),y=20,label="ITA",fontface="bold",size=4)


temp <- data.frame(index(ener),stack(as.data.frame(coredata(ener))))
names(temp)[1] <- "Year"
names(temp)[2] <- "AggInf"
names(temp)[3] <- "Country"

p3 <- ggplot(temp,aes(x =Year, y=AggInf, color=Country)) + geom_line() +
  ggtitle("(c) Energy Inflation") +
  theme(axis.title.x=element_blank(),
        axis.title.y=element_blank(),
        axis.text.x=element_text(color = "black",size=15),
        axis.text.y=element_text(color="black",size=15),
        panel.background=element_rect(fill = "white"),
        panel.grid.minor = element_blank(),
        panel.grid.major = element_blank(),
        axis.line = element_line(colour = "black", size = 1),
        legend.position="none",
        plot.title = element_text(lineheight=.8, face="bold")) +
  annotate("text",x=as.Date("1991-01-01"),y=30,label="SWE",fontface="bold",size=4) + 
  annotate("text",x=as.Date("1971-01-01"),y=40,label="DEN",fontface="bold",size=4) +
  annotate("text",x=as.Date("1984-03-01"),y=-20,label="SWI",fontface="bold",size=4)


temp <- data.frame(index(food),stack(as.data.frame(coredata(food))))
names(temp)[1] <- "Year"
names(temp)[2] <- "AggInf"
names(temp)[3] <- "Country"

p4 <- ggplot(temp,aes(x =Year, y=AggInf, color=Country)) + geom_line() +
  ggtitle("(d) Food Inflation") +
  ylim(-10, 30) +
  theme(axis.title.x=element_blank(),
        axis.title.y=element_blank(),
        axis.text.x=element_text(color = "black",size=15),
        axis.text.y=element_text(color="black",size=15),
        panel.background=element_rect(fill = "white"),
        panel.grid.minor = element_blank(),
        panel.grid.major = element_blank(),
        axis.line = element_line(colour = "black", size = 1),
        legend.position="none",
        plot.title = element_text(lineheight=.8, face="bold")) +
  annotate("text",x=as.Date("1972-06-01"),y=28,label="JAP",fontface="bold",size=4) + 
  annotate("text",x=as.Date("1976-06-01"),y=25,label="UK",fontface="bold",size=4) +
  annotate("text",x=as.Date("1998-03-01"),y=-5,label="SWE",fontface="bold",size=4) +
  annotate("text",x=as.Date("1983-12-01"),y=15,label="ITA",fontface="bold",size=4) +
  annotate("text",x=as.Date("1993-06-01"),y=-6,label="FIN",fontface="bold",size=4) +
  annotate("text",x=as.Date("2005-10-01"),y=-4,label="NET",fontface="bold",size=4)

library(gridExtra)
grid.arrange(p1, p2, p3, p4, nrow=2, ncol=2)
