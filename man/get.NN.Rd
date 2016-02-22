\name{get.NN}
\alias{get.NN}

\title{Function to find the nearest neighbours}

\description{
This function locates the nearest neighbours of each point in the
test set in the training set. Both sets must of the same dimensions and
are passed as successive rows of the same matrix \code{P}.

User can decide whether a specified number of neighbours should be
sought, or whether they should be sought as some fraction of the size of
the training set.
}

\usage{
get.NN(P, k = 2, p = !k, test, train, dist.type = c("euclidean",
"absolute", "mahal"), nn.type = c("which", "dist", "max"))
}

\arguments{
  \item{P}{The matrix of data. Contains both the training and test sets.}
  \item{k}{The number of nearest neighbours sought.}
  \item{p}{The number of nearest neighbours sought, specified as a
  fraction of the training set.}
  \item{test}{The rows of the matrix \code{P} that contain the test data.}
  \item{train}{The rows of the matrix \code{P} that contain the training data.}
  \item{dist.type}{The type of distance to use when determining neighbours.}
  \item{nn.type}{What should be returned? Either the actual distances
  (\code{dist}) or their locations (rows) in \code{P} (\code{which}) or
  the k-th maximum distances \code{max}}
}

\details{This function is used internally to compute the nearest
  neighbours; the user need not call any of these functions
  directly.
}

\value{
Returns a matrix of dimensions (Number of Nearest Neighbours) x (Rows in
Test Set). Each column contains the nearest neighbours of the
corresponding row in the training set.
}

\author{Mohit Dayal}

\examples{
require(MASS)
mu <- c(3,4)
Sigma <- rbind(c(1,0.2),c(0.2,1))
Y <- mvrnorm(20, mu = mu, Sigma = Sigma)
test <- 1:4
train <- 5:20
nn1a <- get.NN(Y, k = 3, test = 1:4, train = 5:20, dist.type =
'euclidean', nn.type = 'which')
nn1b <- get.NN(Y, k = 3, test = 1:4, train = 5:20, dist.type =
'euclidean', nn.type = 'dist')
nn1c <- get.NN(Y, k = 3, test = 1:4, train = 5:20, dist.type =
'euclidean', nn.type = 'max')
nn2 <- get.NN(Y, p = 0.3, test = 1:4, train = 5:20, dist.type =
'euclidean', nn.type = 'which')
}

\concept{Distance}
\concept{Nearest Neighbours}