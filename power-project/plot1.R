plot1 <- function(){
  library(dplyr)
  #Reading the RDS data into a vector
  if(!exists("NEI")){
    NEI <- readRDS("./exdata_data_NEI_data/summarySCC_PM25.rds")
  }
  

  #SCC <- readRDS("Source_Classification_Code.rds")
  #Renaming Emissions column Name
  NEI <- rename(NEI, PM=Emissions)
  
  #Creating new data frame with year and PM column data for all years
  NEI_sum <- NEI[,c(4,6)]
  
  #Summarizing the PM data grouping by year
  NEI_PM <- tapply(NEI_sum$PM, NEI_sum$year, sum) #Creates a num list vector
  #aggTotalByYear <- aggregate(PM ~ year, NEI, sum) #Creates a data frame
  #year_ag <- aggregate(Emissions~year,data = NEI,FUN=sum)
  
  
  #Setting the parameters for plotting
  par(mfrow = c(1,1), mar = c(4,4,2,2))

  #Creating a plot
  png("plot1.png", width = 400, height = 400)
  
  #Draing the plot
  plot(NEI_PM, x = rownames(NEI_PM), ylab = expression("Total PM"[2.5] *" Emissions"),
       xlab="year", main = expression("Total PM"[2.5]*" Emissions(1999 - 2008)"), 
       pch=19, col="purple")              
  lines(NEI_PM, x=rownames(NEI_PM), pch=16, col="blue")
  
  #=====**********Also shown through a bar plot*************====================
  #barplot(NEI_PM, height = aggTotalByYear$Emissions, names.arg = aggTotalByYear$year, 
  #       xlab = "Year", ylab = expression("Total PM"[2.5] *" Emissions"), 
  #      main=expression('Total PM'[2.5]*' emissions at various years'))
  #=================****************************************====================
  
  dev.off()
  
}

