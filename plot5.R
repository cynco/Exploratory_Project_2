#####################   PLOT 5
##This plot aims to answer the question: 

#How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?  
##This plot shows the total PM2.5 emission from motor vehicle sources sources for Baltimore City for each of the years 1999, 2002, 2005, and 2008.

##The data used is a National Emissions Inventory database of levels of fine particulate matter pollution in the United states over the 10-year period 1999–2008.

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


#Make dt with emissions data plus appropriate short name for every given SCC code.
emiCodedt<- merge(emidt, codedt[, c(1,3), with=F], by="SCC")
#Keep only rows also containing "Motor," and "motor."
motordt <- emiCodedt[grepl("Motor", emiCodedt$Short.Name, ignore.case=T) ,1:7, with=F ]
#Keep only rows also containing "Veh," "veh," "Vehicle," etc
motordt<-motordt[  grepl( "Veh", motordt$Short.Name, ignore.case=T )  , 1:7, with=F] 
#Keep only rows for Baltimore City
totEmiBCdt<- motordt[ (fips=="24510") , .(Emissions=sum(Emissions)), by=year]  
 
##Open PNG device
png("plot5.png")
plot(totEmiBCdt$year, totEmiBCdt$Emissions, ylab="Total Emissions (tons)", xlab="Year", main="Plot 5: Total Emmissions for motor vehicle sources \n for Baltimore City for 1999-2008")
dev.off()