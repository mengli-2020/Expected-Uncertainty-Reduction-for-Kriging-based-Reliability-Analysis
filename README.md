# Expected Uncertainty Reduction for Kriging-based Reliability Analysis

This repository is a collection of Matlab codes intended to demonstrate the deployment of the expected uncertainty reduction (EUR) method for kriging-based reliability analysis proposed by [Li, M, et al. (2021)](https://link.springer.com/article/10.1007/s00158-020-02831-w).

## Introduction

Several acquisition functions have been proposed for kriging-based reliability analysis. Each of these acquisition functions can be used to identify an optimal sequence of samples to be included in the kriging model. However, no single acquisition function provides better performance over the others in all cases. Further, the best-performing acquisition function can change at different iterations over the sequential sampling process. To address this problem, we proposed a new acquisition function, namely EUR, that serves as a meta-criterion to select the best sample from a set of optimal samples, each identified from a large number of candidate samples according to the criterion of an acquisition function. 


## Methodology
EUR does not rely on the local utility measure derived based on the kriging posterior of a performance function as most existing acquisition functions do. Instead, EUR directly quantifies the expected reduction of the uncertainty in the prediction of limit-state function by adding an optimal sample. The uncertainty reduction is quantified by sampling over the kriging posterior. In the proposed EUR-based sequential sampling process, a portfolio that consists of four acquisition functions, i.e., [expected feasibility function (EFF)](https://arc.aiaa.org/doi/abs/10.2514/1.34321?casa_token=CVjYsfQLUXUAAAAA%3A0gYRIvTaXqe34NZG-_jvC8Cs8KXuqPFIZMP96fhmN0MYc3ENjL6YTxNWxMt_5n9hxjAKxiisNQ&), [maximum confidence enhancement (MCE)](https://asmedigitalcollection.asme.org/mechanicaldesign/article/136/2/021006/474056?casa_token=VejqCRHW1NsAAAAA:nAIYsmh9bph7uSrlFqKZ9nh8MdkJAnUlMcni_hQ8qDouIsav_m6x92D9sJJQw3b-RekzJx1D), [expected risk function (ERF)](https://www.sciencedirect.com/science/article/pii/S0307904X14006738), and [sequential exploration-exploitation with dynamic trade-off (SEEDT)](https://link.springer.com/article/10.1007/s00158-017-1748-7), is first employed to suggest four optimal samples at each iteration of sequential sampling. Each of these samples is optimal with respect to the selection criterion of the corresponding acquisition function. Then, EUR is employed as the meta-criterion to identify the best sample among those optimal samples.


## Case Study 1: A 2D Example with High Nonlinearity

The first case study has a highly nonlinear performance function, which consists of a polynomial part, a trigonometric part, and a constant. The performance function is defined as 

where the coefficient a is used to adjust the nonlinearity of G(x). The two input random variables x_1 and x_2 are considered to be independent from each other, both of which follow the normal distribution (μ = 1.5, σ = 1).

The main function to implement this case study is 'main_Example1.m', while the coefficient a can be set for the performance function in 'bmfun2D.m' (line 2).

  line 1: function response= bmfun2D(x)
  line 2: a=7;
  line 3: response=((x(1).^2+4).*(x(2)-1))/20-cos(a*x(1)/2)-1.5;


After implementing the main function, the reliability estimation results can be found from lines 78 to 82.


## Case Study 2: An 7D Example with Strong Variate Interactions

The second case study considers a two-degree-of-freedom primary-secondary system with uncertain damped oscillators in the presence of white noise. The performance function of this system is mathematically expressed as

where ω_p=√(k_p/m_p ), ω_s=√(k_s/m_s ), ω_a=〖(ω〗_p+ω_s)/2 , ξ_a=〖(ξ〗_p+ξ_s)/2 , γ=m_s/m_p and θ=〖(ω〗_p-ω_s)/ω_a, x = [ω_p,ω_s,ω_a,ξ_a,γ,θ]. The reliability level of the system varies depending on the load Fs. The statistical information of the random vaiables in this case study can be found in Table 4 of [Li, M, et al. (2021)](https://link.springer.com/article/10.1007/s00158-020-02831-w).

The main function to implement this case study is 'main_Examle2.m', while Fs can be set for the performance function in line 8 of the main function.

After implementing the main function, the reliability estimation results can be found from lines 84 to 88.



## Contributions

Contributions are welcome!  For bug reports or requests please [submit an issue](https://github.com/lmhit2019/Expected-Uncertainty-Reduction-for-Kriging-based-Reliability-Analysis/issues).

## Contact  

Feel free to contact me to discuss any issues, questions or comments.

* GitHub: [limhit2019](https://github.com/lmhit2019)
* Email: [lm881020@gmail.com]

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

