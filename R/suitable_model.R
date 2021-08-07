#' Title
#'
#' @param list_of_model
#' @param new_data
#'
#' @return
#' @importFrom magrittr
#' @export
#'
#' @examples
suitable_model <- function(
  list_of_model,
  new_data
) {
  foreach::foreach(mod = list_of_model, .errorhandling = "pass") %do%
    {
      mod %>%
        predict(new_data) %>%
        dplyr::bind_cols(new_data) %>%
        yardstick::rmse(
          truth = item_outlet_sales,
          estimate = .pred
        )
    } %>% 
    dplyr::bind_rows(.id = "model_id") %>%
    dplyr::filter(`.estimate`== min(`.estimate`)) -> rmse_tbl

  logger::log_info(paste("RMSE: ", rmse_tbl[[".estimate"]]))

  list_of_model[[as.numeric(rmse_tbl$model_id)]]

}
