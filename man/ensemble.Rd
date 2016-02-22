\name{ensemble}
\alias{ensemble}
\title{Ensemble Objects for Classification}

\description{
  This function provides for the creation, and storage of an ensemble of
  simpler classifiers. Right now, only a single type of classifier is
  available; this shall be fixed in the future.
}

\usage{
ensemble(dat, train, test, labs, bel.type = c('kde', 'knn', 'jit'), bel_options)
}

\arguments{
  \item{dat}{The full data matrix, including both test and train rows.}
  \item{train}{A vector containing the row numbers (or names) of the
  training data in the matrix \code{dat}.}
  \item{test}{A vector containing the row numbers (or names) of the
  test data in the matrix \code{dat}.}
  \item{labs}{Labels for the training data; must be of the same length
    as \code{train}.}
  \item{bel.type}{The type of belief function to build the Ensemble. For
  more details, see help on Belief.}
  \item{bel_options}{The options list that should be passed to the
  belief function.}
}

\details{The simpler classifiers must work in 2-dimensions projections
  of the data.}

\value{
  Returns a list of functions which can be used to query and / or
  manipulate the created \code{ensemble} object.

   \item{try.matrices}{Takes a single argument \code{n} which is the
   number of matrices you want to try.}
   \item{get.bpamats}{Returns a list of bpa.mat objects representing the
   classifications recieved from each projection.}
}

\author{Mohit Dayal}

\examples{
data(cancer)
table(cancer$V2)
colnames(cancer)[1:2] <- c('id', 'type')

cancer.d <- as.matrix(cancer[,3:32])
labs <- cancer$type
test_size <- floor(0.15*nrow(cancer.d))
train <- sample(1:nrow(cancer.d), size = nrow(cancer.d) - test_size)
test <- which(!(1:569 \%in\% train))
truelabs = labs[test]

e <- ensemble(dat = cancer.d, labs = labs[train], train = train, test =
test, bel.type = 'kde', bel_options = list(coef = 0.90))

##Try more matrices than that in real life!
##Also increase the mc.cores parameter if you have more cores!
e$try.matrices(n = 3, mc.cores = 1)

y <- e$get.bpamats()
length(y)

##Can see results from each projection
##b.1  <- bpamat(mat = y[[1]]$get.mat())
##b.2  <- bpamat(mat = y[[2]]$get.mat())
##b.12b <- combine.bpa.mat.bs(b.1, b.2)
##b.12d <- combine.bpa.mat.ds(b.1, b.2)
##b.12b$get.classify()
##b.12d$get.classify()

##All the results
##b.n <- lapply(y, function(x) x$get.classify())
##allb <- combine.bpa.mat.list.bs(e$get.bpamats())
##alld <- combine.bpa.mat.list.ds(e$get.bpamats())

##fn1 <- function(x)
##    table(truelabs, x$get.classify())

##fn2 <- function(x)
##    {
##        tmp <- table(truelabs, x$get.classify())
##        100 *sum(diag(tmp)) / sum(tmp)
##    }

##fn1(allb)
##fn2(allb)
##fn1(alld)
##fn2(alld)
}

\seealso{belief}

% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\concept{Classification}
