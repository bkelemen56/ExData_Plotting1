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
png("plot3.png", width=480, height=480)

plot(data$Datetime, data$Sub_metering_1, type="n", ylab="Energy sub metering", xlab="")
lines(data$Datetime, data$Sub_metering_1, col="black")
lines(data$Datetime, data$Sub_metering_2, col="red")
lines(data$Datetime, data$Sub_metering_3, col="blue")
legend("topright", lwd = 1, col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.off()
