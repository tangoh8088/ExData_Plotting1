##Read the data
dat <- read.table("household_power_consumption.txt",header = TRUE, sep = ";", nrows = 1000000, na.strings = "?", stringsAsFactors = FALSE)

##Convert Date
dat$Date <- as.Date(dat$Date, format = "%d/%m/%Y")

##Load dplyr library
library(dplyr)

##Filter data by date
datsub <- filter(dat, dat$Date >= "2007-02-01" & dat$Date < "2007-02-03")

##Remove old data
rm(dat)

##Convert Date and Time
datsub$DateTime <- as.POSIXct(paste(as.Date(datsub$Date), datsub$Time))

##Construct line graph as PNG file
png(filename = "plot2.png", width = 480, height = 480, units = "px", bg = "white")

plot(datsub$Global_active_power~datsub$DateTime, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")

dev.off()