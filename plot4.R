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
par(mfrow = c(2, 2), mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0))
with(data, {

        
        plot(datetime, as.numeric(data$Global_active_power), type="l", ylab="Global Active Power (Kilowatts)", xlab="")
        
        plot(datetime, as.numeric(data$Voltage), type="l", ylab="Voltage")
        
        plot(datetime, as.numeric(data$Sub_metering_1), type="n", ylab="Energy sub metering", xlab="")
        lines(datetime, as.numeric(data$Sub_metering_1))
        lines(datetime, as.numeric(data$Sub_metering_2), col="red")
        lines(datetime, as.numeric(data$Sub_metering_3), col="blue")
        
        plot(datetime, as.numeric(data$Global_reactive_power), type="l", ylab="Global Reactive Power")
        
        
})


# copy plot to png
dev.copy(png, file = "plot4.png") ## Copy my plot to a PNG file
dev.off() ## close the PNG device!
