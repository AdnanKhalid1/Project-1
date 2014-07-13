# load data.table library that reads data faster, and load the data from working directory
library(data.table)
data = fread("household_power_consumption.txt", na.strings = "?")

# convert date column to class Date
data$Date = as.Date((data$Date), "%d/%m/%Y")

# subset the data so that only the required days are shortlisted 
data = data[data$Date %in% as.Date(c('2007-02-01', '2007-02-02')),]

# sort/order the data by time and then by day
data = data[order(data$Time),]
data = data[order(data$Date),]

# add a new variable that combines Date and Time variables into one variable
ccc = paste(data$Date, data$Time)

# convert above variable into a variable of class POSIXlt and call it 'datetime'
datetime <- strptime(ccc, "%Y-%m-%d %H:%M:%S")

# make the plot
plot(datetime, as.numeric(data$Sub_metering_1), type="n", ylab="Energy sub metering", xlab="")
lines(datetime, as.numeric(data$Sub_metering_1))
lines(datetime, as.numeric(data$Sub_metering_2), col="red")
lines(datetime, as.numeric(data$Sub_metering_3), col="blue")



# copy plot to png
dev.copy(png, file = "plot3.png") ## Copy my plot to a PNG file
dev.off() ## close the PNG device!
