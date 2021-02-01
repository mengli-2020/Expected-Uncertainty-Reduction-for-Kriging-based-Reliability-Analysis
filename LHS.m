
function [init_f,init_pt ]=LHS(obj_fct,model,method,rs)
n_init=model.n_init;
dim=model.variables.dim;
rgindex=model.variables.rgindex;
para=model.variables.para';
range=model.range';
if strcmp('LHS', method)
    rand(rs);
    init_pt=lhsdesign(n_init,dim);
    
    
    for i=1:dim
        init_pt(:,i)=range(1,i)+(range(2,i)-range(1,i))*init_pt(:,i);
    end
    for i=1:n_init
        init_f(i) = obj_fct(init_pt(i,:)); 
    end
    init_f=init_f';
    save('init_pt','init_pt');
elseif strcmp('DATA', method)
    load('init_pt','init_pt');
    for i=1:size(init_pt,1)
        init_f(i) = obj_fct(init_pt(i,:)); 
    end  
    init_f=init_f';
end
