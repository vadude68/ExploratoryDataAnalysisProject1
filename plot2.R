library(dplyr)

##read in data
data <- read.table("./exdata-data-household_power_consumption/household_power_consumption.txt", sep = ";", na.strings = "?")

##open png device
png(filename = "plot2.png", width = 480, height = 480)

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

##create plot and close device
plot(plotdata$datetimes, plotdata$V3, type="n", xlab = "", ylab = "Global Active Power (kilowatts)") 
lines(x = plotdata$datetimes, y = plotdata$V3, col = "black")
dev.off()