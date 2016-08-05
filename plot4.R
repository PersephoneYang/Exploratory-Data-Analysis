dir.create("/Users/YanYang/code/Electric power consumption")
setwd("/Users/YanYang/code/Electric power consumption")
url <- c("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip")
download.file(url, destfile = "/Users/YanYang/code/Electric power consumption/electric_power_consumption.zip", method = "curl")
unzip("/Users/YanYang/code/Electric power consumption/electric_power_consumption.zip")
data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?")

library(dplyr)
data2 <- mutate(data, Date = paste(data$Date, data$Time))
data2 <- select(data2, -Time)
data2$Date <-  strptime(data2$Date, format = "%d/%m/%Y %H:%M:%S")
use <- subset(data2, subset=(Date >= "2007-02-01 00:00:00" & Date <= "2007-02-02 23:59:00"))
par(mfcol = c(2,2))
plot(x = use$Date, y = use$Global_active_power, ylab = "Global Active Power (kilowatts)", xlab = "", type = "l")

plot(x = use$Date, y = use$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
lines(x = use$Date, y = use$Sub_metering_2, col = "red")
lines(x = use$Date, y = use$Sub_metering_3, col = "blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

plot(x = use$Date, y = use$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")

plot(x = use$Date, y = use$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")

dev.copy(png, file = "plot4.png", height = 480, width = 480)
dev.off()



