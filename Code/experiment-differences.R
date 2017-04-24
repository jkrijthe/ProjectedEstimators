library(methods)
library(RSSL)
library(parallel)

source("Code/datasets-and-classifiers.R")
set.seed(5618)

classifiers<-list(
  "Sup"=function(X,y,X_u,y_u) {LeastSquaresClassifier(X,y,intercept=TRUE,x_center=TRUE,scale=FALSE) },
  "Self"=function(X,y,X_u,y_u) {SelfLearning(X, y, X_u, method=LeastSquaresClassifier,intercept=TRUE,x_center=TRUE,scale=FALSE)},
  "Projection"=function(X,y,X_u,y_u) {ICLeastSquaresClassifier(X,y,X_u,intercept=TRUE,x_center=TRUE,scale=FALSE,projection="semisupervised") },
  "SVM"=function(X,y,X_u,y_u) { svmlin(X,y,X_u, algorithm=1,lambda=0.1,lambda_u=1,pos_frac=mean(as.numeric(y)==2)) },
  "TSVM"=function(X,y,X_u,y_u) { svmlin(X,y,X_u, algorithm=2,lambda=0.1,lambda_u=1,pos_frac=mean(as.numeric(y)==2))}
)

measures <- list("Error" =  measure_error,
                 "Loss" = measure_losstest,
                 "Loss labeled" = measure_losslab,
                 "Loss Lab+Unlab" = measure_losstrain
)

lc <- LearningCurveSSL(models,datasets,
                 classifiers,
                 measures=measures,
                 n_l="2d",s=1000,
                 repeats=100, verbose=TRUE, 
                 with_replacement = TRUE, 
                 n_test = 1000, pre_pca=TRUE,
                 low_level_cores=3)

dir.create("Data/",showWarnings = FALSE)
save(lc, file=paste0("Data/experiment-difference-2dor10.RData"))
