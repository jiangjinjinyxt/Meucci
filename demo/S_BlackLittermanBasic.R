#' This script describes to basic market-based Black-Litterman approach in particular: 
#' - full confidence = conditional
#' - no confidence   = reference model
#' Described in A. Meucci, "Risk and Asset Allocation",
#' Springer, 2005,  Chapter 9.
#'
#' @references
#' A. Meucci - "Exercises in Advanced Risk and Portfolio Management" \url{http://symmys.com/node/170},
#' "E 303 - Black-Litterman and beyond II".
#'
#' See Meucci's script for "S_BlackLittermanBasic.m" and "E 302 - Black-Litterman and beyond I"
#'
#' @author Xavier Valls \email{flamejat@@gmail.com}

##################################################################################################################
### Load inputs
data("covNRets"); 

##################################################################################################################
### Compute efficient frontier
NumPortf = 40; # number of MV-efficient portfolios 
L2L = Log2Lin( covNRets$Mu, covNRets$Sigma );
EFR = EfficientFrontierReturns( NumPortf, L2L$S, L2L$M );
PlotCompositionEfficientFrontier( EFR$Composition );

##################################################################################################################
### Modify expected returns the Black-Litterman way and compute new efficient frontier 
P     = cbind( 1, 0, 0, 0, 0, -1 ); # pick matrix
Omega = P %*% covNRets$Sigma %*% t( P );
Views = sqrt( diag( Omega ) ); # views value

B = BlackLittermanFormula( covNRets$Mu, covNRets$Sigma, P, Views, Omega );

L2LBL = Log2Lin( B$BLMu, B$BLSigma );                
EFRBL = EfficientFrontierReturns( NumPortf, L2LBL$S, L2LBL$M );
PlotCompositionEfficientFrontier( EFRBL$Composition );
