library(targets)

# get all R functions from R folder
r_functions <- list.files("R", pattern = "*.R", full.names = TRUE)

sapply(r_functions, source)

options(tidyverse.quiet = TRUE)

# load required packages
tar_option_set(
  packages = c(
    "tidyverse",
    "foreach",
    "tidymodels"
  )
)

# data pipeline
list(
  # 1.0 Read data ----
  tar_target(
    data_list,
    ingest_data("inst/extdata")
  ),

  # 2.0 Extract Train data ----
  tar_target(
    train_data,
    extract_data(data_list, "train")
  ),

  # 3.0 Split data ----
  tar_target(
    split_data,
    rsample::initial_split(train_data, prop = 3/4)
  ),

  # 4.0 Data cleaning recipes ----
  tar_target(
    train_data_recipe,
    data_cleaning_recipe(split_data)
  ),

  # 5.0 ML models ----
  ## 5.1 XGBoost ----
  tar_target(
    xgb_model,
    fit_xgboost(
      train_split = split_data,
      recipe = train_data_recipe
    )
  ),

  ## 5.2 Random Forest ----
  tar_target(
    rf_model,
    fit_rf(
      train_split = split_data,
      recipe = train_data_recipe
    )
  ),

  # 6.0 Select suitable model by RMSE ----
  tar_target(
    final_model,
    suitable_model(
      list_of_model = list(xgb_model, rf_model),
      new_data = rsample::testing(split_data)
    )
  ),

  # 7.0 Extract Submission file ----
  tar_target(
    submission_data,
    extract_data(data_list, "test")
  ),

  # 8.0 Final Submission file ----
  tar_target(
    final_submission_data,
    predict_submission(
      final_model = final_model,
      new_data = submission_data
    )
  )
)
