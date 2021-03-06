plot6 <- function(){
  library(dplyr)
  library(ggplot2)
  #Reading the RDS data into a vector
  if(!exists("NEI")){
    NEI <- readRDS("summarySCC_PM25.rds")
  }
  
  if (!exists("SCC")){
    SCC <- readRDS("Source_Classification_Code.rds")
  }
  #Renaming Emissions column Name
  NEI <- rename(NEI, PM=Emissions)
  
  #subsetting SCC data to filter Vehicle related codes
  SCC_auto <- SCC %>% filter(grepl("Vehicles",EI.Sector)) %>% select(SCC) %>% unique
  
  #Creating new data frame by filtering Baltimore and Los Angeles data
  NEI_bwi_lax <- filter(NEI, fips %in% c("24510", "06037"))
  
  #Adding new column County
  NEI_bwi_lax <- mutate(NEI_bwi_lax, County=ifelse(fips=="24510", "Baltimore","Los Angeles"))
  
  #subsetting NEI data for Vehiclec emissions
  NEI_bwi_lax_auto <- filter(NEI_bwi_lax, SCC %in% SCC_auto$SCC)
  
  #Summarizing the PM data grouping by year and County
  sm <- group_by(NEI_bwi_lax_auto,year,County) %>% summarize(PM= sum(PM, na.rm=T))
  
  #Setting the parameters for plotting
  par(mfrow = c(1,1), mar = c(4,4,2,2))
  
  #Creating a plot area
  png("plot6.png", width = 400, height = 400)
  
  #Drawing the plot
  qplot(as.numeric(as.character(year)), PM, data=sm, color=County, geom=c("point","line"),
        xlab = "Year", ylab=expression("Motor Vehicle PM"[2.5]*"Emissions"),
        main = expression("LA and BAL Cities Vehicle PM"[2.5] *" Emissions (1999 - 2008)"))
        
  #Alternate #1, 
  #g <- ggplot(NEI_bwi_lax_auto, aes(year, PM, fill=County))
  #g+geom_bar(stat="identity",fill="blue",width=0.75) + facet_grid(. ~ County) + ggtitle("Emissions from motor Vehicles Baltmore vs LA")
  dev.off()
  
  
}

