# function for initialization:
# 1. definition of the working directory
# 2. enlargement of max.print to read in the large input file
# 3. loading the sqldf-package for defining sql queries
initialize<-function(workingdir){
        setwd(workingdir)
        options(max.print=99999999)
        if(!require('sqldf')){
                install.packages('sqldf')
        }
        library(sqldf)
}
# function to read in the required data 
# the required data are read in using an SQL statement
# after the required data is read in the function for plotting is called
readData<-function(inputfile){
        cols <- c("character", "character", rep("numeric", 7))
        data<-read.csv.sql(inputfile,sql = "SELECT * FROM file WHERE Date='1/2/2007' OR Date='2/2/2007'",header=TRUE,sep=";",colClasses=cols)
        createPlot1("plot1.png",data)
}
# function for plotting a histogram with the global active power
createPlot1<-function(outputfile,data){
        png(outputfile)
        hist(data$Global_active_power, main="Global Active Power",xlab="Global Active Power (kilowatts)", col="red")
        dev.off() # close the png device
}
# call the function for initialization
initialize("C:/Users/hobramsk/weiterbildung/exploratory data analysis/Project assignment1")
# call the function to read in the required data
readData("household_power_consumption.txt")



