library(data.table)
#read data
consumption <- read.table(unz("./household_powerconsumption.zip","household_power_consumption.txt"), 
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

with(consumptionOfInterest, hist(Global_active_power, col="red", main="Global Active Power", 
                                xlab="Global Active Power (kilowatts)"))