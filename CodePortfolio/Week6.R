# Data Transformation
# ANLY 506-51- B-2019/Summer - Exploratory Data Analytics
# Tejal Satish Kanase

# Install nycflights13
library(nycflights13)
library(tidyverse)

# View Flights
flights

# Filter dataset based on values
filter(flights, month == 1, day == 1)

# Assignment operator <-
jan1 <- filter(flights, month == 1, day == 1)

# Both print and save to results
(dec25 <- filter(flights, month == 12, day == 25))

# Floating Point Arithmetic
sqrt(2) ^ 2 == 2
1 / 49 * 49 == 1

# near function approximates
near(sqrt(2) ^ 2,  2)
near(1 / 49 * 49, 1)

# Filter flights for November & December
filter(flights, month == 11 | month == 12)

# Shorthand %in%
nov_dec <- filter(flights, month %in% c(11, 12))

# Flights that are not delayed by more than 2 hours
filter(flights, !(arr_delay > 120 | dep_delay > 120))
filter(flights, arr_delay <= 120, dep_delay <= 120)


# Represents Unknown value so missing values are “contagious”
NA > 5 
NA == NA
x <- NA
y <- NA
x == y

# determine if a value is missing
is.na(x)

# Perserve missing values, mention explicitly
df <- tibble(x = c(1, NA, 3))
filter(df, x > 1)

filter(df, is.na(x) | x > 1)

# Ordering NYCFlights

# Arrange by Year, Month, Day
arrange(flights, year, month, day)

# Missing values are always sorted at the end
arrange(flights, desc(dep_delay))

# Another example using a tibble
df <- tibble(x = c(5, 2, NA))
arrange(df, x)

# Select filter on nyc Flights
select(flights, year, month, day)

# Select all between the year and day inclusive
select(flights, year:day)

# Select all except those from year to day inclusive
select(flights, -(year:day))

# Rename keeps varibles which are not explicitly mentioned
rename(flights, tail_num = tailnum)

# Another option is to use Select with everything to achieve the same result
select(flights, time_hour, air_time, everything())


# Create a Subset dataset 
flights_sml <- select(flights, 
                      year:day, 
                      ends_with("delay"), 
                      distance, 
                      air_time
)

# view the subset
View(flights_sml)

# Mutate creates columns at the end of the dataset
# gain and speed are the 2 new columns created
mutate(flights_sml,
       gain = dep_delay - arr_delay,
       speed = distance / air_time * 60
)

# Mutate can also refer to the columns just created inside it
# here use gain to compute gain_per_hour
mutate(flights_sml,
       gain = dep_delay - arr_delay,
       hours = air_time / 60,
       gain_per_hour = gain / hours
)

# To keep the newly created variables use transmute
transmute(flights,
          gain = dep_delay - arr_delay,
          hours = air_time / 60,
          gain_per_hour = gain / hours
)

# Mutate with arithmetic operations
# %% (remainder), %/% (integer division)
transmute(flights,
          dep_time,
          hour = dep_time %/% 100,
          minute = dep_time %% 100
)

# Lag and Lead Series, useful in Stocks backtesting
(x <- 1:10)
lag(x)
lead(x)

# Cumulative Operations 
# Cumulative Sum and mean
cumsum(x)
cummean(x)

# Ranking of datasets , different methods used
y <- c(1, 2, 2, NA, 3, 4)
min_rank(y)
min_rank(desc(y))
row_number(y)
dense_rank(y)
percent_rank(y)
cume_dist(y)

# Grouped Summaries of DataSet in a single row
summarise(flights, delay = mean(dep_delay, na.rm = TRUE))

# Summary grouped by date
by_day <- group_by(flights, year, month, day)
summarise(by_day, delay = mean(dep_delay, na.rm = TRUE))

# Group by Destination
by_dest <- group_by(flights, dest)

# Summarize the grouped by dataset
delay <- summarise(by_dest,
                   count = n(),
                   dist = mean(distance, na.rm = TRUE),
                   delay = mean(arr_delay, na.rm = TRUE)
)

# Create a subset on the count of Destination != HNL
delay <- filter(delay, count > 20, dest != "HNL") 

# Check if the delays increase with longer flight distances
ggplot(data = delay, mapping = aes(x = dist, y = delay)) +
  geom_point(aes(size = count), alpha = 1/3) +
  geom_smooth(se = FALSE)

# Combine multiple groupby and summarize  by pipe functions
delays <- flights %>% 
  group_by(dest) %>% 
  summarise(
    count = n(),
    dist = mean(distance, na.rm = TRUE),
    delay = mean(arr_delay, na.rm = TRUE)
  ) %>% 
  filter(count > 20, dest != "HNL")

# Not setting na.rm, How non available values are retained
flights %>% 
  group_by(year, month, day) %>% 
  summarise(mean = mean(dep_delay))

# Now remove the missing values
flights %>% 
  group_by(year, month, day) %>% 
  summarise(mean = mean(dep_delay, na.rm = TRUE))

# Take out Cancelled flights from the dataset
not_cancelled <- flights %>% 
  filter(
    !is.na(dep_delay), 
    !is.na(arr_delay)
  )

# Grouping by and summarizing for further usage
not_cancelled %>% 
  group_by(
    year, month, day
    ) %>% 
      summarise(
        mean = mean(dep_delay)
        )

# Part of exploration, count the non missing values
# In this case - the delays
delays <- not_cancelled %>% 
  group_by(tailnum) %>% 
  summarise(
    delay = mean(arr_delay)
  )

# Plot the delays - some planes have an average delay of 5 hours.
ggplot(data = delays, mapping = aes(x = delay)) + 
  geom_freqpoly(binwidth = 10)

# Number of flights per day vs the average delay
delays <- not_cancelled %>% 
  group_by(tailnum) %>% 
  summarise(
    delay = mean(arr_delay, na.rm = TRUE),
    n = n()
  )

ggplot(data = delays, mapping = aes(x = n, y = delay)) + 
  geom_point(alpha = 1/10)

# Useful summary functions
# Mean and Median
# Taking into consideration average positive delay
not_cancelled %>% 
  group_by(year, month, day) %>% 
  summarise(
    avg_delay1 = mean(arr_delay),
    avg_delay2 = mean(arr_delay[arr_delay > 0])
  )

# Standard Deviation
not_cancelled %>% 
  group_by(dest) %>% 
  summarise(distance_sd = sd(distance)) %>% 
  arrange(desc(distance_sd))

# Grouping by multiple variables
# Removes one level of grouping  data
daily <- group_by(flights, year, month, day)

# Per Day
(per_day   <- summarise(daily, flights = n()))

# Per Month
(per_month <- summarise(per_day, flights = sum(flights)))


# Ungrouping or unstacking to go back to the normal format
daily %>% 
  ungroup() %>%           
  summarise(flights = n())

# Grouping with filters
# Group by year, month and day and filter for delays
flights_sml %>% 
  group_by(year, month, day) %>%
  filter(rank(desc(arr_delay)) < 10)
