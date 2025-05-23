# Clustering- FCPS
install.packages("FCPS")
library(FCPS)
library(tidyverse) # data manipulation
library(cluster) # clustering algorithms
install.packages("factoextra")
library(factoextra) # clustering algorithms & visualization

# read data
pizza_new <- read.csv("Project1/data/pizza_processed.csv")

# create data frame
df <- data.frame(pizza_new$price_level, pizza_new$review_stats_community_average_score)
df <- na.omit(df) # removes missing values
df <- scale(df)
head(df)

# distance
distance <- get_dist(df) # euclidean distance
fviz_dist(distance, gradient = list(low = "#00AFBB", mid = "white", high = "#FC4E07"))

# apply k-means
k2 <- kmeans(df, centers = 2, nstart = 25)
str(k2)
fviz_cluster(k2, data = df)

# different initial cluster amount
k2 <- kmeans(df, centers = 4, nstart = 25)
str(k2)
fviz_cluster(k2, data = df)

# determining optimal clusters
set.seed(123)
fviz_nbclust(df, kmeans, method = "wss")

# # analysis
# Data = pizza_new$price_level
# Review = pizza_new$review_stats_all_average_score
# ClusterPlotMDS(Data, Review)
