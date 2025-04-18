pizza <- read.csv(file= "Project1/data/pizza_barstool.csv")

df <- duplicated(pizza$name) == FALSE
pizza_new <- pizza[df,]

save(pizza_new, file = "Project1/data/pizza_processed.Rdata")
