# Guide for using R for simple analyses
# @author: smehrotra@umass.edu         
# Topics Covered                       
# 0. Download R and RStudio. Show the website 
# A quick introduction on R[control structures, decision making]
# 1. Get/Set a path.
# 2. Create a dataset. Read a simple dataset.(5 mins)(Include how to read a file(.csv))
# 3. A quick overview of data structures
# 4. Quick Aggregation and apply
# 5. Plotting my data (ggplot2)
# 6. What to do when I am stuck??? (A few tricks I learnt while fighting with R)(5 mins)


################## 0.0 A Quick Introduction to R  ##############################################
# 1. Free Programming Language mostly used for statistical analysis and graphics
# 2. Is supported on multiple operating systems
# 3. Utilized the RAM on your system
# 
# (Press Ctrl+Shift+C if you are accessing R Studio on Windows (MAC users use Command+Shift+C))
# Reference: https://support.rstudio.com/hc/en-us/articles/200711853-Keyboard-Shortcuts

################## 0.1 A Quick Introduction to R  ##############################################

# variables
my.variable = 400 # Press Ctrl+Enter at the end of this line. It is now available in your environment
your.variable = 600

sum.our.variables <- my.variable+your.variable # Arithmetic Operations (You can use = or <-. Its upto you)

# Note: DO NOT USE RESERVED WORDS AS VARIABLE NAMES.
#     : What is a reserved word? (Type ?reserved in the console below and see for yourself)

################## 1 Set Directory Path  ##############################################

path = "~/R"
# Note: Windows users please ensure you use '/' instead of '\'

setwd(path)
getwd() #Shows what is the present working directory

list.files()# list all the files in the directory


################## 2 Create a small dataset  ##############################################

class = c("410","585","324")
department = c("MIE","CS","CEE")
credits = c(3,3,2)

spring.workload = data.frame(class, department, credits)

# obtain elements, rows and columns
first.element = spring.workload[1,1]
print(first.element)
first.row = spring.workload[1,]
print(first.row)
first.column = spring.workload[,1]
print(first.column)

# filter data out
three.credit.courses = spring.workload[spring.workload$credits>2,]
print(three.credit.courses)

# Read a .csv file
read_test_csv = read.csv(file = "test.csv",header = T)
View(read_test_csv)
################## 3. A quick overview of data structures ##########################
# 
# Homogeneous	Heterogeneous
# 1d	Atomic vector	List
# 2d	Matrix	Data frame
# nd	Array

#Vector of different types
numeric_vector <- c(1, 2.5, 4.5)

# Logical Vector
logical_vector <- c(TRUE, FALSE)

# character vector
character_vectorr <- c("statistical", "quality","control")

# matrix 
matrix = matrix(c(1,2,3,4,5,6), nrow = 2, ncol = 3, byrow = TRUE)
dimnames(matrix) <- list(c("row1", "row2"),c("column1", "column2", "column3"))
print(matrix)

################## 4. Quick Aggregation and apply##########################

# mtcars is a predefined dataset that we would be using
#aggregate

View(x = mtcars)
?mtcars
# Get average horse power for cars with gears 3, 4 and 5

hp.gearwise = aggregate(x = mtcars$hp,by=list(mtcars$gear),FUN=mean)
colnames(hp.gearwise) = c("Gear","Avg. HP")
print(hp.gearwise)

# Alternate approach to obtaining the average
# Obtain the min miles per gallon for automatic vs manual transmission

mileage.transmission = tapply(X = mtcars$mpg,INDEX = mtcars$am,FUN = min)
# Some other apply functions
# lapply returns a list of the same length as X, each element of which is the result of applying FUN to the corresponding element of X.
# 
# sapply is a user-friendly version and wrapper of lapply by default returning a vector, matrix or, if simplify = "array", an array if appropriate, by applying simplify2array(). sapply(x, f, simplify = FALSE, USE.NAMES = FALSE) is the same as lapply(x, f).
# 
# vapply is similar to sapply, but has a pre-specified type of return value, so it can be safer (and sometimes faster) to use.

################## 5. Plotting my data (ggplot2)##########################


install.packages("ggplot2",dependencies = T)
library(ggplot2)
# You can also access it using the packages tab on the viewer
# Line chart

#Draw a line; try to convert the x axis as a factor
# Explore how to set custom y axis (Hint: explore ylim())
# Explore scales for x/y axis scale_x_log()
ggplot(data = BOD, aes(x=Time, y=demand)) + geom_line()

ggplot(BOD, aes(x=Time, y=demand)) + geom_line() + geom_point()

# Explore multilines
library(plyr)

# Summarize the ToothGrowth data
?ToothGrowth
View(ToothGrowth)

tg = aggregate(formula=len~supp+dose,data = ToothGrowth,FUN = sum)

# Based on color
ggplot(tg, aes(x=dose, y=len, colour=supp)) + geom_line()

#Based on line type
ggplot(tg, aes(x=dose, y=len, linetype=supp)) + geom_line()# Map supp to linetype

#Putting a point in the 
ggplot(BOD, aes(x=Time, y=demand)) +  geom_line() +  geom_point(size=4, shape=21, fill="white")

# Bar chart

install.packages("gcookbook",dependencies = T)
library(gcookbook)

# Simple Bar graph
ggplot(BOD, aes(x=Time, y=demand)) + geom_bar(stat="identity")
ggplot(BOD, aes(x =as.factor(Time),y=demand)) + geom_bar(stat="identity") # Can you spot the difference?

# Multiple Bar graph
View(cabbage_exp)

ggplot(cabbage_exp, aes(x=Date, y=Weight, fill=Cultivar)) +
  geom_bar(stat="identity",position="dodge", colour="black")

#Using a different scale for color
ggplot(cabbage_exp, aes(x=Date, y=Weight, fill=Cultivar)) +
  geom_bar(stat="identity",position="dodge", colour="black") +
  scale_fill_brewer(palette = "Pastel1")

# You can chose multiple color schemes from this resource: https://www.nceas.ucsb.edu/~frazier/RSpatialGuides/colorPaletteCheatsheet.pdf

# Frequency DIstribution graphs

ggplot(diamonds, aes(x=carat)) + geom_bar()

hist = ggplot(diamonds, aes(x=carat)) + geom_histogram()# Why have I assigned this to a variable?

# Title to the graphs
hist + labs(title = "FREQUENCY DISTRIBUTION", x = "CARATS", y = "FREQUENCY")


# Can I change the fonts?
hist + labs(title = "FREQUENCY DISTRIBUTION", x = "CARATS", y = "FREQUENCY")

# Scatter Plot
data = heightweight[, c("ageYear", "heightIn","sex")]

ggplot(data, aes(x=ageYear, y=heightIn)) + geom_point()
ggplot(data, aes(x=ageYear, y=heightIn)) + geom_point(shape=1.5)

# COlor
ggplot(data, aes(x=ageYear, y=heightIn,color=sex)) + geom_point()
# Shape
ggplot(data, aes(x=ageYear, y=heightIn,shape=sex)) + geom_point()


# Add a line to the scatter plot
ggplot(data, aes(x=ageYear, y=heightIn)) + geom_point() + geom_line() + geom_smooth(method = "lm")


##################6. What to do when I am stuck??? (A few tricks I learnt while working with R)
# help is underrated. Note what the options are
?help

# data structure mismatch is a common issue

is.array(data)#FALSE
is.data.frame(data)#TRUE

typeof(three.credit.courses)

class(mileage.transmission)
typeof(mileage.transmission)

# Resources for help

# ggplot2- R graphics cookbook
# https://r-dir.com/community/forums.html

