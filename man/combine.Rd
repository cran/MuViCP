\name{combine.ds}
\alias{combine.bs}
\alias{combine.ds}
\alias{combine.bpa.bs}
\alias{combine.bpa.ds}
\alias{combine.bpa.list.bs}
\alias{combine.bpa.list.ds}
\alias{combine.bpamat.bs}
\alias{combine.bpamat.ds}
\alias{combine.bpamat.list.bs}
\alias{combine.bpamat.list.ds}

\title{Combining Basic Probability Assignments}

\description{These functions can be used to combine one or several basic
probability assignments (bpa). In the limited context that we support here, a
bpa is nothing but a discrete distribution, that may have an additional
mass for ignorance.

The suffix tells how the combination will be done : \code{ds} denotes
that the Dempster-Shafer rules will be used, \code{bs} denotes that
Bayes' rule will be used. Thus the function \code{combine.ds} combines
two numeric vectors by Dempster-Shafer rules.

The first middle denotes what kind of object a function operates
on. Thus \code{combine.bpa.ds} combines two \code{bpa} objects by
Dempster-Shafer rules, while \code{combine.bpamat.ds} does the same for
two bpamat objects.

Finally, the second middle may be used - if set to \code{list}, it
combines lists of objects. Thus, the function \code{combine.bpa.list.ds}
combines lists of \code{bpa} objects by Dempster-Shafer rules.}

\usage{
combine.bs(x, y)
combine.ds(x, y)
combine.bpa.bs(b1, b2)
combine.bpa.ds(b1, b2)
combine.bpa.list.bs(blist)
combine.bpa.list.ds(blist)
combine.bpamat.bs(bmat1, bmat2)
combine.bpamat.ds(bmat1, bmat2)
combine.bpamat.list.bs(bmatlist)
combine.bpamat.list.ds(bmatlist)
}

\arguments{
  \item{x}{A numeric vector representing a bpa.}
  \item{y}{A numeric vector representing a bpa.}  
  \item{b1}{The first bpa object that needs to be combined.}
  \item{b2}{The second bpa object that needs to be combined.}
  \item{blist}{A list of bpa's to be be combined.}  
  \item{bmat1}{The first bpa matrix that needs to be combined.}
  \item{bmat2}{The second bpa matrix that needs to be combined.}
  \item{bmatlist}{A list of bpa matrices to be be combined.}
}

\value{
   The \code{combine.ds} functions returns a numeric vector representing
   the new bpa.

   The \code{combine.bpamat.bs}, \code{combine.bpamat.ds},
  \code{combine.bpamat.list.bs} and \code{combine.bpamat.list.bs}
  functions themselves returns a bpamat object.

  The \code{combine.bpa.bs}, \code{combine.bpa.ds},
  \code{combine.bpa.list.bs} and the \code{combine.bpa.list.ds}
  functions themselves returns a bpa object.  
}

\references{
  Gordon, J. and Shortliffe, E. H. (1984). The dempster-shafer theory of
  evidence. Rule-Based Expert Systems: The MYCIN Experiments of the
  Stanford Heuristic Programming Project, 3:832-838.
  Shafer, G. (1986). The combination of evidence. International Journal of
  Intelligent Systems, 1(3):155-179.
}

\author{Mohit Dayal}

\examples{
##Very Strong, Consistent Testimony
vstrong <- c(0.85, 0.07, 0.08)
##Strong, Consistent Testimony
strong <- c(0.7, 0.15, 0.15)
##Somewhat Ambiguous Testimony
amb <- c(0.55, 0.40, 0.05)
##More Diffuse Testimony
amb2 <- c(0.55, 0.20, 0.25)

fn_gen <- function(par)
{
    x <- gtools::rdirichlet(2, par)
    y <- x
    y <- t(apply(y, MARGIN = 1, FUN = function(x) x * 0.9))
    y <- cbind(y, 0.1)
    return(y)
}

a1 <- fn_gen(vstrong)
combine.bs(a1[1,], a1[2,])
combine.ds(a1[1,], a1[2,])

a2 <- fn_gen(strong)
combine.bs(a2[1,], a2[2,])
combine.ds(a2[1,], a2[2,])

a3 <- fn_gen(amb)
combine.bs(a3[1,], a3[2,])
combine.ds(a3[1,], a3[2,])

a4 <- fn_gen(amb2)
combine.bs(a4[1,], a4[2,])
combine.ds(a4[1,], a4[2,])

##For bpa or bpamat examples, see the relevant help files
}