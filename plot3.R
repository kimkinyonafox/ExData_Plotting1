#R Plotting Task for Exploratory Data Analysis, Course Project 1,
#Plot #3
#by Kimkinyona Fox


## The purpose of this code is to plot Energy sub metering vs.
## DateTime. 
## Sub-metering 1 will be colored black.
## Sub-metering 2 will be colored red.
## Sub-metering 3 will be colored blue.
## There will be a legend in the top right hand corner.
## The plot is a vertical line plot, with no title and no xlab title. 
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

        
        #Change date column to day of the week
        my_data$Date <- strftime(my_data$Time, "%A")
        
        #adjust column names to reflect day of week & dateTime change
        my_names <- names(my_data)
        my_names[1] <- "Day"
        my_names[2] <- "DateTime"
        names(my_data) <- my_names
        

        final_data <- my_data
        
        
#Plot DateTime vs. Global active power (in kilowatts)
#To make this a line plot, type = "l"
#Plot to PNG device
        final_data$Global_active_power <- as.numeric (final_data$Global_active_power)
        
        png (file = "plot3.png")
        par (mar = c(5.1, 4.1, 4.1, 2.1),
             oma = c(0, 0, 0, 0))
        
        #Just draw the plot frame, not the data
        with (final_data, plot(DateTime, Sub_metering_1,
                               xlab = "",
                               ylab = "Energy sub metering",
                               type = "n",
                                ))
        
        #draw in sub_metering_1 as a line, in black 
        with (final_data, points (DateTime, Sub_metering_1,
                               col = "black",
                               type = "l"
                               ))
        
        #draw in sub_metering_2 as a line, in red 
        with (final_data, points (DateTime, Sub_metering_2,
                                  col = "red",
                                  type = "l"
                                ))
        
        #draw in sub_metering_3 as a line, in blue 
        with (final_data, points (DateTime, Sub_metering_3,
                                  col = "blue",
                                  type = "l"
                                ))
        
        #add a legend in the top right hand corner
        legend ("topright", col = c("black", "blue", "red"),
                lwd = 1,
                legend = c("Sub_metering_1",
                           "Sub_metering_2", 
                           "Sub_metering_3"))
        dev.off()
        
        
        
        
        
        