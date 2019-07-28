# Week 10 - K-Means Clustering , Hierarchical Clustering
# ANLY 506-51- B-2019/Summer - Exploratory Data Analytics
# Tejal Satish Kanase

# K means Clustering

# K Means Algorithm illustration
set.seed(1234)
x <- rnorm(12, mean = rep(1:3, each = 4), sd = 0.2)
y <- rnorm(12, mean = rep(c(1, 2, 1), each = 4), sd = 0.2)
plot(x, y, col = "blue", pch = 19, cex = 2)
text(x + 0.05, y + 0.05, labels = as.character(1:12))

# kmeans() function
dataFrame <- data.frame(x, y)
kmeansObj <- kmeans(dataFrame, centers = 3)
names(kmeansObj)

# which data point is assigned to which cluster
kmeansObj$cluster

# Bluiding heatmaps for K-means

set.seed(1234)
dataMatrix <- as.matrix(dataFrame)[sample(1:12), ]
kmeansObj <- kmeans(dataMatrix, centers = 3)

par(mfrow = c(1, 2))
image(t(dataMatrix)[, nrow(dataMatrix):1], yaxt = "n", main = "Original Data")
image(t(dataMatrix)[, order(kmeansObj$cluster)], yaxt = "n", main = "Clustered Data")


library(tidyverse)  
library(cluster)    
library(factoextra)

#data prep

df <- USArrests
df <- na.omit(df)
df <- scale(df)
head(df)

#computing Kmeans clustering in R
k2 <- kmeans(df, centers = 2, nstart = 25)
str(k2)

k2

# illustration of clusters
fviz_cluster(k2, data = df)

#  standard pairwise scatter plots to illustrate the clusters
df %>%
  as_tibble() %>%
  mutate(cluster = k2$cluster,
         state = row.names(USArrests)) %>%
  ggplot(aes(UrbanPop, Murder, color = factor(cluster), label = state)) +
  geom_text()

k3 <- kmeans(df, centers = 3, nstart = 25)
k4 <- kmeans(df, centers = 4, nstart = 25)
k5 <- kmeans(df, centers = 5, nstart = 25)

# plot for clusters
p1 <- fviz_cluster(k2, geom = "point", data = df)  + ggtitle("k = 2")
p2 <- fviz_cluster(k3, geom = "point",  data = df) + ggtitle("k = 3")
p3 <- fviz_cluster(k4, geom = "point",  data = df) + ggtitle("k = 4")
p4 <- fviz_cluster(k5, geom = "point",  data = df) + ggtitle("k = 5")

library(gridExtra)
grid.arrange(p1, p2, p3, p4, nrow = 2)

# Hierarchical Cluster Analysis
library(tidyverse)  
library(cluster)  
library(factoextra) 
library(dendextend) 

# data prep

df <- USArrests
df <- na.omit(df)
df <- scale(df)
head(df)

# Eucldian distance matrix
d <- dist(df, method = "euclidean")

# Hierarchical clustering using Complete Linkage
hc1 <- hclust(d, method = "complete" )

# plotting the dendrogram
plot(hc1, cex = 0.6, hang = -1)

# Compute using agnes fuction
hc2 <- agnes(df, method = "complete")

# Agglomerative coefficient - measures the amount of clustering structure found
hc2$ac

# cluster using ward's method
hc3 <- agnes(df, method = "ward")

# Plot dendrogram
pltree(hc3, cex = 0.6, hang = -1, main = "Dendrogram of agnes") 

#divisive  hierarchical clustering using function diana
hc4 <- diana(df)
hc4$dc

# Plot dendrogram
pltree(hc4, cex = 0.6, hang = -1, main = "Dendrogram of diana")

# cluster using Ward's method
hc5 <- hclust(d, method = "ward.D2" )

# split tree into 4 groups
sub_grp <- cutree(hc5, k = 4)

# View number of members in each cluster
table(sub_grp)

USArrests %>%
  mutate(cluster = sub_grp) %>%
  head

plot(hc5, cex = 0.6)
# plotting dendrogram with border around each cluster
rect.hclust(hc5, k = 4, border = 2:5)

#fviz_cluster fucntion to view results in scatterplots
fviz_cluster(list(data = df, cluster = sub_grp))
