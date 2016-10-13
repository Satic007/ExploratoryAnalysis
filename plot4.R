source("power_data.R")

plot4 <- function(df = NULL){
  #Loading the data
  if(is.null(df)){
    df <- power_data()
  }
  
  #creating png file
  png("plot4.png", width = 400, height = 400)
  
  #Setting the Plotting Area 2X2 column wise
  par(mfcol = c(2,2))
  #Creating first Plot @ Top Left
  plot(df$Time,df$Global_active_power, type = "l",
       xlab = "", ylab = "Global Active Power (kilowats)")
  
  #Creating Second Plot @ Bottom Left
  plot(df$Time,df$Sub_metering_1, type = "l",
       xlab = "", ylab = "Energy sub metering")
  #=====Drawing additional plots 
  lines(df$Time,df$Sub_metering_2, col="red")
  lines(df$Time,df$Sub_metering_3, col="blue")
  #====Adding Legend; 
  legend("topright", 
         legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
         col = c("black","red","blue"),
         lty=1, bty="n", cex = 0.75)
  
  #Creating Third Plot #Top Right
  plot(df$Time, df$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")
  
  #Creating Fourth Plot #Bottom Right
  plot(df$Time, df$Global_reactive_power, type = "l", 
       xlab = "datetime", ylab = "Global_reactive_power")
  
  dev.off()
}