function [nbr,ind_nbr]=find_nbr(x,X,delta)

ns = 1:size(X,2); d = pdist2(x',X');

nbr = X(:,d<delta+eps);  ind_nbr = ns(d<delta+eps);
end