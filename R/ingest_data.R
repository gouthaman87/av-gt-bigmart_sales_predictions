#' Title
#'
#' @param data_path
#'
#' @return
#' @export
#'
#' @examples
ingest_data <- function(data_path = as.character()) {

  # get list of data paths
  file_paths = list.files(
    path = data_path,
    pattern = "*.csv",
    full.names = TRUE
  )

  # read csv files
  file_paths %>%
    purrr::map(
      .f = ~readr::read_csv(., name_repair = janitor::make_clean_names)
    ) %>%
    purrr::set_names(file_paths)
}
