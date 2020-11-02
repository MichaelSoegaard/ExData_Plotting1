library(dplyr)
library(lubridate)

data <- read.table('data/household_power_consumption.txt', sep = ';', header = TRUE)
data$Time <- dmy_hms(paste(data$Date, data$Time, sep = ','))

sub_data <- subset(data, select = -Date, subset = (Time >= '2007-02-01' & Time < '2007-02-03'))
sub_data[,2:7] <- lapply(sub_data[,2:7], function(x) as.numeric(as.character(x)))

# Remove any rows containing '?'
sub_logical <- apply(sub_data, 1, function(x) any(x != "?"))
sub_data <- sub_data[sub_logical,]

# We open a .png writer, make the histogram and then closes the writer again 
png(filename="plot1.png")
hist(sub_data$Global_active_power,
        col = 'red',
        xlab = 'Global Active Power (kilowatts)', 
        ylab = 'Frequency',
        main = 'Global Active Power')
dev.off()
