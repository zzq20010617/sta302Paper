#### Preamble ####
# Purpose: Downloads and saves the data from internet
# Author: Ziqi Zhu
# Date: 7 October 2024
# Contact: ziqi.zhu@mail.utoronto.ca 
# License: MIT
# Pre-requisites: None


#### Workspace setup ####
library(readr)
library(httr)
library(jsonlite)


#### Save data ####

# download data from Kaggle
system("kaggle datasets download -d nikdavis/steam-store-games -p data/raw_data")
unzip("data/raw_data/steam-store-games.zip",exdir = "data/raw_data")

# save data as raw_data.csv file
data <- read.csv("data/raw_data/steam.csv")
write_csv(data, "data/raw_data/raw_data.csv") 

         
