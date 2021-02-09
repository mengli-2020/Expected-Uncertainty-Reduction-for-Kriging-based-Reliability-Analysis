function [rel_true, ErrorEUR,ErrorMEU,ErrorMCE,ErrorEFF,ErrorERF] = main_Example2()
addpath('../src');
rs=randi(50);
%% Design variables definition
ns = 100000; % number of candidate points
n_MCS = 1000000; % number of MCS points for reliability analysis
model.variables.ns=ns;
model.variables.n_MCS=n_MCS;
Fs=15; % Set Fs here.
p1 = [-0.0196 -4.624  0.4002 -4.6102 -3.07 -4.0239 log(Fs)]; %the mean value for input variables
p2 = [0.1979 0.1980 0.0997 0.0998 0.3850 0.4723 0.0998]; % the std of input variables.
p3 = [0 0 0 0 0 0 0 ];       % parameter "a" which uses in some distributions
p4 = [0 0 0 0 0 0 0 ];       % parameter "b" wich uses in some distributions
model.variables.dim=size(p1,2);  % dimension number
model.variables.rgindex = 3;        % range of values = mean-+rgindex*std
model.variables.para = [p1' p2' p3' p4'];
model.variables.type = ['normal.....';'normal.....';'normal.....';'normal.....';'normal.....';'normal.....';'normal.....';'normal.....';'normal.....';'normal.....';'normal.....';'normal.....';'normal.....';'normal.....';'normal.....';'normal.....';'normal.....';'normal.....';'normal.....';'normal.....';'normal.....';'normal.....';'normal.....';'normal.....';'normal.....';'normal.....';'normal.....';'normal.....';'normal.....';'normal.....';'normal.....';'normal.....';'normal.....';'normal.....';'normal.....';'normal.....';'normal.....';'normal.....';'normal.....']; % distribution types: normal; beta ; uniform; exponential; gamma; weibull; lognormal; triangle
model=MCSgen(model, ns,'MCS',rs);
%%  MLE Kriging model
obj_fct = @(x)bmfundamped(x);     % Initialize the objective function.
model.total_iter = 70;
model.noise=1e-10;
model.n_init=35; % Number of initial sample points
[model.init_value,model.init_x]=LHS(obj_fct,model,'LHS',rs);
model.GP = fitrgp(model.init_x,model.init_value,'BasisFunction','none',...
      'FitMethod','exact','PredictMethod','exact','Sigma',1e-10, 'ConstantSigma',true);
modelEUR=model;
modelMEU=model;
modelMCE=model;
modelEFF=model;
modelERF=model;

%The SEEDT method
for i = 1:model.total_iter-model.n_init
    [x_star, modelMEU] = acq_opt(modelMEU,'MEU',obj_fct);
    f_star = obj_fct(x_star);
    modelMEU.init_value=[modelMEU.init_value;f_star];
    modelMEU.init_x=[modelMEU.init_x;x_star];
    modelMEU.GP = fitrgp(modelMEU.init_x,modelMEU.init_value,'BasisFunction','none',...
                    'FitMethod','exact','PredictMethod','exact','Sigma',1e-10, 'ConstantSigma',true);
end

% the MCE method
for i = 1:model.total_iter-model.n_init
    [x_star, modelMCE] = acq_opt(modelMCE,'MCE',obj_fct);
    f_star = obj_fct(x_star);
    modelMCE.init_value=[modelMCE.init_value;f_star];
    modelMCE.init_x=[modelMCE.init_x;x_star];
    modelMCE.GP = fitrgp(modelMCE.init_x,modelMCE.init_value,'BasisFunction','none',...
                    'FitMethod','exact','PredictMethod','exact','Sigma',1e-10, 'ConstantSigma',true);
end

%The EFF method
for i = 1:model.total_iter-model.n_init
    [x_star, modelEFF] = acq_opt(modelEFF,'EFF',obj_fct);
    f_star = obj_fct(x_star);
    modelEFF.init_value=[modelEFF.init_value;f_star];
    modelEFF.init_x=[modelEFF.init_x;x_star];
    modelEFF.GP = fitrgp(modelEFF.init_x,modelEFF.init_value,'BasisFunction','none',...
                    'FitMethod','exact','PredictMethod','exact','Sigma',1e-10, 'ConstantSigma',true);  
end

%The ERF method
for i = 1:model.total_iter-model.n_init
    [x_star, modelERF] = acq_opt(modelERF,'ERF',obj_fct);
    f_star = obj_fct(x_star);
    modelERF.init_value=[modelERF.init_value;f_star];
    modelERF.init_x=[modelERF.init_x;x_star];
    modelERF.GP = fitrgp(modelERF.init_x,modelERF.init_value,'BasisFunction','none',...
                    'FitMethod','exact','PredictMethod','exact','Sigma',1e-10, 'ConstantSigma',true);
end

% the EUR method:
for i = 1:model.total_iter-model.n_init
    [x_star, modelEUR] = acq_opt(modelEUR,'EUR',obj_fct);
    f_star = obj_fct(x_star);
    modelEUR.init_value=[modelEUR.init_value;f_star];
    modelEUR.init_x=[modelEUR.init_x;x_star];
    modelEUR.GP = fitrgp(modelEUR.init_x,modelEUR.init_value,'BasisFunction','none',...
                    'FitMethod','exact','PredictMethod','exact','Sigma',1e-10, 'ConstantSigma',true);
    i
end

% %% Results
[rel_true rel_EUR ErrorEUR]=rel(modelEUR,obj_fct );
[rel_true rel_MEU ErrorMEU]=rel(modelMEU,obj_fct );
[rel_true rel_MCE ErrorMCE]=rel(modelMCE,obj_fct );
[rel_true rel_EFF ErrorEFF]=rel(modelEFF,obj_fct );
[rel_true rel_ERF ErrorERF]=rel(modelERF,obj_fct );
end




