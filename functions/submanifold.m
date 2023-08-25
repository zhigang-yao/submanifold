function X = submanifold(sample,sig,h,maxiter,manifold)

X = sample; Y = sample; N = size(sample,2);

switch manifold

    case "cylinder"
        for iter = 1:maxiter

            parfor ii = 1:N

                x = X(:,ii);

                X0 = find_nbr(x,sample,h);

                xbar = mean(X0,2); xbar = [xbar(1:end-1)/norm(xbar(1:end-1)); xbar(end)];

                [u,~] = svds(X0 - xbar,1,'largest'); xbar_ = [xbar(1);xbar(2);0];  nv = null([u,xbar_]'); nv = sig*nv;

                fs = zeros(21,1); deltas = -1:0.05:1;

                for i_delta = 1:length(deltas)

                    delta =  deltas(i_delta);

                    xnew = xbar + delta*nv;

                    xnew = [xnew(1:end-1)/norm(xnew(1:end-1)); xnew(end)];

                    XNnew  = find_nbr(xnew,sample,h);

                    xnewbar = mean(XNnew,2);

                    fs(i_delta) = norm(xnew - xnewbar)^2;

                end

                [~,id] = min(fs); xnew = xbar + deltas(id)*nv;

                Y(:,ii) = [xnew(1:end-1)/norm(xnew(1:end-1)); xnew(end)];

            end

            X = Y; 

        end



    case "sphere"
        
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

                Y(:,ii) = xnew/norm(xnew);


            end

            X = Y; 

        end        

end

