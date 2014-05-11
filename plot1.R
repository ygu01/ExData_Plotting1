## read only data of Date '1/2/2007' and '2/2/2007'
setwd("C:/Users/Yan/Documents/R Course/Exploratory")
file<-"household_power_consumption.txt"
require("sqldf")
mySql <- "SELECT * from file WHERE Date = '1/2/2007' OR Date = '2/2/2007'"
myData <- read.csv.sql(file, sql=mySql, sep=";")

## convert any "?" to "NA"
for( i in 1:9) {
  myData[myData[, i] == "?"] <- "NA"
}

## convert power measurements to numeric
for(i in 3:9){
  myData[, i] <- as.numeric(myData[, i])
}

## Graphic device
png(file="plot1.png",width = 480, height = 480,bg="transparent")
## Plot histogram
hist(myData[,3],main="Global Active Power", xlab="Global Active Power (kilowatts)",ylab="Frequency",col="red")
dev.off()