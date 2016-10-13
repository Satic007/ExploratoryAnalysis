source("power_data.R")

plot1 <- function(df = NULL){
  #Loading the data
  if(is.null(df)){
    df <- power_data()
  }
  
  #creating png file
  png("plot1.png", width = 400, height = 400)
  
  #plotting a histogram
  hist(df$Global_active_power,xlab = "Global Active Power (kilowatts)", main = "Globla Active Power", col = "red")
  
  dev.off()
}