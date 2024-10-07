#### Preamble ####
# Purpose: Cleans the raw plane data recorded
# Author: Ziqi Zhu
# Date: 7 October 2024
# Contact: ziqi.zhu@mail.utoronto.ca 
# License: MIT
# Pre-requisites: None

#### Workspace setup ####
library(lubridate)
library(dplyr)

#### Clean data ####
raw_data <- read_csv("data/raw_data/raw_data.csv")

# Modify release date column and save as release month, select columns will be 
# used for analysis save as analysus_data.csv
cleaned_data <-
  raw_data |> mutate(release_month = month(ymd(release_date),
                                           label = TRUE, abbr = TRUE)) %>% 
  select(release_month, english, developer, publisher, required_age, achievements,
         positive_ratings, negative_ratings, average_playtime, median_playtime,
         owners, price) %>%
  filter(average_playtime != 0)

write_csv(cleaned_data, "data/analysis_data/analysis_data.csv")