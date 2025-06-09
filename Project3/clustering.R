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


# FIRST CLUSTER PLOT - PRICE & SCORE
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


# SECOND CLUSTER PLOT - PRICE & LONGITUDE
# create new data frame
df_2 <- data.frame(pizza_new$price_level, pizza_new$longitude)
df_2 <- na.omit(df_2) # removes missing values
df_2 <- scale(df_2)
head(df_2)

# apply k-means
k2 <- kmeans(df_2, centers = 3, nstart = 25)
str(k2)
fviz_cluster(k2, data = df_2)

# determining optimal clusters
set.seed(123)
fviz_nbclust(df_2, kmeans, method = "wss")


# THIRD CLUSTER PLOT - PRICE & SCORE IN NEW YORK
# create a new filter
ny_pizza <- pizza_new %>%
  filter(latitude >= 40.5, latitude <= 45,
         longitude >= -79.8, longitude <= -71.8)
# select(contains("lat"), contains("long"))

head(ny_pizza) # 313 pizza places that are in NY

# create new data frame
df_ny <- data.frame(ny_pizza$price_level, ny_pizza$review_stats_community_average_score)
df_ny <- na.omit(df_ny) # removes missing values
df_ny <- scale(df_ny)
head(df_ny)

# apply k-means
k2 <- kmeans(df_ny, centers = 3, nstart = 25)
str(k2)
fviz_cluster(k2, data = df_ny)

# determining optimal clusters
set.seed(123)
fviz_nbclust(df_ny, kmeans, method = "wss")


# FOURTH CLUSTER PLOT - PRICE & SCORE OUTSIDE OF NEW YORK
# create a new filter
not_ny_pizza <- pizza_new %>%
  filter(!(latitude >= 40.5 & latitude <= 45 &
             longitude >= -79.8 & longitude <= -71.8))

head(not_ny_pizza) #137 pizza places that are not in NY

# create new data frame
df_nny <- data.frame(not_ny_pizza$price_level, not_ny_pizza$review_stats_community_average_score)
df_nny <- na.omit(df_nny) # removes missing values
df_nny <- scale(df_nny)
head(df_nny)

# apply k-means
k2 <- kmeans(df_nny, centers = 3, nstart = 25)
str(k2)
fviz_cluster(k2, data = df_nny)

# determining optimal clusters
set.seed(123)
fviz_nbclust(df_nny, kmeans, method = "wss")
