% Load data 
load('Data_EQ.mat');

sig = 0.1; h = 0.1; maxiter = 5; manifold = 'sphere';
Y = submanifold_irregular(sample,sig,h,maxiter);

% Plot original data
subplot(1,4,1); 
[w,u,v] = sphere(30);
surf(w,u,v); hold on; colormap summer;  
axis equal; shading flat;   box off; axis off;
plot3(sample(1,:),sample(2,:),sample(3,:),'b.','Markersize',5);
view([-0.307,0.946, 0.1045]);
title('(a)')

% Plot principal submanifold data 
subplot(1,4,2);
[w,u,v] = sphere(30);
surf(w,u,v);hold on; 
axis equal; shading flat;  box off; axis off;
plot3(Y(1,:),Y(2,:),Y(3,:),'b.','Markersize',5);
view([-0.307,0.946, 0.1045]);
title('(b)')

% Plot original data with colormap  
subplot(1,4,3);
[w,u,v] = sphere(30);
surf(w,u,v);hold on; 
axis equal; shading interp;  box off; axis off;
plot3(sample(1,:),sample(2,:),sample(3,:),'b.','Markersize',5);
view([-0.959,-0.2699,-0.0864]);
title('(c)');

% Plot principal submanifold data 
subplot(1,4,4); 
[w,u,v] = sphere(30);
surf(w,u,v);hold on; 
axis equal; shading flat;   box off; axis off;
plot3(Y(1,:),Y(2,:),Y(3,:),'b.','Markersize',5);
view([-0.959,-0.2699,-0.0864]);
title('(d)')
