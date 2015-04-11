library(dplyr)

##read in data
data <- read.table("./exdata-data-household_power_consumption/household_power_consumption.txt", sep = ";", na.strings = "?")

##open png device
png(filename = "plot3.png", width = 480, height = 480)

##clean dates and times
datesubset <- data$V1
timesubset <- data$V2
x <- paste(datesubset, timesubset)
datetimes <- strptime(x, "%d/%m/%Y %H:%M:%S")

##combine clean dates with rest of table
restoftable <- select(data, V3:V9)
datedtable <- cbind(datetimes, restoftable)

##select correct dates and prepare data to plot
plotdata <- with(datedtable, datedtable[(datetimes >= "2007-2-1" & datetimes < "2007-2-3"), ])
plotdata[,6] <- as.numeric(as.character(plotdata[,6]))
plotdata[,7] <- as.numeric(as.character(plotdata[,7]))
plotdata[,8] <- as.numeric(as.character(plotdata[,8]))

##create plot and close device
plot(plotdata$datetimes, plotdata$V7, type="l", xlab = "", ylab = "Energy sub metering")
lines(plotdata$datetimes, plotdata$V8, col = "red")
lines(plotdata$datetimes, plotdata$V9, col = "blue")
legend(x = "topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lwd = 1, lty = c(1, 1, 1))
dev.off()
