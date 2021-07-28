## Read in data txt file as table (it will read in the entire dataset
## (2,075,259 rows and 9 columns), so ensure you have enough memory space).
data <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?")

## Subset the entire dataset to just the rows that have the dates 
## 2007-02-01 and 2007-02-02.
data <- subset(data, Date %in% c("1/2/2007", "2/2/2007"))
## Reset the row indices.
rownames(data) <- NULL

## Combine the "Date" and "Time" columns to have one "Date_time" column and
## then convert the column to POSIXlt, POSIXt classes.
data$Date <- paste(data$Date, data$Time)
data <- data[, !(names(data) %in% "Time")]
colnames(data) <- c("Date_time", names(data)[2:length(names(data))])
data$Date_time <- strptime(data$Date, "%d/%m/%Y %T")
## Convert the "Sub_metering_1" column to numeric.
data$Sub_metering_1 <- as.numeric(data$Sub_metering_1)
## Convert the "Sub_metering_2" column to numeric.
data$Sub_metering_2 <- as.numeric(data$Sub_metering_2)
## Convert the "Sub_metering_3" column to numeric.
data$Sub_metering_3 <- as.numeric(data$Sub_metering_3)

## Create png file "plot3.png"
png(filename = "plot3.png",
    width = 480,
    height = 480)

## Create the three line plots of Time versus Energy sub metering,
## with all three sub metering plots on the same graph, and with a legend.
plot(data$Date_time,
     data$Sub_metering_1,
     type = "n",
     xlab="",
     ylab="Energy sub metering")
lines(data$Date_time,
      data$Sub_metering_1,
      col="black")
lines(data$Date_time,
      data$Sub_metering_2,
      col="red")
lines(data$Date_time,
      data$Sub_metering_3,
      col="blue")
legend("topright",
       lty="solid",
       lwd="1",
       col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## Close png file.
dev.off()