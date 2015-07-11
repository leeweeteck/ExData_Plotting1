library(data.table)

# read in the data
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

# plot the histogram
hist(as.numeric(plotData$Global_active_power),
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)",
     col = 'red')

# save a copy of the histogram to a PNG file
dev.copy(png, "plot1.png", width = 480, height = 480, units = 'px')
dev.off()
