# Expected Uncertainty Reduction for Kriging-based Reliability Analysis

This repository is a collection of Matlab codes intended to demonstrate the deployment of the expected uncertainty reduction (EUR) method for kriging-based reliability analysis proposed by [Li, M, et al. (2021)](https://link.springer.com/article/10.1007/s00158-020-02831-w).

## Introduction

Several acquisition functions have been proposed for kriging-based reliability analysis. Each of these acquisition functions can be used to identify an optimal sequence of samples to be included in the kriging model. However, no single acquisition function provides better performance over the others in all cases. Further, the best-performing acquisition function can change at different iterations over the sequential sampling process. To address this problem, we proposed a new acquisition function, namely EUR, that serves as a meta-criterion to select the best sample from a set of optimal samples, each identified from a large number of candidate samples according to the criterion of an acquisition function. EUR does not rely on the local utility measure derived based on the kriging posterior of a performance function as most existing acquisition functions do. Instead, EUR directly quantifies the expected reduction of the uncertainty in the prediction of limit-state function by adding an optimal sample. The uncertainty reduction is quantified by sampling over the kriging posterior. In the proposed EUR-based sequential sampling process, a portfolio that consists of four acquisition functions is first employed to suggest four optimal samples at each iteration of sequential sampling. Each of these samples is optimal with respect to the selection criterion of the corresponding acquisition function. Then, EUR is employed as the meta-criterion to identify the best sample among those optimal samples.



<p align="center"><img src="https://cdn.rawgit.com/axelbrando/Mixture-Density-Networks-for-distribution-and-uncertainty-estimation/cd4d8e9c/svgs/f442dfcf42c5ca5d6c9b96753cde8768.svg" align=middle width=645.87435pt height=348.58725pt/>
</p>
<p align="center">
<em>Representation of the Mixture Density Network model. The output of the feed-forward neural network determine the parameters in a mixture density model. Therefore, the mixture density model represents the conditional probability density function of the target variables conditioned on the input vector of the neural network.</em>
</p>

## Implemented tricks and techniques

> - Log-sum-exp trick.
> - ELU+1 representation function for variance scale parameter proposed by us in the Master's Thesis that I will link when it is published.
> - Clipping of the mixing coefficient parameter value.
> - Mean log Gaussian likelihood proposed by [Bishop](http://eprints.aston.ac.uk/373/).
> - Mean log Laplace likelihood proposed by us in the Master's Thesis that I will link when it is published.
> - Fast Gradient Sign Method to produce Adversarial Training proposed [by Goodfellow et al](https://arxiv.org/abs/1412.6572).
> - Modified version of Adversarial Training proposed by [Nokland](https://arxiv.org/abs/1510.04189).
> - Simple and Scalable Predictive Uncertainty Estimation using Deep Ensembles implementation proposed by [Lakshminarayanan et a](https://arxiv.org/abs/1612.01474).

## Some Keras algorithms used

> - RMSProp optimisation algorithm.
> - Adam optimisation algorithm.
> - Gradient Clipping
> - Batch normalisation

## Implemented visualisation functionalities

> - Generic implementation to visualise mean and variance (as errorbar) of the distribution with maximum mixing coefficient  of of the MDN.
> - Generic implementation to visualise mean and variance (as errorbar) of all the distributions of of the MDN.
> - Generic implementation to visualise all the probability density function as a *heat graphic* for 2D problems.
> - Generic implementation to visualise the original 3D surface and visualise the mean of the distribution of the mixture through a sampling process.
> - Adversarial data set visualisation proposed by us in the Master's Thesis that I will link when it is published.



## Notebooks
(Currently tested on Keras (1.1.0) and TensorFlow (0.11.0rc2)

#### [Introduction to MDN models and generic implementation of MDN](https://github.com/axelbrando/Mixture-Density-Networks-for-distribution-and-uncertainty-estimation/blob/master/MDN-Introduction.ipynb)

#### [MDN applied to a 2D regression problem](https://github.com/axelbrando/Mixture-Density-Networks-for-distribution-and-uncertainty-estimation/blob/master/MDN-2D-Regression.ipynb)

#### [MDN applied to a 3D regression problem](https://github.com/axelbrando/Mixture-Density-Networks-for-distribution-and-uncertainty-estimation/blob/master/MDN-3D-Regression.ipynb)

#### [MDN with LSTM neural network for a time series regression problem](https://github.com/axelbrando/Mixture-Density-Networks-for-distribution-and-uncertainty-estimation/blob/master/MDN-LSTM-Regression.ipynb) 

#### [MDN with completely dense neural network for a time series regression problem by using Adversarial Training](https://github.com/axelbrando/Mixture-Density-Networks-for-distribution-and-uncertainty-estimation/blob/master/MDN-DNN-Regression.ipynb) 

#### [Ensemble of MDNs with completely dense neural network for a simple regression problem for Predictive Uncertainty Estimation](https://github.com/axelbrando/Mixture-Density-Networks-for-distribution-and-uncertainty-estimation/blob/master/MDN-DNN-Simple-Ensemble-Uncertainty.ipynb) 

#### [Ensemble of MDNs with completely dense neural network for a complex regression problem for Predictive Uncertainty Estimation and Adversarial Data set test](https://github.com/axelbrando/Mixture-Density-Networks-for-distribution-and-uncertainty-estimation/blob/master/MDN-DNN-Complex-Ensemble-Uncertainty.ipynb) 




## Contributions

Contributions are welcome!  For bug reports or requests please [submit an issue](https://github.com/axelbrando/Mixture-Density-Networks-for-distribution-and-uncertainty-estimation/issues).

## Contact  

Feel free to contact me to discuss any issues, questions or comments.

* GitHub: [axelbrando](https://github.com/axelbrando)
* Website: [axelbrando.github.io](http://axelbrando.github.io)

### BibTex reference format for citation for the Code
```
@misc{MDNABrando,
title={Mixture Density Networks (MDN) for distribution and uncertainty estimation},
url={https://github.com/axelbrando/Mixture-Density-Networks-for-distribution-and-uncertainty-estimation/},
note={GitHub repository with a collection of Jupyter notebooks intended to solve a lot of problems related to MDN.},
author={Axel Brando},
  year={2017}
}
```
### BibTex reference format for citation for the report of the Master's Thesis

```
@misc{MDNABrandoMasterThesis,
title={Mixture Density Networks (MDN) for distribution and uncertainty estimation},
url={https://github.com/axelbrando/Mixture-Density-Networks-for-distribution-and-uncertainty-estimation/blob/master/ABrando-MDN-MasterThesis.pdf},
note={Report of the Master's Thesis: Mixture Density Networks for distribution and uncertainty estimation.},
author={Axel Brando},
  year={2017}
}
```

## License

The content developed by Axel Brando is distributed under the following license:

    Copyright 2016 Axel Brando

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.

