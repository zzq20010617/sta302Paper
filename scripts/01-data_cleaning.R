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
library(readr)

#### Clean data ####
# Read the raw data
raw_data <- read_csv(here::here("data/raw_data/raw_data.csv"))

# Clean and transform the data
cleaned_data <- raw_data %>%
  mutate(
    release_month = month(ymd(release_date), label = TRUE, abbr = TRUE),
    owners_combined = recode(owners,
                             "5000000-10000000" = "5000000-20000000",
                             "10000000-20000000" = "5000000-20000000",
                             "20000000-50000000" = "20000000-200000000",
                             "100000000-200000000" = "20000000-200000000",
                             "50000000-100000000" = "20000000-200000000",
                             .default = as.character(owners))
  ) %>%
  select(release_month, english, developer, publisher, achievements,
         positive_ratings, negative_ratings, average_playtime, median_playtime,
         owners, price, owners_combined) %>%
  filter(average_playtime != 0)

# Define the order of levels for the owners and owners_combined columns
levels_order <- c("0-20000", "20000-50000", "50000-100000", "100000-200000", 
                  "200000-500000", "500000-1000000", "1000000-2000000", 
                  "2000000-5000000", "5000000-10000000", "10000000-20000000", 
                  "20000000-50000000", "50000000-100000000", "100000000-200000000")

levels_order_combined <- c("0-20000", "20000-50000", "50000-100000", "100000-200000", 
                           "200000-500000", "500000-1000000", "1000000-2000000", 
                           "2000000-5000000", "5000000-20000000", "20000000-200000000")

# Apply the factor levels
cleaned_data$owners <- factor(cleaned_data$owners, levels = levels_order)
cleaned_data$owners_combined <- factor(cleaned_data$owners_combined, levels = levels_order_combined)

# Save the cleaned data
write_csv(cleaned_data, "data/analysis_data/analysis_data.csv")