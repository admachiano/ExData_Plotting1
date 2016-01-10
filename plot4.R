#Set working directory
setwd("~/R/exdata-data-household_power_consumption")

#Read text file into workspace
power = read.table("household_power_consumption.txt", header = TRUE, sep = ";", stringsAsFactors = FALSE, dec = ".")

#Change dates from character to Date
power$Date = as.Date(power$Date, format = "%d/%m/%Y")

#Subset only rows needed
consump = power[(power$Date == "2007-02-01") | (power$Date == "2007-02-02") ,]

#Combine dates and times into new variable
datestimes = paste(as.Date(consump$Date), consump$Time)
consump$datestimes = as.POSIXct(datestimes)
#Change Global_active_power and Global_reactive_power to numeric from character
#I realize I did this differently as I did in plot2.  I did this assignment over the 
#course of a few days and thought this way would be better and didn't want to change
#my code for Plot1 because it worked then.
consump$Global_active_power = as.numeric(consump$Global_active_power)
consump$Global_reactive_power = as.numeric(consump$Global_reactive_power)

#Doing the same thing for the Submetering 1 & 2, and Voltage. Submetering 3 is already numeric and doesn't need to change.
consump$Sub_metering_1 = as.numeric(consump$Sub_metering_1)
consump$Sub_metering_2 = as.numeric(consump$Sub_metering_2)
consump$Voltage = as.numeric(consump$Voltage)

#Initialize plots, specify parameters, write to file, close device
png("plot4.png", width = 480, height = 480)
par(mfrow = c(2,2))
#top left plot
plot(consump$datestimes, consump$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")

#top right plot
plot(consump$datestimes, consump$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")

#bottom left plot
plot(consump$datestimes, consump$Sub_metering_1, type = "l", xlab = "", ylab = "Energy Submetering")
lines(consump$datestimes, consump$Sub_metering_2, type = "l", col="red")
lines(consump$datestimes, consump$Sub_metering_3, type = "l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1, lwd = 2.5, col = c("black", "red", "blue"), bty = "n")

#bottom right plot
plot(consump$datestimes, consump$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")
dev.off()