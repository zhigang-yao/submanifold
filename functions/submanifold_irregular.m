function X = submanifold_irregular(sample,sig,h,maxiter)

X = sample; Y = sample; N = size(sample,2);



for iter = 1:maxiter

    parfor ii = 1:N

        x = X(:,ii);

        X0 = find_nbr(x,sample,h);

        xbar = mean(X0,2); xbar = xbar/norm(xbar);

        [u,~] = svds(X0 - xbar,1,'largest');  nv = null([u,xbar]'); nv = sig*nv;

        fs = zeros(21,1); deltas = -1:0.05:1;

        for i_delta = 1:length(deltas)

            delta =  deltas(i_delta);

            xnew = xbar + delta*nv;

            xnew = xnew/norm(xnew);

            XNnew  = find_nbr(xnew,sample,h);

            xnewbar = mean(XNnew,2);

            xnewbar = xnewbar/norm(xnewbar);

            fs(i_delta) = norm(xnew - xnewbar)^2;

        end

        [~,id] = min(fs); xnew = xbar + deltas(id)*nv;

        t = u'*(x - xnew)/(norm(u)^2);

        xnew = xnew + t*u;

        Y(:,ii) = xnew/norm(xnew);

    end

    X = Y; sample = X;

end


