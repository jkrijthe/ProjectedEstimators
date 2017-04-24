# Projected Estimators for Robust Semi-supervised Classification

## Reference
This repository contains the code and Latex files to produce the paper:
Krijthe, J. H., & Loog, M. (2017). Projected Estimators for Robust Semi-supervised Classification. Machine Learning. https://doi.org/10.1007/s10994-017-5626-8

## Abstract
For semi-supervised techniques to be applied safely in practice we at least want methods to outperform their supervised counterparts. We study this question for classification using the well-known quadratic surrogate loss function. Unlike other approaches to semi-supervised learning, the procedure proposed in this work does not rely on assumptions that are not intrinsic to the classifier at hand. Using a projection of the supervised estimate onto a set of constraints imposed by the unlabeled data, we find we can safely improve over the supervised solution in terms of this quadratic loss. More specifically, we prove that, measured on the labeled and unlabeled training data, this semi-supervised procedure never gives a lower quadratic loss than the supervised alternative. To our knowledge this is the first approach that offers such strong, albeit conservative, guarantees for improvement over the supervised solution. The characteristics of our approach are explicated using benchmark datasets to further understand the similarities and differences between the quadratic loss criterion used in the theoretical results and the classification accuracy typically considered in practice.

## Repository
Generating the paper requires R, knitr and a number of packages that you can find in the corresponding code files. The two main dependencies are the [RSSL](https://www.github.com/jkrijthe/RSSL) package, which contains the implementations of the methods considered in the paper and the [createdatasets](https://www.github.com/jkrijthe/createdatasets) package to load the data for the experiments.
