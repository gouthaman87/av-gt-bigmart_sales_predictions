#' Title
#'
#' @param data
#' @param y_variable
#' @param x_variable
#'
#' @return
#' @export
#'
#' @examples
box_plot <- function(
  data,
  y_variable,
  x_variable
) {
  data %>%
    ggplot2::ggplot(ggplot2::aes({{ x_variable }}, {{ y_variable }})) +
    ggplot2::geom_boxplot() +
    tidyquant::theme_tq()
}
