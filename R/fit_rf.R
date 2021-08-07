#' Title
#'
#' @param train_split
#' @param recipe
#'
#' @return
#' @export
#'
#' @examples
fit_rf <- function(
  train_split,
  recipe
) {
  model_spec <- parsnip::rand_forest(mode = "regression") %>%
    parsnip::set_engine("ranger")

  workflows::workflow() %>%
    workflows::add_model(spec = model_spec) %>%
    workflows::add_recipe(recipe = recipe) %>%
    parsnip::fit(data = rsample::training(train_split))
}
