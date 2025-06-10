
# set seed for reproducibility
set.seed(123)

# generate fake data
generate_data <- function(membership) {
  n <- length(membership)
  
  # identify clusters
  cluster1_price <- rnorm(n, mean = 5, sd = 2)
  cluster2_score <- rnorm(n, mean = 10, sd = 3)
  
  # create a data frame
  data <- data.frame(
    cluster1_price = cluster1_price,
    cluster2_score = cluster2_score,
    cluster = membership
  )
  
  return(data)
}

# random list of 0s and 1s to indicate membership
membership_vector <- sample(c(0, 1), size = 100, replace = TRUE)

# generate the data
generated_data_clusters <- generate_data(membership_vector)

head(generated_data_clusters)

