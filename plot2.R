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
## Convert the "Global_active_power" column to numeric.
data$Global_active_power <- as.numeric(data$Global_active_power)

## Create png file "plot2.png"
png(filename = "plot2.png",
    width = 480,
    height = 480)

## Create the line plot Time versus Global Active Power.
plot(data$Date_time,
     data$Global_active_power,
     type="l",
     col="black",
     xlab="",
     ylab="Global Active Power (kilowatts)")

## Close png file.
dev.off()