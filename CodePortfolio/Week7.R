# Week 7 - Data Visualisation
# ANLY 506-51- B-2019/Summer - Exploratory Data Analytics
# Tejal Satish Kanase

library(tidyverse)
mpg

# creating a ggplot for mpg dataset
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy))

# mapping colors of points to the class variable
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = class))

# mapping class variable using different sizes
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, size = class))

# alpha controls the tranparency of the points
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, alpha = class))

# to plot using diffrent shapes
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, shape = class))

# setting the color to blue
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy), color = "blue")


# splitting the plots in various facets that is the subplot to display one subset
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_wrap(~ class, nrow = 2)


# facet the plot on a combination of 2 variables
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_grid(drv ~ cyl)

# geom_smooth to plot the shape of the line

ggplot(data = mpg) + 
  geom_smooth(mapping = aes(x = displ, y = hwy))

# geom_smooth to plot the different line type for each unique variable

ggplot(data = mpg) + 
  geom_smooth(mapping = aes(x = displ, y = hwy, linetype = drv))

# drawing a separate object for each different value of a variable

ggplot(data = mpg) +
  geom_smooth(mapping = aes(x = displ, y = hwy, group = drv))

# displaying each different value with a different color

ggplot(data = mpg) +
  geom_smooth(
    mapping = aes(x = displ, y = hwy, color = drv),
    show.legend = FALSE
  )

# displaying mutiple geoms on the same plot

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  geom_smooth(mapping = aes(x = displ, y = hwy))

# displaying different aesthetics for different geoms

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point(mapping = aes(color = class)) + 
  geom_smooth()

# filtering dataset to display only a certain class using geom_smooth
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point(mapping = aes(color = class)) + 
  geom_smooth(data = filter(mpg, class == "subcompact"), se = FALSE)


# bar charts
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut))

# using stat_count instead of geom_bar, they can be used interchangebly
ggplot(data = diamonds) + 
  stat_count(mapping = aes(x = cut))

demo <- tribble(
  ~cut,         ~freq,
  "Fair",       1610,
  "Good",       4906,
  "Very Good",  12082,
  "Premium",    13791,
  "Ideal",      21551
)

demo

ggplot(data = demo) +
  geom_bar(mapping = aes(x = cut, y = freq), stat = "identity")

# displaying bar chart of proportion
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, y = ..prop.., group = 1))

# ggplot to summarise the y values for each unique x value
ggplot(data = diamonds) + 
  stat_summary(
    mapping = aes(x = cut, y = depth),
    fun.ymin = min,
    fun.ymax = max,
    fun.y = median
  )

# position adjustments
# coloring a bar chart using the color aesthetic
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, colour = cut))

# coloring a bar chart using the fill aesthetic
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = cut))

# stacked bar chart y including a 3rd variable
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity))

# using position ="identity" to position each object exactly where it falls
ggplot(data = diamonds, mapping = aes(x = cut, fill = clarity)) + 
  geom_bar(alpha = 1/5, position = "identity")

# using fill='NA' for completely transparent bar plots
ggplot(data = diamonds, mapping = aes(x = cut, colour = clarity)) + 
  geom_bar(fill = NA, position = "identity")

# using position = fill to make each stacked bar same heigth so comparing becomes easier across groups

ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity), position = "fill")

# using position=dodge to place overlapping objects next to one another

ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity), position = "dodge")

# co-ordinate systems

# boxplots
ggplot(data = mpg, mapping = aes(x = class, y = hwy)) + 
  geom_boxplot()

# plot horizontal box plot
ggplot(data = mpg, mapping = aes(x = class, y = hwy)) + 
  geom_boxplot() +
  coord_flip()

library(maps)
nz <- map_data("nz")

# plotting spatial data with ggplot2
ggplot(nz, aes(long, lat, group = group)) +
  geom_polygon(fill = "white", colour = "black")

# using coord_quickmaps() to set the aspect ratio correctly when potting spatial data
ggplot(nz, aes(long, lat, group = group)) +
  geom_polygon(fill = "white", colour = "black") +
  coord_quickmap()

# coord_polar() uses polar coordinates
bar <- ggplot(data = diamonds) + 
  geom_bar(
    mapping = aes(x = cut, fill = cut), 
    show.legend = FALSE,
    width = 1
  ) + 
  theme(aspect.ratio = 1) +
  labs(x = NULL, y = NULL)

bar + coord_flip()
bar + coord_polar()
