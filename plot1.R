## First download and unzip the dataset at 
## https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
## and make sure it is saved in a file called "household_power_consumption.txt".
if (!("household_power_consumption.txt" %in% dir())) {
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
                  "household_power_consumption.zip",
                  "curl")
    unzip("household_power_consumption.zip", "household_power_consumption.txt")
    unlink("household_power_consumption.zip")
}

## Read in data txt file as table (it will read in the entire dataset
## (2,075,259 rows and 9 columns), so ensure you have enough memory space).
data <- read.table("household_power_consumption.txt",
                   header=TRUE,
                   sep=";",
                   na.strings = "?")

## Subset the entire dataset to just the rows that have the dates 
## 2007-02-01 and 2007-02-02.
data <- subset(data, Date %in% c("1/2/2007", "2/2/2007"))
## Reset the row indices.
rownames(data) <- NULL

## Convert the "Global_active_power" column to numeric.
data$Global_active_power <- as.numeric(data$Global_active_power)

## Create png file "plot1.png"
png(filename = "plot1.png",
    width = 480,
    height = 480)

## Create the Global Active Power histogram.
hist(data$Global_active_power,
     col="red",
     xlab="Global Active Power (kilowatts)",
     ylab="Frequency",
     main="Global Active Power")

## Close png file.
dev.off()