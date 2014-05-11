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

## formatting date and time
datetime<-paste(myData[,1],myData[,2]) 
datetime<-strptime(datetime, "%d/%m/%Y %H:%M:%S")

## Graphic device
png(file="plot4.png",width = 480, height = 480,bg="transparent")

par(mfcol=c(2,2))
##plot top left
plot(datetime,myData[,3],type="l",xlab="",ylab="Global Active Power (kilowatts)")
##plot bottom left
plot(datetime,myData[,7],type="l",xlab="",ylab="Global Active Power (kilowatts)")
lines(datetime,myData[,8],col="red")
lines(datetime,myData[,9],col="blue")
legend("topright", colnames(myData)[7:9], cex=0.8, col=c("black","red","blue"),lty=c(1,1,1))
##plot top right
plot(datetime,myData[,5],type="l",xlab="datetime",ylab="Voltage")
##plot bottom right
plot(datetime,myData[,4],type="l",xlab="datetime",ylab="Global_reactive_power")
dev.off()