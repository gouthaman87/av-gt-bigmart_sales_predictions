#' Title
#'
#' @param train_split
#'
#' @return
#' @export
#'
#' @examples
data_cleaning_recipe <- function(train_split) {
  recipes::recipe(item_outlet_sales ~ ., data = rsample::training(train_split)) %>%
    # remove X variables
    recipes::step_rm(item_identifier) %>%
    # impute missing values
    recipes::step_impute_median(recipes::all_numeric()) %>%
    recipes::step_impute_mode(recipes::all_nominal()) %>%
    # one hot encoding
    recipes::step_dummy(recipes::all_nominal(), one_hot = TRUE)
}
