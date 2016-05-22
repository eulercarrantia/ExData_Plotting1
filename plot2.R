# 1. Getting data 

household_power_consumption <- read.csv("~/Data Science - Coursera/4. Exploratory Data Analysis/Course Project/exdata-data-household_power_consumption/household_power_consumption.txt", sep=";", na.strings="?")

data <- household_power_consumption[which((household_power_consumption$Date=="1/2/2007" | household_power_consumption$Date=="2/2/2007")),]


# 2. Convert the Date and Time variables to Date/Time classes

data$Date <- as.character(data$Date)
data$Date <- as.Date(data$Date, "%d/%m/%Y")
data$Time <- as.character(data$Time)
complete_date <- paste(data$Date, data$Time)
complete_date <- strptime(complete_date, "%Y-%m-%d %H:%M:%S")

data <- cbind(data,complete_date)

# 3. Plot 2

# Weekdays in English
Sys.setlocale("LC_TIME", "English")

setwd("C:/Users/irene/Documents/Data Science - Coursera/4. Exploratory Data Analysis/Course Project")

png(filename = "plot2.png", width=480, height=480, units="px")
with(data, plot(complete_date,Global_active_power, type="l", ylab="Global Active Power (kilowatts)", xlab=""))
dev.off()
