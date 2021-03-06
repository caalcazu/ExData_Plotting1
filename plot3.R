# Download data set Assignment 1: Exploratory Data Analysis

if (!file.exists("data")){
        dir.create("data")
}
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile ="./data/household_power_consumption.zip")
unzip("./data/household_power_consumption.zip", overwrite = T, exdir = "./data")


dateDownloaded <- date()


# Read household_power_consumption Data

HPC_Data <- read.table("./data/household_power_consumption.txt", header = TRUE, sep = ";", 
                       na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))

# Subset data from 1/02/2007 to 2/2/2007
HPC_Data1 <- HPC_Data[HPC_Data$Date %in% c("1/2/2007","2/2/2007"),]

# Merge Date and Time and convert to calendar dates
DateTime <-strptime(paste(HPC_Data1$Date, HPC_Data1$Time, sep=" "),"%d/%m/%Y %H:%M:%S")

# Merge information 
Finaldata <- cbind(DateTime, HPC_Data1)

# Create and save plot 3
plot(DateTime, Finaldata$Sub_metering_1, 
     ylim= range (c(Finaldata$Sub_metering_1, Finaldata$Sub_metering_2, Finaldata$Sub_metering_3)), 
     type = "l", xlab="", ylab="")
par(new= TRUE)
plot(DateTime, Finaldata$Sub_metering_2, 
     ylim= range (c(Finaldata$Sub_metering_1, Finaldata$Sub_metering_2, Finaldata$Sub_metering_3)), 
     type = "l", col="red", xlab="", ylab="")
par(new= TRUE)
plot(DateTime, Finaldata$Sub_metering_3, 
     ylim= range (c(Finaldata$Sub_metering_1, Finaldata$Sub_metering_2, Finaldata$Sub_metering_3)), type = "l", 
     col = "blue", xlab = "", ylab= "Energy sub metering")
legend("topright", legend =c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = 1)

dev.copy(png, file = "plot3.png", width =480, height = 480)
dev.off()
