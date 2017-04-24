library(RSSL)
library(methods)
source("Code/datasets-and-classifiers.R")

set.seed(5618)
modelforms <- models[c("Ionosphere","SPECT","USPS")]
datasets <- datasets[c("Ionosphere","SPECT","USPS")]

measures <- list("Error"=measure_error,
                 "Average Loss Test"=measure_losstest)

lc <- LearningCurveSSL(modelforms,datasets,
                       classifiers=classifiers,
                       measures=measures,
                         n_l="2d",repeats=1000,verbose=TRUE,
                       pre_scale = FALSE, pre_pca = TRUE, mc.cores=1, low_level_cores=3,sizes = 2^(1:10))
save(lc, file="Data/learningcurves.RData")
