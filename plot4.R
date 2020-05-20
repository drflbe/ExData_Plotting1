# Download dataset
library(tidyverse)
library(readr)
library(lubridate)

fileUrl <-  "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

download.file(fileUrl, destfile = "power.zip", method = "curl")

unzip(zipfile = "power.zip", exdir = "./")

power <- read_delim("household_power_consumption.txt", col_names = FALSE, delim = ";", skip = 66637, n_max = 2880)

names(power) <- c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3") 

power <- power %>%
        mutate(Date = dmy(Date)) %>%
        unite("datetime", Date, Time, sep = " ") %>%
        mutate(datetime = ymd_hms(datetime))

png(filename = "plot4.png", width = 480, height = 480)

par(mfcol = c(2,2))

# Plot 2

with(power, plot(datetime, Global_active_power, type = "l", xlab = " ", ylab = "Global Active Power"))

# Plot 3

with(power, plot(datetime, Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering"))

with(power, lines(datetime, Sub_metering_1, col = "black"))

with(power, lines(datetime, Sub_metering_2, col = "red"))

with(power, lines(datetime, Sub_metering_3, col = "blue"))

legend("topright", lty = 1, lwd=2, col = c("black","red","blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

# New Plot 1

with(power, plot(datetime, Voltage, type = "l", xlab = "datetime", ylab = "Voltage"))

# New Plot 2

with(power, plot(datetime, Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power"))

dev.off()

