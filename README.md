# Expected Uncertainty Reduction for Kriging-based Reliability Analysis

This repository is a collection of Matlab codes intended to demonstrate the deployment of the expected uncertainty reduction (EUR) method for kriging-based reliability analysis proposed by [Li, M, et al. (2021)](https://link.springer.com/article/10.1007/s00158-020-02831-w).

## Introduction

Several acquisition functions have been proposed for kriging-based reliability analysis. Each of these acquisition functions can be used to identify an optimal sequence of samples to be included in the kriging model. However, no single acquisition function provides better performance over the others in all cases. Further, the best-performing acquisition function can change at different iterations over the sequential sampling process. To address this problem, we proposed a new acquisition function, namely EUR, that serves as a meta-criterion to select the best sample from a set of optimal samples, each identified from a large number of candidate samples according to the criterion of an acquisition function. 


## Methodology
EUR does not rely on the local utility measure derived based on the kriging posterior of a performance function as most existing acquisition functions do. Instead, EUR directly quantifies the expected reduction of the uncertainty in the prediction of limit-state function by adding an optimal sample. The uncertainty reduction is quantified by sampling over the kriging posterior. In the proposed EUR-based sequential sampling process, a portfolio that consists of four acquisition functions, i.e., [expected feasibility function (EFF)](https://arc.aiaa.org/doi/abs/10.2514/1.34321?casa_token=CVjYsfQLUXUAAAAA%3A0gYRIvTaXqe34NZG-_jvC8Cs8KXuqPFIZMP96fhmN0MYc3ENjL6YTxNWxMt_5n9hxjAKxiisNQ&), [maximum confidence enhancement (MCE)](https://asmedigitalcollection.asme.org/mechanicaldesign/article/136/2/021006/474056?casa_token=VejqCRHW1NsAAAAA:nAIYsmh9bph7uSrlFqKZ9nh8MdkJAnUlMcni_hQ8qDouIsav_m6x92D9sJJQw3b-RekzJx1D), [expected risk function (ERF)](https://www.sciencedirect.com/science/article/pii/S0307904X14006738), and [sequential exploration-exploitation with dynamic trade-off (SEEDT)](https://link.springer.com/article/10.1007/s00158-017-1748-7), is first employed to suggest four optimal samples at each iteration of sequential sampling. Each of these samples is optimal with respect to the selection criterion of the corresponding acquisition function. Then, EUR is employed as the meta-criterion to identify the best sample among those optimal samples.


## Case Study 1: A 2D Example with High Nonlinearity

The first case study has a highly nonlinear performance function, which consists of a polynomial part, a trigonometric part, and a constant. The performance function is defined as:

   <a href="https://www.codecogs.com/eqnedit.php?latex=G(x)=\frac{(x_{1}^{2}&plus;4)(x_{2}-1)}{20}-cos(\frac{ax_{1}}{2})-1.5" target="_blank"><img src="https://latex.codecogs.com/gif.latex?G(x)=\frac{(x_{1}^{2}&plus;4)(x_{2}-1)}{20}-cos(\frac{ax_{1}}{2})-1.5" title="G(x)=\frac{(x_{1}^{2}+4)(x_{2}-1)}{20}-cos(\frac{ax_{1}}{2})-1.5" /></a>

where the coefficient <a href="https://www.codecogs.com/eqnedit.php?latex=a" target="_blank"><img src="https://latex.codecogs.com/gif.latex?a" title="a" /></a> is used to adjust the nonlinearity of <a href="https://www.codecogs.com/eqnedit.php?latex=G(x)" target="_blank"><img src="https://latex.codecogs.com/gif.latex?G(x)" title="G(x)" /></a>. The two input random variables <a href="https://www.codecogs.com/eqnedit.php?latex=x_{1}" target="_blank"><img src="https://latex.codecogs.com/gif.latex?x_{1}" title="x_{1}" /></a> and <a href="https://www.codecogs.com/eqnedit.php?latex=x_{2}" target="_blank"><img src="https://latex.codecogs.com/gif.latex?x_{2}" title="x_{2}" /></a> are considered to be independent from each other, both of which follow the normal distribution (<a href="https://www.codecogs.com/eqnedit.php?latex=\mu&space;=1.5,&space;\sigma&space;=1.0" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\mu&space;=1.5,&space;\sigma&space;=1.0" title="\mu =1.5, \sigma =1.0" /></a>).

The main function to implement this case study is 'main_Example1.m', while the coefficient a can be set for the performance function in 'bmfun2D.m'.

```matlab
function response= bmfun2D(x)
a=7; %Set parameter a here
response=((x(1).^2+4).*(x(2)-1))/20-cos(a*x(1)/2)-1.5;
```


After implementing the main function, the reliability estimation results can be generated with the 'rel' function.

```matlab
% %% Results
[rel_true rel_EUR ErrorEUR]=rel(modelEUR,obj_fct );
[rel_true rel_MEU ErrorMEU]=rel(modelMEU,obj_fct );
[rel_true rel_MCE ErrorMCE]=rel(modelMCE,obj_fct );
[rel_true rel_EFF ErrorEFF]=rel(modelEFF,obj_fct );
[rel_true rel_ERF ErrorERF]=rel(modelERF,obj_fct );
```


## Case Study 2: An 7D Example with Strong Variate Interactions

The second case study considers a two-degree-of-freedom primary-secondary system with uncertain damped oscillators in the presence of white noise. The performance function of this system is mathematically expressed as:

   <a href="https://www.codecogs.com/eqnedit.php?latex=G(x)=3k_{s}(\frac{\pi&space;S_{0}&space;}{4\xi&space;_{s}\omega&space;_{s}^{3}}[\frac{\xi&space;_{a}\xi&space;_{s}}{\xi&space;_{p}\xi&space;_{s}(4\xi&space;_{a}^2&plus;&space;\theta&space;^{2})&plus;\gamma\xi&space;_{a}^2&space;}&space;\frac{&space;(\xi&space;_{p}\omega&space;_{p}^{3}&plus;\xi&space;_{s}\omega&space;_{s}^{3}&space;)\omega&space;_{p}&space;}{4\xi&space;_{a}\omega&space;_{a}^{4}}&space;]])^{1/2}-F_{s}" target="_blank"><img src="https://latex.codecogs.com/gif.latex?G(x)=3k_{s}(\frac{\pi&space;S_{0}&space;}{4\xi&space;_{s}\omega&space;_{s}^{3}}[\frac{\xi&space;_{a}\xi&space;_{s}}{\xi&space;_{p}\xi&space;_{s}(4\xi&space;_{a}^2&plus;&space;\theta&space;^{2})&plus;\gamma\xi&space;_{a}^2&space;}&space;\frac{&space;(\xi&space;_{p}\omega&space;_{p}^{3}&plus;\xi&space;_{s}\omega&space;_{s}^{3}&space;)\omega&space;_{p}&space;}{4\xi&space;_{a}\omega&space;_{a}^{4}}&space;]])^{1/2}-F_{s}" title="G(x)=3k_{s}(\frac{\pi S_{0} }{4\xi _{s}\omega _{s}^{3}}[\frac{\xi _{a}\xi _{s}}{\xi _{p}\xi _{s}(4\xi _{a}^2+ \theta ^{2})+\gamma\xi _{a}^2 } \frac{ (\xi _{p}\omega _{p}^{3}+\xi _{s}\omega _{s}^{3} )\omega _{p} }{4\xi _{a}\omega _{a}^{4}} ]])^{1/2}-F_{s}" /></a>

where

 <a href="https://www.codecogs.com/eqnedit.php?latex=\omega&space;_{p}=\sqrt{k_{p}/m_{p}},&space;\omega&space;_{s}=\sqrt{k_{s}/m_{s}},&space;\omega&space;_{a}=(\omega&space;_{p}&plus;\omega&space;_{s})/2,&space;\xi&space;_{a}=(\xi&space;_{p}&plus;\xi&space;_{s})/2,&space;\gamma&space;=m_{s}/m_{p},&space;\theta&space;=&space;(\omega&space;_{p}-\omega&space;_{s})/\omega&space;_{a},&space;\mathbf{x}=[\omega&space;_{s},\omega&space;_{s},\omega&space;_{s},&space;\xi&space;_{s},&space;\gamma&space;,&space;\theta&space;]." target="_blank"><img src="https://latex.codecogs.com/gif.latex?\omega&space;_{p}=\sqrt{k_{p}/m_{p}},&space;\omega&space;_{s}=\sqrt{k_{s}/m_{s}},&space;\omega&space;_{a}=(\omega&space;_{p}&plus;\omega&space;_{s})/2,&space;\xi&space;_{a}=(\xi&space;_{p}&plus;\xi&space;_{s})/2,&space;\gamma&space;=m_{s}/m_{p},&space;\theta&space;=&space;(\omega&space;_{p}-\omega&space;_{s})/\omega&space;_{a},&space;\mathbf{x}=[\omega&space;_{s},\omega&space;_{s},\omega&space;_{s},&space;\xi&space;_{s},&space;\gamma&space;,&space;\theta&space;]." title="\omega _{p}=\sqrt{k_{p}/m_{p}}, \omega _{s}=\sqrt{k_{s}/m_{s}}, \omega _{a}=(\omega _{p}+\omega _{s})/2, \xi _{a}=(\xi _{p}+\xi _{s})/2, \gamma =m_{s}/m_{p}, \theta = (\omega _{p}-\omega _{s})/\omega _{a}, \mathbf{x}=[\omega _{s},\omega _{s},\omega _{s}, \xi _{s}, \gamma , \theta ]." /></a>. 
 
 
 The reliability level of the system varies depending on the load <a href="https://www.codecogs.com/eqnedit.php?latex=F_{s}" target="_blank"><img src="https://latex.codecogs.com/gif.latex?F_{s}" title="F_{s}" /></a>. The statistical information of the random vaiables in this case study can be found in Table 4 of [Li, M, et al. (2021)](https://link.springer.com/article/10.1007/s00158-020-02831-w).

The main function to implement this case study is 'main_Example2.m', while <a href="https://www.codecogs.com/eqnedit.php?latex=F_{s}" target="_blank"><img src="https://latex.codecogs.com/gif.latex?F_{s}" title="F_{s}" /></a> can be set for the performance function in the main function.

```matlab
%% Design variables definition
ns = 100000; % number of candidate points
n_MCS = 1000000; % number of MCS points for reliability analysis
model.variables.ns=ns;
model.variables.n_MCS=n_MCS;
Fs=15; % Set Fs here.
```

After implementing the main function, the reliability estimation results can be generated with the 'rel' function.

```matlab
% %% Results
[rel_true rel_EUR ErrorEUR]=rel(modelEUR,obj_fct );
[rel_true rel_MEU ErrorMEU]=rel(modelMEU,obj_fct );
[rel_true rel_MCE ErrorMCE]=rel(modelMCE,obj_fct );
[rel_true rel_EFF ErrorEFF]=rel(modelEFF,obj_fct );
[rel_true rel_ERF ErrorERF]=rel(modelERF,obj_fct );
```

## Contributions

Contributions are welcome!  For bug reports or requests please [submit an issue](https://github.com/lmhit2019/Expected-Uncertainty-Reduction-for-Kriging-based-Reliability-Analysis/issues).

## Contact  

Feel free to contact me to discuss any issues, questions or comments.

* GitHub: [limhit2019](https://github.com/lmhit2019)
* Contact: Meng Li, Chao Hu
* Email: [lm881020@gmail.com], [chaohu@iastate.edu]

### BibTex reference format for citation for the Code
```
@misc{limhit2019,
title={Mixture Density Networks (MDN) for distribution and uncertainty estimation},
url={https://github.com/lmhit2019/Expected-Uncertainty-Reduction-for-Kriging-based-Reliability-Analysis/},
note={Matlab codes intended to demonstrate the deployment of the expected uncertainty reduction (EUR) method for kriging-based reliability analysis.},
author={Meng Li},
  year={2021}
}
```

## License

The content developed by Meng Li is distributed under the following license:

    Copyright 2021 Meng Li

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.

