#' @importFrom dplyr arrange filter group_by select summarize summarise ungroup
#' @importFrom dplyr distinct ungroup mutate mutate_at pull %>% bind_rows select_vars n
#' @importFrom graphics plot legend
#' @importFrom grDevices adjustcolor
#' @importFrom lazyeval lazy_dots lazy
#' @importFrom lubridate hours minutes seconds now days weeks
#' @importFrom stats coef dgamma median na.omit qgamma quantile runif sd var
#' @importFrom tidyr nest unnest
#' @importFrom tibble tibble tribble is_tibble as_tibble
#' @importFrom utils data head tail
#' @importFrom sp CRS
#' @importFrom methods is
#' @importFrom purrr map
#' @importFrom rlang quo quos enquo quo_name
#' @importFrom raster raster
#' @import survival
#' @export

methods::setOldClass(c("track_xy", "tbl_df", "tbl", "data.frame"))
methods::setOldClass(c("track_xyt", "track_xy", "tbl_df", "tbl", "data.frame"))
methods::setOldClass(c("random_points", "tbl_df", "tbl", "data.frame"))
methods::setOldClass(c("steps", "tbl_df", "tbl", "data.frame"))
methods::setOldClass(c("random_steps", "tbl_df"))

utils::globalVariables(c("burst_", "step_id_", "t_", ".data", "ts")) # to omit CRAN notes

#' @useDynLib amt

"_PACKAGE"


# exports from other packages ---------------------------------------------

#' @export
dplyr::arrange
#' @export
dplyr::filter
#' @export
dplyr::group_by
#' @export
dplyr::select
#' @export
dplyr::summarise
#' @export
dplyr::summarize
#' @export
dplyr::ungroup

#' @export
dplyr::distinct

#' @export
dplyr::ungroup

#' @export
dplyr::mutate

#' @export
dplyr::pull

#' @export
sp::CRS

#' @export
lubridate::hours

#' @export
lubridate::minutes

#' @export
lubridate::seconds

#' @export
lubridate::days

#' @export
lubridate::weeks

#' @export
purrr::map

#' @export
survival::clogit

#' @export
survival::strata

#' @export
tidyr::nest

#' @export
tidyr::unnest

#' @export
tibble::tibble

#' @export
magrittr::`%>%`

#' @export
survival::Surv

#' @export
raster::raster
