# Load necessary additional packages
library(tidyverse)
library(readr)
library(lubridate)

# Download datasets and unzip it

fileUrl <-  "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

download.file(fileUrl, destfile = "power.zip", method = "curl")

unzip(zipfile = "power.zip", exdir = "./")

# Read data into R using readR. To save memory the script will read only the required data

power <- read_delim("household_power_consumption.txt", col_names = FALSE, delim = ";", skip = 66637, n_max = 2880)

names(power) <- c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3") 

power <- power %>%
        mutate(Date = dmy(Date)) %>%
        unite("datetime", Date, Time, sep = " ") %>%
        mutate(datetime = ymd_hms(datetime))

# Create the plot

png(filename = "plot3.png", width = 480, height = 480)

with(power, plot(datetime, Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering"))

with(power, lines(datetime, Sub_metering_1, col = "black"))

with(power, lines(datetime, Sub_metering_2, col = "red"))

with(power, lines(datetime, Sub_metering_3, col = "blue"))

legend("topright", lty = 1, col = c("black","red","blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.off()

