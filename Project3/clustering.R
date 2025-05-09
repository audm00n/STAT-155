# Clustering- FCPS
install.packages("FCPS")
library(FCPS)
data("pizza_new")
Data = pizza_new$price_level
Review = pizza_new$review_stats_all_average_score
ClusterPlotMDS(Data, Review)