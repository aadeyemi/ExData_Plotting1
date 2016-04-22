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

data$newdate <- with(data, as.POSIXct(paste(Date, Time), format="%Y-%m-%d %H:%M:%S"))


png(file = "figure/plot3.png", bg = "white", width = 480, height = 480, units = "px")

par(mfrow=c(1,1))

plot(Sub_metering_1 ~ newdate, 
     data=data,
     type="l",
     lwd=1,
     ylab="Energy sub metering",
     xlab="")

lines(Sub_metering_2 ~ newdate, 
     data=data,
     type="l",
     lwd=1,
     col="red")

lines(Sub_metering_3 ~ newdate, 
      data=data,
      type="l",
      lwd=1,
      col="blue")

legend("topright", 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lwd=c(1,1),
       col = c("black", "red", "blue")
       )


dev.off()