#Chapter 8 from YaRrr!- Matrices and dataframes
#ANLY 506-51- B-2019/Summer - Exploratory Data Analytics
#Tejal Satish Kanase

# creating 3 vectors
x <- 1:5
y <- 6:10
z <- 11:15

# Create a matrix with x, y and z as columns
cbind(x, y, z)

# Create a matrix with x, y and z as rows
rbind(x, y, z)

# Create a matrix with numeric and character columns.
# It makes everything a character

cbind(c(1, 2, 3, 4, 5),
      c("a", "b", "c", "d", "e"))

# Create a matrix of the integers 1 to 10 with 5 rows and 2 columns

matrix(data = 1:10,
       nrow = 5,
       ncol = 2)

# Create a matrix of the integers 1 to 10 with 2 rows and 5 columns

matrix(data = 1:10,
       nrow = 2,
       ncol = 5)

# Create a matrix of the integers 1 to 10 with 2 rows and 5 columns
# Fill by rows instead of columns

matrix(data = 1:10,
       nrow = 2,
       ncol = 5,
       byrow = TRUE)

# Survey dataframe creation

survey <- data.frame("index" = c(1, 2, 3, 4, 5),
                     "sex" = c("m", "m", "m", "f", "f"),
                     "age" = c(99, 46, 23, 54, 23))
# display survey
survey

# structure of survey dataframe
str(survey)

# create survey data without factors
survey <- data.frame("index" = c(1, 2, 3, 4, 5),
                     "sex" = c("m", "m", "m", "f", "f"),
                     "age" = c(99, 46, 23, 54, 23),
                     stringsAsFactors = FALSE)
# structure of survey dataframe without factors
str(survey)

# take a peek at ChickWeight dataset

head(ChickWeight)
tail(ChickWeight)
View(ChickWeight)

# View summary statistics of ToothGrowth
summary(ToothGrowth)
# toothGrowth Structure
str(ToothGrowth)

# Column names in the ToothGrowth dataframe
names(ToothGrowth)

# len column of ToothGrowth
ToothGrowth$len

# Mean of Length
mean(ToothGrowth$len)

# Table of the supp column of ToothGrowth.
table(ToothGrowth$supp)


# len & supp columns of ToothGrowth
head(ToothGrowth[c("len", "supp")])

# New dataframe survey
survey <- data.frame("index" = c(1, 2, 3, 4, 5),
                     "age" = c(24, 25, 42, 56, 22))

# Add a new column sex
survey$sex <- c("m", "m", "f", "f", "m")

# View survey
survey

# Change the name of column to "participant.number"
names(survey)[1] <-"participant.number"

# Change the age column to age.years
names(survey)[names(survey) == "age"] <- "years"

# Slicing DataFrame
ToothGrowth[1:6, 1]

# Slicing Matrices on index for first 3 rows for columns 1 and 3
ToothGrowth[1:3, c(1,3)]

# Slice the 1st row and all columns of ToothGrowth
ToothGrowth[1, ]

# Slice the 2nd Column  of ToothGrowth
ToothGrowth[, 2]

# New DataFrame with only the rows of ToothGrowth
# Where supp equals VC
ToothGrowth.VC <- ToothGrowth[ToothGrowth$supp == "VC", ]

# View the new DataFrame
head(ToothGrowth.VC)

# New DataFrame with only the rows of ToothGrowth
# Where supp equals OJ and dose < 1

ToothGrowth.OJ.a <- ToothGrowth[
  ToothGrowth$supp == "OJ" &
  ToothGrowth$dose < 1, ]

# Peek at the new DataFrame
head(ToothGrowth.OJ.a)

# Subset the DataSet
# Where len < 20 & supp == "OJ" & dose >= 1
subset(x = ToothGrowth,
       subset = len < 20 &
         supp == "OJ" &
         dose >= 1)

# Subset the DataSet
# len > 30 & supp == "VC"
# Returns onlylen and dose columns
subset(x = ToothGrowth,
       subset = len > 30 & supp == "VC",
       select = c(len, dose))

# mean tooth length of guinea pigs given OJ

# Subset DataFrame
oj <- subset(x = ToothGrowth,
             subset = supp == "OJ")

# Calculate the mean of the len column
mean(oj$len)

# Health Data Frame 
health <- data.frame("age" = c(32, 24, 43, 19, 43),
                  "height" = c(1.75, 1.65, 1.50, 1.92, 1.80),
                  "weight" = c(70, 65, 62, 79, 85))

# peek at the new dataframe
head(health)

# BMI = weight/height^2
# Compute DMI

bmi = health$weight / health$height ^ 2

# With function to save to a new column
with(health, height / weight ^ 2)

