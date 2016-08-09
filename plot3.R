library(data.table)

#read data from zipfile
consumption <- read.table(unz("./household_power_consumption.zip","household_power_consumption.txt"), 
                          header=TRUE, na.strings = "?", sep = ";", 
                          stringsAsFactors = FALSE)

#convert date and time columns to a combined dateTime so we can subset
consumption$DateTime <- paste(consumption$Date, consumption$Time)
consumption$DateTime <- strptime(consumption$DateTime, format = "%d/%m/%Y %H:%M:%S")

#get data of interest (2007-02-01 and 2007-02-02)
lowDate <- strptime("01/02/2007 00:00:00", format = "%d/%m/%Y %H:%M:%S")
highDate <- strptime("03/02/2007 00:00:00", format = "%d/%m/%Y %H:%M:%S")
consumptionOfInterest <- subset(consumption, DateTime >= lowDate
                               & DateTime < highDate)

with(consumptionOfInterest, plot(DateTime, Sub_metering_1, type="l",  xlab="",
                                 ylab="Energy sub metering"))

with(consumptionOfInterest, lines(DateTime, Sub_metering_2, col="red"))
with(consumptionOfInterest, lines(DateTime, Sub_metering_3, col="blue"))
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col=c("black","red","blue"), 
       lty =c(1,1))
