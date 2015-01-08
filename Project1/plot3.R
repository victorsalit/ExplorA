# plot3.R - a script for plot3 - submeterings

# The data file contains measurements of electric power consumption in one 
# household with a one-minute sampling rate.
# The data columnes are:
# 1. Date: Date in format dd/mm/yyyy
# 2. Time: time in format hh:mm:ss
# 3. Global_active_power: household global minute-averaged active power (in kilowatt)
# 4. Global_reactive_power: household global minute-averaged reactive power (in kilowatt)
# 5. Voltage: minute-averaged voltage (in volt)
# 6. Global_intensity: household global minute-averaged current intensity (in ampere)
# 7. Sub_metering_1: energy sub-metering No. 1 (in watt-hour of active energy). 
#    It corresponds to the kitchen, containing mainly a dishwasher, an oven and a 
#    microwave (hot plates are not electric but gas powered).
#
# 8. Sub_metering_2: energy sub-metering No. 2 (in watt-hour of active energy). 
#    It corresponds to the laundry room, containing a washing-machine, a 
#    tumble-drier, a refrigerator and a light.
#
# 9. Sub_metering_3: energy sub-metering No. 3 (in watt-hour of active energy). 
#    It corresponds to an electric water-heater and an air-conditioner.

dataFile <- "household_power_consumption.txt"

# we use the read.csv with all the known settings to reduce the reading time
# and memory usage.
# to further reduce the reading time we could use the fread() from data.table
# package, however this particular function is not recommended yet:
# http://www.inside-r.org/packages/cran/data.table/docs/fread
data <- read.csv(dataFile, sep = ";", na.strings = "?", stringsAsFactors=FALSE, 
                 colClasses = c("character", "character", "numeric", "numeric", 
                                "numeric", "numeric", "numeric", "numeric", "numeric"),
                 comment.char="", quote="", header = TRUE)

# subsetting two days
twodays <- data[grep("^[12]/2/2007", data$Date), ]

# adding a DateTime column
twodays$DateTime <- paste(twodays$Date, twodays$Time)
twodays$DateTime <- strptime(twodays$DateTime, "%d/%m/%Y %H:%M:%S")

# plot creation
png(file = "plot3.png",width = 480, height = 480, units = "px")
plot(twodays$DateTime, twodays$Sub_metering_1, main = "", xlab = "",
     ylab = "Energy submetering", type = "l", col = "black")
lines(twodays$DateTime, twodays$Sub_metering_2, col = "red")
lines(twodays$DateTime, twodays$Sub_metering_3, col = "blue")
legend('topright',legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lty=1, col=c('black', 'red', 'blue'))
dev.off()
