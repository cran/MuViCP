\name{ab.dist}
\alias{ab.dist}
\alias{ab.dist.matY}
\alias{eu.dist}
\alias{eu.dist.matY}
\alias{mh.dist}
\alias{mh.dist.matY}

\title{Distance Functions for nearest neighbours}

\description{
These functions compute Absolute (\code{ab.dist}), Euclidean
(\code{eu.dist}) or Mahalanobis (\code{mh.dist}) distances between two
points. The variant functions (\code{*.matY}), accomplish the same task,
but between a point on the one hand, and every point specified as rows of a matrix on the other.
}

\usage{
ab.dist(x, y)
eu.dist(x, y)
mh.dist(x, y, A)
ab.dist.matY(x, Y)
eu.dist.matY(x, Y)
mh.dist.matY(x, Y, A)
}

\arguments{
  \item{x}{The vector (point) from which distance is sought.}
  \item{y}{The vector (point) to which distance is sought.}
  \item{Y}{A set of points, specified as rows of a matrix, to which distances are sought.}
  \item{A}{The inverse matrix to use for the Mahalanobis distance.}
}

\details{These functions are used internally to decide how the nearest
  neighbours shall be calculated; the user need not call any of these
  functions directly. Rather, the choice of distance is specified as a
  string ('euclidean' or 'absolute' or 'mahal').
}

\value{Either a single number for the distance, or a vector of distances,
corresponding to each row of \code{Y}.
}

\author{Mohit Dayal}

\seealso{get.NN}

\examples{
x <- c(1,2)
y <- c(0,3)
mu <- c(1,3)
Sigma <- rbind(c(1,0.2),c(0.2,1))
Y <- MASS::mvrnorm(20, mu = mu, Sigma = Sigma)
ab.dist(x,y)
eu.dist(x,y)
mh.dist(x,y,Sigma)
ab.dist.matY(x,Y)
eu.dist.matY(x,Y)
mh.dist.matY(x,Y,Sigma)
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\concept{Distance}