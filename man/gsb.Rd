\name{gsb}
\alias{gsb}
\alias{gsbDesign}
\alias{gsbSimulation}

\title{Group Sequential Bayesian Design}

\description{
The \code{gsbDesign} package allows to evaluate the operating characteristics for a group sequential design with Bayesian success/futility criteria and prior information. A clinical trial with two arms, a normal endpoint and an arbitrary number of interim analyses can be evaluated. The success and futility criteria at each interim analysis are based on the posterior distribution for the true treatment difference (delta). An arbitrary number of success and futility criteria can be specified at each interim analysis. The success criteria are of the form:  
  \deqn{P( \delta  >  ds | data  )  > ps} 
And the futility criteria are of the form:   
   \deqn{P( \delta  <  df | data  )  > pf} 
Here ds and df are user-specified effect thresholds, and ps and pf are user-defined probability thresholds. \cr
Prior information can either be specified for the true treatment
difference (delta), or for the true effects in the two treatment
arms. Only normal prior distributions can be used. In all cases informative priors are specified in terms of a mean and an effective sample size defined relative to sigma.\cr
The user also has to specify the number of patients for each stage of
the group sequential design, and the standard deviation (sigma) of the endpoint (assumed to be known).\cr
The operating characteristics are either evaluated for a user-specified grid of true treatment differences, or for a grid or set of true treatment means for the two arms. The operating characteristics of main interest are the probabilities of success and futility at each interim analysis, and the expected sample size.\cr
The main function of the package is \code{gsb()}. 
}
\usage{
gsb(design = NULL, simulation = NULL)

gsbDesign(nr.stages = NULL,
          patients = NULL,
          sigma = 1,
          criteria.success = NULL,
          criteria.futility = NULL,
          prior.difference = "non-informative",
          prior.control = "non-informative",
          prior.treatment = "non-informative")

gsbSimulation(truth = NULL,
              type.update = c("treatment effect","per arm"),
              method = c("numerical integration", "simulation", "both"),
              grid.type = c("table","plot","sliced","manually"),
              nr.sim = 50000,
              warnings.sensitivity = 100,
              seed = NULL)
}
\arguments{
  \item{design}{
    an object of class \code{gsbDesign} containing information on the
              trial design. I.e. information on the number of stages
              (\code{nr.stages}), the number of patients
              (\code{patients}), and the standard deviation
              (\code{sigma}), the decision criteria
              (\code{criteria.success}, \code{criteria.futility}) and
              prior information (\code{prior.difference},
              \code{prior.control}, 
	      \code{prior.treatment}). This object can be created with
    function \code{gsbDesign()} as shown in the examples below.
  }
  \item{simulation}{
    an object of class \code{gsbSimulation} containing information on
    how to evaluate the operating characteristics. I.e. on the true
              effects (\code{truth}, \code{grid.type}), the Bayesian
              update (\code{type.update}), whether simulation or
              numerical integration is used (\code{method}) and simulation parameters (\code{nr.sim},
              \code{warnings.sensitivity}, \code{seed}). This object can be created with function
    \code{gsbSimulation()} as shown in the examples below.
  }
  \item{nr.stages}{
    a \code{numeric} of length 1 specifying the number of stages (interim and
    final analyses). 
  }
  \item{patients}{
    a \code{numeric} of length 1 in order to specify an equal number of
    patients in the control and treatment arm in every stage.
    Enter a \code{numeric} of length 2 in order to specify the number of
    patients in the control and treatment arm separately. If the number
              of patients is not equal for all stages enter a n x 2
              \code{matrix}. n denotes the number of stages.
	      More details are shown in the examples below. 
  }
  \item{sigma}{
    a \code{numeric} of length 1 in order to specify an equal
    standard deviation sigma for both arms. If the sigma is not equal in
              both arms enter a \code{numeric} of length 2 specifying
              c(sigma.control, sigma.treatment). More
    details are shown in the examples below. 
  }
  \item{criteria.success}{
    a \code{numeric} or \code{matrix} containing the success criteria ds
    and ps. More details are shown in the examples below.    
  }
  \item{criteria.futility}{
    a \code{numeric} or \code{matrix} containing the futility criteria df
    and pf. More details are shown in the examples below.    
  }
  \item{prior.difference}{
    if \code{prior.difference = "non-informative"} a non-informative (flat)
    prior on difference is used. Enter an informative prior as \code{numeric} as shown
    in the examples below. If this prior is specified the argument
              \code{type.update} as to be on "treatment effect".
  }
  \item{prior.control}{
    if \code{prior.control = "non-informative"} a non-informative (flat)
    prior is used in the control arm. Enter an informative prior as \code{numeric} as shown
    in the examples below. If this prior is specified the argument \code{type.update} has to be "per arm".
  }
  \item{prior.treatment}{
    if \code{prior.treatment = "non-informative"} a non-informative (flat)
    prior is used in the treatment arm. Enter an informative prior as \code{numeric} as shown
    in the examples below. If this prior is specified the argument \code{type.update} has to be "per arm".
  }
  \item{truth}{
    specifies the truth to evaluate.\cr
    
    If \code{type.update = "treatment effect"} this argument specifies
    the true treatment effect delta (= treatment - placebo). It has the form
    \code{truth = c(min, max, n)} where \code{min} and \code{max}
    indicates the range of the true treatment effect and \code{n}
    specifies the number of true values. (See example 1 below.)\cr
    Alternatively a \code{numeric} containing true delta values can be entered. To
    use this set \code{grid.type = "manually"}. (example 2).
    
    If \code{type.update = "per arm"} and \code{grid.type = "table"} the
    argument has to be specified as \code{list} containing a vector of true
    control values and true treatment values.\cr

    If \code{type.update = "per arm"} and \code{grid.type = "sliced"} the
    argument has to be specified as \code{list} containing a vector of true
    control values and a vector of true deltas (= treatment - control).\cr    
    
    If \code{type.update = "per arm"} and \code{grid.type = "plot"} the
    argument has to be specified as follows:\cr \code{truth = c(min.placebo, max.placebo,min.treatment, max.treatment, n)},
    here \code{n} is the number of grid points.\cr

    If \code{type.update = "per arm"} and \code{grid.type = "manually"}
    the argument has to be a n x 2 - matrix containing the true placebo
    values in the first column and the corresponding treatment values in
    the second column.
  }
  \item{type.update}{
    If \code{type.update = "treatment effect"}, the Bayesian update from prior to
    posterior is calculated on treatment effect delta. If
    \code{type.update = "per arm"}, the update is calculated separately
    in the placebo and the treatment arm. In this case it is possible to
    enter prior information in only one arm. For \code{type.update =
    "per arm"} only a simulation method is implemented. 
  }
  \item{method}{
    If the \code{type.update = "treatment effect"}, the operating characteristics
    can be obtained by simulation or by numerical integration, which is
    faster. So \code{method} can be set to \code{"simulation"}, \code{"numerical integration"} or
    \code{"both"}. We used \code{method = "both"} to check, whether the different methods yield
    the same results.
    If \code{type.update = "per arm"} only a simulation method is implemented.
  }
  \item{grid.type}{
    If \code{type.update = "per arm"}, there are 4 possibilities to
    specify the truth: \cr 
    1. \code{grid.type = "table"} for presenting the results in a table.\cr
    2. \code{grid.type = "sliced"} for presenting the results in a table.\cr
    3. \code{grid.type = "plot"} optimized grid for plotting the results.\cr
    4. \code{grid.type = "manually"} for specifying a grid in a matrix.\cr
    If \code{type.update = "treatment effect"} only \code{grid.type =
    "table"} and \code{grid.type = "manually"} are valid inputs. 
    The argument \code{truth} should be specified according to the argument
    \code{grid.type}.
  }
  \item{nr.sim}{
    a \code{numeric} of length 1 specifying the number of simulations.
  }
  \item{warnings.sensitivity}{
    a \code{numeric} of length 1. If the number of (\code{nr.sim}) is smaller than this integer value during the simulation, a warning
    message is printed. The number of simulations is
    decreasing in each stage because only the simulated trials with no decision in
    the precedent stages are remaining for simulation. Thus the accuracy decreases in
    each stage. \code{warnings.sensitivity} has to be specified
    if \code{method = "simulation"} or \code{method = "both"}.
  }
  \item{seed}{
    a \code{numeric} of length 1 to set a seed value for the random
    number generator. If \code{seed = "generate"} a new seed value is generated. 
  }
}
\details{
See Gerber and Gsponer (2016) for more details.
}
\value{
\item{OC }{a \code{data.frame} containing the resulting operating characteristics
  per stage (i.e. the probabilities of success, of futility and of
    success or futility), the cumulative operating characteristics per
    stage and the expected sample size per stage. }
\item{boundary }{a \code{data.frame} containing the boundaries, i.e. the
  bounds on posterior scale and the standardized bounds. This is
    available if \code{type.update = "treatment effect"} and \code{method = "numerical integration"} or \code{method = "both"}.}
\item{design }{same as input. }
\item{simulation }{same as input. }
\item{delta.grid }{an object of class \code{gsbDelta.grid} and
  \code{matrix} containing the grid of true control and true
  treatment values. Available if \code{type.update = "per arm"}.}
\item{warnings }{a \code{matrix} containing warnings if any. If a simulation was done (i.e. \code{method = "simulation"} or
    \code{method = "both"}) the number of simulations is
    decreasing in each stage because only the simulated trials with no decision in
    the precedent stages are remaining for simulation. Thus the accuracy decreases in
    each stage. \code{warnings} indicates the stages (and the
    deltas) for which the number of remaining simulations is below the threshold
    specified in \code{warnings.sensitivity}.  

}
\item{system.time }{contains information on the used time for the
  simulation / numerical integration.}
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
    \item Spiegelhalter DJ, Abrams KR, and Myles, JP (2004). Bayesian
    Approaches to Clinical Trials and Health Care Evaluation. Wiley, New
    York.
  }
}
\author{
Florian Gerber <florian.gerber@math.uzh.ch>, Thomas Gsponer
}
\seealso{
\code{\link{plot.gsbMainOut}}, \code{\link{tab}}, \code{\link{gsbBayesUpdate}}, \code{\link{gsbCriteria}}, \code{\link{gsbDesign-package}}
}
\examples{
## E X A M P L E 1: Update on treatment effect, flat prior
##
## A. Trial Design:
## ----------------
## A.1 2 stages (interim + final):
##     --> nr.stages = 2
## A.2 10 patients per arms and stages. (total 2*2*10 = 40 patients)
##     --> patients = 10
## A.3 Sigma in both arms = 10
##     --> sigma = 10
## A.3 Criteria:
##     stop for success, if P( delta > 0 | data ) >= 0.8
##                      AND P( delta > 7 | data ) >= 0.5 
##     --> criteria.success = c(0,0.8,7,0.5)
##     stop for futility, if P( delta < 2 | data ) >= 0.8
##     --> criteria.futility = c(2,0.8)
## A.4 Prior:
##     --> prior = "non-informative"

design1 <- gsbDesign(nr.stages = 2,
                     patients = 10,
                     sigma = 10,
                     criteria.success = c(0,0.8, 7, 0.5),
                     criteria.futility = c(2,0.8),
                     prior.difference = "non-informative")
design1

## B. Simulation Settings
## ----------------------
## B.1 True treatment effects to be evaluated = seq(-10,20,60)
##     --> truth = c(-10,20,60)
## B.2 Bayesian update on treatment effect delta (= treatment - control)
##     --> type.update = "treatment effect"

simulation1 <- gsbSimulation(truth=c(-10,20,60),
                             type.update="treatment effect")
simulation1

## C.1 Calculate the operating characteristics
x1 <- gsb(design=design1, simulation=simulation1)
x1

## D.1 Table the probabilities of success
t1.1 <- tab(x1, "success", digits=2)
t1.1

## D.2 Table the cumulative probabilities of futility at delta = c(-5,0,5.57)
##     (for 5.57 a linear interpolation is used.)
t1.2 <- tab(x1, "cumulative futility", atDelta = c(-5,0,5.57), digits=5)
t1.2

## D.3 Table the expected sample size (digits == 0 --> ceiling)
t1.3 <- tab(x1, "sample size", atDelta= c(-5,0,5,16), digits=0)
t1.3

## E.1 Plot the operating characteristics
plot(x1)

## E.2 Plot the operating characteristics
plot(x1,"cumulative all")

## E.3 Plot the expected sample size
plot(x1, what="sample size")

## F.1 Boundaries / criteria 
x1$boundary
plot(x1, what="boundary")
plot(x1, what="std.boundary")


## E X A M P L E 2: Update on treatment effect, informative prior
##
## A. Trial design:
## ----------------
## A.1 3 stages (interims + final):
##     --> nr.stages = 3
## A.2 10 patients per stage in control arm
##     15 patients per stage in treatment arm
##     (i.e. total 3 * ( 10 + 15 ) = 75 patients)
##     --> patients = c(10,15)
## A.3 Sigma in control arm = 9, sigma in treatment arm = 12
##     --> sigma = c(9,12)
## A.3 Criteria:
##     stop for success, if P( delta > 0 | data ) >= 0.8
##                      AND P( delta > 7 | data ) >= 0.5 
##     --> criteria.success = c(0,0.8,7,0.5)
##     not stop for futility, i.e. no futility criteria
##     --> criteria.futility = NA
## A.4 Prior on difference:
##     prior difference = 3
##     informative prior equivalent to:
##     5 patients in control arm; 2 patients in treatment arm
##     --> prior = c(3,5,2)

design2a <- gsbDesign(nr.stages = 3,
                     patients = c(10,15),
                     sigma=c(9,12),
                     criteria.success = c(0,0.8,7,0.5),
                     criteria.futility = NA,
                     prior.diff = c(3,5,2))
design2a

## A similar design with 3 success criteria can be specified as follows
## A.3 criteria:
##     Stage 1: stop for success, if P( delta > 0  | data ) >= 0.8
##                            AND if P( delta > 10 | data ) >= 0.5
##                            AND if P( delta > 14 | data ) >= 0.4
##     Stage 2: stop for success, if P( delta > 0  | data ) >= 0.8
##                            AND if P( delta > 9  | data ) >= 0.5
##                            AND if P( delta > 13 | data ) >= 0.4
##     Stage 3: stop for success, if P( delta > 0  | data ) >= 0.8
##                            AND if P( delta > 7  | data ) >= 0.5
##                            AND if P( delta > 12 | data ) >= 0.4
##     --> criteria.success = rbind(c(0,0.8, 10,0.5, 14,0.4),
##                                  c(0,0.8,  9,0.5, 13,0.4),
##                                  c(0,0.8,  7,0.5, 12,0.4))

design2b <- gsbDesign(nr.stages = 3,
                      patients = c(10,15),
                      sigma = c(9,12),
                      criteria.success = rbind(c(0,0.8, 10,0.5, 14,0.4),
                                               c(0,0.8, 9,0.5,  13,0.4),
                                               c(0,0.8, 7,0.5,  12,0.4)),
                      criteria.futility = NA,
                      prior.diff = c(3,5,2))
design2b

## B. Simulation Settings
## ----------------------
## B.1 True treatment effects to be evaluated from -5 to 30
##     --> truth = -5:30
## B.2 To enter the values in this format set grid.type = "manually"
##     --> grid.type = "manually"

## B.2 Bayesian update on treatment effect delta (treatment - control)
##     --> type.update = "treatment effect"

simulation2 <- gsbSimulation(truth = -5:30,
                             grid.type ="manually",
                             type.update = "treatment effect")
simulation2

## C. Calculate the operating characteristics
x2a <- gsb(design = design2a, simulation = simulation2)
x2b <- gsb(design = design2b, simulation = simulation2)
x2a
x2b

## D. Table the cumulative probabilities of success of 'design2b'
##    at delta = c(-5,0,5.57). For 5.57 a linear interpolation is used.
t2b <- tab(x2b, "cumulative success", atDelta = c(-5,0,5.57), digits=5)
t2b

## E. Plot the operating characteristics of 'design2a' and 'design2b'
plot(x2a)
plot(x2b)
plot(x2a,"cumulative all")

## F.1 Boundaries / criteria of 'design2b' 
x2b$boundary
plot(x2b, what="boundary")
plot(x2b, what="std.boundary")




\donttest{
## E X A M P L E 3: Update on treatment effect, informative prior
##
## A. Trial Design
## ---------------
## A.1 3 stages (interims + final):
##     --> nr.stages = 3
## A.2 Patients:
##         Stage 1: 10 patients in control arm; 15 patients in treatment arm
##         Stage 2: 20 patients in control arm; 30 patients in treatment arm
##         Stage 3: 30 patients in control arm; 45 patients in treatment arm
##     --> patients = rbind(c(10,15),c(20,30),c(30,45))
## A.3 Sigma in control arm = 9 ; in treatment arm = 12
##     --> sigma = c(9,12)
## A.4 Success criteria for all stages:
##     stop for success, if P( delta > 0 | data ) >= 0.8
##                      AND P( delta > 7 | data ) >= 0.5
##      --> criteria.success = c(0,0.8,7,0.5)
## A.5 Futility criteria:
##         Stage 1: no futility criteria
##         Stage 2: stop for futility, if P( delta < 2 | data ) >= 0.8
##         Stage 3: stop for futility, if P( delta < 2 | data ) >= 0.8
##     --> criteria.futility = rbind(c(NA,NA),c(2,0.8),c(2,0.8))
## A.6 Prior on treatment effect:
##         difference  = 3;
##         informative prior equivalent to:
##         2 placebo patient; 1 treatment patient
##     --> prior.difference = c(3,2,1)

design3 <- gsbDesign(nr.stages = 3,
                     patients = rbind(c(10,15),c(20,30),c(30,45)),
                     sigma=c(9,12),
                     criteria.success = c(0,0.8,7,0.5),
                     criteria.futility = rbind(c(NA,NA),c(2,0.8),c(2,0.8)),
                     prior.difference = c(3,2,1))
design3

## B. Simulation Settings
## ----------------------
## B.1 True treatment effects to be evaluated at seq(-5,20,15)
##     --> truth = c(-5,20,15)
## B.2 Bayesian update on treatment effect delta (= treatment - control)
##     --> type.update = "treatment effect"
## B.3 Operating characteristics are evaluated by simulation and
##     numerical integration to double check the results
##     --> method = "both"
## B.4 Number of simulations = 5000
##     --> nr.sim = 5000
## B.5 If the number of simulated trials is smaller than 300
##     during the simulation print a warning.
##     --> warnings.sensitivity = 300
## B.6 A seed value is set to 13
##     --> seed = 13 

simulation3 <- gsbSimulation(truth = c(-5,20,15),
                             type.update = "treatment effect",
                             method = "both",
                             nr.sim = 5000,
                             warnings.sensitivity = 300,
                             seed = 13)
simulation3

## C. Calculate the operating characteristics
x3 <- gsb(design = design3, simulation = simulation3)
x3

## D. The summary(x3) is almost the same as print(x3) but its entries
##    can be saved as list.
s3 <- summary(x3)
names(s3)

## E.1 Plot the operating characteristics
plot(x3)

## E.2 Plot the operating characteristics obtained by simulation and
##     numerical integration in one plot. The lines should be identical (then
##     only one line is visible)
plot(x3, "both")
plot(x3, "cumulative both")



## E X A M P L E 4 - Boundaries / Criteria
## See how the Bayesian boundaries change within 10 stages.
##
## A. Trial Design:
## ----------------
## A.1 10 stages (interims + final):
##     --> nr.stages = 10
## A.2 10 patients per arm and stage. (total 2*10*10 = 200 patients)
##     --> patients = 10
## A.3 sigma in both arms = 10
##     --> sigma = 10
## A.3 Criteria:
##     stop for success, if P( delta > 0 | data ) >= 0.8
##                      AND P( delta > 7 | data ) >= 0.5 
##     --> criteria.success = c(0,0.8,7,0.5)
##     stop for futility, if P( delta < 2 | data ) >= 0.8
##     --> criteria.futility = c(2,0.8)
## A.4 Prior:
##     --> prior = "non-informative"

design4 <- gsbDesign(nr.stages=10,
                     patients=10,
                     sigma=10,
                     criteria.success=c(0,0.8, 7, 0.5),
                     criteria.futility=c(2,0.8),
                     prior.difference="non-informative")
design4


## B. Simulation Settings
## --------------------------------------------
## B.1 True treatment effects to be evaluated = seq(-10,20,60)
##     --> truth = c(-10,20,60)
## B.2 Bayesian update on treatment effect delta (= treatment - control)
##     --> type.update = "treatment effect"

simulation4 <- gsbSimulation(truth=c(-10,20,60),
                             type.update="treatment effect")
simulation4

## C. Calculate the operating characteristics
x4 <- gsb(design = design4, simulation = simulation4)
x4

## D. Boundaries / criteria 
x4$boundary
plot(x4, what="boundary")
plot(x4, what="std.boundary")


## E X A M P L E 5 - Bayesian update "per arm", 
## 
## A. Trial Design:
## ----------------
## A.1 3 stages (interims + final):
##     --> nr.stages = 3
## A.2 12 patients per stage in control arm
##     20 patients per stage in treatment arm
##     (i.e. total 3 * ( 12 + 20 ) = 96 patients)
##     --> patients = c(12,20)
## A.3 sigma in both arms = 10
##     --> sigma = 10
## A.3 Criteria:
##     stop for success, if P( delta > 0 | data ) >= 0.8
##                      AND P( delta > 7 | data ) >= 0.5 
##     --> criteria.success = c(0,0.8,7,0.5)
##     stop for futility, if P( delta < 2 | data ) >= 0.8
##     --> criteria.futility = c(2,0.8)
## A.4 Prior:
##     informative prior equivalent to:
##     2 patients in control arm with mean = 0
##     --> prior.control = c(0,2)
##     1 patient in treatment arm with mean = 7 
##     --> prior.treatment = c(7,1)

design5 <- gsbDesign(nr.stages=3,
                     patients=c(12,20),
                     sigma=10,
                     criteria.success=c(0,0.8,7,0.5),
                     criteria.futility=c(2,0.8),
                     prior.control=c(0,2),
                     prior.treatment=c(7,1)) 
design5

## B.  Simulation Settings: - with table grid
## --------------------------------------------
## B.1 True control/treatment values:
##       control = seq(1,5,0.5)
##       treatment = seq(1,7,1)
##       --> truth = list(seq(1,5,0.5),seq(1,7,1))
## B.2 Output optimized to create table
##       --> grid.type = "table"
## B.3 Bayesian update per arm
##       --> type.update = "per arm"
## B.4 Number of simulations = 5000 (which is low)
##       --> nr.sim = 5000
## B.5 If the number of simulations is smaller than 2000
##       print a warning.
##       --> warnings.sensitivity = 2000
## B.6 A seed value is set to 13
##       --> seed = 13

simulation5.table <- gsbSimulation(truth = list(seq(1,5,0.5), seq(1,7,1)),
                                   grid.type = "table",
                                   type.update = "per arm",
                                   nr.sim = 5000,
                                   warnings.sensitivity = 2000,
                                   seed = 13)
simulation5.table

## The same grid can be specified manually by
simulation5.manually <- gsbSimulation(truth = as.matrix(expand.grid(seq(1,5,0.5),seq(1,7,1))),
                                     grid.type = "manually",
                                     type.update = "per arm",
                                     nr.sim = 5000,
                                     warnings.sensitivity = 2000,
                                     seed = 13)
simulation5.manually

## To specify a grid optimized for sliced plotting with
## control values from -10 to 0 and treatment values from -10 to 25

simulation5.sliced <- gsbSimulation(truth = list(control=seq(-10,0,2), delta=seq(-10,25,4)),
                                    grid.type = "sliced",
                                    type.update = "per arm",
                                    nr.sim = 5000,
                                    warnings.sensitivity = 2000,
                                    seed = 13)
simulation5.sliced

## To specify a grid optimized for plotting with
## control values from 1 to 5 and treatment values from 1 to 7
## with approximately 20 values enter: 
simulation5.plot <- gsbSimulation(truth = c(1,5,1,7,20),
                                  grid.type = "plot",
                                  type.update = "per arm",
                                  nr.sim = 5000,
                                  warnings.sensitivity = 2000,
                                  seed = 13)
simulation5.plot

## C. Use function gsb
x5.table <- gsb(design5,simulation5.table)
x5.sliced <- gsb(design5,simulation5.sliced)
x5.plot <- gsb(design5,simulation5.plot)
x5.table

## D. Tables
## D.1 For any grid a table in long format can be obtained  
t5.1 <- tab(x5.table,"cumulative futility")
head(t5.1)

t5.2 <- tab(x5.sliced,"all")
head(t5.2)

## D.2 For the "table" grid there are additionally tables in wide format available.
t5.3 <- tab(x5.table,"success", wide=TRUE)
t5.3

## Fix a stage, e.g. stage 2, to get a matrix
t5.3[,,2]

## D.2 Set delta.control to '3' to get a matrix
t5.3["contr 3",,]

# D.3 Plot results
plot(x5.table)
plot(x5.plot)
plot(x5.sliced)
plot(x5.sliced, sliced=TRUE)
plot(x5.sliced, sliced=TRUE, range.control=c(-4,0))
plot(x5.sliced, what="success", sliced=TRUE, range.control=c(-4,0))

## the plot can differ because the number of simulations "nr.sim"
## is low and because the grids are different
plot(x5.plot,"sample size", color=FALSE)
head(tab(x5.table,"sample size"))
}
}

\keyword{main function}
\keyword{operating characteristics}

