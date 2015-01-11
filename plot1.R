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
png("plot1.png", width=480, height=480)
hist(data$Global_active_power, main="Global Active Power", xlab="Global Active Power (kilowatts)", col="red")
dev.off()
