% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/random_steps.R
\name{random_steps}
\alias{random_steps}
\alias{random_steps.steps_xy}
\title{Generate Random Steps}
\usage{
random_steps(x, ...)

\method{random_steps}{steps_xy}(x, n_control = 10, sl_distr = "gamma",
  ta_distr = "vonmises", random.error = 0.001, ...)
}
\arguments{
\item{x}{Steps.}

\item{...}{Further arguments, none implemented.}

\item{n_control}{\code{[integer(1)=10]{>1}} \cr The number of control steps paired with each observed step.}

\item{sl_distr}{\code{[character(1)='gamma']{'gamma'}} \cr The distribution to be fitted to the empirical distribution of step lengths.}

\item{ta_distr}{\code{[character(1)='vonmises']{'vonmises', 'unif'}} \cr The distribution to be fitted to the empirical distribution of turn angles.}

\item{random.error}{\code{[numeric(1)=0.001]{>0}} \cr Upper limit for a uniformly distributed random error
(between 0 and \code{random.error}) to be added to step lengths, to avoid step
lengths of length 0.}
}
\description{
Function to generate a given number of random steps for each observed step.
}
