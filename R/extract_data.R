#' Title
#'
#' @param data_list
#' @param pattern
#'
#' @return
#' @export
#'
#' @examples
extract_data <- function(data_list,
                         pattern) {
  names_list = names(data_list)

  name = names_list[grepl(pattern, names_list, ignore.case = TRUE)]

  data_list[[name]]
}
