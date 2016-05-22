

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

# 3. Create an unique variable for sub_metering

data1 <- data[,c(7,10)]
data2 <- data[,c(8,10)]
data3 <- data[,c(9,10)]

colnames(data1)[1] <- "sub_metering"
colnames(data2)[1] <- "sub_metering"
colnames(data3)[1] <- "sub_metering"

type1 <- rep(1,times=nrow(data))
type2 <- rep(2,times=nrow(data))
type3 <- rep(3,times=nrow(data))

type1 <- as.data.frame(type1)
type2 <- as.data.frame(type2)
type3 <- as.data.frame(type3)

colnames(type1)[1] <- "type_sub_metering"
colnames(type2)[1] <- "type_sub_metering"
colnames(type3)[1] <- "type_sub_metering"

type <- rbind(type1, type2, type3)

data_sub_metering <- rbind(data1, data2, data3)
data_sub_metering <- cbind(data_sub_metering, type)


# 4. Final Plot 

# Weekdays in English
Sys.setlocale("LC_TIME", "English")

setwd("C:/Users/irene/Documents/Data Science - Coursera/4. Exploratory Data Analysis/Course Project")
png(filename = "plot4.png", width=480, height=480, units="px")
par(mfcol=c(2,2))

# Plot1
with(data,plot(complete_date,Global_active_power, type="l", ylab="Global Active Power (kilowatts)", xlab=""))

# Plot 2
with(data_sub_metering, plot(complete_date,sub_metering, ylab="Energy sub metering", xlab="", type="n"))
data_sub_metering$type_sub_metering <- as.factor(data_sub_metering$type_sub_metering)
with(subset(data_sub_metering, type_sub_metering==1), lines(complete_date,sub_metering,col="black"))
with(subset(data_sub_metering, type_sub_metering==2), lines(complete_date,sub_metering,col="red"))
with(subset(data_sub_metering, type_sub_metering==3), lines(complete_date,sub_metering,col="blue"))
legend("topright",lwd=2, col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty="n")

# Plot 3
with(data, plot(complete_date,Voltage, type="l", ylab="Voltage", xlab="datetime"))

# Plot 4
with(data, plot(complete_date,Global_reactive_power, type="l", ylab="Global_reactive_power", xlab="datetime"))


dev.off()
