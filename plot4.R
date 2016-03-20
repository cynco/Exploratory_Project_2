
##This plot aims to answer the question: 

#Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008? 
##This plot shows the total PM2.5 emission from coal combustion-related sources for the US for each of the years 1999, 2002, 2005, and 2008.

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
#Keep only rows also containing "Coal," "coal."
coaldt <- emiCodedt[grepl("Coal|coal", emiCodedt$Short.Name)  ,1:7, with=F ]
#Keep only rows also containing "Comb," "comb," "Combustion," etc
coaldt<-coaldt[  grepl( "Comb|comb", coaldt$Short.Name )  , 1:7, with=F] 
totEmidt<- coaldt[  , .(Emissions=sum(Emissions)), by=.(year)]  


##Open PNG device
png("plot4.png")
##	Make plot with ggplot
gp<- ggplot(data=totEmidt, aes(x=year, y=Emissions))
gp<- gp+geom_line()+ylab("Total Emmissions (tons)")+labs(title="Plot 4: total PM2.5 emission from all coal combustion sources \nfor the US for 1999-2008.")
print(gp)
dev.off()