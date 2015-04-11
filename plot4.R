library(dplyr)

##read in data
data <- read.table("./exdata-data-household_power_consumption/household_power_consumption.txt", sep = ";", na.strings = "?")

##open png device
png(filename = "plot4.png", width = 480, height = 480)

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
plotdata[,2] <- as.numeric(as.character(plotdata[,2]))
plotdata[,3] <- as.numeric(as.character(plotdata[,3]))
plotdata[,4] <- as.numeric(as.character(plotdata[,4]))
plotdata[,5] <- as.numeric(as.character(plotdata[,5]))
plotdata[,6] <- as.numeric(as.character(plotdata[,6]))
plotdata[,7] <- as.numeric(as.character(plotdata[,7]))
plotdata[,8] <- as.numeric(as.character(plotdata[,8]))

##create plot and close device
par(mfrow = c(2, 2))
plot(plotdata$datetimes, plotdata$V3, type="n", xlab = "", ylab = "Global Active Power") 
lines(x = plotdata$datetimes, y = plotdata$V3, col = "black")
plot(plotdata$datetimes, plotdata$V5, type = "n", xlab = "datetime", ylab = "Voltage")
lines(x = plotdata$datetimes, y = plotdata$V5, col = "black")
plot(plotdata$datetimes, plotdata$V7, type="l", xlab = "", ylab = "Energy sub metering")
lines(plotdata$datetimes, plotdata$V8, col = "red")
lines(plotdata$datetimes, plotdata$V9, col = "blue")
legend(x = "topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), bty = "n", cex = .50, lwd = 1, lty = c(1, 1, 1))
plot(plotdata$datetimes, plotdata$V4, type="n", xlab = "datetime", ylab = "Global_reactive_power") 
lines(x = plotdata$datetimes, y = plotdata$V4, col = "black")
dev.off()