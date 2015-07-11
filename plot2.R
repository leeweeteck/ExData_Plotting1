library(data.table)

# read in the data (assumes data is in the same directory)
dataFile <- "household_power_consumption.txt"
data <- fread(dataFile, colClasses = c(rep("character", 8), "numeric"))

# replace "?" with NA
data[data == "?"] <- NA

# convert "Date" from character to date class
data[, Date := as.Date(Date, format = "%d/%m/%Y")]

# create the subset of the data corresponding to "2007-02-01" & "2007-02-02"
plotData <- data[Date == "2007-02-01" | Date == "2007-02-02"]

# check if plotData contains NA
any(is.na(plotData))  # no NA values found

# create a timestamp column
plotData[, timeStamp := 
           as.POSIXct(paste(Date, Time), format = "%Y-%m-%d %H:%M:%S")]

# plot the line graph
plot(plotData$timeStamp, as.numeric(plotData$Global_active_power),
     type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")

# save a copy of the line graph to a PNG file
dev.copy(png, "plot2.png", width = 480, height = 480, units = 'px')
dev.off()

