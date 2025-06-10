## Welcome to My Repository!

This project aims to explore the potential groups between pizza places within the United States. Variables such as location, rating, and price level can create natural groups amongst the restaurants depending on cluster characteristics. 

The original dataset is from Jared Lander and Barstool Sports via Tyler Richards, and can be found under the tidytuesday GitHub repository. The preprocessed data contains 452 different pizza places across the United States. 

Research question: How do community review scores relate to price level and location across clusters for US pizza places?

### Contents

- [Project 1](Project1): Data sources, data dictionary, preprocessing code
- [Project 2](Project2): Exploratory data analysis & related code, EDA plots & graphs
- [Project 3](Project3): Clustering code, cluster plots, analysis of results
- [Project 4](Project4): Monte Carlo Simulation

### How to Reproduce
1. Download this repository into a ZIP file.
2. Go to Project1 and run the 'preprocessing.R' file to clean the dataset.
3. In Project2, you will find the exploratory data analysis code. You can find the code in the file named 'eda.R' or under the 'Exploratory Data Analysis' portion of the 'eda.qmd' file.
4. Project3 contains the clustering model code. Similar to step 3, you can either run the 'clustering.R' file, or find the code in the 'clustering.qmd' file under the header 'Code'.

### Package List
library(tidyverse)
library(naniar) 
library(superheat)
library(patchwork)
library(gplots)
library(psych)
library(FCPS)
library(cluster) 
library(factoextra)
