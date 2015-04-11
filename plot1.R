library(dplyr)

##open png device
png(filename = "plot1.png", width = 480, height = 480)

##read in data
data <- read.table("./exdata-data-household_power_consumption/household_power_consumption.txt", sep = ";", na.strings = "?")

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

##create histogram and close device
hist(plotdata$V3, col = "red", main = "Global Active Power", xlab = "Global Active Power(kilowatts)", ylab = "Frequency")
dev.off()