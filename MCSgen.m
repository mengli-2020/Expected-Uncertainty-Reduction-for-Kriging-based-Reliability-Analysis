function model=MCSgen2(model,ns,method,rs)
rgindex=model.variables.rgindex;
para=model.variables.para;
nv=model.variables.dim;
type=model.variables.type;
a = zeros(1,nv); b = zeros(1,nv); p = zeros(1,nv); q = zeros(1,nv); r = zeros(1,nv);
for k = 1:nv
    if strcmp('normal.....', type(k,:))
        u(k) = para(k,1);
        s(k) = para(k,2);       
        range(k,:) = [(u(k)-rgindex*s(k))',(u(k)+rgindex*s(k))']; 
    elseif strcmp('beta.......', type(k,:))
        u(k) = para(k,1);
        s(k) = para(k,2);
        a(k) = para(k,3);
        b(k) = para(k,4);
        r(k) = b(k)-a(k);
        p(k)=(-3*u(k)*a(k)^2+3*u(k)^2*a(k)+s(k)^2*a(k)-s(k)^2*u(k)+...
            r(k)*u(k)^2+a(k)^3-u(k)^3+r(k)*a(k)^2-2*r(k)*u(k)*a(k))/s(k)^2/r(k);
        q(k)=(-r(k)+u(k)-a(k))*(u(k)^2-2*u(k)*a(k)-r(k)*u(k)+a(k)^2+r(k)*a(k)+s(k)^2)/s(k)^2/r(k);
        range(k,:) = [a(k),b(k)];
    elseif strcmp('uniform....', type(k,:))
        u(k) = para(k,1);
        s(k) = para(k,2);
        a(k) = para(k,1);  % u(k)-1/2*sqrt(12)*s(k);
        b(k) = para(k,2);  %u(k)+1/2*sqrt(12)*s(k);
        range(k,:) = [a(k),b(k)];
    elseif strcmp('triangle...', type(k,:))
        a(k) =  para(k,1);
        b(k) =  para(k,3);
        p(k) =  para(k,2);
        range(k,:) = [a(k),b(k)];
    elseif strcmp('lognormal..', type(k,:))
        u(k) = para(k,1);
        s(k) = para(k,2);
        q(k) = sqrt(log(1+(s(k)/u(k))^2));
        p(k) = log(u(k))-0.5*q(k)^2;
    elseif strcmp('exponential', type(k,:))
        u(k) = para(k,1);
        s(k) = para(k,1);
    elseif strcmp('weibull....', type(k,:))
        p(k) = para(k,1);
        q(k) = para(k,2);
        a(k) = para(k,3);
        u(k) = p(k)*gamma(1+1/q(k))+a(k);
        s(k) = sqrt(p(k)^2*(gamma(1+2/q(k))-(gamma(1+1/q(k)))^2));
        range(k,:) = [max((u(k)-rgindex*s(k))',0),(u(k)+rgindex*s(k))']; 
    else
        error('Distribution types are not defined correctly!\n');
    end
end
model.range=range;
%%%%%%%%%%%%%%%%%%%%%%%%=======MCS===========%%%%%%%%%%%%%%%%%%%%
rng(rs)
for k = 1:nv
    if strcmp('normal.....', type(k,:))
        condidate(k,:) = normrnd(u(k),s(k),1,ns);
        condidate_rel(k,:) = normrnd(u(k),s(k),1,model.variables.n_MCS);
    elseif strcmp('beta.......', type(k,:))
        condidate(k,:) = betarnd(p(k),q(k),1,ns)*r(k)+a(k);
    elseif strcmp('uniform....', type(k,:))
        condidate(k,:) = unifrnd(a(k),b(k),1,ns);
    elseif strcmp('exponential', type(k,:))
        condidate(k,:) = exprnd(u(k),1,ns);
    elseif strcmp('weibull....', type(k))
        condidate(k,:) = wblrnd(p(k),q(k),1,ns)+a(k);
    elseif strcmp('triangle...', type(k,:))
        temp = unifrnd(0,1,1,ns);
        for k1 = 1:ns
            if mod(k1,10000) == 0
                k1;
            end
            condidate(k,k1) = trirnd(a(k),p(k),b(k),temp(k1));
        end
    elseif strcmp('lognormal', type(k,:))
        condidate(k,:) = lognrnd(p(k),q(k),1,ns);
    end
end
condidate=condidate';
condidate_rel=condidate_rel';
model.random_variables=condidate;
model.condidate_rel=condidate_rel;
% save('condidate','condidate');
if strcmp('DATA', method)
% variables=0:0.01:1; 
% variables=variables';
load('condidate','condidate');
model.random_variables=variables;
end
for k = 1:nv
    norm_condidate(:,k) = (condidate(:,k) - range(k,1))/(range(k,2)-range(k,1));
end
model.norm_variables=norm_condidate;
end