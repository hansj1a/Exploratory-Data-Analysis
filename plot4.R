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
        data<-read.csv.sql("household_power_consumption.txt",sql = "SELECT * FROM file WHERE Date='1/2/2007' OR Date='2/2/2007'",header=TRUE,sep=";",colClasses=cols)
        # build new variable with date and time of the measurements
        datetime<-paste(data$Date,data$Time)
        # change the class of the new variable into time format
        Date2<-strptime(datetime,format="%d/%m/%Y %H:%M:%S")
        # enlarge the data frame by a new column with the data and time of the measurements
        data$Date2<-Date2
        createPlot4("plot4.png",data)
}
# function for plotting the 4 diagrams 
createPlot4<-function(outputfile,data){
        png(outputfile)
        par(mfrow=c(2,2))
        with(data,plot(Date2,Global_active_power,type="l",xlab="",ylab="Global Active Power"))
        with(data,plot(Date2,Voltage,type="l",xlab="datetime",ylab="Voltage"))
        with(data,{
                plot(Date2,Sub_metering_1,type="l",xlab="",ylab="Energy sub metering")
                lines(Date2,Sub_metering_2,type="l",col="red")
                lines(Date2,Sub_metering_3,type="l",col="blue")
        })
        legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lwd="l",col=c("black","red","blue"))
        with(data,plot(Date2,Global_reactive_power,type="l",xlab="datetime",ylab="Global reactive power"))
        dev.off() # close the png device
}
# call the function for initialization
initialize("C:/Users/hobramsk/weiterbildung/exploratory data analysis/Project assignment1")
# call the function to read in the required data
readData("household_power_consumption.txt")