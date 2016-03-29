\name{gsb-package}
\alias{gsb-package}
\alias{gsbDesign-package}
\docType{package}
\title{Group Sequential Bayesian Design}
\description{
The \code{gsbDesign} package allows to evaluate the operating characteristics for a group sequential design with Bayesian success/futility criteria and prior information. A clinical trial with two arms, a normal endpoint and an arbitrary number of interim analyses can be evaluated. The success and futility criteria at each interim analysis are based on the posterior distribution for the true treatment difference (delta). An arbitrary number of success and futility criteria can be specified at each interim analysis. The success criteria are of the form:  
  \deqn{P( \delta  >  ds  | data  )  > ps} 
And the futility criteria are of the form:   
   \deqn{P( \delta  <  df  | data  )  > pf} 
Here ds and df are user-specified effect thresholds, and ps and pf are user-defined probability thresholds. \cr
Prior information can either be specified for the true treatment
difference (delta), or for the true effects in the two treatment
arms. Only normal prior distributions can be used. In all cases
informative priors are specified in terms of a mean and an effective
sample size defined relative to sigma.\cr
The user also has to specify the number of patients for each stage of
the group sequential design, and the standard deviation (sigma) of the endpoint (assumed to be known).\cr
The operating characteristics are either evaluated for a user-specified grid of true treatment differences, or for a grid or set of true treatment means for the two arms. The operating characteristics of main interest are the probabilities of success and futility at each interim analysis, and the expected sample size.\cr
The main function of the package is \code{gsb()}. More detailed information can be found in the help of function \code{gsb()}.
}

\details{
  \tabular{ll}{
    Package: \tab gsbDesign\cr
    Type: \tab Package\cr
    Version: \tab 1.00\cr
    Date: \tab 2016-03-27\cr
    License: \tab GNU General Public License >=3\cr
    LazyLoad: \tab yes\cr
  }
}

\author{
Florian Gerber <florian.gerber@math.uzh.ch>, Thomas Gsponer
}
\references{
  \itemize{
    \item Gerber F, Gsponer T (2016). 
    gsbDesign: An R Package for Evaluating the Operating Characteristics of a Group Sequential Bayesian Design.
    Journal of Statistical Software, 69(11), 1-23, DOI: 10.18637/jss.v069.i11
    \item Gsponer T, Gerber F, Bornkamp B, Ohlssen D, Vandemeulebroecke M, Schmidli H (2014).
    A Practical Guide to Bayesian Group Sequential Designs.
    Pharmaceutical Statistics, 13(1) 71-80, DOI: 10.1002/pst.1593
    \item Berry SM, Carlin BP, Lee JJ, and Mueller P
    (2010). Bayesian Adaptive Methods for Clinical Trials.
    Chapman&Hall/CRC, London.
    \item Jennison C, and Turnbull BW (2000). Group Sequential Methods
    with Applications to Clinical Trials. Chapman&Hall/CRC, London.
    \item Spiegelhalter DJ, Abrams KR, and Myles, J. P. (2004). Bayesian
    Approaches to Clinical Trials and Health Care Evaluation. Wiley, New
    York.
  }
}

\keyword{package}
\seealso{
  \code{\link{gsb}}
}
