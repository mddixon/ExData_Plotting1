# File: plot1.R
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
# Output file: plot1.png 
# 
# The input file must be unzipped and placed in a working directory 
# along with this script file.
# 
# This script creates a histogram plot of the Global_active_power 
# variable.

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
png(filename = "plot1.png", width = 480, height = 480, units = "px")

# Create histogram plot
hist(data_plot$Global_active_power, col="red", main="Global Active Power", 
     xlab="Global Active Power (kilowatts)")

# Close the graphics device
dev.off()