# Chapter 20 
# Vectors

library(tidyverse)
typeof(letters)

# Vectors
# Check types
typeof(1:10)

# Determine what's length
x <- list("a", "b", 1:10)
length(x)

# Logical Vectos
1:10 %% 3 == 0

# Construct a Vector in R
c(TRUE, TRUE, FALSE, NA)

# Numeric Vectors
# Square root of 2
x <- sqrt(2) ^ 2

# x
x
x-2

# Special values for NA for int & double
c(-1, 0, 1) / 0

# Amount of memory used by duplicated strings
library(pryr)
x <- "This is a reasonably long string."
pryr::object_size(x)

y <- rep(x, 1000)
pryr::object_size(y)

# Use Coercion on a logical vector in a numeric context
# Find the Mean and Sum of the values that are greater than 10
x <- sample(20, 100, replace = TRUE)
y <- x > 10
sum(y)
mean(y)

# Vector Containing Mutiple Types of Objects
typeof(c(TRUE, 1L))
typeof(c(1L, 1.5))
typeof(c(1.5, "a"))

# Scalar & Mathematical operations on those vectors
sample(10) + 100
runif(10) > 0.5

# Add 2 vectors of varied lengths
1:10 + 1:2
1:10 + 1:3

# Create Tables using repeated Vectors
tibble(x = 1:4, y = rep(1:2, 2))
tibble(x = 1:4, y = rep(1:2, each = 2))

# Naming vectors as x,y,z or a,b,c
c(x = 1, y = 2, z = 4)
set_names(1:3, c("a", "b", "c"))

# Subsetting with +ve integers keeps the elements 
# at those positions:
x <- c("one", "two", "three", "four", "five")
x[c(3, 2, 5)]

# Repeat an option
x[c(1, 1, 5, 5, 5, 2)]

#Negative values drop the elements at the specified positions
x[c(-1, -3, -5)]

# If we mix positive and negative values, results in an error
x[c(1, -1)]

# Subsetting on 0 which doesn't return any values
x[0]

# Comparison Functions for vectors
x <- c(10, 3, NA, 5, 8, 1, NA)

# Available values of x
x[!is.na(x)]

# All even or non-available values of x
x[x %% 2 == 0]

# Subset it with a character vector:
x <- c(abc = 1, def = 2, xyz = 5)
x[c("xyz", "def")]

# Recursive Vectors
# List: hierarchical or tree-like structures
x <- list(1, 2, 3)
x

# Structure of x
str(x)

# Create a vector and view  the structure
x_named <- list(a = 1, b = 2, c = 3)
str(x_named)

# Create list with mix type of objects
y <- list("a", 1L, 1.5, TRUE)
str(y)

# Create list which consists of list of lists
z <- list(list(1, 2), list(3, 4))
str(z)

# List Examples / Visualization
x1 <- list(c(1, 2), c(3, 4))
x2 <- list(list(1, 2), list(3, 4))
x3 <- list(1, list(2, list(3)))

# Subsetting Lists
# There are three ways to subset a list
a <- list(a = 1:3, b = "a string", c = pi, d = list(-1, -5))

# Extracts Sub List
str(a[1:2])
str(a[4])

# Extracts Single Components
str(a[[1]])
str(a[[4]])

# Extracts Names Elements in a list
a$a
a[["a"]]

# Attributes to add arbitary metadata using attr()
x <- 1:10
attr(x, "greeting")
attr(x, "greeting") <- "Hi!"
attr(x, "farewell") <- "Bye!"
attributes(x)

#Generic Functions usage
methods("as.Date")
getS3method("as.Date", "default")

# View Categorical data that takes a fixed set of values
x <- factor(c("ab", "cd", "ab"), levels = c("ab", "cd", "ef"))
typeof(x)
attributes(x)


# View Dates and types/attributes of Dates
x <- as.Date("1971-01-01")
unclass(x)
typeof(x)
attributes(x)

# Portable Operating System Interface (POSIX) Dates
x <- lubridate::ymd_hm("1970-01-01 01:00")
unclass(x)

typeof(x)
attributes(x)

# tzone attribute controls how the time is printed
attr(x, "tzone") <- "US/Pacific"
x

attr(x, "tzone") <- "US/Eastern"
x

# POSIXlt
y <- as.POSIXlt(x)
typeof(y)
attributes(y)

# Tibbles act as augmented lists: 
# They have structure as class "tbl_df" + "tbl" + "data.frame"
tb <- tibble::tibble(x = 1:5, y = 5:1)
typeof(tb)
attributes(tb)


# Traditional R data.frames
df <- data.frame(x = 1:5, y = 5:1)
typeof(df)
attributes(df)
