# Run preprocessing.R in Project1 before proceeding

pizza_new <- read_csv("Project1/data/pizza_processed.csv")

# UNIVARIATE two histograms side-by-side comparing price level and CAS
pizza_new |>
  select(price_level) |>
  # pivot_longer(everything()) |>
  ggplot() +
  geom_bar(aes(x = as.factor(price_level)), color = "white") +
  coord_flip()#, binwidth = 1) #+
#  facet_wrap(~name, scales = "free") +
# labs(x = "Price Level", y = "Frequency")

par(mfrow = c(1, 2))
hist(pizza_new$review_stats_community_average_score, main = "Histogram of Community Average Score", xlab = "Average Score",
     ylab = "Frequency", col = "lightgreen")
hist(pizza_new$review_stats_all_average_score, main = "Histogram of All Average Score", xlab = "Average Score",
     ylab = "Frequency", col = "lightpink")

unique(pizza_new$city)

plot(pizza_new$longitude, pizza_new$latitude)

list_cities <- c("Bronx", "Brooklyn", "New York", "Saratoga Springs", "Staten Island") #Yonkers", "Buffalo", "Staten Island", "Saratoga Springs", "Gansevoort", "Hampton Bays", "Southampton", "East Meadow", "Elmont", "Howard Beach", "New Hyde Park", "Kew Gardens", "Middle Village", "Huntington", "New York City", "Mount Vernon")

pizza_new |>
  filter(city %in% list_cities) |>
  ggplot() +
  geom_bar(aes(x = as.factor(city)), color = "white") +
  coord_flip()

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

# summary statistics
summary(pizza_new$review_stats_community_average_score)
summary(pizza_new$price_level)
summary(pizza_new$review_stats_community_average_score ~ pizza_new$price_level)


# Install if you don't have these packages

install.packages("maps")

# Load libraries
library(ggplot2)
library(maps)

# Get US map data
us_map <- map_data("state")

# Plot the map
ggplot(us_map, aes(x = long, y = lat, group = group)) +
  geom_polygon(fill = "white", color = "black") +
  geom_point(data = pizza_new, aes(x = longitude, y = latitude, 
                                   group = city), 
             color = "red", size = 2) +
  coord_fixed(1.3) +
  theme_void() +
  ggtitle("US Map with Cities")
