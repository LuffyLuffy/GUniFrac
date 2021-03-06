\name{GUniFrac-package}
\alias{GUniFrac-package}
\docType{package}
\title{
Generalized UniFrac distance for comparing microbial communities.
}
\description{
A generalized version of the commonly used UniFrac distance. The generalized UniFrac
distance contains an extra parameter controlling the weight on abundant 
lineages so the distance is not dominated by highly abundant lineages. The 
unweighted and weighted UniFrac, and variance-adjusted weighted UniFrac distances
are also implemented.  The package also implements a permutation-based multivariate
analysis of variance using \strong{MULTIPLE} distance matrices.
}
\details{
\tabular{ll}{
Package: \tab GUniFrac\cr
Type: \tab Package\cr
Version: \tab 1.1\cr
Date: \tab 2018-02-14\cr
License: \tab GPL-3\cr
LazyLoad: \tab yes\cr
}
}
\references{
%% ~put references to the literature/web site here ~
Jun Chen et al. (2012). Associating microbiome composition with 
environmental covariates using generalized UniFrac distances. 28(16): 2106–2113.
}
\author{
%%  ~~who you are~~
Jun Chen <chen.jun2@mayo.edu>
}

\keyword{ package }
\keyword{ distance }
\keyword{ ecology }
\keyword{ htest}
\keyword{ multivariate }
\keyword{ regression }
\keyword{ nonparametric }

\examples{
data(throat.otu.tab)
data(throat.tree)
data(throat.meta)

groups <- throat.meta$SmokingStatus

# Rarefaction
otu.tab.rff <- Rarefy(throat.otu.tab)$otu.tab.rff

# Calculate the UniFracs
unifracs <- GUniFrac(otu.tab.rff, throat.tree, alpha=c(0, 0.5, 1))$unifracs

dw <- unifracs[, , "d_1"]			# Weighted UniFrac
du <- unifracs[, , "d_UW"]			# Unweighted UniFrac	
dv <- unifracs[, , "d_VAW"]			# Variance adjusted weighted UniFrac
d0 <- unifracs[, , "d_0"]     		# GUniFrac with alpha 0  
d5 <- unifracs[, , "d_0.5"]   		# GUniFrac with alpha 0.5 

# Permanova - Distance based multivariate analysis of variance
adonis(as.dist(d5) ~ groups)

# Combine d(0), d(0.5), d(1) for testing
PermanovaG(unifracs[, , c("d_0", "d_0.5", "d_1")] ~ groups)
}
