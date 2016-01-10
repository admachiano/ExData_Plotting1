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

#Change first two submetering variables to numeric from character
#Sub_metering_3 was already numeric so no need to change it
consump$Sub_metering_1 = as.numeric(consump$Sub_metering_1)
consump$Sub_metering_2 = as.numeric(consump$Sub_metering_2)

#Initialize plot, specify parameters, write to file, close device
png("plot3.png", width = 480, height = 480)
plot(consump$datestimes, consump$Sub_metering_1, type = "l", xlab = "", ylab = "Energy Submetering")
lines(consump$datestimes, consump$Sub_metering_2, type = "l", col="red")
lines(consump$datestimes, consump$Sub_metering_3, type = "l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1, lwd = 2.5, col = c("black", "red", "blue"))
dev.off()