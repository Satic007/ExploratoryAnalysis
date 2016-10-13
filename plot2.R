source("power_data.R")

plot2 <- function(df = NULL){
  #Loading the data
  if(is.null(df)){
    df <- power_data()
  }
  
  #creating png file
  png("plot2.png", width = 400, height = 400)
  
  #creating X-Y plot
  plot(df$Time,df$Global_active_power, type = "l",
       xlab = "", ylab = "Global Active Power (kilowats)")
  
  dev.off()
}