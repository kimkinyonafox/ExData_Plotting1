#R Plotting Task for Exploratory Data Analysis, Course Project 1
#by Kimkinyona Fox


## The purpose of this code is to plot electric power consumption
## Global Active Power (in kilowatts) vs. Frequency
## The plot is a histogram, with red bars, having a title of 
## "Global Active Power".
## This plot will be constructed with the base plotting system


#load in the file, put dates in correct format
        ##read in text file
        data <-read.table("power_consumption_data/household_power_consumption.txt", 
                       header = TRUE,
                       #nrow = 500,
                       stringsAsFactors = TRUE,
                       na.strings = "?",
                       sep = ";")
        
        #only keep rows with dates 2/1/2007 thru 2/2/2007
        #keep all columns                           
        my_data <- subset (data, 
                        data$Date == "1/2/2007"|
                        data$Date == "2/2/2007", )        
                        
        
        #convert date and time from character to POSIXlt time  
        date_and_time <- paste (my_data$Date, my_data$Time, sep = " ")
        my_data$Time <- strptime(date_and_time, "%d/%m/%Y %H:%M:%S", 
                              tz = "UTC")

        
        #Change date column to day of the week
        my_data$Date <- strftime(my_data$Time, "%A")
        
        #adjust column names to reflect day of week & dateTime change
        my_names <- names(my_data)
        my_names[1] <- "Day"
        my_names[2] <- "DateTime"
        names(my_data) <- my_names
        


        final_data <- my_data
        

        
#Plot frequency of Global active power (in kilowatts)
#Plot to PNG device
        final_data$Global_active_power <- as.numeric (final_data$Global_active_power)
        
        png (file = "plot1.png")
        par (mar = c(5.1, 4.1, 4.1, 2.1),
             oma = c(0, 0, 2, 0))
 
        with (final_data, hist(Global_active_power,
                               main = "Global Active Power",
                               col = "red",
                               xlab = "Global Active Power (kilowatts)",
                               ))
        dev.off()
        
        
        
        
        
        