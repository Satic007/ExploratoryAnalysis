plot2 <- function(){
  library(dplyr)
  #Reading the RDS data into a vector
  if(!exists("NEI")){
    NEI <- readRDS("summarySCC_PM25.rds")
  }
  

  #SCC <- readRDS("Source_Classification_Code.rds")
  #Renaming Emissions column Name
  NEI <- rename(NEI, PM=Emissions)
  
  #Creating new data frame with year and PM column data for all years
  NEI_bwi <- subset(NEI, fips=="24510")
  
  #Summarizing the PM data grouping by year
  NEI_bwi_PM <- tapply(NEI_bwi$PM, NEI_bwi$year, sum)
  
  
  #Setting the parameters for plotting
  par(mfrow = c(1,1), mar = c(4,4,2,2))
  
  #Creating a plot
  png("plot2.png", width = 400, height = 400)
  
  #Draing the plot
  plot(NEI_bwi_PM, x = rownames(NEI_bwi_PM), ylab = expression("Total PM"[2.5] *" Emissions"),
       xlab="Year", main = expression("Baltimore City's Total PM"[2.5]*" Emissions(1999 - 2008)"), 
       pch=19, col="purple")              
  lines(NEI_bwi_PM, x=rownames(NEI_bwi_PM), pch=16, col="blue")
  

  
  dev.off()
  
}

