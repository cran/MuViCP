\name{bel.builder}
\alias{kde_bel.builder}
\alias{knn_bel.builder}
\alias{jit_bel.builder}

\title{Building Belief Functions}

\description{
  These are a set of functions that can be used to build belief
  functions (hence the name \code{*.builder}). Each of these returns a
  function that can be used to classify points in two dimensions.

  The algorithm used can be judged from the first three letters. Thus
  the \code{kde_bel} function uses the kernel density estimate (kde), the
  \code{knn_bel} function uses the kernel density estimate together with
  information on the Nearest Neighbours, the \code{jit_bel} function
  uses jittering of the point in the neighbourhood. Finally, the
  \code{cor_bel} function uses the kde but includes a factor for
  self-correction.
  
  These generated functions (return values) are meant to be passed to
  the \code{ensemble} function to build an ensemble.
}

\usage{
kde_bel.builder(labs, test, train, options = list(coef = 0.90))
knn_bel.builder(labs, test, train, options = list(k = 3, p = FALSE,
dist.type = c('euclidean', 'absolute', 'mahal'), out = c('var', 'cv'),
coef = 0.90))
jit_bel.builder(labs, test, train, options = list(k = 3, p = FALSE, s =
5, dist.type = c('euclidean', 'absolute', 'mahal'), out = c('var',
'cv'), coef = 0.90))
}

\arguments{
  \item{labs}{The possible labels for the points. Can be strings. Must
      be of the same length as \code{train}}
  \item{test}{The indices of the test data in \code{P}}
  \item{train}{The indices of the training data in \code{P}}
  \item{options}{A list of arguments that determine the behaviour of the
  constructed belief function.}
  \item{k}{The number of nearest neighbours to consider, specified as a
    definite integer}
  \item{p}{The number of nearest neighbours to consider, specified as a
    fraction of the test set}
  \item{s}{For the jitter belief function : how many times should each
  point be jittered in the neighbourhood? Usually, 2 or 3 works.}
  \item{dist.type}{The type of distance to use when computing nearest
    neighbours. Can be one of "euclidean", "absolute", or "mahal"}
  \item{out}{Should beliefs be built from the variance (\code{var}) or
  the coefficient of variation(\code{cv})? Also see the Details section below.}
  \item{coef}{The classifier only assigns the class labels that actually
  occur, that is, ignorance is, by default not accounted for. This
  argument specifies what amount of belief should be allocated to
  ignorance; the beliefs to the other classes are correspondingly
  adjusted. Note that for the 'corrected' classifier, the actual belief
  assigned to ignorance may be higher than this for some
  projections. See Details.}
}

\details{
  Each of these functions uses a different algorithm for classification.

  The \code{kde_bel.builder} returns a classifier that simply evaluates
  the kernel density estimate of each class on each point, and
  classifies that point to that class which has the maximum density on
  it.

  The \code{knn_bel.builder} returns a classifier that tries to locate
  \code{k} (or \code{p*length(train)}) nearest neighbours of each of the
  points in the test set. It then evaluates the kernel density estimate
  of each class in the training set on each of these nearest neighbours,
  and at each of the testing points. With argument \code{var}, the
  variance of the set of density values, centered at the density value
  at the testing point itself, is taken as a measure of that point
  belonging to this class. With argument \code{cv}, the coefficient of
  variation is used instead, and for the mean, one uses the density
  value on the point itself. Generally, the \code{var} classifier has
  higher accuracy.

  The \code{jit_bel.builder} works very similar to the
  \code{knn_bel.builder} classifier, but instead uses the nearest
  neighbour information to determine a point "neighbourhood". The test
  points are then jittered in this neighbourhood, and on these fake
  points the kernel density is evaluated. The \code{var} and \code{cv}
  work here as they work in the \code{knn_bel.builder} classifier.  
}

\value{A Classifier function that can be passed on to the
  \code{ensemble} function.

  Alternately, 2-D projected data may directly be passed to the
  classifier function returned, in which case, a matrix of dimensions
  (Number of Classes) x (length(test)) is returned. Each column sums to
  1, and represents the partial assignment of that point to each of the
  classes. The rows are named after the class names, while the columns
  are named after the test points. Ignorance is represented by the
  special symbol 'Inf' and is the last class in the matrix.}

\author{Mohit Dayal}

\examples{
##Setting Up
data(cancer)
table(cancer$V2)
colnames(cancer)[1:2] <- c('id', 'type')
cancer.d <- as.matrix(cancer[,3:32])
labs <- cancer$type
test_size <- floor(0.15*nrow(cancer.d))
train <- sample(1:nrow(cancer.d), size = nrow(cancer.d) - test_size)
test <- which(!(1:569 \%in\% train))
truelabs = labs[test]

projectron <- function(A) cancer.d \%*\% A

seed <- .Random.seed
F <- projectron(basis_random(30))

##Simple Density Classification
kdebel <- kde_bel.builder(labs = labs[train], test = test, train = train)
x1 <- kdebel(F)
predicted1 <- apply(x1, MARGIN = 2, FUN = function(x) names(which.max(x)))
table(truelabs, predicted1)

##Density Classification Using Nearest Neighbor Information
knnbel <- knn_bel.builder(labs = labs[train], test = test, train =
train, options = list(k = 3, p = FALSE, dist.type = 'euclidean', out = 'var', coef
= 0.90))
x2 <- knnbel(F)
predicted2 <- apply(x2, MARGIN = 2, FUN = function(x) names(which.max(x)))
table(truelabs, predicted2)

##Same as above but now using the Coefficient of Variation for Classification
knnbel2 <- knn_bel.builder(labs = labs[train], test = test, train =
train, options = list(k = 3, p = FALSE, dist.type = 'euclidean', out = 'cv', coef =
0.90))
x3 <- knnbel2(F)
predicted3 <- apply(x3, MARGIN = 2, FUN = function(x) names(which.max(x)))
table(truelabs, predicted3)

##Density Classification Using Jitter & NN Information
jitbel <- jit_bel.builder(labs = labs[train], test = test, train =
train, options = list(k = 3, s = 2, p = FALSE, dist.type = 'euclidean', out =
'var', coef = 0.90))
x4 <- jitbel(F)
predicted4 <- apply(x4, MARGIN = 2, FUN = function(x) names(which.max(x)))
table(truelabs, predicted4)

##Same as above but now using the Coefficient of Variation for Classification
jitbel2 <- jit_bel.builder(labs = labs[train], test = test, train =
train, options = list(k = 3, p = FALSE, dist.type = 'euclidean', out =
'cv', s = 2, coef = 0.90))
x5 <- jitbel2(F)
predicted5 <- apply(x5, MARGIN = 2, FUN = function(x) names(which.max(x)))
table(truelabs, predicted5)

}

\concept{Classification}
