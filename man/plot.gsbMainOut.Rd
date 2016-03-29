\name{plot.gsbMainOut}
\alias{plot.gsbMainOut}
\alias{plot.gsbDesign}
\alias{plot.gsbSimulation}

\title{
Plot methods
}
\description{
Methods for plotting the results of \code{gsb()}.}
\usage{
\method{plot}{gsbMainOut}(x,
     what=c("all", "cumulative all",
            "both", "cumulative both",
            "sample size", "success", "futility",
            "success or futility", "indeterminate", "cumulative success",
            "cumulative futility", "cumulative success or futility",
            "cumulative indeterminate", "boundary",
            "std.boundary","delta.grid","patients"),
     range.delta = "default",
     stages = "default",
     delta.grid = TRUE,
     color = TRUE,
     smooth = 100,
     contour = TRUE, 
     export = FALSE,
     path = getwd(),
     sliced = FALSE,
     range.control="default", ...)

\method{plot}{gsbSimulation}(x,...)

\method{plot}{gsbDesign}(x,...)
}

\arguments{
  \item{x}{
    object of appropriate class.  
  }
  \item{what}{
    a \code{character string} to choose a plot. It should
    correspond to one level of \code{OC$type} where \code{OC} is an
    object of the output of \code{gsb()}. Additional possibilities are
    \code{what = "all"} to plot the success-, futility- and success or
    futility-probabilities, \code{what = "cumulative all"} to plot the
    cumulative success-, cumulative futility- and cumulative success or
    futility-probabilities, \code{what = "boundary"} or \code{what =
  "std.boundary"} to plot the bounds, \code{what = "patients"} for a histogram of
    the patients per stage and \code{what = "delta.grid"} to plot the
    grid of delta's.
  }
  \item{range.delta}{
    a \code{vector} of length 2. For choosing the plot limits manually
    set \code{range.delta = c(min, max)} for a Bayesian update on
    "treatment effect" or \cr \code{range.delta = c(control.min, control.max, treatment.min, treatment.max)} for a Bayesian update "per arm". If
    \code{range.delta = "default"} the range of the
    plot is chosen so that all delta's are covered.
  }
  \item{stages}{
    a \code{vector} of length 2 containing the number of the lowest and
    highest stage, which should be plotted. If \code{stages = "default"}
    all stages are plotted (expect for \code{what = "sample size"} where
    only the last stage is plotted.)
  }
 
  \item{delta.grid}{
    \code{logical}. If \code{TRUE} the delta grid is plotted too.
  }
  \item{color}{
    \code{logical}. If \code{TRUE} the plot is colored.
  }
  \item{smooth}{
    a \code{vector} of length 1. A higher number makes the plot
    'smoother' if \code{type.update = "per arm"}.
  }
  \item{contour}{
    \code{logical}. If \code{TRUE} contour lines are added to the plot.
  }
  \item{export}{
    \code{logical}. If \code{TRUE} the plot is save as .png-file.
  }
  \item{path}{
    \code{character}. to specify the location to which to table should
    be exported. the default 'getwd()' exports the table to the working
    directory.
  }
  \item{sliced}{
    \code{logical}. If \code{TRUE} the contour plot for \code{type.update =
    "per arm"} is shown in several 2D plots. In order to use this option
    the argument \code{grid.type} of \code{gsbSimulation()} has to be \code{sliced}.   
  }
  \item{range.control}{
    a \code{vector} of length 2 or \"default\". If \code{special = TRUE}
    the range of the control values can be set manually as vector c(min, max). 
  }
  \item{...}{further arguments passed to or from other methods.}
}

\references{
uses the R-package 'lattice'. 
}
\author{
Florian Gerber <florian.gerber@math.uzh.ch>, Thomas Gsponer
}

\seealso{
\code{\link{gsb}}, \link[lattice]{xyplot}
}

\examples{

## please see examples of function 'gsb'. 
## --------------------------------------


## --------------------------------------
## alternative plots can be created for example
## with package 'ggplot2'.
\dontrun{
des <- gsbDesign(nr.stages=2,
                     patients=10,
                     sigma=10,
                     criteria.success=c(0,0.8, 7, 0.5),
                     criteria.futility=c(2,0.8),
                     prior.difference="non-informative")

sim <- gsbSimulation(truth=c(-10,20,60),
                             type.update="treatment effect")


x <- gsb(des,sim)

## get data.frame with operating characteristics
datgraph <- x$OC


## prepare for plot
sub <- levels(datgraph$type)[1:3]
datgraph2 <- subset(datgraph,datgraph$type \%in\% sub)
datgraph2$type <- as.factor(paste(datgraph2$type))
datgraph2$value[datgraph2$type=="cumulative success or futility"] <-
1-datgraph2$value[datgraph2$type=="cumulative success or futility"]
levels(datgraph2$type) <- c("1)cumulative futility" ,"3)cumulative success","2)indeterminate")
datgraph2$type=as.factor(paste(datgraph2$type))
levels(datgraph2$type) <- c("cumulative futility" ,"indeterminate","cumulative success")
datgraph2 <- datgraph2[order(datgraph2$delta),]


## plots
p1 <- qplot(delta,value,geom="blank",color=type,facets=.~stage,data=datgraph2,
xlab=expression(delta))

p1+geom_line(size=1.5)+scale_color_manual(values = c("cumulative futility" = "dark red",
"indeterminate" = "orange", "cumulative success" = "dark green"))

p2=p1+geom_area(aes(x = delta,y=value,fill=type))

p2+scale_fill_manual(values = c("cumulative futility" = "dark red",
"indeterminate" = "orange", "cumulative success" = "dark green"))

}
}
\keyword{plot}