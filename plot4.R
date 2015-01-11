library(lubridate)

# read data and do some data class conversions
data <- read.csv("../data/household_power_consumption.txt", 
                 sep=";", 
                 colClasses=c(NA, NA, rep("numeric", 7)), 
                 na.strings=c("?"))

# we only need a subset of the observations
data$Date1 <- as.Date(data$Date, "%d/%m/%Y")
data <- data[data$Date1 >= as.Date("2007-02-01") & data$Date1 <= as.Date("2007-02-02"),]

# combine Date and Time into one variable
data$Datetime <- strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S", tz="")
data$Date <- NULL
data$Time <- NULL

# generate the plot
png("plot4.png", width=480, height=480)

par(mfrow = c(2, 2))

# plot 1 - upper left
plot(data$Datetime, data$Global_active_power, type="l", ylab="Global Active Power", xlab="")

# plot 2 - lower left
plot(data$Datetime, data$Voltage, type="l", ylab="Voltage", xlab="datetime")

# plot 3 - upper right
plot(data$Datetime, data$Sub_metering_1, type="n", ylab="Energy sub metering", xlab="")
lines(data$Datetime, data$Sub_metering_1, col="black")
lines(data$Datetime, data$Sub_metering_2, col="red")
lines(data$Datetime, data$Sub_metering_3, col="blue")
legend("topright", lwd = 1, bty = "n", col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
# plot 4 - upper right
plot(data$Datetime, data$Global_reactive_power, lwd = 0.5, type="l", ylab="Global_reactive_power", xlab="datetime")

dev.off()
