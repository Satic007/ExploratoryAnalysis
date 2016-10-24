plot5 <- function(){
  library(dplyr)
  #Reading the RDS data into a vector
  NEI <- readRDS("summarySCC_PM25.rds")
  SCC <- readRDS("Source_Classification_Code.rds")
  #Renaming Emissions column Name
  NEI <- rename(NEI, PM=Emissions)
  
  #subsetting SCC data to filter Vehicle related codes
  SCC_auto <- SCC %>% filter(grepl("Vehicles",EI.Sector)) %>% select(SCC) %>% unique
  
  #Filtering Baltimore data for SCC with Vehicle Emissions
  NEI_bwi <- subset(NEI, fips=="24510")
  NEI_bwi_auto <- filter(NEI_bwi, SCC %in% SCC_auto$SCC)
  
  
  #Summarizing the PM data grouping by year
  NEI_auto_pm <- tapply(NEI_bwi_auto$PM, NEI_bwi_auto$year, sum)
  
  
  #Setting the parameters for plotting
  par(mfrow = c(1,1), mar = c(4,4,4,4))

  #Creating a plot
  png("plot5.png", width = 400, height = 400)
  
  #Draing the plot
  plot(NEI_auto_pm, x = rownames(NEI_auto_pm), ylab = expression("Total PM"[2.5] *" Emissions"),
       xlab="year", main = expression("Baltimore City Motor Vehicle related PM"[2.5]*" Emissions(1999 - 2008)"), 
       pch=19, col="purple")              
  lines(NEI_auto_pm, x=rownames(NEI_auto_pm), pch=16, col="blue")
  
  dev.off()
  
}

