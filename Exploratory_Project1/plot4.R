data <- read.table("household_power_consumption.txt",sep=";",header=T,na.strings="?",colClasses=c("character","character",rep("numeric",7)))
sub_data <- data[data$Date %in% c("1/2/2007","2/2/2007"),]
png(filename="plot4.png",width=480,height=480)
par(mfrow = c(2, 2))
with(sub_data, {
  plot(strptime(paste(sub_data$Date,sub_data$Time),format = "%d/%m/%Y %H:%M:%S"),sub_data$Global_active_power,type="l",xlab="",ylab="Global Active Power (kilowatts)")
  plot(strptime(paste(sub_data$Date,sub_data$Time),format = "%d/%m/%Y %H:%M:%S"),sub_data$Voltage,type="l",xlab="",ylab="Voltage")
  with(sub_data,plot(strptime(paste(sub_data$Date,sub_data$Time),format = "%d/%m/%Y %H:%M:%S"),sub_data$Sub_metering_1,type="l",xlab="",ylab="Energy sub metering"))
  with(sub_data,lines(strptime(paste(sub_data$Date,sub_data$Time),format = "%d/%m/%Y %H:%M:%S"),sub_data$Sub_metering_2,type="l",col="red"))
  with(sub_data,lines(strptime(paste(sub_data$Date,sub_data$Time),format = "%d/%m/%Y %H:%M:%S"),sub_data$Sub_metering_3,type="l",col="blue"))
  legend("topright",legend=c("sub_metering_1","sub_metering_2","sub_metering_3"),lty = 1,col=c("black","red","blue"))
  plot(strptime(paste(sub_data$Date,sub_data$Time),format = "%d/%m/%Y %H:%M:%S"),sub_data$Global_reactive_power,type="l",xlab="",ylab="Global Reactive Power (kilowatts)")
})
dev.off()