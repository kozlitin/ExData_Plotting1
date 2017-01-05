library(dplyr)

raw_df <- read.csv2('household_power_consumption.txt', stringsAsFactors = FALSE, colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"), na.strings=c("?"), dec=".")
raw_df$DateTime <- as.POSIXct(strptime(paste(raw_df$Date,raw_df$Time),"%d/%m/%Y %H:%M:%S"))
tbl_df_filtered <- tbl_df(raw_df) %>% filter(DateTime>=strptime("01/02/2007 00:00:00","%d/%m/%Y %H:%M:%S") & DateTime<=strptime("02/02/2007 23:59:59","%d/%m/%Y %H:%M:%S"))
png(filename="plot1.png", width = 480, height = 480)
hist(tbl_df_filtered$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.off()