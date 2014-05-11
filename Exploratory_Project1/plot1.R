data <- read.table("household_power_consumption.txt",sep=";",header=T,na.strings="?",colClasses=c("character","character",rep("numeric",7)))
sub_data <- data[data$Date %in% c("1/2/2007","2/2/2007"),]
png(filename="plot1.png",width=480,height=480)
hist(sub_data$Global_active_power, xlab="Global Active Power (kilowatts)",col="red",main="Global Active Power")
dev.off()