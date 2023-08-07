function Xs = Sub_sphere(sample,N0,h,max_iter)

Y = sample; rng(1);  Seed = randperm(size(sample,2)); X = Y(:,Seed(1:N0)); 

Xs = cell(max_iter+1,1); Xs{1,1} = X;

for iter = 1:max_iter

    parfor ii = 1:N0
        
        x = X(:,ii);
        X0 = find_nbr(x,Y,h); 
        xbar = mean(X0,2);  
        dx = x - xbar;    

        f =  norm(dx)^2;  
        alpha0 = 10; 
        rho = 1.e-1;      
        pp = 0;
        while pp<100
              xnew = x - alpha0*dx;
              XN0 = find_nbr(xnew,Y,h);  
              xnewbar   = mean(XN0,2);
              fnew2 = norm(xnew - xnewbar)^2;
              fnew  =   fnew2; 
              if fnew < f -  rho*alpha0*norm(dx)^2
                 x = xnew;
                 break;
              end
              pp = pp + 1; alpha0 = alpha0/2;
        end
        X(:,ii) = x/norm(x); 
    end
     
    Xs{iter+1,1} = X;

end