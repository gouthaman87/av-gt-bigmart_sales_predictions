#' Title
#'
#' @param train_split
#' @param recipe
#'
#' @return
#' @export
#'
#' @examples
fit_xgboost <- function(
  train_split,
  recipe
) {
  model_spec <- parsnip::boost_tree(mode = "regression") %>%
    parsnip::set_engine("xgboost")

  workflows::workflow() %>%
    workflows::add_model(spec = model_spec) %>%
    workflows::add_recipe(recipe = recipe) %>%
    parsnip::fit(data = rsample::training(train_split))
}
