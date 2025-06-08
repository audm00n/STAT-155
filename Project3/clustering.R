# Run preprocessing.R in Project1 before proceeding

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

# clustering location
df_2 <- data.frame(pizza_new$price_level, pizza_new$latitude)
df_2 <- na.omit(df_2) # removes missing values
df_2 <- scale(df_2)
head(df_2)

k2 <- kmeans(df_2, centers = 4, nstart = 25)
str(k2)
fviz_cluster(k2, data = df_2)

# EVERYTHING BELOW IS A WORK-IN-PROGRESS
# new scale
library(dplyr)

# Combine raw data with cluster labels
pizza_clustered <- pizza_new %>%
  mutate(cluster = factor(cluster))  # make sure cluster is a factor

# Compute means and medians
cluster_summary <- pizza_clustered %>%
  group_by(cluster) %>%
  summarise(
    mean_price_level = mean(price_level),
    median_price_level = median(price_level),
    mean_review_score = mean(review_stats_community_average_score),
    median_review_score = median(review_stats_community_average_score),
    count = n()
  )

# new york
ny_pizza <- pizza_new %>%
  filter(latitude >= 40.5, latitude <= 45,
         longitude >= -79.8, longitude <= -71.8)
select(contains("lat"), contains("long"))

head(ny_pizza) # 313 pizza places that are in NY

# df_ny <- data.frame(ny_pizza)
# df_ny <- na.omit(df_ny)
# df_ny <- scale(df_ny)
# head(df_ny)

df_ny <- data.frame(ny_pizza$price_level, ny_pizza$review_stats_community_average_score)
df_ny <- na.omit(df_ny) # removes missing values
df_ny <- scale(df_ny)
head(df_ny)

k2 <- kmeans(df_ny, centers = 4, nstart = 25)
str(k2)
fviz_cluster(k2, data = df_ny)

set.seed(123)
fviz_nbclust(df_ny, kmeans, method = "wss")

# not new york
not_ny_pizza <- pizza_new %>%
  filter(!(latitude >= 40.5 & latitude <= 45 &
             longitude >= -79.8 & longitude <= -71.8))

head(not_ny_pizza) #137 pizza places that are not in NY

print(cluster_summary)
# # analysis
# Data = pizza_new$price_level
# Review = pizza_new$review_stats_all_average_score
# ClusterPlotMDS(Data, Review)
