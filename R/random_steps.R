# add ta.distr
#' @export
random_steps <- function(x, ...) {
  UseMethod("random_steps", x)
}

#' @export
random_steps.steps <- function(x, n_controll = 10, sl.distr = "gamma", ta.distr = "vonmises", random.error = 0.001,
                               .progress = FALSE, ...) {
  if (any(is.na(x$sl_)) || any(is.na(x$ta_))) {
    x <- x %>% filter(!is.na(sl_), !is.na(ta_))
    warning("Step-lengths or truning angles contained NA, which were removed.")
  }

  # random.error
  if (random.error != 0) {
    x$sl_ <- x$sl_ + stats::runif(nrow(x), 0, random.error)
  }

  if (.progress) cat("* fitting sl-distr\n")
  sl <- fit_sl_dist_base(x$sl_, distr = sl.distr)
  if (.progress) cat("* fitting ta-distr\n")
  ta <- fit_ta_dist_base(x$ta_) # ta_distr
  if (.progress) cat("* generating random steps\n")
  random_steps_base(x, n_controll, sl, ta)
}

random_steps_base <- function(x, n_controll, sl, ta) {
  # Generate random points
  ns <- nrow(x)  # number of steps
  case_for_controll <- rep(1:ns, each = n_controll)

  slr <- do.call(paste0("r", sl$distname), c(list(n = ns * n_controll), as.list(sl$estimate)))
  tar <- x[case_for_controll, ]$ta_ + circular::rvonmises(ns * n_controll, mu = 0, kappa = ta$kappa)  # turning angles for new stps

  # Controll points
  xy_cc <- x[case_for_controll, ]
  xy_cc["x2_"] <- xy_cc$x1_ + slr * cos(tar)
  xy_cc["y2_"] <- xy_cc$y2_ + slr * sin(tar)

  xy_cc$case_ <- FALSE
  xy_cc$step_id_ <- rep(1:ns, each = n_controll)
  xy_cc$sl_ <- slr
  xy_cc$ta_ <- tar

  x$case_ <- TRUE
  x$step_id_ <- 1:ns
  has_burst <- "burst_" %in% names(x)

  vars <- c("step_id_", "case_", "x1_", "y1_", "x2_", "y2_", "t1_", "t2_", "dt_")
  if (has_burst) {
    vars <- c("burst_", vars)
  }

  vars <- c(vars, base::setdiff(names(x), vars))

  out <- bind_rows(x, xy_cc) %>% arrange_("step_id_") %>% select_(.dots = vars)

  class(out) <- c("random_steps", class(out))
  attributes(out)$sl_ <- sl
  attributes(out)$ta_ <- ta
  attributes(out)$n_controll_ <- n_controll
  out
}

rsteps_transfer_attr <- function(from, to) {
  from <- attributes(from)
  attributes(to)$class <- from$class
  attributes(to)$sl_ <- from$sl_
  attributes(to)$ta_ <- from$ta_
  to
}

methods::setOldClass(c("random_steps", "tbl_df"))
# see here: https://github.com/hadley/dplyr/issues/719
#' @export
arrange_.random_steps <- function(.data, ..., .dots) {
  xx <- NextMethod()
  rsteps_transfer_attr(.data, xx)
}

#' @export
filter_.random_steps <- function(.data, ..., .dots) {
  xx <- NextMethod()
  rsteps_transfer_attr(.data, xx)
}

#' @export
group_by_.random_steps <- function(.data, ..., .dots) {
  xx <- NextMethod()
  rsteps_transfer_attr(.data, xx)
}

#' @export
select_.random_steps <- function(.data, ..., .dots) {
  xx <- NextMethod()
  rsteps_transfer_attr(.data, xx)
}

#' @export
summarise_.random_steps <- function(.data, ..., .dots) {
  xx <- NextMethod()
  rsteps_transfer_attr(.data, xx)
}


#' @export
summarize_.random_steps <- function(.data, ..., .dots) {
  xx <- NextMethod()
  rsteps_transfer_attr(.data, xx)
}