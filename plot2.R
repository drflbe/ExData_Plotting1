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

png(filename = "plot2.png", width = 480, height = 480)

with(power, plot(datetime, Global_active_power, type = "l", xlab = " ", ylab = "Global Active Power (kilowatts)"))

dev.off()

