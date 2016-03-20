#####################   PLOT 1

##This plot aims to answer the question: 

#Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
##This plot shows the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.



##Load required packages:
library(data.table)

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

totEmidt<- emidt[ , .(Emissions=sum(Emissions)), by=year]   
##Open PNG device
png("plot1.png")
plot(totEmidt$year, totEmidt$Emissions/10^3, type="o", ylab="Total Emissions (kilotons)", xlab="Year", main="Plot 1: Total Emmissions for the US for 1999-2008")
dev.off()








