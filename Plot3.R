library(ggplot2)
library(Rmisc)
library(scales)


#load data
setwd("C:/Users/scott.ziemke/Documents/Coursera/Exploratory Data Analytics/exdata-data-household_power_consumption/")
data <- read.table("C:/Users/scott.ziemke/Documents/Coursera/Exploratory Data Analytics/exdata-data-household_power_consumption/household_power_consumption.txt", header = TRUE, sep = ";")


#convert date time and subset
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
findata <- subset(data, Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02"))
remove(data)

findata[,3:9] <- sapply(findata[,3:9], function(x) as.numeric(as.character(x)))
findata$DateTime <- format(as.POSIXct(paste(findata$Date, findata$Time)), "%Y/%m/%d %H:%M:%S")

######################################
#chart 3
######################################

ggplot(findata, aes(as.POSIXct(DateTime))) + 
  geom_line(aes(y = Sub_metering_1, colour = "Sub Metering 1")) + 
  geom_line(aes(y = Sub_metering_2, colour = "Sub Metering 2")) +
  geom_line(aes(y = Sub_metering_3, colour = "Sub Metering 3")) +
  scale_x_datetime(breaks = date_breaks("1 day"), labels = date_format("%a")) +
  xlab(" ") +          
  ylab("Energy Sub Metering") +
  theme(legend.title=element_blank())

dev.copy(png, file = "Plot3.png")
dev.off()
