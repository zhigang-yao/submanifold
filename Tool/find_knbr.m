function [nbr,ind_nbr]=find_knbr(x,X,k)

d = pdist2(x',X'); 

[~,ind_nbr] = mink(d,k);

nbr = X(:,ind_nbr);  
end