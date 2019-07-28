#Chapter 9 - Week 2 - Importing, saving and managing data
#ANLY 506-51- B-2019/Summer - Exploratory Data Analytics
#Tejal Satish Kanase


# current working directory is /Users/tejalkanase
getwd()  

# Set working directory to your code portfolio folder
setwd(dir="/Users/tejalkanase/Desktop/EDA")

# Lists the current Directory
ls()

# Example 1 - Sample Data Frame

study1.df <- data.frame(id = 1:5, 
                        sex = c("m", "m", "f", "f", "m"), 
                        score = c(51, 20, 67, 52, 42))
# display study1.df
study1.df

score.by.sex <- aggregate(score ~ sex, 
                          FUN = mean, 
                          data = study1.df)
# mean score by gender
score.by.sex

study1.htest <- t.test(score ~ sex, 
                       data = study1.df)
# display t.test results
study1.htest

# saving all the three objects in a .Rdata file
save(study1.df, score.by.sex, study1.htest,
     file = "/Users/tejalkanase/Desktop/EDA/study1.RData")

# load study1.Rdata in my workspace
load(file="study1.RData")

write.table(x = airquality,
            file = "airquality.txt",  # Save the file as airquality.txt
            sep = "\t")               # in a tab-delimited file

# view the list of files in working directory. Verify that airquality.txt was created
list.files()

# read the airquality.txt that was created above
mydata <- read.table(file = 'airquality.txt',     # file is in my working directory
                     sep = '\t',                  # file is tab--delimited
                     header = TRUE,               # the first row of the data is a header row
                     stringsAsFactors = FALSE)    # strings to factors set to false

# View mydata 
View(mydata)

# reading the file from the web URL
mydatafromweb <- read.table(file = 'http://goo.gl/jTNf6P',
                      sep = '\t',
                      header = TRUE)
# display mydatafromweb
mydatafromweb

# remove object mydata from my the working directory
rm(mydata)
# verify that mydata was removed by displaying all the objects in working direcotry
ls()
