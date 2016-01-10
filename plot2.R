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

#Change Global_active_power to numeric from character
GlobalActPow = as.numeric(consump$Global_active_power)

#Initialize plot, specify parameters, write to file, close device
png("plot2.png", width = 480, height = 480)
plot(consump$datestimes, GlobalActPow, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
dev.off()