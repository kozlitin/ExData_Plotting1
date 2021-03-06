library(dplyr)

raw_df <- read.csv2('household_power_consumption.txt', stringsAsFactors = FALSE, colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"), na.strings=c("?"), dec=".")
raw_df$DateTime <- as.POSIXct(strptime(paste(raw_df$Date,raw_df$Time),"%d/%m/%Y %H:%M:%S"))
tbl_df_filtered <- tbl_df(raw_df) %>% filter(DateTime>=strptime("01/02/2007 00:00:00","%d/%m/%Y %H:%M:%S") & DateTime<=strptime("02/02/2007 23:59:59","%d/%m/%Y %H:%M:%S"))

png(filename="plot4.png", width = 480, height = 480)

par(mfrow=c(2,2))

with(tbl_df_filtered, plot(DateTime, Global_active_power, type="l", xlab="", ylab="Global Active Power"))

with(tbl_df_filtered, plot(DateTime, Voltage, type="l", xlab="datetime", ylab="Voltage"))

with(tbl_df_filtered, plot(DateTime, Sub_metering_1, type="n", xlab="", ylab="Energy sub metering"))
with(tbl_df_filtered, lines(DateTime, Sub_metering_1, col="black"))
with(tbl_df_filtered, lines(DateTime, Sub_metering_2, col="red"))
with(tbl_df_filtered, lines(DateTime, Sub_metering_3, col="blue"))
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, col=c("black","red","blue"))

with(tbl_df_filtered, plot(DateTime, Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power"))

dev.off()