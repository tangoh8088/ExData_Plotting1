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

##Construct 4 graphs in plot
par(mfrow = c(2,2), mar = c(4,4,2,1))
with (datsub, { 
      plot(Global_active_power~DateTime, type = "l", ylab = "Global Active Power", xlab = "")
      plot(Voltage~DateTime, type = "l", ylab = "Voltage", xlab = "datetime")
      plot(datsub$Sub_metering_1~datsub$DateTime, type = "l", ylab = "Energy sub metering",xlab = "")
      lines(datsub$Sub_metering_2~datsub$DateTime, type = "l", col = "red")
      lines(datsub$Sub_metering_3~datsub$DateTime, type = "l", col = "blue")
      legend("topright", lwd = 1, col = c("black", "red", "blue"), bty = "n", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
      plot(Global_reactive_power~DateTime, type = "l", ylab = "Global_reactive_power", xlab = "datetime")
      })

##Copy to PNG file
dev.copy(png, "plot4.png", height = 480, width = 480)

dev.off()