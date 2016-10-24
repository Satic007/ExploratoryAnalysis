plot4 <- function(){
  library(dplyr)
  #Reading the RDS data into a vector
  NEI <- readRDS("summarySCC_PM25.rds")
  SCC <- readRDS("Source_Classification_Code.rds")
  #Renaming Emissions column Name
  NEI <- rename(NEI, PM=Emissions)
  
  #Selecting the records which Coal Combustion Emissions
  SCC_Coal <-  filter(SCC, EI.Sector == "Fuel Comb - Comm/Institutional - Coal")
  
  #Creating new data frame by filtering NEI records having Coal Combusiont Emissions
  NEI_Coal <- filter(NEI,SCC %in% SCC_Coal$SCC)
  
  #Summarizing the PM data grouping by year
  NEI_Coal_pm <- tapply(NEI_Coal$PM,NEI_Coal$year, sum)
  
  
  #Setting the parameters for plotting
  par(mfrow = c(1,1), mar = c(4,4,2,2))

  #Creating a plot
  png("plot4.png", width = 400, height = 400)
  
  #Draing the plot
  plot(NEI_Coal_pm, x = rownames(NEI_Coal_pm), ylab = expression("Total PM"[2.5] *" Emissions"),
       xlab="year", main = expression("Coal Related PM"[2.5]*" Emissions Across USA (1999 - 2008)"), 
       pch=19, col="purple")              
  lines(NEI_Coal_pm, x=rownames(NEI_Coal_pm), pch=16, col="red")
  
  dev.off()
  
}

