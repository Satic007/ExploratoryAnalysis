source("power_data.R")

plot3 <- function(df = NULL){
  #Loading the data
  if(is.null(df)){
    df <- power_data()
  }
  
  #creating png file
  png("plot3.png", width = 400, height = 400)
  
  #creating X-Y plot
  plot(df$Time,df$Sub_metering_1, type = "l",
       xlab = "", ylab = "Energy sub metering")
  #Drawing additional plots 
  lines(df$Time,df$Sub_metering_2, col="red")
  lines(df$Time,df$Sub_metering_3, col="blue")
  #Adding Legend
  legend("topright", 
         legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
         col = c("black","red","blue"),
         lty=1)
  
  dev.off()
}