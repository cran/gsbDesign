\name{gsbCriteria}
\alias{gsbCriteria}
\title{
Criteria on posterior scale
}
\description{
Transforms the criteria on posterior-scale. 
}
\usage{
gsbCriteria(criteria, priorMean, postPrecision, weight)
}
\arguments{
  \item{criteria}{an \code{array} with criteria. Can be created with the function \code{gsbDesign()}.
}
  \item{priorMean}{a \code{vector} of prior means.}
  \item{postPrecision}{a \code{vector} of posterior precisions. Can be created
    with function \code{gsbBayesUpdate()}.}
  \item{weight}{a \code{vector} of weights from the bayesian update. Can be created with function \code{gsbBayesUpdate()}.
}
}
\value{
\item{CS }{vector of success criteria on posterior scale}
\item{CF }{vector of futility criteria on posterior scale}
}

\author{
Florian Gerber, Thomas Gsponer
}
\note{
This function is used in function \code{gsb()}. 
}

\seealso{
\code{\link{gsb}}
}

\keyword{criteria}

