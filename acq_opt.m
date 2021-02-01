function [x_max, model] = acq_opt(model, method,obj_fct)
candidate=model.random_variables;
if strcmp('MEU', method)
    [acqMEU model]=acq_function(model, candidate, 'MEU');
    [acq_maxMEU, i_maxMEU]=max(acqMEU);
    x_max=candidate(i_maxMEU,:);
elseif strcmp('MCE', method)
    [acqMCE model]=acq_function(model, candidate, 'MCE');
    [acq_maxMCE, i_maxMCE]=max(acqMCE);
    x_max=candidate(i_maxMCE,:);
elseif strcmp('EFF', method)
    [acqEFF model]=acq_function(model, candidate, 'EFF');
    [acq_maxEFF, i_maxEFF]=max(acqEFF);
    x_max=candidate(i_maxEFF,:);
elseif strcmp('ERF', method)
    [acqERF model]=acq_function(model, candidate, 'ERF');
    [acq_maxERF, i_maxERF]=max(acqERF);
    x_max=candidate(i_maxERF,:);
elseif strcmp('EUR', method)
    % MEU
    [acqMEU model]=acq_function(model, candidate, 'MEU');
    [acq_maxMEU, i_maxMEU]=max(acqMEU);
    x_starMEU=candidate(i_maxMEU,:);
    % MCE
    [acqMCE model]=acq_function(model, candidate, 'MCE');
    [acq_maxMCE, i_maxMCE]=max(acqMCE);
    x_starMCE=candidate(i_maxMCE,:);
    % EFF
    [acqEFF model]=acq_function(model, candidate, 'EFF');
    [acq_maxEFF, i_maxEFF]=max(acqEFF);
    x_starEFF=candidate(i_maxEFF,:);
    % ERF
    [acqERF model]=acq_function(model, candidate, 'ERF');
    [acq_maxERF, i_maxERF]=max(acqERF);
    x_starERF=candidate(i_maxERF,:);
    x_cand=[x_starMEU;x_starMCE;x_starEFF;x_starERF];
    %Ita in the previous iteration
    [meanvalue0, stdvalue0] =predict(model.GP,candidate);
    uppervalue=meanvalue0+3*stdvalue0;
    lowervalue=meanvalue0-3*stdvalue0;
    ita0=size(find(lowervalue.*uppervalue<=0),1)/size(meanvalue0,1);
    %nh: number of simulated samples to be the 100 percentiles of the kriging
    %posterior
    nh=100;
    PDF=zeros(4,nh);
    Hall=zeros(4,nh);
    weights=zeros(4,nh);
    for i=1:4
        [YK(i), STDYK(i)] = predict(model.GP,x_cand(i,:));
        [x,w]=GaussHermite(nh);
        Hall(i,:)=(sqrt(2)*STDYK(i)*x+YK(i))';
        weights(i,:)=(w/sqrt(pi))';
        for j=1:size(Hall(i,:),2)
            y_star=Hall(i,:);
            Hmodel{j}=model;
            Hmodel{j}.init_value=[Hmodel{j}.init_value;y_star(j)];
            Hmodel{j}.init_x=[Hmodel{j}.init_x;x_cand(i,:)];
            Hmodel{j}.GP = fitrgp(Hmodel{j}.init_x,Hmodel{j}.init_value,'BasisFunction','none',...
                    'FitMethod','exact','PredictMethod','exact','Sigma',1e-10, 'ConstantSigma',true);
            [meanvalue, stdvalue] = predict(Hmodel{j}.GP , candidate);
            uppervalue=meanvalue+3*stdvalue;
            lowervalue=meanvalue-3*stdvalue;
            itaM(j)=size(find(lowervalue.*uppervalue<=0),1)/size(meanvalue,1);
        end
        PDF(i,:)=itaM.*weights(i,:);
    end
    Acq=ita0-sum(PDF,2);
    [M,I]=max(Acq);
    model.M_ind(size(model.init_value,1))=I;
    x_max=x_cand(I,:);
end
