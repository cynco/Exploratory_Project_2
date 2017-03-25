# Analyze and visualize Fine particulate matter pollution according to the National Emissions Inventory of the EPA.

##Introduction

Fine particulate matter (PM2.5) is an ambient air pollutant for which there is strong evidence that it is harmful to human health. In the United States, the Environmental Protection Agency (EPA) is tasked with setting national ambient air quality standards for fine PM and for tracking the emissions of this pollutant into the atmosphere. Approximatly every 3 years, the EPA releases its database on emissions of PM2.5. This database is known as the National Emissions Inventory (NEI). You can read more information about the NEI at the EPA National Emissions Inventory web site (http://www.epa.gov/ttn/chief/eiinformation.html).
For each year and for each type of PM source, the NEI records how many tons of PM2.5 were emitted from that source over the course of the entire year. The data that you will use for this assignment are for 1999, 2002, 2005, and 2008.

##Data

The data for this assignment are available from the course web site as a single zip file:
Data for Peer Assessment (https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip) [29Mb]
The zip file contains two files:
PM2.5 Emissions Data ( summarySCC_PM25.rds ): This file contains a data frame with all of the PM2.5 emissions data for 1999, 2002, 2005, and 2008. For each year, the table contains number of tons of PM2.5 emitted from a specific type of source for the entire year. 

fips : A five-digit number (represented as a string) indicating the U.S. county

SCC : The name of the source as indicated by a digit string (see source code classification table) 

Pollutant : A string indicating the pollutant

Emissions : Amount of PM2.5 emitted, in tons

type : The type of source (point, non-point, on-road, or non-road)

year : The year of emissions recorded

##Results and Plots

1. Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base plotting system?  

![plot1](plot1.png)  

2. Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips=="24510")from 1999 to 2008?  
![plot2](plot2.png)  
3. Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? Which have seen increases in emissions from 1999–2008? Use the ggplot2 plotting system to make a plot answer this question.  
![plot3](plot3.png)  
4. Across the United States, how have emissions from coal combustion-related sources changedfrom 1999–2008?  
![plot4](plot4.png)  
5. How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?  
![plot5](plot5.png)  
6. Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California ( fips == "06037" ). Which city has seen greater changes over time in motor vehicle emissions?  
![plot6](plot6.png)  

Each .R file downloads the necessary data, tidies it and produces the corresponding plot. 
