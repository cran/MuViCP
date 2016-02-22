\name{bpamat}
\alias{bpamat}
\alias{print.bpamat}

\title{Matrices of Basic Probability Assignment Objects}

\description{
These functions enhance the functionality provided via \code{bpa}
objects. They essentially provide for the storage of several bpa
objects at once as a matrix.
}

\usage{
bpamat(info = NULL, mat = NULL)
\method{print}{bpamat}(x, ...)
}

\arguments{
  \item{info}{A piece of auxiliary information that you want stored
  along with the matrix of bpa's. (Used internally to store the random seed, or
  the special character \code{'C'} if the bpa object resulted from a combination.)}
  \item{mat}{The matrix of bpa's. Each column represents a point, and
  the rows represent classes. Should have column names set to the row
  names of the points, and row names set to the names of the classes}
  \item{x}{The bpamat object to be printed.}
  \item{...}{Additional arguments to print method. Not Used.}
}

\details{The \code{ensemble} function returns objects of this type.}

\value{
  The \code{bpamat} function returns a list of functions which can be used to
  query and / or manipulate the create bpa object.

   \item{set.info}{Takes a single argument which is set as the auxiliary
   information you want stored with the matrix}
   \item{get.info}{Returns the auxiliary information stored with the matrix}
   \item{assign.mat}{Takes a single argument, which should be a matrix
   of bpa's, to be stored inside the bpamat object.}
   \item{get.classify}{Returns a vector as long as the number of points
   stored in the \code{bpamat} object. The elements are named after the
   points, and are the current classification of the point, based on the
   bpamat object.}
   \item{get.point}{Returns the bpa corresponding to a single point,
   whose name is passed as the argument.}
   \item{get.mat}{Returns the matrix of bpa's.}
  \item{get.setlist}{Returns the class names that occur in the current matrix}
   \item{get.pointlist}{Returns the names of all the points whose bpa's
     are stored in the current matrix.}
}

\author{Mohit Dayal}

\seealso{bpa, combine.bpamat.bs, combine.bpamat.ds,
  combine.bpamat.list.bs, combine.bpamat.list.ds}

\examples{
data(cancer)
table(cancer$V2)
colnames(cancer)[1:2] <- c('id', 'type')

cancer.d <- as.matrix(cancer[,3:32])
labs <- cancer$type
test_size <- floor(0.15*nrow(cancer.d))
train <- sample(1:nrow(cancer.d), size = nrow(cancer.d) - test_size)
test <- which(!(1:569 \%in\% train))
truelabs <- labs[test]

projectron <- function(A)
    cancer.d \%*\% A

kdebel <- kde_bel.builder(labs = labs[train], test = test, train =
train)

##A projection
seed1 <- .Random.seed
F1 <- projectron(basis_random(30))
x1 <- kdebel(F1)
y1 <- bpamat(info = seed1, mat = x1)
y1
predicted1 <- y1$get.classify()
table(truelabs, predicted1)

##Another projection
seed2 <- .Random.seed
F2 <- projectron(basis_random(30))
x2 <- kdebel(F2)
y2 <- bpamat(info = seed2, mat = x2)
y2
predicted2 <- y2$get.classify()
table(truelabs, predicted2)

z1 <- combine.bpamat.bs(y1, y2)
z2 <- combine.bpamat.ds(y1, y2)
table(truelabs, z1$get.classify())
table(truelabs, z2$get.classify())

##Same result
w1 <- combine.bpamat.list.bs(list(y1, y2))
w2 <- combine.bpamat.list.ds(list(y1, y2))
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\concept{dempster-shafer calculus}
