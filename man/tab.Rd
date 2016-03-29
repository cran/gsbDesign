\name{tab}
\alias{tab}

\title{
get tables.
}
\description{
This function creates tables from the output of function
\code{gsb()}. 
}
\usage{
tab(x,
    what=c("all", "cumulative all", "success", "futility",
           "indeterminate", "success or futility", 
           "cumulative success", "cumulative futility",
           "cumulative indeterminate", "cumulative success or futility",
           "sample size"),
    atDelta = "default",
    wide=FALSE,
    digits = 3,
    export = FALSE,
    sep = ",",
    path = getwd())
}

\arguments{
  \item{x}{
    object of class \code{gsbMainOut} which is returned by the function
    \code{gsb()}.
  }
  \item{what}{
    \code{string} to specify the content of the table. It should correspond
    one level of \code{OC$type} in the output of \code{gsb()}. 
  }
  \item{atDelta}{
    if \code{"default"} the table shows the operating characteristics
    evaluated at the actually calculated true values entered in argument
    \code{truth} of function \code{gsbSimulation}. Alternatively a
    \code{numeric} of arbitrary length can be entered. Then the operating
    characteristics are displayed for the true value delta entered in this
    \code{numeric} using a linear interpolation. This only works if \code{type.update = "treatment effect"}.
  }
  \item{wide}{
    \code{logical}. If TRUE a zable in wide format is produced. Only
  possible if \code{grid.type = "table"}.
  }
  \item{digits}{
    \code{numeric} of length 1 specifying the number of digits which should be
    displayed in the table. The function \code{round()} is used. If \code{what = "sample size"} and \code{digits = 0}, the function uses \code{ceiling()} instead. 
  }
  \item{export}{
    \code{logical}. if \code{TRUE} the table is exported and saved as .cvs-file.   }
 \item{sep}{
   \code{character}. the field separator string. if the table is
  exported the values are separated by this string.
 }
  \item{path}{
    \code{character}. to specify the location to which to table should
  be exported. the default 'getwd()' exports the table to the working
  directory.
  }
  
}

\author{
Florian Gerber <florian.gerber@math.uzh.ch>
}

\examples{
## please see examples of function 'gsb'.
}

\keyword{table}

