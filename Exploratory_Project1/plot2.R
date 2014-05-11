data <- read.table("household_power_consumption.txt",sep=";",header=T,na.strings="?",colClasses=c("character","character",rep("numeric",7)))
sub_data <- data[data$Date %in% c("1/2/2007","2/2/2007"),]
png(filename="plot2.png",width=480,height=480)
plot(strptime(paste(sub_data$Date,sub_data$Time),format = "%d/%m/%Y %H:%M:%S"),sub_data$Global_active_power,type="l",xlab="",ylab="Global Active Power (kilowatts)")
dev.off()