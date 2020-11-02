library(dplyr)
library(lubridate)

#Set local computer language to englsih to get weekdays in english
Sys.setlocale("LC_TIME", "C")

data <- read.table('data/household_power_consumption.txt', sep = ';', header = TRUE)
data$Time <- dmy_hms(paste(data$Date, data$Time, sep = ','))

sub_data <- subset(data, select = -Date, subset = (Time >= '2007-02-01' & Time < '2007-02-03'))
sub_data[,2:7] <- lapply(sub_data[,2:7], function(x) as.numeric(as.character(x)))

# Remove any rows containing '?'
sub_logical <- apply(sub_data, 1, function(x) any(x != "?"))
sub_data <- sub_data[sub_logical,]

plot(sub_data$Time, sub_data$Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)",
     xlab = "")

# We test for NAN's in dataset
if (sum(is.na(sub_data)) > 0) print('There is NAN values in dataset')

# We open a .png writer, make the plot and then closes the writer again 
png(filename="plot3.png")
plot(sub_data$Time, sub_data$Sub_metering_1, type = "l", col = 'black', ylab = "Global Active Power (kilowatts)",
     xlab = "")
lines(sub_data$Time, sub_data$Sub_metering_2, type = "l", col = 'red')
lines(sub_data$Time, sub_data$Sub_metering_3, type = "l", col = 'blue')
legend("topright",legend=names(sub_data[6:8]),
       col=c("black", "red", "blue"), lty = 1)
dev.off()

