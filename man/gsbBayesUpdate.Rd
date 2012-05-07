\name{gsbBayesUpdate}
\alias{gsbBayesUpdate}
\title{
Bayesian Update
}
\description{
Bayesian update from prior and data to posterior for normally
distributed data with known sigma. 
}
\usage{
gsbBayesUpdate(alpha, beta, meanData, precisionData, with.alpha = TRUE)
}
\arguments{
  \item{alpha}{
    \code{vector} of prior means.
  }
  \item{beta}{
    \code{vector} of prior precisions.
  }
  \item{meanData}{
    \code{vector} of means from data.
  }
  \item{precisionData}{
    \code{vector} of precisions from data.
  }
  \item{with.alpha}{
    \code{logical}. If \code{with.alpha = TRUE}, \code{alpha}, \code{beta},
    \code{meanData} and \code{precisionData} has to be specified and the
    posterior means, posterior precisions and weights are returned. Else only \code{beta} and \code{precisionData} has to be specified and the posterior precisions and weights are returned.}
}
\value{
  \item{alpha}{posterior means. Only if \code{with.alpha = TRUE}.}
  \item{beta}{posterior precisions.}
  \item{weight}{weights of the priors relative to the whole information after updating.}
}
\author{
Florian Gerber, Thomas Gsponer
}
\note{
This function is used in the function \code{gsb()}. 
}
\seealso{
\code{\link{gsb}}
}
\examples{
## One dimensional case, with.alpha = FALSE
gsbBayesUpdate(beta=10,precisionData=20, with.alpha=FALSE)

## Two dimensional case, with.alpha = TRUE
gsbBayesUpdate(alpha=c(5,6),beta=c(10,11),meanData=c(10,11),
               precisionData=c(20,21),with.alpha=TRUE)
}


\keyword{bayes update}
