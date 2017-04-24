library(RSSL)
library(methods)
source("Code/datasets-and-classifiers.R")

set.seed(5618)


measures <- list("Error" =  measure_error,
                 "Loss" = measure_losstest,
                 "Loss labeled" = measure_losslab,
                 "Loss Lab+Unlab" = measure_losstrain
)

classifiers<-list(
  "Supervised"=function(X,y,X_u,y_u) {LeastSquaresClassifier(X,y,intercept=TRUE,x_center=TRUE,scale=FALSE) },
  "Self-Learning"=function(X,y,X_u,y_u) {SelfLearning(X, y, X_u, method=LeastSquaresClassifier,intercept=TRUE,x_center=TRUE,scale=FALSE)},
  "ICLS"=function(X,y,X_u,y_u) {ICLeastSquaresClassifier(X,y,X_u,intercept=TRUE,x_center=TRUE,scale=FALSE) },
  "Projection"=function(X,y,X_u,y_u) {ICLeastSquaresClassifier(X,y,X_u,intercept=TRUE,x_center=TRUE,scale=FALSE,projection="semisupervised") },
  "Oracle"=function(X,y,X_u,y_u) {LeastSquaresClassifier(rbind(X,X_u),unlist(list(y,y_u)),intercept=TRUE,x_center=TRUE,scale=FALSE) },
  "SVM"=function(X,y,X_u,y_u) { svmlin(X,y,X_u, algorithm=1,lambda=0.1,lambda_u=1,pos_frac=mean(as.numeric(y)==2)) },
  "TSVM"=function(X,y,X_u,y_u) { svmlin(X,y,X_u, algorithm=2,lambda=0.1,lambda_u=1,pos_frac=mean(as.numeric(y)==2))}
)


results_cv <- CrossValidationSSL(models, datasets,
                       classifiers=classifiers,
                       measures=measures,
                       n_l="enough",repeats=20,verbose=TRUE,
                       pre_scale = FALSE, pre_pca = FALSE, mc.cores=1, low_level_cores=3)
save(results_cv, file="Data/crossvalidation.RData")