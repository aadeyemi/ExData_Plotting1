##-----------------------------------
## Read in data
##-----------------------------------
alldata0 <- read.table(unz("exdata_data_household_power_consumption.zip","household_power_consumption.txt"),sep=";",header = T)
alldata <- as.data.frame(alldata0)
alldata$Date <- as.Date(as.character(alldata$Date),"%d/%m/%Y")
subset_data <- alldata[alldata$Date>=as.Date("2007-02-01") & alldata$Date<=as.Date("2007-02-02"),]

# convert ? to NA in table if any
subset_data0 <- subset_data
for (i in 1:ncol(subset_data) ) {
    subset_data0[,i] <- as.character(subset_data0[,i])
    subset_data0[,i] <- gsub(subset_data0[,i],pattern="\\?",replacement=NA)
}

# check for NAs
for (i in 1:ncol(subset_data)) {
    print(any(is.na(subset_data0[,i])))
}

# write subset data to csv file
write.csv(subset_data0, file = "household_power_consumption.csv")


##-----------------------------------
## Make Plots
##-----------------------------------
data <- read.csv("household_power_consumption.csv")
data$Date <- as.Date(as.character(data$Date))

data$datetime <- with(data, as.POSIXct(paste(Date, Time), format="%Y-%m-%d %H:%M:%S"))


png(file = "figure/plot4.png", bg = "transparent")

par(mfrow=c(2,2), mar=c(5,4.5,4,2), oma=c(0,0,2,0))

# subplot 1,1
plot(Global_active_power ~ datetime, 
     data=data,
     type="l",
     ylab="Global Active Power",
     xlab="")

# subplot 1,2
plot(Voltage ~ datetime, 
     data=data,
     type="l",
     ylab="Voltage")

# subplot 2,1
plot(Sub_metering_1 ~ datetime, 
     data=data,
     type="l",
     lwd=1,
     ylab="Energy sub metering",
     xlab="")

lines(Sub_metering_2 ~ datetime, 
      data=data,
      type="l",
      lwd=1,
      col="red")

lines(Sub_metering_3 ~ datetime, 
      data=data,
      type="l",
      lwd=1,
      col="blue")

legend("topright", 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lwd=c(1,1),
       col = c("black", "red", "blue")
)

# subplot 2,2
plot(Global_reactive_power ~ datetime, 
     data=data,
     lwd=0.5,
     type="l")

points(Global_reactive_power ~ datetime, 
      data=data,
      pch=20)


dev.off()
