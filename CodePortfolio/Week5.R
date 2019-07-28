#Chapter 12 from R for Data Science - Tidy data
#ANLY 506-51- B-2019/Summer - Exploratory Data Analytics
#Tejal Satish Kanase

library(tidyverse)

# representing same data in multiple ways

table1
table2
table3

table4a
table4b


# calculate rate per 10,000. rate column is added.
table1 %>% mutate(rate = cases / population * 10000)

# calculate cases per year
table1 %>% count(year, wt = cases)


# Visualise trends over time
library(ggplot2)
ggplot(table1, aes(year, cases)) + 
  geom_line(aes(group = country), colour = "grey50") + 
  geom_point(aes(colour = country))

table4a
# gather columns in new pair of variables
table4a %>% gather('1999','2000',key="year",value="cases")

table4b
# gather columns in new pair of variables
table4b %>% gather('1999','2000',key="year",value="population")

tidy4a <- table4a %>% gather('1999','2000',key="year",value="cases")

tidy4b <- table4b %>% gather('1999','2000',key="year",value="population")
# combine tidied data tables 4a and 4b
left_join(tidy4a, tidy4b)


table2
# spread table2 data into columns
table2 %>% spread(key=type,value=count)

table3
#split rate into cases and population
table3 %>% separate(rate, into = c("cases", "population"))

# explicitly mention the separator
table3 %>% separate(rate, into = c("cases", "population"), sep = "/")

# convert data types from char wich is default to ints
table3 %>% separate(rate, into = c("cases", "population"), convert = TRUE)

# sepearte year into century and year
table3 %>% separate(year, into = c("century", "year"), sep = 2)

table5

# rejoin century and year
table5 %>% unite(new, century, year)

# to replace the _ between century and year with ""
table5 %>% unite(new, century, year, sep = "")

# Missing values

stocks <- tibble(
  year   = c(2015, 2015, 2015, 2015, 2016, 2016, 2016),
  qtr    = c(   1,    2,    3,    4,    2,    3,    4),
  return = c(1.88, 0.59, 0.35,   NA, 0.92, 0.17, 2.66)
)

stocks

# spread year and return
stocks %>% spread(year, return)

#spread and gather
stocks %>% spread(year, return) %>% gather(year, return, '2015':'2016', na.rm = TRUE)
         
stocks

#filling explicit NAs wherever necessary
stocks %>% 
  complete(year, qtr)

# creating treatment table
treatment <- tribble(
  ~ person,           ~ treatment, ~response,
  "Derrick Whitmore", 1,           7,
  NA,                 2,           10,
  NA,                 3,           9,
  "Katherine Burke",  1,           4
)

# fill missing values with most recent non missing values
treatment %>% fill(person)

# case study who dataset

who

# gather columns together to create a new key
who1 <- who %>% 
  gather(new_sp_m014:newrel_f65, key = "key", value = "cases", na.rm = TRUE)

who1

who1 %>%count(key)

# string replace to make key consistent
who2 <- who1 %>% 
  mutate(key = stringr::str_replace(key, "newrel", "new_rel"))

who2


who3 <- who2 %>% 
  separate(key, c("new", "type", "sexage"), sep = "_")

who3

who3 %>% count(new)

# drop columns new ,iso2 and iso3
who4 <- who3 %>% select(-new, -iso2, -iso3)

#split sexage into sex and age
who5 <- who4 %>% separate(sexage, c("sex", "age"), sep = 1)
who5

# who dataset is now completely tidy
who %>%
  gather(key, value, new_sp_m014:newrel_f65, na.rm = TRUE) %>% 
  mutate(key = stringr::str_replace(key, "newrel", "new_rel")) %>%
  separate(key, c("new", "var", "sexage")) %>% 
  select(-new, -iso2, -iso3) %>% 
  separate(sexage, c("sex", "age"), sep = 1)
who
