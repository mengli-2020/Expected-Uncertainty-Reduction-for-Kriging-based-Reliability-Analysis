function [acq, model] = acq_function(model, x, type)

[meanvalue, stdvalue] = predict(model.GP,x);
sigma = sqrt(stdvalue);
pdg = makedist('Normal','mu',0,'sigma',1);
mu=model.variables.para(:,1)';
A=eye(model.variables.dim);
for i=1:model.variables.dim
    SIGMA(i,:)=A(i,:)*model.variables.para(i,2);
end
pdfx=mvnpdf(x,mu,SIGMA);
if strcmp('MCE', type)
    CIM=cdf(pdg,abs(meanvalue)./(sqrt(stdvalue)));
    acq=((1-CIM)).*(pdfx.^1).*(stdvalue.^0.5);
elseif strcmp('MEU', type)
    uppervalue=meanvalue+3*stdvalue;
    lowervalue=meanvalue-3*stdvalue;
    accuracy=size(find(lowervalue.*uppervalue<=0),1)/size(meanvalue,1);
    alpha=exp(accuracy);
    acq=(stdvalue).*pdfx./sqrt(1+alpha^2).*exp(-(meanvalue.^2)./(sqrt(1+alpha^2)*stdvalue));
elseif strcmp('ERF', type)
    acq=-sign(meanvalue).*meanvalue.*normcdf(-sign(meanvalue).*meanvalue./stdvalue)+stdvalue.*normpdf(meanvalue./stdvalue);
elseif strcmp('EFF', type)
    %epsilon in EFF is 2sigmaG
    stdp=2*stdvalue;
    EFF_part1=meanvalue.*(2*normcdf((-meanvalue)./stdvalue)-normcdf((-stdp-meanvalue)./stdvalue)-normcdf((stdp-meanvalue)./stdvalue));
    EFF_part2=stdvalue.*(2*normpdf((-meanvalue)./stdvalue)-normpdf((-stdp-meanvalue)./stdvalue)-normpdf((stdp-meanvalue)./stdvalue));
    EFF_part3=(normcdf((stdp-meanvalue)./stdvalue)-normcdf((-stdp-meanvalue)./stdvalue));
    acq=EFF_part1+EFF_part2+EFF_part3;
end