#R Plotting Task for Exploratory Data Analysis, Course Project 1,
#Plot #2
#by Kimkinyona Fox


## The purpose of this code is to plot day vs.
## Global Active Power (in kilowatts) 
## The plot is a line plot, with no title and no xlab title. 
## This plot will be constructed with the base plotting system


#load in the file, put dates in correct format
        ##read in text file
        data <-read.table("power_consumption_data/household_power_consumption.txt", 
                       header = TRUE,
                       #nrow = 500,
                       stringsAsFactors = TRUE,
                       na.strings = "?",
                       sep = ";")
        
        #only keep rows with dates 2/1/2007 thru 2/3/2007
        #keep all columns                           
        my_data <- subset (data, 
                        data$Date == "1/2/2007"|
                        data$Date == "2/2/2007", )        
                        
        
        #convert date and time from character to POSIXlt time  
        date_and_time <- paste (my_data$Date, my_data$Time, sep = " ")
        my_data$Time <- strptime(date_and_time, "%d/%m/%Y %H:%M:%S", 
                              tz = "UTC")

        
        #adjust column name to reflect dateTime change
        my_names <- names(my_data)
        my_names[2] <- "DateTime"
        names(my_data) <- my_names
        
        
        final_data <- my_data
        final_data$Global_active_power <- as.numeric (final_data$Global_active_power)
        
        
        
#Plot DateTime vs. Global active power (in kilowatts)
#To make this a line plot, type = "l"
#Plot to PNG device
        
        
        png (file = "plot2.png")
        par (mar = c(5.1, 4.1, 4.1, 2.1),
             oma = c(0, 0, 0, 0),
             mfcol = c(1,1))
 
        with (final_data, plot(DateTime, Global_active_power,
                               col = "black",
                               xlab = "",
                               ylab = "Global Active Power (kilowatts)",
                               type = "l",
                               ))
        dev.off()
        
        
        
        
        
        