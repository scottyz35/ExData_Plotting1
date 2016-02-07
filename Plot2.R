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

##################################
#chart 2
##################################

qplot(as.POSIXct(findata$DateTime), findata$Global_active_power) + 
  geom_line() +
  scale_x_datetime(labels = date_format("%a"),breaks = date_breaks("1 day")) +
  xlab(" ") +          
  ylab("Global Active Power (kilowatts)") 

dev.copy(png, file = "Plot2.png")
dev.off()