# load in libraries
library(tidyverse)
library(naniar) # this is a nice package for visualizing missing data
library(superheat)
library(patchwork)
install.packages("gplots")
library(gplots)
library(psych)

# read original dataset
pizza <- read.csv(file= "pizza_barstool.csv")

# preprocess the data - remove duplicates
df <- duplicated(pizza$name) == FALSE
pizza_new <- pizza[df,]

# load in new dataset
View(pizza_new)
save(pizza_new, file = "Project1/data/pizza_processed.Rdata")

# number of values and names of variables
names(pizza_new)
nrow(pizza_new)

# plot data
pizza_new |>
  select(price_level, review_stats_community_average_score) |>
  pivot_longer(everything()) |>
  ggplot() +
  geom_histogram(aes(x = value), color = "white") +
  facet_wrap(~name, scales = "free")

# UNIVARIATE two histograms side-by-side comparing price level and CAS
par(mfrow = c(1, 2))
hist(pizza_new$price_level, main = "Histogram of Price Level", xlab = "Price",
     ylab = "Frequency", col = "lightblue")
hist(pizza_new$review_stats_community_average_score, main = "Histogram of Community Average Score", xlab = "Average Score",
     ylab = "Frequency", col = "lightgreen")

# BIVARIATE plot CAS in relation to price
plotmeans(pizza_new$review_stats_community_average_score ~ pizza_new$price_level, main = "Community Average Score in Relation to Price Level", xlab = "Price Level", ylab = "Community Average Score")

# MULTIVARIATE plot
x <- 1:452
y1 <- pizza_new$price_level
y2 <- pizza_new$review_stats_community_average_score
y3 <- pizza_new$review_stats_all_average_score
# Create an empty plot
plot(x, y1, type = "n", xlim = c(0, 200), ylim = c(0, 10), 
     xlab = "Frequency", ylab = "Value", main = "Multivariate Plot")
# Plot each line one by one
lines(x, y1, type = "l", col = "red")
lines(x, y2, type = "l", col = "blue")
lines(x, y3, type = "l", col = "green")
# Add a legend
legend("topright", legend = c("Price Level", "Community Average Score", "All Average Score"),
       cex = 0.75,
       col = c("red", "blue", "green"), lty = 1)

# plot histogram CAS in relation to price
pizzanew.df <- data.frame(pizza_new$review_stats_community_average_score, pizza_new$price_level)
rowMeans(pizzanew.df)
alpha(pizzanew.df)
hist(pizzanew.df)
hist(pizza_barstool$review_stats_community_average_score ~ pizza_barstool$price_level)

# summary statistics
summary(pizza_new$review_stats_community_average_score)
summary(pizza_new$price_level)
summary(pizza_new$review_stats_community_average_score ~ pizza_new$price_level)