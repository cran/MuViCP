\name{bpa}
\alias{bpa}
\alias{print.bpa}
\title{Basic Probability Assignment Objects}

\description{
These functions can be used to create, combine and print basic probability
assignment objects for classificiation. A Basic Probabilty Assignment is
a similar to a probabilty mass function, except that it has an
additional mass for the concept for "ignorance".
}

\usage{
bpa(n = 1, setlist = c(1:n, Inf), mlist = c(rep(0, n), 1))
\method{print}{bpa}(x, verbose = FALSE, ...)
}

\arguments{
  \item{n}{The number of distinct values that need to be
  represented. Usually set to the number of classes in the data.}
  \item{setlist}{A subset of 1:\code{n}, indicating those elements that have
  positive mass. The special value 'Inf' is used to denote the whole
  set, which is ignorance in dempster-shafer terms.}
  \item{mlist}{The actual masses assigned to the elements in the \code{setlist}.}
  \item{x}{The bpa object to be printed.}
  \item{verbose}{If FALSE (default), simply prints out the basic
  probability assignment. If TRUE, prints a list of all member functions
  as well.}
  \item{...}{Additional arguments to print method. Not Used.}
}

\details{
  It should be noted that these functions are fairly simplistic, since
  they were designed to be fast, and work with classification only. In
  particular, if you have set-valued elements, the combination function
  will likely give the wrong answer unless the sets are
  non-intersecting. For the same reason, belief functions have not been
  implemented either, since for atomic elements, bpa = belief function.
}

\value{
  The \code{bpa} function returns a list of functions which can be used to
  query and / or manipulate the create bpa object.
   \item{get.N}{Get the number of distinct values represented in the
     bpa. Usually set to the number of classes.}
   \item{get.setlist}{Get the sets represented in the bpa}
   \item{get.full.m}{Get the masses assigned to each of the elements.}
   \item{get.focal.elements}{Get only those elements that have a
     positive mass attached to them. Such elements are called the focal
     elements of the bpa.}
   \item{get.m}{Get the masses attached only to the focal elements, that
   is the non-zero elements of the mlist.}
   \item{get.mass}{Get the masses attached to certain specified elements
   of the bpa. The elements are specifed as a vector via the argument \code{s}.}
  \item{assign.bpa}{Can be used to re-assign mass to certain specified
     elements of the bpa. The argument \code{s} is the same as the
     setlist, and \code{m} is the same as mlist.}
   \item{get.assigned.class}{Returns a vector of all possible classes,
     in decreasing order of assigned probabilty. (That is, the first
     element is the most likely class, and the last element is the least
     likely class.)}
   \item{get.assigned.ratios}{Returns a vector of length \code{N}-1,
     each of whose elements is the ratio of the probability assigned to the
     successive classes. That is, the first element is the ratio of the
     probability assigned to the most likely class to that assigned to the
     next most likely class, and so on.}
   \item{set.name}{Can be passed a string to name the \code{bpa} object. (Used
  by the \code{bpamat} function; names are set to the row number.)}
   \item{get.name}{Returns the name of the \code{bpa} object. If not assigned,
  returns \code{NULL}.}
   \item{set.info}{Can be used to store as auxiliary information. (Used
  internally by the \code{bpamat} function to store the random seed, or
  the special character \code{'C'} if the bpa object resulted from a combination.)}
   \item{get.info}{Returns whatever was stored as info. If empty,
  \code{NULL} is returned.}
 }

 \references{
   Gordon, J. and Shortliffe, E. H. (1984). The dempster-shafer theory of
   evidence. Rule-Based Expert Systems: The MYCIN Experiments of the
   Stanford Heuristic Programming Project, 3:832-838.
   Shafer, G. (1986). The combination of evidence. International Journal of
   Intelligent Systems, 1(3):155-179.
 }

 \author{Mohit Dayal}

 \seealso{combine.bpa.bs, combine.bpa.ds, combine.bpa.list.ds, combine.bpa.list.ds}

 \examples{
##Empty bpa - All mass is attached to ignorance
b1 <- bpa(3)
b1

##Add a set to this bpa
b1$assign.bpa(s = c(1,2), m = c(0.3,0.4))
print(b1, verbose = TRUE)

##The same thing in a different way - classes can be named
##Note that the print method omits empty classes
b0 <- bpa(3, c('A','B','C', Inf), c(0.3, 0.4, 0, 0.3))
b0

##Another bpa
##Again, class '2' has been omitted
b2 <- bpa(3)
b2$assign.bpa(s = c(1,3), m = c(0.7,0.1))
b2

##Combine
b3 <- combine.bpa.ds(b1,b2)
b3
combine.bpa.bs(b1,b2)

##As a list, should be same answer as above
b4 <- combine.bpa.list.ds(list(b1,b2))
b4
combine.bpa.list.bs(list(b1,b2))
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\concept{dempster-shafer calculus}
