# File: plot4.R
# Author: Mark D. Dixon
# Date: July 2014
# R script to plot measurements of electric power consumption in one 
# household with a one-minute sampling rate over a two day period of
# 2007-02-01 to 2007-02-02. The plot is constructed and saved as a 
# PNG file with a width of 480 pixels and a height of 480 pixels.
#  
# Data set can be found at:
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2F
#     household_power_consumption.zip
#
# Input file: household_power_consumption.txt
# Output file: plot4.png 
# 
# The input file must be unzipped and placed in a working directory 
# along with this script file.
# 
# This script creates four plots on a single page:
# 1. X-Y plot of Global_active_power vs. combined Date and Time
# 2. X-Y plot of Voltage vs. combined Date and Time
# 3. X-Y plot of Sub_metering_1, Sub_metering_2 
#      and Sub_metering_3 vs. combined Date and Time.
# 4. X-Y plot of Global_reactive_power vs. combined Date and Time

# Read input file into a data frame.
data = read.csv("household_power_consumption.txt", header=TRUE, sep=";", 
                  as.is=c(1,2), na.strings="?")

# Combine and convert the first two columns into a POSIXlt object
Date_Time = strptime(paste(data$Date, data$Time, sep=" "), 
                     format="%d/%m/%Y %H:%M:%S")

# Replace the first two columns of the data frame with Date_Time
data = cbind(Date_Time, data[ ,3:9])
# Remove Date_Time from the workspace
rm(Date_Time)

# Create a new data frame to include only data to plot
time_start_plot = "2007-02-01 00:00:00"
time_end_plot = "2007-02-02 24:00:00"
time_format = "%Y-%m-%d %H:%M:%S"
data_plot = subset(data,(data$Date_Time >= strptime(time_start_plot, 
                                                    format=time_format)
                         & data$Date_Time < strptime(time_end_plot, 
                                                     format=time_format)))
# Remove full data frame from the workspace
rm(data)

# Open the PNG graphics device and create the output file
png(filename = "plot4.png", width = 480, height = 480, units = "px")

# Set graphics parameter for two by two array of plots
par(mfrow = c(2,2))

# Create first plot (top left)
plot(data_plot$Date_Time, data_plot$Global_active_power, type="l", 
     xlab="", ylab="Global Active Power (kilowatts)")

# Create second plot (top right)
plot(data_plot$Date_Time, data_plot$Voltage, type="l", 
     xlab="datetime", ylab="Voltage")

# Create third plot (bottom left)
plot(data_plot$Date_Time, data_plot$Sub_metering_1, type="l",
     xlab=" ", ylab="Energy Sub Metering")
lines(data_plot$Date_Time, data_plot$Sub_metering_2, type="l",
      col="red")
lines(data_plot$Date_Time, data_plot$Sub_metering_3, type="l",
      col="blue")
legend("topright", lwd=2, col=c("black", "red", "blue"), bty="n",
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Create fourth plot (bottom right)
plot(data_plot$Date_Time, data_plot$Global_reactive_power, type="l", 
     xlab="datetime", ylab="Global_reactive_power")

# Close the graphics device
dev.off()
