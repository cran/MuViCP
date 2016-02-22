\name{least.k}
\alias{least.k}
\alias{least.p}
\alias{which.least.k}
\alias{which.least.p}

\title{Functions to find the few smallest elements in a vector.}

\description{
Given a numeric vector, these functions compute and return the few
smallest elements in it. The number of elements returned is specified as
either a definite number (\code{k}) or as a proportion of the vector
length (\code{p}). The variant functions (\code{which.*}), accomplish
the same task, but return instead the position of such elements in the vector.
}

\usage{
least.k(x, k)
least.p(x, p)
which.least.k(x, k)
which.least.p(x, p)
}

\arguments{
  \item{x}{The numeric vector.}
  \item{k}{The number of smallest elements sought.}
  \item{p}{The number of smallest elements sought, specified as proportion of the length of \code{x}.}
}

\details{
These functions are used internally in the determination of nearest neighbours; the user need not call any of these functions directly. Rather, the choice is specified via the arguments \code{k} and \code{p}.

}
\value{Either the smallest values themselves or, for the which.* functions, their positions in the vector.
}

\author{Mohit Dayal}

\seealso{
get.NN
}

\examples{
x <- rnorm(10)
least.k(x, 3)
least.p(x, 0.3)
which.least.k(x, 3)
which.least.p(x, 0.3)
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\concept{distance}
\concept{order}
\concept{sort}