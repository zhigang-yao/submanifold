function dists = APError(X,Y)
n = size(X,2);
dists = zeros(n,1);
parfor ii = 1:n
    dists(ii) = min(pdist2(X(:,ii)',Y'));
end
