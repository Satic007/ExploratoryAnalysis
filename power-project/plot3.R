plot3 <- function(){
  library(dplyr)
  library(ggplot2)
  #Reading the RDS data into a vector
  if(!exists("NEI")){
    NEI <- readRDS("./exdata_data_NEI_data/summarySCC_PM25.rds")
  }
  

  #SCC <- readRDS("Source_Classification_Code.rds")
  #Renaming Emissions column Name
  NEI <- rename(NEI, PM=Emissions)
  
  #Creating new data frame with year and PM column data for all years
  NEI_bwi <- subset(NEI, fips=="24510")
  
  #Summarizing the PM data grouping by year and type
  sm <- group_by(NEI_bwi,year,type) %>% summarize(PM= sum(PM, na.rm=T))
  
  #Setting the parameters for plotting
  par(mfrow = c(1,1), mar = c(4,4,2,2))
  
  #Creating a plot
  png("plot3.png", width = 400, height = 400)
  
  #Draing the plot
  qplot(as.numeric(as.character(year)), PM, data=sm, color=type, geom=c("point","line"),
        xlab = "Year", ylab=expression("Total PM"[2.5]*"Emissions"),
        main = expression("Baltimore City's Total PM"[2.5] *"Emissions-Type Wise"))
  
  #Using ggplot
  #ggplot(sm,aes(x=year,y=PM,group=type,colour=type))+geom_line()
  
  
  dev.off()
  
}

