power_data <- function() {
  fl <- "household_power_consumption.txt"
  #Loading the text file data into a data frame
  dt_fr <- read.table(fl, header = TRUE, sep = ";", na="?",
                      colClasses = c("character","character", rep("numeric")))
  
  #Transforming the Time and Date column values accordingly
  dt_fr$Time <- strptime(paste(dt_fr$Date,dt_fr$Time),"%d/%m/%Y %H:%M:%S")
  dt_fr$Date <- as.Date(dt_fr$Date,"%d/%m/%Y")
  
  #Vector to store the dates to be filtered
  fltr_dts <- as.Date(c("2007-02-01","2007-02-02"),"%Y-%m-%d")
  
  #subsetting the data 
  dt_fr <- dt_fr[dt_fr$Date %in% fltr_dts,]
  
  return(dt_fr)
}