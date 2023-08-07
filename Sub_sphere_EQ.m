function Y = Sub_sphere_EQ(sample,h,maxiter)
Y = sample; N = size(sample,2);
for iter = 1:maxiter
    sample = Y;
    for ii = 1:N
        Xii = find_nbr(sample(:,ii),sample,h);
        x0 = mean(Xii,2); [u,~] = svds(Xii - x0,1,'largest');
        y = sample(:,ii) - x0; t = u'*y/(norm(u)^2);
        z = x0 + t*u;
        Y(:,ii) = z/norm(z);
    end
end