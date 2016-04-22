# setwd('C:/Work/DataScience/Projects/ExploratoryDataAnalysis/ExData_Plotting1')

# read in data
#alldata0 <- read.table("household_power_consumption.txt",sep=";",header = T)
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