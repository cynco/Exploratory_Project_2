#### PLOT 2
#Have total emissions from PM2.5 decreased in the Baltimore City, MD from 1999 to 2008? 
##This plot shows the total PM2.5 emission from all sources for Baltimore City (fips=="24510") for each of the years 1999, 2002, 2005, and 2008.

##The data used is a National Emissions Inventory database of levels of fine particulate matter pollution in the United states over the 10-year period 1999–2008.

##Load required packages:
library(data.table)
#library(ggplot2)     ##Plots  3, 4,  6

#Check if file directory isn't already in working directory
if(   !file.exists("exdata-data-NEI_data")    ) { 
	##Check if zip file isn't already in working directory
	if (   !file.exists("exdata-data-NEI_data.zip")    ) {
		## If not: Download file
		myurl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
		download.file(url=myurl, method="curl", destfile="exdata-data-NEI_data.zip") 
		unzip("exdata-data-NEI_data.zip", exdir="exdata-data-NEI_data")
		}
	}
##The directory "exdata-data-NEI_data" contains files
##Source_Classification_Code.rds        -      myfiles[1]
##summarySCC_PM25.rds                   -       myfiles[2]
myfiles <- c("exdata-data-NEI_data/Source_Classification_Code.rds", "exdata-data-NEI_data/summarySCC_PM25.rds")

##Read data from file
SCC<-readRDS(myfiles[1]) 
NEI<-readRDS(myfiles[2])  
# Make data tables
codedt<-data.table(SCC)
emidt<- data.table(NEI)


totEmiBCdt<- emidt[ (fips=="24510") , .(Emissions=sum(Emissions)), by=year]   
##Open PNG device
png("plot2.png")
plot(totEmiBCdt$year, totEmiBCdt$Emissions/10^3, type="o", ylab="Total Emissions (kilotons)", xlab="Year", main="Plot 2: Total Emmissions for Baltimore City for 1999-2008")
dev.off()