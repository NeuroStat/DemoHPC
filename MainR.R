####################
#### TITLE:     R containing main code
#### Contents:
####
#### Source Files:
#### Last Modified: 21/10/2016
####################


##
###############
### Notes
###############
##



###########################################################
################### COMMAND GIVEN TO HPC ##################
#                           ||                            #
#                           IDs                           #
#                           ||                            #
############### BASH SCRIPT EXECUTED ON HPC ###############
#                           ||                            #
#                           ||                            #
##################### ONE MAIN R FILE #####################
######||#######       ######||#######       ######||#######
#     ||                    ||                    ||      #
######||#######       ######||#######       ######||#######
## R script_1 #       ## R script_2 #       ## R script_3 #
######||#######       ######||#######       ######||#######
#     ||                    ||                    ||      #
######||#######       ######||#######       ######||#######
# CORE ON HPC #       # CORE ON HPC #       # CORE ON HPC #
###########################################################


# So this "Main R file" gets a unique number from your bash script.
# We can use this number to generate our conditions.

# In this demonstration, we use this number under K and use it in a simple simulation.



##
###############
### Preparation
###############
##

# Start with clear working space
rm(list=ls())

# activate input from command line
input <- commandArgs(TRUE)
# Here we say, take the first argument from your input.
  # Hence this corresponds to PBS_ARRAYID in your bash script
K <- as.numeric(as.character(input)[1])

# You can give more arguments, e.g. here is your account number (second argument)
vsc <- as.numeric(as.character(args)[2])

# Seed based on K !!!
seed <- 50*K
set.seed(seed)

##
###############
### Code
###############
##


# Here, we check distribution of t-values from a simple linear regression fit.
  # Can we find association between weight of subjects and IQ?
	# Predictor is weight of subjects
	# Y variable is IQ.

# Weight of subjects
X <- 60 + rnorm(n=30,mean=0,sd=5)
# IQ
Y <- 100 + rnorm(n=30,mean=0,sd=5)

# Linear regression
fit <- lm(Y~X)

# T-value
TVal <- summary(fit)$coefficients[2,3]



##
###############
### Save our results
###############
##

# Better give name, according to K to your results!

# Saving into my home folder on HPC
save(TVal, file=paste('/user/home/gent/vsc407/vsc',vsc,'/Demo/Results/TVal_',K,sep=''))








