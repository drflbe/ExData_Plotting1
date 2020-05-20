# Load necessary additional packages
library(tidyverse)
library(readr)
library(lubridate)

# Download datasets and unzip it

fileUrl <-  "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

download.file(fileUrl, destfile = "power.zip", method = "curl")

unzip(zipfile = "power.zip", exdir = "./")

# Read data into R using readR. To save memory the script will read only the required data

power <- read_delim("household_power_consumption.txt", col_names = FALSE, delim = ";", na = "?", skip = 66637, n_max = 2880)

names(power) <- c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3") 

power <- power %>%
        mutate(Date = dmy(Date))

# Create the plot

png(filename = "plot1.png", width = 480, height = 480)

with(power, hist(Global_active_power, main = "Global Active Power", col = "red", xlab = "Global Active Power (kilowatts)"))

dev.off()

