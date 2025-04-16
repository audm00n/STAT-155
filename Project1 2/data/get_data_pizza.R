pizza_jared <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2019/2019-10-01/pizza_jared.csv")
pizza_barstool <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2019/2019-10-01/pizza_barstool.csv")
pizza_datafiniti <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2019/2019-10-01/pizza_datafiniti.csv")

library(tidyverse)
library(jsonlite)

# Get barstool data off github
pizza_raw <- read_csv("https://raw.githubusercontent.com/tylerjrichards/Barstool_Pizza/master/pizza_data.csv")

pizza_cooked <- pizza_raw %>% 
  select(name, address1, city, zip, country, latitude, longitude, priceLevel, 
         providerRating, providerReviewCount, 
         reviewStats.all.averageScore:reviewStats.dave.totalScore) %>% 
  janitor::clean_names()

# Get jared data off his website (json)

url <- "https://jaredlander.com/data/PizzaPollData.php"

jared_pizza <- fromJSON(readLines(url), flatten = TRUE) %>% 
  as_tibble() %>% 
  janitor::clean_names()

write_csv(jared_pizza, here::here("2019", "2019-10-01", "pizza_jared.csv"))

write_csv(pizza_cooked, here::here("2019", "2019-10-01", "pizza_barstool.csv"))