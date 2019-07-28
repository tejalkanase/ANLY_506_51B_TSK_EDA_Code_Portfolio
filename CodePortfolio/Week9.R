# Week 9 Data and Sampling Distributions
# ANLY 506-51- B-2019/Summer - Exploratory Data Analytics
# Tejal Satish Kanase

# Chapter 7

data(cars)

# create Plot
with(cars, plot(speed, dist))

# add labels

title("Speed Vs Distance")

# lattice plotting 
library(lattice)
state <- data.frame(state.x77, region = state.region)
#lattice plot for relating between life expectancy and income divided by region
xyplot(Life.Exp ~ Income | region, data = state, layout = c(4, 1))

#ggplot2
install.packages("ggplot2")
library(ggplot2)

data(mpg)
# qplot in ggplot used to quickly display some data
qplot(displ, hwy, data = mpg)

# chapter 8
# Graphic Devices

# plot function
with(faithful, plot(eruptions, waiting)) 

# add a title

title(main = "Old Faithful Geyser data")  

# create a pdf in working directory
pdf(file = "myplot.pdf")  
# check to see if myplot.pdf is created
list.files()

library(datasets)

# plot function
with(faithful, plot(eruptions, waiting)) 

# add a title

title(main = "Old Faithful Geyser data") 

#copying plots to a PNG file
dev.copy(png, file = "geyserplot.png") 
dev.off()

list.files()
