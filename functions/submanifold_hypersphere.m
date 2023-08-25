function X = submanifold_hypersphere(sample,sig,h,maxiter)

X = sample; N = size(sample,2);


for iter = 1:maxiter

    disp(iter);   

    parfor ii = 1:N

        x = X(:,ii);

        Xh = find_nbr(x,sample,h);

        Xk = find_knbr(x,sample,6);

        X0 = union(Xh',Xk','row'); X0 = X0';

        xbar = mean(X0,2);  
        
        if size(X0,2)>size(X0,1)

            xbar = xbar/norm(xbar);

            [u,~] = svds(X0 - xbar,1,'largest');

            nv = null([u,xbar]'); nv = sig*nv;

        else

            nv = x- xbar;        
        
        end
               
        f =  norm(nv)^2; alpha = 10; rho = 1.e-1; pp = 0;

        while pp<100

            xnew = x - alpha*nv;

            Xnewh = find_nbr(xnew,sample,h);

            Xnewk = find_knbr(xnew,sample,6);

            Xnew = union(Xnewh',Xnewk','row');

            Xnew = Xnew';

            xnewbar = mean(Xnew,2);

            fnew = norm(xnew - xnewbar)^2;

            if fnew < f -  rho*alpha*norm(nv)^2

                x = xnew;

                break;

            end

            pp = pp + 1; alpha = alpha/2;

        end

        X(:,ii) = x/norm(x);

    end

end