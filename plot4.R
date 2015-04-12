#R Plotting Task for Exploratory Data Analysis, Course Project 1,
#Plot #4
#by Kimkinyona Fox


## The purpose of this code is to plot for plots on one page. 
## Plot 1:  DateTime vs. Global Active Power
## Plot 2:  DateTime vs. Energy sub metering vs.
## Plot 3:  DateTime vs. Voltage
## Plot 4:  DateTime vs. Global reactive power
## Plot 1 should be a line plot, all in black.  Plot 2 should
## be a line plot with
## Sub-metering 1 shown in black.
## Sub-metering 2 shown in red.
## Sub-metering 3 shown in blue.  There will be a legend in 
## the top right hand corner.  Plots 3 & 4 should be line 
## plots in black.
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
        
#Put 4 plots on one page.
#Plot to PNG device
            
        png (file = "plot4.png")
        
        par (mar = c(5.1, 4.1, 4.1, 2.1),
             oma = c(0, 0, 0, 0),
             mfcol = c(2,2))
        
        
        #plot 1
        with (final_data, plot(DateTime, Global_active_power,
                               col = "black",
                               xlab = "",
                               ylab = "Global Active Power",
                               type = "l",
                                ))
        
        
        #plot 2
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
        
        #add a legend in the top right hand corner,
        #shrink the legend size with cex parameter
        #turn off legend border with bty parameter
        legend ("topright", col = c("black", "blue", "red"),
                lwd = 1,
                cex = 0.9,
                bty = "n",
                legend = c("Sub_metering_1",
                           "Sub_metering_2", 
                           "Sub_metering_3"))
        
        
        #plots 3 & 4
        #set the range of the y axis with ylim parameter
        #set the size of the axis text (thus numbers shown)
        # with cex.axis parameter
        #set the size of the axis labels with cex.lab parameter
        with (final_data,{
                plot (DateTime, Voltage, col = "black", type = "l",
                      xlab = "datetime",
                      ylim = c(234,246))
                plot (DateTime, Global_reactive_power, col = "black", 
                      type = "l",
                      lwd = 0.1,
                      yaxp = c(0.0, 0.5, 5),
                      xlab = "datetime")
        })

        
        dev.off()
        
        
        
        
        
        