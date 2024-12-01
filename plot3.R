# set working directory to the pulled local repository
setwd("./ExData_Plotting1")

# use the necessary library
library(data.table)

# Load the dataset
data <- fread(
  "./household_power_consumption.txt", 
  header = TRUE, 
  sep = ";", 
  na.strings = "?"
)

# Change Date Column to Date Class
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")

# Filter the dates
data_subset <- data[data$Date %in% as.Date(c("2007-02-01", "2007-02-02"))]

# Combine Date and Time
datetime <- paste(data_subset$Date, data_subset$Time)
data_subset$DateTime <- as.POSIXct(datetime, format = "%Y-%m-%d %H:%M:%S")

# Create the png file
png(filename = "plot3.png", width = 480, height = 480)

# Create the plot
plot(Sub_metering_1 ~ DateTime, 
     data_subset, 
     type = "l", 
     ylab = "Energy sub metering", 
     xlab = NA)

lines(Sub_metering_2 ~ DateTime, data_subset, type = "l", col = "red")

lines(Sub_metering_3 ~ DateTime, data_subset, type = "l", col = "blue")

legend("topright", 
       col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", 
                  "Sub_metering_2", 
                  "Sub_metering_3"), 
       lty = 1)

dev.off()