plot4 <- function(){
  library(dplyr)
  #Reading the RDS data into a vector
  if(!exists("NEI")){
    NEI <- readRDS("./exdata_data_NEI_data/summarySCC_PM25.rds")
  }
  
  if (!exists("SCC")){
    SCC <- readRDS("Source_Classification_Code.rds")
  }
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
  
  #Drawing the plot
  plot(NEI_Coal_pm, x = rownames(NEI_Coal_pm), ylab = expression("Total PM"[2.5] *" Emissions"),
       xlab="year", main = expression("Coal Related PM"[2.5]*" Emissions Across USA (1999 - 2008)"), 
       pch=19, col="purple")              
  lines(NEI_Coal_pm, x=rownames(NEI_Coal_pm), pch=16, col="red")
  #Drawing a bar
  #g <- ggplot(NEI_Coal_pm, aes(factor(year), PM))
  #g <- g + geom_bar(stat="identity") + xlab("year") +  
  #  ylab(expression('Total PM'[2.5]*" Emissions")) +
  #  ggtitle('Total Emissions from 1999 to 2008 by coal')
  
  
  dev.off()
  
}

