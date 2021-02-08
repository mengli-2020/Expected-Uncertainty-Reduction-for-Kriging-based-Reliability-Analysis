function [rel_true, rel_nonuniform, Errornonuniform]=rel(model,obj_fct )
[mean, var] = predict(model.GP,model.condidate_rel);
 for i=1: size(model.condidate_rel,1)
     Ytrue(i)=obj_fct(model.condidate_rel(i,:));   
 end
epsilon=0.05*sum(abs(Ytrue))/size(Ytrue,2);
i_index=abs(epsilon)>abs(Ytrue);
LSF_error=sum(i_index.*abs(Ytrue-mean'))/sum(i_index); 
rel_true = size(find(Ytrue<0),2)/size(Ytrue,2);
rel_nonuniform = size(find(mean'<0),2)/size(mean',2);
Errornonuniform=abs(rel_true-rel_nonuniform);