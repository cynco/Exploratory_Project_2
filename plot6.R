#####################   PLOT 6

##This plot aims to answer the question: 

#Has Baltimore City or Los Angeles County seen greater changes over time in motor vehicle emissions?  ##This plot Compares emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California ( fips == "06037" ) for each of the years 1999, 2002, 2005, and 2008. 

##The data used is a National Emissions Inventory database of levels of fine particulate matter pollution in the United states over the 10-year period 1999–2008.

##Load required packages:
library(data.table)
library(ggplot2) 

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
#Keep only rows for Baltimore City and Los Angeles County
 totEmiBCdt<- motordt[ (fips=="24510" | fips== "06037") , .(Emissions=sum(Emissions)), by=.(fips, year)]  
 
##Open PNG device
png("plot6.png")
qp<-qplot(year, Emissions, data=totEmiBCdt, color=fips, geom="line", ylab="Total Emmissions (tons)",  main="Plot 6: total PM2.5 emission from motor vehicle sources \n for Baltimore City and Los Angeles County for 1999-2008.")
qp<- qp+scale_color_manual("Location\n",labels = c("Los Angeles County", "Baltimore City"), values = c("orange", "green"))
print(qp)
dev.off()