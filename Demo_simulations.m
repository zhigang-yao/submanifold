Examples = {'Tennis ball curve', 'S-shaped curve', 'Small circle', 'Pancake curve', 'Helix'};

id_example = 5;

example = Examples{id_example};

switch example
    case 'Tennis ball curve'

        rng default;  t = linspace(-pi, pi,1500); N = length(t); sig = 0.1;

        sample_nsls = [(cos(t)).^3;(sin(t)).^3;sqrt(3)/2*sin(2*t)];

        sample = sample_nsls;  Err = zeros(1,N);

        for ii = 1:N

            err = sig*randn(1);

            Err(ii) = err;

            vec_ii = sample_nsls(:,ii);

            sint = sin(t(ii));
            cost = cos(t(ii));
            cos2t = cos(2*t(ii));

            vec_tan = [-2*cost^2*sint; 2*sint^2*cost; sqrt(3)*cos2t];

            dir = null([vec_ii vec_tan]');

            dir = dir/norm(dir);

            sample(:,ii) = vec_ii + err*dir;

            sample(:,ii) = sample(:,ii)/norm(sample(:,ii));

        end

        sample(:, abs(Err)>sig) = [];

        subplot(1,5,1);
        [w,u,v] = sphere(30);  surf(w,u,v);
        hold on; axis equal; shading flat; alpha(0.6); box off; axis off;

        % Plot original samples in red
        plot3(sample(1,:),sample(2,:),sample(3,:),'r.',MarkerSize=5);
        xlim([-1.01,1.01]);
        ylim([-1.01,1.01]),zlim([-1.01,1.01]);

        % Plot subdivided samples in blue
        maxiter = 4; manifold = 'sphere'; N = size(sample,2);  h = 1/(2*log10(N));
        X = submanifold(sample,sig,h,maxiter,manifold);
        plot3(X(1,:),X(2,:),X(3,:),'b.',MarkerSize=5);

    case 'S-shaped curve'

        t = linspace(-pi, 0,1500); N = length(t);

        x = sin(t) .* cos(t); y = -sin(t) .* sin(t); z = cos(t);

        sample_ = [x;y;z]; sample = zeros(3,N); Err = zeros(1,N); sig = 0.1;

        for ii = 1:N
            
            err = sig*randn(1);

            Err(ii) = err;
            
            vec_ii = sample_(:,ii);
            
            sint = sin(t(ii)); cost = cos(t(ii)); cos2t = cos(2*t(ii));
            
            vec_tan = [cos2t; -2*sint*cost; -sint];
            
            dir = null([vec_ii vec_tan]');
            
            dir = dir/norm(dir);
            
            sample(:,ii) = vec_ii + err*dir;
            
            sample(:,ii) = sample(:,ii)/norm(sample(:,ii));
        
        end
        
        sample(:, abs(Err)>sig) = [];

        subplot(1,5,2);
        
        [w,u,v] = sphere(30);  surf(w,u,v);
        
        hold on; axis equal; shading flat; alpha(0.6); box off; axis off;

        % Plot original samples in red
        plot3(sample(1,:),sample(2,:),sample(3,:),'r.',MarkerSize=5);
        
        xlim([-1.01,1.01]);
        
        ylim([-1.01,1.01]),zlim([-1.01,1.01]);


        % Plot subdivided samples in blue
        maxiter = 4; manifold = 'sphere'; N = size(sample,2);  h = 1/(2*log10(N));
        
        X = submanifold(sample,sig,h,maxiter,manifold);
        
        plot3(X(1,:),X(2,:),X(3,:),'b.',MarkerSize=5);        


    case 'Small circle'

        t = linspace(-pi,pi,1500); N = length(t);

        x = sqrt(3)*sin(t)/2;

        y = sqrt(3)*cos(t)/2;

        z = 1/2*ones(1,length(t));

        sample_ = [x;y;z]; sample = zeros(3,N); Err = zeros(1,N); sig = 0.1;

        for ii = 1:N

            err = sig*randn(1);

            Err(ii) = err;

            vec_ii = sample_(:,ii);

            sint = sin(t(ii)); cost = cos(t(ii));

            vec_tan = [sqrt(3)*cost/2; -sqrt(3)*sint/2; 0];

            dir = null([vec_ii vec_tan]');

            dir = dir/norm(dir);

            sample(:,ii) = vec_ii + err*dir;

            sample(:,ii) = sample(:,ii)/norm(sample(:,ii));

        end

        sample(:, abs(Err)>sig) = [];

        subplot(1,5,3);
        
        [w,u,v] = sphere(30);  surf(w,u,v);
        
        hold on; axis equal; shading flat; alpha(0.6); box off; axis off;

        % Plot original samples in red
        plot3(sample(1,:),sample(2,:),sample(3,:),'r.',MarkerSize=5);
        
        xlim([-1.01,1.01]);
        
        ylim([-1.01,1.01]),zlim([-1.01,1.01]);        


        % Plot subdivided samples in blue
        maxiter = 4; manifold = 'sphere'; N = size(sample,2);  h = 1/(2*log10(N));
        
        X = submanifold(sample,sig,h,maxiter,manifold);
        
        plot3(X(1,:),X(2,:),X(3,:),'b.',MarkerSize=5);               


    case 'Pancake curve'

        t = linspace(0,2*pi,1500); N = length(t);

        x = 8*cos(t)./sqrt(66+2*cos(4*t));

        y = 8*sin(t)./sqrt(66+2*cos(4*t));

        z = 2*cos(2*t)./sqrt(66+2*cos(4*t));

        sample_ = [x;y;z]; sample = zeros(3,N); Err = zeros(1,N); sig = 0.1;

        for ii = 1:N

            err = sig*randn(1);

            Err(ii) = err;

            vec_ii = sample_(:,ii);

            sint = sin(t(ii)); cost = cos(t(ii));

            Xii = find_nbr(vec_ii,sample_,0.2);

            x0 = mean(Xii,2);

            [vec_tan,~] = svds(Xii - x0,1,'largest');

            dir = null([vec_ii vec_tan]');

            dir = dir/norm(dir);

            sample(:,ii) = vec_ii + err*dir;

            sample(:,ii) = sample(:,ii)/norm(sample(:,ii));

        end

        sample(:, abs(Err)>sig) = [];

        subplot(1,5,4);
        
        [w,u,v] = sphere(30);  surf(w,u,v);
        
        hold on; axis equal; shading flat; alpha(0.6); box off; axis off;

        % Plot original samples in red
        plot3(sample(1,:),sample(2,:),sample(3,:),'r.',MarkerSize=5);
        
        xlim([-1.01,1.01]);
        
        ylim([-1.01,1.01]),zlim([-1.01,1.01]);        


        % Plot subdivided samples in blue
        maxiter = 4; manifold = 'sphere'; N = size(sample,2);  h = 1/(2*log10(N));
        
        X = submanifold(sample,sig,h,maxiter,manifold);
        
        plot3(X(1,:),X(2,:),X(3,:),'b.',MarkerSize=5);       

    case 'Helix'

        t = linspace(-2*pi,2*pi,1500); N = length(t); sig = 0.1; 

        sample_ = [cos(t);sin(t);t/8]; sample = sample_; 

        % Add gaussian noise to points
        Err = zeros(1,N);

        for ii = 1:N

            err = sig*randn(1); % Sample noise

            Err(ii) = err;

            vec_ii = sample_(:,ii);

            vec_normal = [ vec_ii(1)  vec_ii(2) 0]; % Surface normal

            sint = sin(t(ii)); cost = cos(t(ii));

            vec_tan = [-sint; cost; 1/4]; % Tangent vector

            dir = null([vec_ii vec_tan]'); % Orthogonal direction

            dir = dir/norm(dir);

            sample(:,ii) = vec_ii + err*dir; % Add noise

            sample(:,ii) = sample(:,ii)/norm(sample(1:end-1,ii)); % Normalize
        end

        % Remove outliers
        sample(:, abs(Err)>sig) = []; N = size(sample,2);

        subplot(1,5,5);
        
        [Xc,Yc,Zc] = cylinder; Zc = Zc*2 - 1; surf(Xc,Yc,Zc); colormap summer;

        axis equal; shading flat; alpha(0.6); box off; axis off; hold on;

        plot3(sample(1,:),sample(2,:),sample(3,:),'r.',MarkerSize=5);
        
        maxiter = 4; manifold = 'cylinder'; h = 3/(2*log10(N));

        X = submanifold(sample,sig,h,maxiter,manifold);

        plot3(X(1,:),X(2,:),X(3,:),'b.',MarkerSize = 5);


end
