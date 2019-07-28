#Chapter 4 - Week 3 - Exploratory Data Analysis
#ANLY 506-51- B-2019/Summer - Exploratory Data Analytics
#Tejal Satish Kanase

library(readr)
# read the csv file
USEPA<-read_csv("US EPA data 2017.csv")
# view the csv file
View(USEPA)

# removes spaces in the column names
names(USEPA)<-make.names(names(USEPA))
names(USEPA)

# Peek at the data
nrow(USEPA)
ncol(USEPA)
str(USEPA)
head(USEPA[,c(6:7,10)])
tail(USEPA[,c(7:8,11)])
table(USEPA$POC)


table(USEPA$Longitude)
head(USEPA$Longitude,1)

# Find Observations measured at the above Longitude
install.packages(dplyr)
library(dplyr)

# Filter the USEPA Data for the above Longitude and select the 4 Columns
# Observation count, State code, Sample Duration, Arithmetic Mean
filter(USEPA, Longitude == head(USEPA$Longitude,1)) %>% 
  select(`Observation.Count`,`State.Code`,
         `Sample.Duration`,`Arithmetic.Mean`)

# Filter Selection for State.Code == 01 and find all Observations
filter(USEPA, USEPA$'State.Code' == "01") %>% 
  select(`Observation.Count`,`State.Code`,
         `Sample.Duration`,`Arithmetic.Mean`) %>% 
  as.data.frame


# Unique States in the DataSet Count and Names

select(USEPA, State.Name) %>% 
  unique %>% 
  nrow

# Display unique States
unique(USEPA$State.Name)

View(USEPA)
# decile of the data
quantile(USEPA$Observation.Count, seq(0, 1, 0.1))

# rank the state and counties by Arithmetic.Mean
ranking <- group_by(USEPA, State.Name, County.Name) %>%
     summarize(USEPA = mean(USEPA$Arithmetic.Mean)) %>%
     as.data.frame %>%
     arrange(desc(USEPA))

# view head ranking
head(ranking)

# View  bottom 10 tail ranking
tail(ranking,10)

# number of observations for Lincoln county in Wyoming
filter(USEPA, State.Name == "Wyoming" & County.Name == "Lincoln") %>% 
  nrow
