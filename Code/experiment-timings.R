library(RSSL)
library(methods)

set.seed(5618)

classifiers<-list(
  "Supervised"=function(X,y,X_u,y_u) {LeastSquaresClassifier(X,y,intercept=TRUE,x_center=TRUE,scale=FALSE) },
  "Self-Learning"=function(X,y,X_u,y_u) {SelfLearning(X, y, X_u, method=LeastSquaresClassifier,intercept=TRUE,x_center=TRUE,scale=FALSE)},
  "ICLS"=function(X,y,X_u,y_u) {ICLeastSquaresClassifier(X,y,X_u,intercept=TRUE,x_center=TRUE,scale=FALSE) },
  "Projection"=function(X,y,X_u,y_u) {ICLeastSquaresClassifier(X,y,X_u,intercept=TRUE,x_center=TRUE,scale=FALSE,projection="semisupervised") },
  "Oracle"=function(X,y,X_u,y_u) {LeastSquaresClassifier(rbind(X,X_u),unlist(list(y,y_u)),intercept=TRUE,x_center=TRUE,scale=FALSE) },
  "SVM"=function(X,y,X_u,y_u) { svmlin(X,y,X_u, algorithm=1,lambda=0.1,lambda_u=1,pos_frac=mean(as.numeric(y)==2)) },
  "SVMlin"=function(X,y,X_u,y_u) { svmlin(X,y,X_u, algorithm=2,lambda=0.1,lambda_u=1,pos_frac=mean(as.numeric(y)==2))}
)

datasets <- list("Simple Gaussians"=generate2ClassGaussian(d=100))
modelforms <- list("Simple Gaussians"=formula(Class~.))

measures <- list("Error"=measure_error,
                 "Average Loss Test"=measure_losstest)

lc <- LearningCurveSSL(modelforms,datasets,
                       classifiers=classifiers,
                       measures=measures,
                       n_l=200,repeats=10,verbose=TRUE,
                       pre_scale = FALSE, pre_pca = FALSE, mc.cores=1, low_level_cores=1,sizes = 2^(1:10))
save(lc, file="Data/learningcurves-timing.RData")