# Clustering- FCPS
install.packages("FCPS")
library(FCPS)
library(tidyverse)
library(cluster)
install.packages("factoextra")
library(factoextra)

# read data
pizza_new <- read_csv("Project1/data/pizza_processed.csv")

# create data frame
df <- data.frame(pizza_new$price_level, pizza_new$review_stats_community_average_score)
df <- na.omit(df)
df <- scale(df)
head(df)

# distance
distance <- get_dist(df)
fviz_dist(distance, gradient = list(low = "#00AFBB", mid = "white", high = "#FC4E07"))

# apply k-means
k2 <- kmeans(df, centers = 2, nstart = 25)
str(k2)
fviz_cluster(k2, data = df)

# # analysis
# Data = pizza_new$price_level
# Review = pizza_new$review_stats_all_average_score
# ClusterPlotMDS(Data, Review)
