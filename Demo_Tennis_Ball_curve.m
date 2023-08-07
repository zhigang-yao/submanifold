% Set random number generator to default state
rng default; 

% Generate array of angles from -pi to pi, excluding pi
t = -pi:0.0001*pi:pi;
t(end) = [];

% Get number of elements in t
N = length(t);   

% Set noise standard deviation 
sig = 0.1;

% Generate x, y, z coordinate functions
x = (cos(t)).^3;   
y = (sin(t)).^3;
z = sqrt(3)/2*sin(2*t);

% Concatenate into sample matrix
sample_ = [x;y;z]; 

% Preallocate sample matrix
sample = zeros(3,N);

% Preallocate error matrix  
Err = zeros(1,N);

% Loop through each angle
for ii = 1:N

  % Generate random normal error  
  err = sig*randn(1);
  
  % Store error
  Err(ii) = err;  

  % Get sample vector for this angle
  vec_ii = sample_(:,ii);
  
  % Trig functions of angle
  sint = sin(t(ii));
  cost = cos(t(ii));
  cos2t = cos(2*t(ii));

  % Tangent vector
  vec_tan = [-2*cost^2*sint; 2*sint^2*cost; sqrt(3)*cos2t];
  
  % Orthogonal direction to sample and tangent
  dir = null([vec_ii vec_tan]'); 
  
  % Normalize direction
  dir = dir/norm(dir);

  % Add error in orthogonal direction 
  sample(:,ii) = vec_ii + err*dir;

  % Normalize sample  
  sample(:,ii) = sample(:,ii)/norm(sample(:,ii));
  
end

% Remove samples with large error
sample(:, abs(Err)>sig) = [];
sample_(:, abs(Err)>sig) = [];

% Get number of remaining samples
N = size(sample,2);  

% Set max iterations
max_iter = 4;  

% Call sphere subdivision function 
h = 1/(log10(N));
Xs = Sub_sphere(sample,N,h,max_iter);

% Plot sphere surface
[w,u,v] = sphere(30); 
surf(w,u,v);
hold on;
axis equal; 
shading flat;
alpha(0.6);
box off;
axis off;

% Get final subdivided samples
X = Xs{max_iter + 1,1};

% Plot original samples in red
plot3(sample(1,:),sample(2,:),sample(3,:),'r.',MarkerSize=5); 
xlim([-1.01,1.01]); 
ylim([-1.01,1.01]),zlim([-1.01,1.01]);

% Plot subdivided samples in blue
plot3(X(1,:),X(2,:),X(3,:),'b.',MarkerSize=5);
xlim([-1.01,1.01]);
ylim([-1.01,1.01]),zlim([-1.01,1.01]);
