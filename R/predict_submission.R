#' Title
#'
#' @param final_model
#' @param new_data
#'
#' @return
#' @export
#'
#' @examples
predict_submission <- function(
  final_model,
  new_data
) {
  final_model %>%
    predict(new_data) %>%
    dplyr::bind_cols(new_data) %>%
    dplyr::select(
      Item_Identifier = item_identifier,
      Outlet_Identifier = outlet_identifier,
      Item_Outlet_Sales = .pred
    ) %>%
    dplyr::mutate(
      Item_Outlet_Sales = ifelse(
        Item_Outlet_Sales < 0,
        0,
        Item_Outlet_Sales
      )
    )
}
