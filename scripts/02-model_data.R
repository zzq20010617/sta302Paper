#### Preamble ####
# Purpose: Save fitted model with analysis data 
# Author: Ziqi Zhu
# Date: 30 November 2024
# Contact: ziqi.zhu@mail.utoronto.ca 
# License: MIT
# Pre-requisites: None


#### Workspace setup ####
library(tidyverse)
#### preliminary data ####

analysis_data <- read_csv(here::here("data/analysis_data/analysis_data.csv"))

# first model with all predictors
model_1 <- lm(average_playtime ~ price + positive_ratings + negative_ratings + achievements + owners, data=analysis_data)

# Second model with boc-cox transform on predictors
analysis_data$price <- analysis_data$price + 1
analysis_data$positive_ratings <- analysis_data$positive_ratings + 1
analysis_data$negative_ratings <- analysis_data$negative_ratings + 1
analysis_data$achievements <- analysis_data$achievements + 1

# Define the Box-Cox transformation function
boxcox_transform <- function(x) {
  bc <- BoxCoxTrans(x)
  predict(bc, x)
}
# Apply the transformation to each predictor and the response
bc_average_playtime <- boxcox_transform(analysis_data$average_playtime)
bc_price <- boxcox_transform(analysis_data$price)
bc_positive_ratings <- boxcox_transform(analysis_data$positive_ratings)
bc_negative_ratings <- boxcox_transform(analysis_data$negative_ratings)
bc_achievements <- boxcox_transform(analysis_data$achievements)

model_bc_trans <- lm(bc_average_playtime ~ bc_price + bc_positive_ratings + bc_achievements+ bc_negative_ratings + owners, data=analysis_data)

# Third model with reduced predictor
model_bc_reduced <- lm(bc_average_playtime ~ bc_price + bc_positive_ratings + bc_achievements + owners, data=analysis_data)
# Save models as rds
saveRDS(model_1, file = "models/model_1.rds")
saveRDS(model_bc_trans, file = "models/model_bc_trans.rds")
saveRDS(model_bc_reduced, file = "models/model_bc_reduced.rds")